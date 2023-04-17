const std = @import("std");

const arch = enum { unspecified, i386 };

pub fn build(b: *std.build.Builder) void {
    std.fs.cwd().makeDir("iso") catch {};

    var isoDirectory = std.fs.cwd().openDir("iso", std.fs.Dir.OpenDirOptions{}) catch unreachable;
    defer isoDirectory.close();

    var build_arch = b.option(arch, "arch", "Build for the i386 architecture") orelse arch.unspecified;

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

    //std.fs.cwd().copyFile("limine/limine-cd.bin", isoDirectory, "limine-cd.bin", std.fs.CopyFileOptions{}) catch unreachable;
    //std.fs.cwd().copyFile("limine/limine.sys", isoDirectory, "limine.sys", std.fs.CopyFileOptions{}) catch unreachable;
    //std.fs.cwd().copyFile("limine/limine.cfg", isoDirectory, "limine.cfg", std.fs.CopyFileOptions{}) catch unreachable;
    //std.fs.cwd().copyFile("zig-out/bin/EeeOS", isoDirectory, "EeeOS.elf", std.fs.CopyFileOptions{}) catch unreachable;

    //const args: [*:null]const ?[*:0]const u8 = ;

    //std.os.execvpeZ("xorriso", args, null);

    //const run_cmd = exe.run();
    //run_cmd.step.dependOn(b.getInstallStep());
    //if (b.args) |args| {
    //    run_cmd.addArgs(args);
    //}

    //const run_step = b.step("run", "Run the app");
    //run_step.dependOn(&run_cmd.step);

    //const exe_tests = b.addTest("src/main.zig");
    //exe_tests.setTarget(target);
    //exe_tests.setBuildMode(mode);

    //const test_step = b.step("test", "Run unit tests");
    //test_step.dependOn(&exe_tests.step);
}
