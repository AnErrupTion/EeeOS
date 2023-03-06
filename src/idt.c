//
// Created by anerruption on 06/03/23.
//

#include <stdint.h>

#include "../include/idt.h"
#include "../include/pic.h"
#include "../include/vga.h"
#include "../include/panic.h"

void interrupt_handler(uint32_t irq)
{
    switch (irq)
    {
        case 0: abort("Divide error");
        case 4: abort("Arithmetic overflow exception");
        case 5: abort("Bound check error");
        case 6: abort("Invalid OpCode");
        case 7: abort("Co-processor not available");
        case 8: abort("Double fault");
        case 9: abort("Co-processor segment over-run");
        case 10: abort("Invalid TSS");
        case 11: abort("Segment not present");
        case 12: abort("Stack exception");
        case 13: abort("General Protection Fault");
        case 14: abort("Memory error"); // TODO
        case 16: abort("Co-processor error");
        case 19: abort("SIMD floating point exception");
        default:
            term_write_string("A");
            pic_send_eoi(irq);
            break;
    }
}

extern void load_idt(uint32_t idtr);

extern void irq0();
extern void irq1();
extern void irq2();
extern void irq3();
extern void irq4();
extern void irq5();
extern void irq6();
extern void irq7();
extern void irq8();
extern void irq9();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();
extern void irq16();
extern void irq17();
extern void irq18();
extern void irq19();
extern void irq20();
extern void irq21();
extern void irq22();
extern void irq23();
extern void irq24();
extern void irq25();
extern void irq26();
extern void irq27();
extern void irq28();
extern void irq29();
extern void irq30();
extern void irq31();
extern void irq32();
extern void irq33();
extern void irq34();
extern void irq35();
extern void irq36();
extern void irq37();
extern void irq38();
extern void irq39();
extern void irq40();
extern void irq41();
extern void irq42();
extern void irq43();
extern void irq44();
extern void irq45();
extern void irq46();
extern void irq47();
extern void irq48();
extern void irq49();
extern void irq50();
extern void irq51();
extern void irq52();
extern void irq53();
extern void irq54();
extern void irq55();
extern void irq56();
extern void irq57();
extern void irq58();
extern void irq59();
extern void irq60();
extern void irq61();
extern void irq62();
extern void irq63();
extern void irq64();
extern void irq65();
extern void irq66();
extern void irq67();
extern void irq68();
extern void irq69();
extern void irq70();
extern void irq71();
extern void irq72();
extern void irq73();
extern void irq74();
extern void irq75();
extern void irq76();
extern void irq77();
extern void irq78();
extern void irq79();
extern void irq80();
extern void irq81();
extern void irq82();
extern void irq83();
extern void irq84();
extern void irq85();
extern void irq86();
extern void irq87();
extern void irq88();
extern void irq89();
extern void irq90();
extern void irq91();
extern void irq92();
extern void irq93();
extern void irq94();
extern void irq95();
extern void irq96();
extern void irq97();
extern void irq98();
extern void irq99();
extern void irq100();
extern void irq101();
extern void irq102();
extern void irq103();
extern void irq104();
extern void irq105();
extern void irq106();
extern void irq107();
extern void irq108();
extern void irq109();
extern void irq110();
extern void irq111();
extern void irq112();
extern void irq113();
extern void irq114();
extern void irq115();
extern void irq116();
extern void irq117();
extern void irq118();
extern void irq119();
extern void irq120();
extern void irq121();
extern void irq122();
extern void irq123();
extern void irq124();
extern void irq125();
extern void irq126();
extern void irq127();
extern void irq128();
extern void irq129();
extern void irq130();
extern void irq131();
extern void irq132();
extern void irq133();
extern void irq134();
extern void irq135();
extern void irq136();
extern void irq137();
extern void irq138();
extern void irq139();
extern void irq140();
extern void irq141();
extern void irq142();
extern void irq143();
extern void irq144();
extern void irq145();
extern void irq146();
extern void irq147();
extern void irq148();
extern void irq149();
extern void irq150();
extern void irq151();
extern void irq152();
extern void irq153();
extern void irq154();
extern void irq155();
extern void irq156();
extern void irq157();
extern void irq158();
extern void irq159();
extern void irq160();
extern void irq161();
extern void irq162();
extern void irq163();
extern void irq164();
extern void irq165();
extern void irq166();
extern void irq167();
extern void irq168();
extern void irq169();
extern void irq170();
extern void irq171();
extern void irq172();
extern void irq173();
extern void irq174();
extern void irq175();
extern void irq176();
extern void irq177();
extern void irq178();
extern void irq179();
extern void irq180();
extern void irq181();
extern void irq182();
extern void irq183();
extern void irq184();
extern void irq185();
extern void irq186();
extern void irq187();
extern void irq188();
extern void irq189();
extern void irq190();
extern void irq191();
extern void irq192();
extern void irq193();
extern void irq194();
extern void irq195();
extern void irq196();
extern void irq197();
extern void irq198();
extern void irq199();
extern void irq200();
extern void irq201();
extern void irq202();
extern void irq203();
extern void irq204();
extern void irq205();
extern void irq206();
extern void irq207();
extern void irq208();
extern void irq209();
extern void irq210();
extern void irq211();
extern void irq212();
extern void irq213();
extern void irq214();
extern void irq215();
extern void irq216();
extern void irq217();
extern void irq218();
extern void irq219();
extern void irq220();
extern void irq221();
extern void irq222();
extern void irq223();
extern void irq224();
extern void irq225();
extern void irq226();
extern void irq227();
extern void irq228();
extern void irq229();
extern void irq230();
extern void irq231();
extern void irq232();
extern void irq233();
extern void irq234();
extern void irq235();
extern void irq236();
extern void irq237();
extern void irq238();
extern void irq239();
extern void irq240();
extern void irq241();
extern void irq242();
extern void irq243();
extern void irq244();
extern void irq245();
extern void irq246();
extern void irq247();
extern void irq248();
extern void irq249();
extern void irq250();
extern void irq251();
extern void irq252();
extern void irq253();
extern void irq254();
extern void irq255();

