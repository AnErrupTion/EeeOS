const std = @import("std");

const arch = enum { unspecified, i386 };

pub fn build(b: *std.build.Builder) void {
    var build_arch = b.option(arch, "arch", "Build for a specified architecture") orelse arch.unspecified;

    const exe = b.addExecutable("EeeOS", "src/main.zig");
    exe.code_model = std.builtin.CodeModel.kernel;
    exe.red_zone = false;

    exe.setLinkerScriptPath(.{ .path = "linker.ld" });
    exe.setBuildMode(b.standardReleaseOptions());

    if (build_arch == arch.i386) {
        exe.addAssemblyFile("src/i386/asm/entry.s");
        exe.addAssemblyFile("src/i386/asm/helpers.s");

        var target = std.zig.CrossTarget{ .cpu_arch = .i386, .os_tag = .freestanding, .abi = .none };
        target.cpu_features_sub.addFeature(@enumToInt(std.Target.x86.Feature.mmx));
        target.cpu_features_sub.addFeature(@enumToInt(std.Target.x86.Feature.sse));
        target.cpu_features_sub.addFeature(@enumToInt(std.Target.x86.Feature.sse2));
        target.cpu_features_sub.addFeature(@enumToInt(std.Target.x86.Feature.avx));
        target.cpu_features_sub.addFeature(@enumToInt(std.Target.x86.Feature.avx2));
        target.cpu_features_add.addFeature(@enumToInt(std.Target.x86.Feature.soft_float));

        exe.setTarget(target);
    } else {
        std.debug.print("Unsupported architecture: {}", .{build_arch});
        return;
    }

    exe.install();

    const make_iso_step = b.step("make-iso", "Create a bootable ISO image");
    make_iso_step.makeFn = make_iso;
    make_iso_step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Runs the operating system");
    run_step.makeFn = run;
    run_step.dependOn(make_iso_step);

    //const exe_tests = b.addTest("src/main.zig");
    //exe_tests.setTarget(target);
    //exe_tests.setBuildMode(mode);

    //const test_step = b.step("test", "Run unit tests");
    //test_step.dependOn(&exe_tests.step);
}

fn make_iso(self: *std.build.Step) !void {
    _ = self;

    var current_dir = std.fs.cwd();

    current_dir.makeDir("iso") catch {};

    var isoDirectory = current_dir.openDir("iso", std.fs.Dir.OpenDirOptions{}) catch unreachable;
    defer isoDirectory.close();

    current_dir.copyFile("limine/limine-cd.bin", isoDirectory, "limine-cd.bin", std.fs.CopyFileOptions{}) catch unreachable;
    current_dir.copyFile("limine/limine.sys", isoDirectory, "limine.sys", std.fs.CopyFileOptions{}) catch unreachable;
    current_dir.copyFile("limine/limine.cfg", isoDirectory, "limine.cfg", std.fs.CopyFileOptions{}) catch unreachable;
    current_dir.copyFile("zig-out/bin/EeeOS", isoDirectory, "EeeOS.elf", std.fs.CopyFileOptions{}) catch unreachable;

    const xorriso_argv = [_][]const u8{
        "xorriso",
        "-as",
        "mkisofs",
        "-b",
        "limine-cd.bin",
        "-no-emul-boot",
        "-boot-load-size",
        "4",
        "-boot-info-table",
        "iso",
        "-o",
        "EeeOS.iso",
    };

    _ = std.ChildProcess.exec(.{ .argv = &xorriso_argv, .allocator = std.heap.page_allocator }) catch unreachable;

    const limine_deploy_argv = [_][]const u8{
        "limine/limine-deploy",
        "EeeOS.iso",
    };

    _ = std.ChildProcess.exec(.{ .argv = &limine_deploy_argv, .allocator = std.heap.page_allocator }) catch unreachable;
}

fn run(self: *std.build.Step) !void {
    _ = self;

    const qemu_argv = [_][]const u8{
        "qemu-system-i386",
        "-cpu",
        "pentium2",
        "-enable-kvm",
        "-m",
        "128M",
        "-cdrom",
        "EeeOS.iso",
    };

    _ = std.ChildProcess.exec(.{ .argv = &qemu_argv, .allocator = std.heap.page_allocator }) catch unreachable;
}
