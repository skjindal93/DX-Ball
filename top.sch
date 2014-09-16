VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL start
        SIGNAL reset
        SIGNAL led
        SIGNAL rid
        SIGNAL XLXN_9(9:0)
        SIGNAL XLXN_10(8:0)
        SIGNAL XLXN_12(9:0)
        SIGNAL XLXN_13
        SIGNAL XLXN_14
        SIGNAL XLXN_15
        SIGNAL XLXN_16
        SIGNAL VGA_COMP_SYNCH
        SIGNAL VGA_OUT_BLANK_Z
        SIGNAL VGA_HSYNCH
        SIGNAL VGA_VSYNCH
        SIGNAL VGA_OUT_RED(7:0)
        SIGNAL VGA_OUT_GREEN(7:0)
        SIGNAL VGA_OUT_BLUE(7:0)
        SIGNAL VGA_OUT_PIXEL_CLOCK
        SIGNAL clk10
        SIGNAL XLXN_41(39:0)
        SIGNAL XLXN_43(6:0)
        SIGNAL XLXN_44(2:0)
        SIGNAL SYSTEM_CLOCK
        SIGNAL XLXN_79
        SIGNAL XLXN_80(1:0)
        SIGNAL kb_clk
        SIGNAL kb_data
        SIGNAL pausein
        PORT Input start
        PORT Input reset
        PORT Input led
        PORT Input rid
        PORT Output VGA_COMP_SYNCH
        PORT Output VGA_OUT_BLANK_Z
        PORT Output VGA_HSYNCH
        PORT Output VGA_VSYNCH
        PORT Output VGA_OUT_RED(7:0)
        PORT Output VGA_OUT_GREEN(7:0)
        PORT Output VGA_OUT_BLUE(7:0)
        PORT Output VGA_OUT_PIXEL_CLOCK
        PORT Output clk10
        PORT Input SYSTEM_CLOCK
        PORT Input kb_clk
        PORT Input kb_data
        PORT Input pausein
        BEGIN BLOCKDEF mainc
            TIMESTAMP 2013 4 26 8 32 56
            LINE N 64 800 0 800 
            LINE N 64 672 0 672 
            LINE N 64 736 0 736 
            RECTANGLE N 320 596 384 620 
            LINE N 320 608 384 608 
            RECTANGLE N 320 532 384 556 
            LINE N 320 544 384 544 
            RECTANGLE N 320 468 384 492 
            LINE N 320 480 384 480 
            RECTANGLE N 320 340 384 364 
            LINE N 320 352 384 352 
            RECTANGLE N 320 20 384 44 
            LINE N 320 32 384 32 
            RECTANGLE N 320 84 384 108 
            LINE N 320 96 384 96 
            RECTANGLE N 320 212 384 236 
            LINE N 320 224 384 224 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            RECTANGLE N 320 -204 384 -180 
            LINE N 320 -192 384 -192 
            RECTANGLE N 320 -60 384 -36 
            LINE N 320 -48 384 -48 
            RECTANGLE N 64 -512 320 1088 
        END BLOCKDEF
        BEGIN BLOCKDEF MAIN
            TIMESTAMP 2013 4 15 17 23 46
            RECTANGLE N 0 788 64 812 
            LINE N 64 800 0 800 
            LINE N 528 736 592 736 
            RECTANGLE N 0 660 64 684 
            LINE N 64 672 0 672 
            RECTANGLE N 0 596 64 620 
            LINE N 64 608 0 608 
            RECTANGLE N 0 532 64 556 
            LINE N 64 544 0 544 
            LINE N 528 416 592 416 
            RECTANGLE N 0 20 64 44 
            LINE N 64 32 0 32 
            RECTANGLE N 0 84 64 108 
            LINE N 64 96 0 96 
            RECTANGLE N 0 148 64 172 
            LINE N 64 160 0 160 
            RECTANGLE N 0 212 64 236 
            LINE N 64 224 0 224 
            LINE N 64 -736 0 -736 
            LINE N 528 -736 592 -736 
            LINE N 528 -672 592 -672 
            LINE N 528 -608 592 -608 
            LINE N 528 -544 592 -544 
            LINE N 528 -480 592 -480 
            LINE N 528 -416 592 -416 
            LINE N 528 -352 592 -352 
            LINE N 528 -288 592 -288 
            LINE N 528 -224 592 -224 
            RECTANGLE N 528 -172 592 -148 
            LINE N 528 -160 592 -160 
            RECTANGLE N 528 -108 592 -84 
            LINE N 528 -96 592 -96 
            RECTANGLE N 528 -44 592 -20 
            LINE N 528 -32 592 -32 
            RECTANGLE N 64 -768 528 832 
        END BLOCKDEF
        BEGIN BLOCKDEF clk10hz
            TIMESTAMP 2011 4 24 3 12 28
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_14 clk10hz
            PIN clkin XLXN_79
            PIN clkout clk10
        END BLOCK
        BEGIN BLOCK XLXI_22 MAIN
            PIN SYSTEM_CLOCK SYSTEM_CLOCK
            PIN score(6:0) XLXN_43(6:0)
            PIN lives(2:0) XLXN_44(2:0)
            PIN bricki(39:0) XLXN_41(39:0)
            PIN ballx(9:0) XLXN_9(9:0)
            PIN bally(8:0) XLXN_10(8:0)
            PIN padup(9:0)
            PIN padwn(9:0) XLXN_12(9:0)
            PIN LED_0 XLXN_13
            PIN LED_1 XLXN_14
            PIN LED_2 XLXN_15
            PIN LED_3 XLXN_16
            PIN pixel_clock XLXN_79
            PIN VGA_OUT_PIXEL_CLOCK VGA_OUT_PIXEL_CLOCK
            PIN VGA_COMP_SYNCH VGA_COMP_SYNCH
            PIN VGA_OUT_BLANK_Z VGA_OUT_BLANK_Z
            PIN VGA_HSYNCH VGA_HSYNCH
            PIN VGA_VSYNCH VGA_VSYNCH
            PIN pass
            PIN VGA_OUT_RED(7:0) VGA_OUT_RED(7:0)
            PIN VGA_OUT_GREEN(7:0) VGA_OUT_GREEN(7:0)
            PIN VGA_OUT_BLUE(7:0) VGA_OUT_BLUE(7:0)
            PIN finish(1:0) XLXN_80(1:0)
        END BLOCK
        BEGIN BLOCK XLXI_23 mainc
            PIN start start
            PIN clk XLXN_79
            PIN reset reset
            PIN leftdd led
            PIN rightdd rid
            PIN kb_clk kb_clk
            PIN kb_data kb_data
            PIN bricko(39:0) XLXN_41(39:0)
            PIN bally(8:0) XLXN_10(8:0)
            PIN ballx(9:0) XLXN_9(9:0)
            PIN padwno(9:0) XLXN_12(9:0)
            PIN sound(1:0)
            PIN liveo(2:0) XLXN_44(2:0)
            PIN score(6:0) XLXN_43(6:0)
            PIN togscore(1:0)
            PIN finish(1:0) XLXN_80(1:0)
            PIN pausein pausein
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        IOMARKER 944 832 start R180 28
        IOMARKER 944 960 reset R180 28
        IOMARKER 944 1024 led R180 28
        IOMARKER 944 1088 rid R180 28
        BEGIN BRANCH XLXN_10(8:0)
            WIRE 1360 1344 1376 1344
            WIRE 1376 1344 1376 1392
            WIRE 1376 1392 1744 1392
        END BRANCH
        BEGIN BRANCH XLXN_12(9:0)
            WIRE 1360 1536 1376 1536
            WIRE 1376 1520 1376 1536
            WIRE 1376 1520 1744 1520
        END BRANCH
        BEGIN BRANCH VGA_COMP_SYNCH
            WIRE 2336 880 2352 880
            WIRE 2352 880 2352 912
            WIRE 2352 912 2368 912
        END BRANCH
        IOMARKER 2368 912 VGA_COMP_SYNCH R0 28
        BEGIN BRANCH VGA_OUT_BLANK_Z
            WIRE 2336 944 2352 944
            WIRE 2352 944 2352 976
            WIRE 2352 976 2368 976
        END BRANCH
        IOMARKER 2368 976 VGA_OUT_BLANK_Z R0 28
        BEGIN BRANCH VGA_HSYNCH
            WIRE 2336 1008 2352 1008
            WIRE 2352 1008 2352 1040
            WIRE 2352 1040 2368 1040
        END BRANCH
        IOMARKER 2368 1040 VGA_HSYNCH R0 28
        BEGIN BRANCH VGA_VSYNCH
            WIRE 2336 1072 2352 1072
            WIRE 2352 1072 2352 1104
            WIRE 2352 1104 2368 1104
        END BRANCH
        IOMARKER 2368 1104 VGA_VSYNCH R0 28
        BEGIN BRANCH VGA_OUT_RED(7:0)
            WIRE 2336 1136 2352 1136
            WIRE 2352 1136 2352 1168
            WIRE 2352 1168 2368 1168
        END BRANCH
        IOMARKER 2368 1168 VGA_OUT_RED(7:0) R0 28
        BEGIN BRANCH VGA_OUT_GREEN(7:0)
            WIRE 2336 1200 2352 1200
            WIRE 2352 1200 2352 1232
            WIRE 2352 1232 2368 1232
        END BRANCH
        IOMARKER 2368 1232 VGA_OUT_GREEN(7:0) R0 28
        BEGIN BRANCH VGA_OUT_BLUE(7:0)
            WIRE 2336 1264 2352 1264
            WIRE 2352 1264 2352 1296
            WIRE 2352 1296 2368 1296
        END BRANCH
        IOMARKER 2368 1296 VGA_OUT_BLUE(7:0) R0 28
        IOMARKER 2624 848 VGA_OUT_PIXEL_CLOCK R0 28
        BEGIN BRANCH VGA_OUT_PIXEL_CLOCK
            WIRE 2336 816 2608 816
            WIRE 2608 816 2608 848
            WIRE 2608 848 2624 848
        END BRANCH
        IOMARKER 1040 576 SYSTEM_CLOCK R180 28
        BEGIN BRANCH clk10
            WIRE 2960 1520 2960 1616
            WIRE 2960 1616 2992 1616
            WIRE 2960 1520 3440 1520
            WIRE 3440 1520 3440 1792
            WIRE 3360 1792 3440 1792
        END BRANCH
        IOMARKER 2992 1616 clk10 R0 28
        BEGIN INSTANCE XLXI_14 2976 1824 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_22 1744 1296 R0
            BEGIN DISPLAY 0 -888 ATTR InstName
                FONT 28 "Arial"
            END DISPLAY
        END INSTANCE
        BEGIN BRANCH XLXN_13
            WIRE 2336 560 2368 560
            WIRE 2368 560 2368 592
        END BRANCH
        BEGIN BRANCH XLXN_14
            WIRE 2336 624 2368 624
            WIRE 2368 624 2368 656
        END BRANCH
        BEGIN BRANCH XLXN_15
            WIRE 2336 688 2368 688
            WIRE 2368 688 2368 720
        END BRANCH
        BEGIN BRANCH XLXN_16
            WIRE 2336 752 2368 752
            WIRE 2368 752 2368 784
        END BRANCH
        BEGIN BRANCH XLXN_41(39:0)
            WIRE 1360 1664 1552 1664
            WIRE 1552 1664 1552 1840
            WIRE 1552 1840 1744 1840
        END BRANCH
        BEGIN BRANCH XLXN_44(2:0)
            WIRE 1360 1792 1520 1792
            WIRE 1520 1792 1520 1968
            WIRE 1520 1968 1744 1968
        END BRANCH
        BEGIN BRANCH XLXN_9(9:0)
            WIRE 1360 1408 1552 1408
            WIRE 1552 1328 1552 1408
            WIRE 1552 1328 1744 1328
        END BRANCH
        BEGIN BRANCH XLXN_43(6:0)
            WIRE 1360 1120 1536 1120
            WIRE 1536 1120 1536 1904
            WIRE 1536 1904 1744 1904
        END BRANCH
        BEGIN BRANCH rid
            WIRE 944 1088 976 1088
        END BRANCH
        BEGIN BRANCH led
            WIRE 944 1024 976 1024
        END BRANCH
        BEGIN BRANCH reset
            WIRE 944 960 976 960
        END BRANCH
        BEGIN BRANCH start
            WIRE 944 832 976 832
        END BRANCH
        BEGIN INSTANCE XLXI_23 976 1312 R0
        END INSTANCE
        BEGIN BRANCH SYSTEM_CLOCK
            WIRE 608 736 608 912
            WIRE 608 736 1152 736
            WIRE 1040 576 1152 576
            WIRE 1152 576 1392 576
            WIRE 1152 576 1152 736
            WIRE 1392 560 1744 560
            WIRE 1392 560 1392 576
        END BRANCH
        BEGIN BRANCH XLXN_79
            WIRE 816 880 928 880
            WIRE 928 880 928 896
            WIRE 928 896 976 896
            WIRE 816 880 816 1808
            WIRE 816 1808 2608 1808
            WIRE 2336 1712 2464 1712
            WIRE 2464 1680 2464 1712
            WIRE 2464 1680 2608 1680
            WIRE 2608 1680 2608 1808
            WIRE 2608 1616 2944 1616
            WIRE 2944 1616 2944 1792
            WIRE 2944 1792 2976 1792
            WIRE 2944 1792 2944 1904
            WIRE 2944 1904 3312 1904
            WIRE 3312 1904 3312 2112
            WIRE 2608 1616 2608 1680
            WIRE 3248 2112 3312 2112
        END BRANCH
        BEGIN BRANCH XLXN_80(1:0)
            WIRE 1360 1920 1504 1920
            WIRE 1504 1920 1504 2096
            WIRE 1504 2096 1744 2096
        END BRANCH
        BEGIN BRANCH kb_clk
            WIRE 944 1984 976 1984
        END BRANCH
        IOMARKER 944 1984 kb_clk R180 28
        BEGIN BRANCH kb_data
            WIRE 944 2048 976 2048
        END BRANCH
        IOMARKER 944 2048 kb_data R180 28
        BEGIN BRANCH pausein
            WIRE 944 2112 976 2112
        END BRANCH
        IOMARKER 944 2112 pausein R180 28
    END SHEET
END SCHEMATIC