/*typedef struct
{
    uint8_t rpl : 2;
    uint8_t ti : 1;
    uint16_t index : 13;
} __attribute__((packed)) segment_select;

typedef struct
{
    uint8_t gate_type : 4;
    uint8_t zero : 1;
    uint8_t dpl : 2;
    uint8_t p : 1;
} __attribute__((packed)) type_attrib;*/

typedef struct
{
    uint16_t size;
    uint32_t offset;
} __attribute__((packed)) idtr;

typedef struct
{
    uint16_t offset_1; // Offset bits 0..15
    uint16_t selector; // A code segment selector in GDT or LDT
    uint8_t zero; // Unused, set to 0
    uint8_t type_attributes; // Gate type, DP1 and P fields
    uint16_t offset_2; // Offset bits 16..31
} __attribute__((packed)) idt_entry;

idt_entry idt_entries[32];

void idt_add_table(uint32_t index, uint32_t offset)
{
    /*type_attrib type_attr = {
            .gate_type = 0b1110, // 32-bit interrupt gate
            .zero = 0b0,
            .dpl = 0b00, // Ring 0
            .p = 0b1 // Present
    };

    segment_select segment_sel = {
            .rpl = 0b00, // Ring 0
            .ti = 0b0, // GDT
            .index = 0b0000000000001 // GDT entry index (32-bit code segment)
    };*/

    idt_entry entry = {
            .offset_1 = (uint16_t)(offset & 0xFFFF),
            .selector = 0x08,
            .zero = 0,
            .type_attributes = 0x8E,
            .offset_2 = (uint16_t)((offset >> 16) & 0xFFFF)
    };

    idt_entries[index] = entry;
}

