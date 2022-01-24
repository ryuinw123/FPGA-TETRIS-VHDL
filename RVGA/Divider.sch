<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CLKOUT" />
        <signal name="XLXN_2" />
        <signal name="CLKIN" />
        <port polarity="Output" name="CLKOUT" />
        <port polarity="Input" name="CLKIN" />
        <blockdef name="fd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
        </blockdef>
        <block symbolname="fd" name="XLXI_1">
            <blockpin signalname="CLKIN" name="C" />
            <blockpin signalname="XLXN_2" name="D" />
            <blockpin signalname="CLKOUT" name="Q" />
        </block>
        <block symbolname="inv" name="XLXI_2">
            <blockpin signalname="CLKOUT" name="I" />
            <blockpin signalname="XLXN_2" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1216" y="992" name="XLXI_1" orien="R0" />
        <instance x="1488" y="464" name="XLXI_2" orien="R180" />
        <branch name="CLKOUT">
            <wire x2="1616" y1="496" y2="496" x1="1488" />
            <wire x2="1616" y1="496" y2="736" x1="1616" />
            <wire x2="1808" y1="736" y2="736" x1="1616" />
            <wire x2="1616" y1="736" y2="736" x1="1600" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1200" y1="496" y2="736" x1="1200" />
            <wire x2="1216" y1="736" y2="736" x1="1200" />
            <wire x2="1264" y1="496" y2="496" x1="1200" />
        </branch>
        <branch name="CLKIN">
            <wire x2="1216" y1="864" y2="864" x1="1184" />
        </branch>
        <iomarker fontsize="28" x="1184" y="864" name="CLKIN" orien="R180" />
        <iomarker fontsize="28" x="1808" y="736" name="CLKOUT" orien="R0" />
    </sheet>
</drawing>