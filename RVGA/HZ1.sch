<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6" />
        <signal name="XLXN_7" />
        <signal name="XLXN_8" />
        <signal name="XLXN_9" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="XLXN_13" />
        <signal name="XLXN_14" />
        <signal name="XLXN_15" />
        <signal name="XLXN_16" />
        <signal name="XLXN_17" />
        <signal name="XLXN_18" />
        <signal name="XLXN_19" />
        <signal name="XLXN_20" />
        <signal name="XLXN_21" />
        <signal name="XLXN_22" />
        <signal name="XLXN_23" />
        <signal name="XLXN_26" />
        <signal name="CLK_IN" />
        <signal name="CLK_OUT" />
        <port polarity="Input" name="CLK_IN" />
        <port polarity="Output" name="CLK_OUT" />
        <blockdef name="Divider">
            <timestamp>2020-11-25T10:15:29</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="Divider" name="XLXI_1">
            <blockpin signalname="CLK_IN" name="CLKIN" />
            <blockpin signalname="XLXN_1" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_2">
            <blockpin signalname="XLXN_1" name="CLKIN" />
            <blockpin signalname="XLXN_2" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_3">
            <blockpin signalname="XLXN_2" name="CLKIN" />
            <blockpin signalname="XLXN_3" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_4">
            <blockpin signalname="XLXN_3" name="CLKIN" />
            <blockpin signalname="XLXN_4" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_5">
            <blockpin signalname="XLXN_4" name="CLKIN" />
            <blockpin signalname="XLXN_5" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_6">
            <blockpin signalname="XLXN_5" name="CLKIN" />
            <blockpin signalname="XLXN_6" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_7">
            <blockpin signalname="XLXN_6" name="CLKIN" />
            <blockpin signalname="XLXN_22" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_8">
            <blockpin signalname="XLXN_22" name="CLKIN" />
            <blockpin signalname="XLXN_7" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_9">
            <blockpin signalname="XLXN_7" name="CLKIN" />
            <blockpin signalname="XLXN_8" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_10">
            <blockpin signalname="XLXN_8" name="CLKIN" />
            <blockpin signalname="XLXN_9" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_11">
            <blockpin signalname="XLXN_9" name="CLKIN" />
            <blockpin signalname="XLXN_10" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_12">
            <blockpin signalname="XLXN_10" name="CLKIN" />
            <blockpin signalname="XLXN_11" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_13">
            <blockpin signalname="XLXN_11" name="CLKIN" />
            <blockpin signalname="XLXN_12" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_14">
            <blockpin signalname="XLXN_12" name="CLKIN" />
            <blockpin signalname="XLXN_23" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_15">
            <blockpin signalname="XLXN_23" name="CLKIN" />
            <blockpin signalname="XLXN_13" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_16">
            <blockpin signalname="XLXN_13" name="CLKIN" />
            <blockpin signalname="XLXN_14" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_17">
            <blockpin signalname="XLXN_14" name="CLKIN" />
            <blockpin signalname="XLXN_15" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_18">
            <blockpin signalname="XLXN_15" name="CLKIN" />
            <blockpin signalname="XLXN_16" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_19">
            <blockpin signalname="XLXN_16" name="CLKIN" />
            <blockpin signalname="XLXN_17" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_20">
            <blockpin signalname="XLXN_17" name="CLKIN" />
            <blockpin signalname="XLXN_18" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_21">
            <blockpin signalname="XLXN_18" name="CLKIN" />
            <blockpin signalname="XLXN_19" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_22">
            <blockpin signalname="XLXN_19" name="CLKIN" />
            <blockpin signalname="XLXN_26" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_25">
            <blockpin signalname="XLXN_21" name="CLKIN" />
            <blockpin signalname="CLK_OUT" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_24">
            <blockpin signalname="XLXN_20" name="CLKIN" />
            <blockpin signalname="XLXN_21" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_23">
            <blockpin signalname="XLXN_26" name="CLKIN" />
            <blockpin signalname="XLXN_20" name="CLKOUT" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="384" y="608" name="XLXI_1" orien="R0">
        </instance>
        <branch name="XLXN_1">
            <wire x2="800" y1="576" y2="576" x1="768" />
        </branch>
        <instance x="800" y="608" name="XLXI_2" orien="R0">
        </instance>
        <branch name="XLXN_2">
            <wire x2="1216" y1="576" y2="576" x1="1184" />
        </branch>
        <instance x="1216" y="608" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_3">
            <wire x2="1632" y1="576" y2="576" x1="1600" />
        </branch>
        <instance x="1632" y="608" name="XLXI_4" orien="R0">
        </instance>
        <branch name="XLXN_4">
            <wire x2="2048" y1="576" y2="576" x1="2016" />
        </branch>
        <instance x="2048" y="608" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_5">
            <wire x2="2464" y1="576" y2="576" x1="2432" />
        </branch>
        <instance x="2464" y="608" name="XLXI_6" orien="R0">
        </instance>
        <branch name="XLXN_6">
            <wire x2="2880" y1="576" y2="576" x1="2848" />
        </branch>
        <instance x="2880" y="608" name="XLXI_7" orien="R0">
        </instance>
        <instance x="320" y="832" name="XLXI_8" orien="R0">
        </instance>
        <branch name="XLXN_7">
            <wire x2="736" y1="800" y2="800" x1="704" />
        </branch>
        <instance x="736" y="832" name="XLXI_9" orien="R0">
        </instance>
        <branch name="XLXN_8">
            <wire x2="1152" y1="800" y2="800" x1="1120" />
        </branch>
        <instance x="1152" y="832" name="XLXI_10" orien="R0">
        </instance>
        <branch name="XLXN_9">
            <wire x2="1568" y1="800" y2="800" x1="1536" />
        </branch>
        <instance x="1568" y="832" name="XLXI_11" orien="R0">
        </instance>
        <branch name="XLXN_10">
            <wire x2="1984" y1="800" y2="800" x1="1952" />
        </branch>
        <instance x="1984" y="832" name="XLXI_12" orien="R0">
        </instance>
        <branch name="XLXN_11">
            <wire x2="2400" y1="800" y2="800" x1="2368" />
        </branch>
        <instance x="2400" y="832" name="XLXI_13" orien="R0">
        </instance>
        <branch name="XLXN_12">
            <wire x2="2816" y1="800" y2="800" x1="2784" />
        </branch>
        <instance x="2816" y="832" name="XLXI_14" orien="R0">
        </instance>
        <instance x="192" y="1072" name="XLXI_15" orien="R0">
        </instance>
        <branch name="XLXN_13">
            <wire x2="608" y1="1040" y2="1040" x1="576" />
        </branch>
        <instance x="608" y="1072" name="XLXI_16" orien="R0">
        </instance>
        <branch name="XLXN_14">
            <wire x2="1024" y1="1040" y2="1040" x1="992" />
        </branch>
        <instance x="1024" y="1072" name="XLXI_17" orien="R0">
        </instance>
        <branch name="XLXN_15">
            <wire x2="1440" y1="1040" y2="1040" x1="1408" />
        </branch>
        <instance x="1440" y="1072" name="XLXI_18" orien="R0">
        </instance>
        <branch name="XLXN_16">
            <wire x2="1856" y1="1040" y2="1040" x1="1824" />
        </branch>
        <instance x="1856" y="1072" name="XLXI_19" orien="R0">
        </instance>
        <branch name="XLXN_17">
            <wire x2="2272" y1="1040" y2="1040" x1="2240" />
        </branch>
        <instance x="2272" y="1072" name="XLXI_20" orien="R0">
        </instance>
        <branch name="XLXN_18">
            <wire x2="2688" y1="1040" y2="1040" x1="2656" />
        </branch>
        <instance x="2688" y="1072" name="XLXI_21" orien="R0">
        </instance>
        <branch name="XLXN_20">
            <wire x2="672" y1="1472" y2="1472" x1="544" />
        </branch>
        <branch name="XLXN_22">
            <wire x2="256" y1="688" y2="800" x1="256" />
            <wire x2="320" y1="800" y2="800" x1="256" />
            <wire x2="3312" y1="688" y2="688" x1="256" />
            <wire x2="3312" y1="576" y2="576" x1="3264" />
            <wire x2="3312" y1="576" y2="688" x1="3312" />
        </branch>
        <branch name="XLXN_23">
            <wire x2="192" y1="1040" y2="1040" x1="128" />
            <wire x2="128" y1="1040" y2="1136" x1="128" />
            <wire x2="3504" y1="1136" y2="1136" x1="128" />
            <wire x2="3504" y1="800" y2="800" x1="3200" />
            <wire x2="3504" y1="800" y2="1136" x1="3504" />
        </branch>
        <instance x="160" y="1504" name="XLXI_23" orien="R0">
        </instance>
        <instance x="672" y="1504" name="XLXI_24" orien="R0">
        </instance>
        <instance x="1168" y="1552" name="XLXI_25" orien="R0">
        </instance>
        <branch name="XLXN_21">
            <wire x2="1072" y1="1472" y2="1472" x1="1056" />
            <wire x2="1072" y1="1472" y2="1520" x1="1072" />
            <wire x2="1168" y1="1520" y2="1520" x1="1072" />
        </branch>
        <instance x="2896" y="1248" name="XLXI_22" orien="R0">
        </instance>
        <branch name="XLXN_19">
            <wire x2="2832" y1="1120" y2="1216" x1="2832" />
            <wire x2="2896" y1="1216" y2="1216" x1="2832" />
            <wire x2="3088" y1="1120" y2="1120" x1="2832" />
            <wire x2="3088" y1="1040" y2="1040" x1="3072" />
            <wire x2="3088" y1="1040" y2="1120" x1="3088" />
        </branch>
        <branch name="XLXN_26">
            <wire x2="96" y1="1360" y2="1472" x1="96" />
            <wire x2="160" y1="1472" y2="1472" x1="96" />
            <wire x2="3360" y1="1360" y2="1360" x1="96" />
            <wire x2="3360" y1="1216" y2="1216" x1="3280" />
            <wire x2="3360" y1="1216" y2="1360" x1="3360" />
        </branch>
        <branch name="CLK_IN">
            <wire x2="384" y1="576" y2="576" x1="352" />
        </branch>
        <iomarker fontsize="28" x="352" y="576" name="CLK_IN" orien="R180" />
        <branch name="CLK_OUT">
            <wire x2="1584" y1="1520" y2="1520" x1="1552" />
        </branch>
        <iomarker fontsize="28" x="1584" y="1520" name="CLK_OUT" orien="R0" />
    </sheet>
</drawing>