void idt_init()
{
    idt_add_table(0, (uint32_t)irq0);
    idt_add_table(1, (uint32_t)irq1);
    idt_add_table(2, (uint32_t)irq2);
    idt_add_table(3, (uint32_t)irq3);
    idt_add_table(4, (uint32_t)irq4);
    idt_add_table(5, (uint32_t)irq5);
    idt_add_table(6, (uint32_t)irq6);
    idt_add_table(7, (uint32_t)irq7);
    idt_add_table(8, (uint32_t)irq8);
    idt_add_table(9, (uint32_t)irq9);
    idt_add_table(10, (uint32_t)irq10);
    idt_add_table(11, (uint32_t)irq11);
    idt_add_table(12, (uint32_t)irq12);
    idt_add_table(13, (uint32_t)irq13);
    idt_add_table(14, (uint32_t)irq14);
    idt_add_table(15, (uint32_t)irq15);
    idt_add_table(16, (uint32_t)irq16);
    idt_add_table(17, (uint32_t)irq17);
    idt_add_table(18, (uint32_t)irq18);
    idt_add_table(19, (uint32_t)irq19);
    idt_add_table(20, (uint32_t)irq20);
    idt_add_table(21, (uint32_t)irq21);
    idt_add_table(22, (uint32_t)irq22);
    idt_add_table(23, (uint32_t)irq23);
    idt_add_table(24, (uint32_t)irq24);
    idt_add_table(25, (uint32_t)irq25);
    idt_add_table(26, (uint32_t)irq26);
    idt_add_table(27, (uint32_t)irq27);
    idt_add_table(28, (uint32_t)irq28);
    idt_add_table(29, (uint32_t)irq29);
    idt_add_table(30, (uint32_t)irq30);
    idt_add_table(31, (uint32_t)irq31);
    /*idt_add_table(32, (uint32_t)irq32);
    idt_add_table(33, (uint32_t)irq33);
    idt_add_table(34, (uint32_t)irq34);
    idt_add_table(35, (uint32_t)irq35);
    idt_add_table(36, (uint32_t)irq36);
    idt_add_table(37, (uint32_t)irq37);
    idt_add_table(38, (uint32_t)irq38);
    idt_add_table(39, (uint32_t)irq39);
    idt_add_table(40, (uint32_t)irq40);
    idt_add_table(41, (uint32_t)irq41);
    idt_add_table(42, (uint32_t)irq42);
    idt_add_table(43, (uint32_t)irq43);
    idt_add_table(44, (uint32_t)irq44);
    idt_add_table(45, (uint32_t)irq45);
    idt_add_table(46, (uint32_t)irq46);
    idt_add_table(47, (uint32_t)irq47);
    idt_add_table(48, (uint32_t)irq48);
    idt_add_table(49, (uint32_t)irq49);
    idt_add_table(50, (uint32_t)irq50);
    idt_add_table(51, (uint32_t)irq51);
    idt_add_table(52, (uint32_t)irq52);
    idt_add_table(53, (uint32_t)irq53);
    idt_add_table(54, (uint32_t)irq54);
    idt_add_table(55, (uint32_t)irq55);
    idt_add_table(56, (uint32_t)irq56);
    idt_add_table(57, (uint32_t)irq57);
    idt_add_table(58, (uint32_t)irq58);
    idt_add_table(59, (uint32_t)irq59);
    idt_add_table(60, (uint32_t)irq60);
    idt_add_table(61, (uint32_t)irq61);
    idt_add_table(62, (uint32_t)irq62);
    idt_add_table(63, (uint32_t)irq63);
    idt_add_table(64, (uint32_t)irq64);
    idt_add_table(65, (uint32_t)irq65);
    idt_add_table(66, (uint32_t)irq66);
    idt_add_table(67, (uint32_t)irq67);
    idt_add_table(68, (uint32_t)irq68);
    idt_add_table(69, (uint32_t)irq69);
    idt_add_table(70, (uint32_t)irq70);
    idt_add_table(71, (uint32_t)irq71);
    idt_add_table(72, (uint32_t)irq72);
    idt_add_table(73, (uint32_t)irq73);
    idt_add_table(74, (uint32_t)irq74);
    idt_add_table(75, (uint32_t)irq75);
    idt_add_table(76, (uint32_t)irq76);
    idt_add_table(77, (uint32_t)irq77);
    idt_add_table(78, (uint32_t)irq78);
    idt_add_table(79, (uint32_t)irq79);
    idt_add_table(80, (uint32_t)irq80);
    idt_add_table(81, (uint32_t)irq81);
    idt_add_table(82, (uint32_t)irq82);
    idt_add_table(83, (uint32_t)irq83);
    idt_add_table(84, (uint32_t)irq84);
    idt_add_table(85, (uint32_t)irq85);
    idt_add_table(86, (uint32_t)irq86);
    idt_add_table(87, (uint32_t)irq87);
    idt_add_table(88, (uint32_t)irq88);
    idt_add_table(89, (uint32_t)irq89);
    idt_add_table(90, (uint32_t)irq90);
    idt_add_table(91, (uint32_t)irq91);
    idt_add_table(92, (uint32_t)irq92);
    idt_add_table(93, (uint32_t)irq93);
    idt_add_table(94, (uint32_t)irq94);
    idt_add_table(95, (uint32_t)irq95);
    idt_add_table(96, (uint32_t)irq96);
    idt_add_table(97, (uint32_t)irq97);
    idt_add_table(98, (uint32_t)irq98);
    idt_add_table(99, (uint32_t)irq99);
    idt_add_table(100, (uint32_t)irq100);
    idt_add_table(101, (uint32_t)irq101);
    idt_add_table(102, (uint32_t)irq102);
    idt_add_table(103, (uint32_t)irq103);
    idt_add_table(104, (uint32_t)irq104);
    idt_add_table(105, (uint32_t)irq105);
    idt_add_table(106, (uint32_t)irq106);
    idt_add_table(107, (uint32_t)irq107);
    idt_add_table(108, (uint32_t)irq108);
    idt_add_table(109, (uint32_t)irq109);
    idt_add_table(110, (uint32_t)irq110);
    idt_add_table(111, (uint32_t)irq111);
    idt_add_table(112, (uint32_t)irq112);
    idt_add_table(113, (uint32_t)irq113);
    idt_add_table(114, (uint32_t)irq114);
    idt_add_table(115, (uint32_t)irq115);
    idt_add_table(116, (uint32_t)irq116);
    idt_add_table(117, (uint32_t)irq117);
    idt_add_table(118, (uint32_t)irq118);
    idt_add_table(119, (uint32_t)irq119);
    idt_add_table(120, (uint32_t)irq120);
    idt_add_table(121, (uint32_t)irq121);
    idt_add_table(122, (uint32_t)irq122);
    idt_add_table(123, (uint32_t)irq123);
    idt_add_table(124, (uint32_t)irq124);
    idt_add_table(125, (uint32_t)irq125);
    idt_add_table(126, (uint32_t)irq126);
    idt_add_table(127, (uint32_t)irq127);
    idt_add_table(128, (uint32_t)irq128);
    idt_add_table(129, (uint32_t)irq129);
    idt_add_table(130, (uint32_t)irq130);
    idt_add_table(131, (uint32_t)irq131);
    idt_add_table(132, (uint32_t)irq132);
    idt_add_table(133, (uint32_t)irq133);
    idt_add_table(134, (uint32_t)irq134);
    idt_add_table(135, (uint32_t)irq135);
    idt_add_table(136, (uint32_t)irq136);
    idt_add_table(137, (uint32_t)irq137);
    idt_add_table(138, (uint32_t)irq138);
    idt_add_table(139, (uint32_t)irq139);
    idt_add_table(140, (uint32_t)irq140);
    idt_add_table(141, (uint32_t)irq141);
    idt_add_table(142, (uint32_t)irq142);
    idt_add_table(143, (uint32_t)irq143);
    idt_add_table(144, (uint32_t)irq144);
    idt_add_table(145, (uint32_t)irq145);
    idt_add_table(146, (uint32_t)irq146);
    idt_add_table(147, (uint32_t)irq147);
    idt_add_table(148, (uint32_t)irq148);
    idt_add_table(149, (uint32_t)irq149);
    idt_add_table(150, (uint32_t)irq150);
    idt_add_table(151, (uint32_t)irq151);
    idt_add_table(152, (uint32_t)irq152);
    idt_add_table(153, (uint32_t)irq153);
    idt_add_table(154, (uint32_t)irq154);
    idt_add_table(155, (uint32_t)irq155);
    idt_add_table(156, (uint32_t)irq156);
    idt_add_table(157, (uint32_t)irq157);
    idt_add_table(158, (uint32_t)irq158);
    idt_add_table(159, (uint32_t)irq159);
    idt_add_table(160, (uint32_t)irq160);
    idt_add_table(161, (uint32_t)irq161);
    idt_add_table(162, (uint32_t)irq162);
    idt_add_table(163, (uint32_t)irq163);
    idt_add_table(164, (uint32_t)irq164);
    idt_add_table(165, (uint32_t)irq165);
    idt_add_table(166, (uint32_t)irq166);
    idt_add_table(167, (uint32_t)irq167);
    idt_add_table(168, (uint32_t)irq168);
    idt_add_table(169, (uint32_t)irq169);
    idt_add_table(170, (uint32_t)irq170);
    idt_add_table(171, (uint32_t)irq171);
    idt_add_table(172, (uint32_t)irq172);
    idt_add_table(173, (uint32_t)irq173);
    idt_add_table(174, (uint32_t)irq174);
    idt_add_table(175, (uint32_t)irq175);
    idt_add_table(176, (uint32_t)irq176);
    idt_add_table(177, (uint32_t)irq177);
    idt_add_table(178, (uint32_t)irq178);
    idt_add_table(179, (uint32_t)irq179);
    idt_add_table(180, (uint32_t)irq180);
    idt_add_table(181, (uint32_t)irq181);
    idt_add_table(182, (uint32_t)irq182);
    idt_add_table(183, (uint32_t)irq183);
    idt_add_table(184, (uint32_t)irq184);
    idt_add_table(185, (uint32_t)irq185);
    idt_add_table(186, (uint32_t)irq186);
    idt_add_table(187, (uint32_t)irq187);
    idt_add_table(188, (uint32_t)irq188);
    idt_add_table(189, (uint32_t)irq189);
    idt_add_table(190, (uint32_t)irq190);
    idt_add_table(191, (uint32_t)irq191);
    idt_add_table(192, (uint32_t)irq192);
    idt_add_table(193, (uint32_t)irq193);
    idt_add_table(194, (uint32_t)irq194);
    idt_add_table(195, (uint32_t)irq195);
    idt_add_table(196, (uint32_t)irq196);
    idt_add_table(197, (uint32_t)irq197);
    idt_add_table(198, (uint32_t)irq198);
    idt_add_table(199, (uint32_t)irq199);
    idt_add_table(200, (uint32_t)irq200);
    idt_add_table(201, (uint32_t)irq201);
    idt_add_table(202, (uint32_t)irq202);
    idt_add_table(203, (uint32_t)irq203);
    idt_add_table(204, (uint32_t)irq204);
    idt_add_table(205, (uint32_t)irq205);
    idt_add_table(206, (uint32_t)irq206);
    idt_add_table(207, (uint32_t)irq207);
    idt_add_table(208, (uint32_t)irq208);
    idt_add_table(209, (uint32_t)irq209);
    idt_add_table(210, (uint32_t)irq210);
    idt_add_table(211, (uint32_t)irq211);
    idt_add_table(212, (uint32_t)irq212);
    idt_add_table(213, (uint32_t)irq213);
    idt_add_table(214, (uint32_t)irq214);
    idt_add_table(215, (uint32_t)irq215);
    idt_add_table(216, (uint32_t)irq216);
    idt_add_table(217, (uint32_t)irq217);
    idt_add_table(218, (uint32_t)irq218);
    idt_add_table(219, (uint32_t)irq219);
    idt_add_table(220, (uint32_t)irq220);
    idt_add_table(221, (uint32_t)irq221);
    idt_add_table(222, (uint32_t)irq222);
    idt_add_table(223, (uint32_t)irq223);
    idt_add_table(224, (uint32_t)irq224);
    idt_add_table(225, (uint32_t)irq225);
    idt_add_table(226, (uint32_t)irq226);
    idt_add_table(227, (uint32_t)irq227);
    idt_add_table(228, (uint32_t)irq228);
    idt_add_table(229, (uint32_t)irq229);
    idt_add_table(230, (uint32_t)irq230);
    idt_add_table(231, (uint32_t)irq231);
    idt_add_table(232, (uint32_t)irq232);
    idt_add_table(233, (uint32_t)irq233);
    idt_add_table(234, (uint32_t)irq234);
    idt_add_table(235, (uint32_t)irq235);
    idt_add_table(236, (uint32_t)irq236);
    idt_add_table(237, (uint32_t)irq237);
    idt_add_table(238, (uint32_t)irq238);
    idt_add_table(239, (uint32_t)irq239);
    idt_add_table(240, (uint32_t)irq240);
    idt_add_table(241, (uint32_t)irq241);
    idt_add_table(242, (uint32_t)irq242);
    idt_add_table(243, (uint32_t)irq243);
    idt_add_table(244, (uint32_t)irq244);
    idt_add_table(245, (uint32_t)irq245);
    idt_add_table(246, (uint32_t)irq246);
    idt_add_table(247, (uint32_t)irq247);
    idt_add_table(248, (uint32_t)irq248);
    idt_add_table(249, (uint32_t)irq249);
    idt_add_table(250, (uint32_t)irq250);
    idt_add_table(251, (uint32_t)irq251);
    idt_add_table(252, (uint32_t)irq252);
    idt_add_table(253, (uint32_t)irq253);
    idt_add_table(254, (uint32_t)irq254);
    idt_add_table(255, (uint32_t)irq255);*/

    idtr idt = {
            .size = (sizeof(idt_entry) * 32) - 1,
            .offset = (uint32_t)idt_entries
    };

    load_idt((uint32_t)&idt);
}