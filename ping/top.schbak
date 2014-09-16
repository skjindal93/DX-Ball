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
        SIGNAL leu
        SIGNAL riu
        SIGNAL speed
        SIGNAL XLXN_9(9:0)
        SIGNAL XLXN_10(8:0)
        SIGNAL XLXN_11(9:0)
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
        SIGNAL SYSTEM_CLOCK
        SIGNAL clk10
        SIGNAL XLXN_38
        PORT Input start
        PORT Input reset
        PORT Input led
        PORT Input rid
        PORT Input leu
        PORT Input riu
        PORT Input speed
        PORT Output VGA_COMP_SYNCH
        PORT Output VGA_OUT_BLANK_Z
        PORT Output VGA_HSYNCH
        PORT Output VGA_VSYNCH
        PORT Output VGA_OUT_RED(7:0)
        PORT Output VGA_OUT_GREEN(7:0)
        PORT Output VGA_OUT_BLUE(7:0)
        PORT Output VGA_OUT_PIXEL_CLOCK
        PORT Input SYSTEM_CLOCK
        PORT Output clk10
        BEGIN BLOCKDEF mainc
            TIMESTAMP 2011 4 22 18 55 28
            RECTANGLE N 320 20 384 44 
            LINE N 320 32 384 32 
            RECTANGLE N 320 84 384 108 
            LINE N 320 96 384 96 
            RECTANGLE N 320 148 384 172 
            LINE N 320 160 384 160 
            RECTANGLE N 320 212 384 236 
            LINE N 320 224 384 224 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 320 -204 384 -180 
            LINE N 320 -192 384 -192 
            RECTANGLE N 320 -60 384 -36 
            LINE N 320 -48 384 -48 
            RECTANGLE N 64 -512 320 256 
        END BLOCKDEF
        BEGIN BLOCKDEF MAIN
            TIMESTAMP 2011 4 24 3 58 44
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
            RECTANGLE N 64 -768 528 448 
        END BLOCKDEF
        BEGIN BLOCKDEF clk10hz
            TIMESTAMP 2011 4 24 3 12 27
            RECTANGLE N 64 -64 320 0 
            LINE N 64 -32 0 -32 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_4 mainc
            PIN start start
            PIN clk XLXN_38
            PIN reset reset
            PIN leftdd led
            PIN rightdd rid
            PIN leftuu leu
            PIN rightuu riu
            PIN speed speed
            PIN score(7:0)
            PIN togscore(1:0)
            PIN bally(8:0) XLXN_10(8:0)
            PIN ballx(9:0) XLXN_9(9:0)
            PIN padupo(9:0) XLXN_11(9:0)
            PIN padwno(9:0) XLXN_12(9:0)
        END BLOCK
        BEGIN BLOCK XLXI_14 clk10hz
            PIN clkin XLXN_38
            PIN clkout clk10
        END BLOCK
        BEGIN BLOCK XLXI_22 MAIN
            PIN SYSTEM_CLOCK SYSTEM_CLOCK
            PIN ballx(9:0) XLXN_9(9:0)
            PIN bally(8:0) XLXN_10(8:0)
            PIN padup(9:0) XLXN_11(9:0)
            PIN padwn(9:0) XLXN_12(9:0)
            PIN LED_0 XLXN_13
            PIN LED_1 XLXN_14
            PIN LED_2 XLXN_15
            PIN LED_3 XLXN_16
            PIN VGA_OUT_PIXEL_CLOCK VGA_OUT_PIXEL_CLOCK
            PIN VGA_COMP_SYNCH VGA_COMP_SYNCH
            PIN VGA_OUT_BLANK_Z VGA_OUT_BLANK_Z
            PIN VGA_HSYNCH VGA_HSYNCH
            PIN VGA_VSYNCH VGA_VSYNCH
            PIN VGA_OUT_RED(7:0) VGA_OUT_RED(7:0)
            PIN VGA_OUT_GREEN(7:0) VGA_OUT_GREEN(7:0)
            PIN VGA_OUT_BLUE(7:0) VGA_OUT_BLUE(7:0)
            PIN pixel_clock XLXN_38
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_4 976 1312 R0
        END INSTANCE
        BEGIN BRANCH start
            WIRE 944 832 976 832
        END BRANCH
        IOMARKER 944 832 start R180 28
        BEGIN BRANCH reset
            WIRE 944 960 976 960
        END BRANCH
        IOMARKER 944 960 reset R180 28
        BEGIN BRANCH led
            WIRE 944 1024 976 1024
        END BRANCH
        IOMARKER 944 1024 led R180 28
        BEGIN BRANCH rid
            WIRE 944 1088 976 1088
        END BRANCH
        IOMARKER 944 1088 rid R180 28
        BEGIN BRANCH leu
            WIRE 944 1152 976 1152
        END BRANCH
        IOMARKER 944 1152 leu R180 28
        BEGIN BRANCH riu
            WIRE 944 1216 976 1216
        END BRANCH
        IOMARKER 944 1216 riu R180 28
        BEGIN BRANCH speed
            WIRE 944 1280 976 1280
        END BRANCH
        IOMARKER 944 1280 speed R180 28
        BEGIN BRANCH XLXN_9(9:0)
            WIRE 1360 1408 1552 1408
            WIRE 1552 1360 1552 1408
            WIRE 1552 1360 1744 1360
        END BRANCH
        BEGIN BRANCH XLXN_10(8:0)
            WIRE 1360 1344 1536 1344
            WIRE 1536 1344 1536 1424
            WIRE 1536 1424 1744 1424
        END BRANCH
        BEGIN BRANCH XLXN_11(9:0)
            WIRE 1360 1472 1552 1472
            WIRE 1552 1472 1552 1488
            WIRE 1552 1488 1744 1488
        END BRANCH
        BEGIN BRANCH XLXN_12(9:0)
            WIRE 1360 1536 1552 1536
            WIRE 1552 1536 1552 1552
            WIRE 1552 1552 1744 1552
        END BRANCH
        BEGIN BRANCH XLXN_13
            WIRE 2336 592 2368 592
        END BRANCH
        BEGIN BRANCH XLXN_14
            WIRE 2336 656 2368 656
        END BRANCH
        BEGIN BRANCH XLXN_15
            WIRE 2336 720 2368 720
        END BRANCH
        BEGIN BRANCH XLXN_16
            WIRE 2336 784 2368 784
        END BRANCH
        BEGIN BRANCH VGA_COMP_SYNCH
            WIRE 2336 912 2368 912
        END BRANCH
        IOMARKER 2368 912 VGA_COMP_SYNCH R0 28
        BEGIN BRANCH VGA_OUT_BLANK_Z
            WIRE 2336 976 2368 976
        END BRANCH
        IOMARKER 2368 976 VGA_OUT_BLANK_Z R0 28
        BEGIN BRANCH VGA_HSYNCH
            WIRE 2336 1040 2368 1040
        END BRANCH
        IOMARKER 2368 1040 VGA_HSYNCH R0 28
        BEGIN BRANCH VGA_VSYNCH
            WIRE 2336 1104 2368 1104
        END BRANCH
        IOMARKER 2368 1104 VGA_VSYNCH R0 28
        BEGIN BRANCH VGA_OUT_RED(7:0)
            WIRE 2336 1168 2368 1168
        END BRANCH
        IOMARKER 2368 1168 VGA_OUT_RED(7:0) R0 28
        BEGIN BRANCH VGA_OUT_GREEN(7:0)
            WIRE 2336 1232 2368 1232
        END BRANCH
        IOMARKER 2368 1232 VGA_OUT_GREEN(7:0) R0 28
        BEGIN BRANCH VGA_OUT_BLUE(7:0)
            WIRE 2336 1296 2368 1296
        END BRANCH
        IOMARKER 2368 1296 VGA_OUT_BLUE(7:0) R0 28
        IOMARKER 2624 848 VGA_OUT_PIXEL_CLOCK R0 28
        BEGIN BRANCH VGA_OUT_PIXEL_CLOCK
            WIRE 2336 848 2624 848
        END BRANCH
        IOMARKER 1040 576 SYSTEM_CLOCK R180 28
        BEGIN BRANCH SYSTEM_CLOCK
            WIRE 608 736 608 880
            WIRE 608 880 656 880
            WIRE 608 736 1200 736
            WIRE 1040 576 1200 576
            WIRE 1200 576 1328 576
            WIRE 1328 576 1328 640
            WIRE 1328 640 1536 640
            WIRE 1200 576 1200 736
            WIRE 1536 592 1536 640
            WIRE 1536 592 1744 592
        END BRANCH
        BEGIN BRANCH clk10
            WIRE 2960 1520 2960 1616
            WIRE 2960 1616 2992 1616
            WIRE 2960 1520 3440 1520
            WIRE 3440 1520 3440 1792
            WIRE 3360 1792 3440 1792
        END BRANCH
        IOMARKER 2992 1616 clk10 R0 28
        BEGIN BRANCH XLXN_38
            WIRE 816 880 928 880
            WIRE 928 880 928 896
            WIRE 928 896 976 896
            WIRE 816 880 816 1808
            WIRE 816 1808 2608 1808
            WIRE 2336 1744 2432 1744
            WIRE 2432 1680 2608 1680
            WIRE 2608 1680 2608 1808
            WIRE 2432 1680 2432 1744
            WIRE 2608 1616 2944 1616
            WIRE 2944 1616 2944 1792
            WIRE 2944 1792 2976 1792
            WIRE 2944 1792 2944 1904
            WIRE 2944 1904 3312 1904
            WIRE 3312 1904 3312 2112
            WIRE 2608 1616 2608 1680
            WIRE 3248 2112 3312 2112
        END BRANCH
        BEGIN INSTANCE XLXI_14 2976 1824 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_22 1744 1328 R0
            BEGIN DISPLAY 0 -888 ATTR InstName
                FONT 28 "Arial"
            END DISPLAY
        END INSTANCE
    END SHEET
END SCHEMATIC
