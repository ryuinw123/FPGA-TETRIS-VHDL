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
        <signal name="CLK_OUT" />
        <signal name="XLXN_15" />
        <signal name="XLXN_16" />
        <signal name="CLK_IN" />
        <signal name="XLXN_17" />
        <signal name="XLXN_20" />
        <signal name="XLXN_21" />
        <signal name="XLXN_22" />
        <signal name="XLXN_24" />
        <signal name="XLXN_25" />
        <signal name="XLXN_26" />
        <signal name="XLXN_27" />
        <port polarity="Output" name="CLK_OUT" />
        <port polarity="Input" name="CLK_IN" />
        <blockdef name="Divider">
            <timestamp>2020-11-25T10:15:29</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="Divider" name="XLXI_2">
            <blockpin signalname="CLK_IN" name="CLKIN" />
            <blockpin signalname="XLXN_1" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_3">
            <blockpin signalname="XLXN_1" name="CLKIN" />
            <blockpin signalname="XLXN_2" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_5">
            <blockpin signalname="XLXN_2" name="CLKIN" />
            <blockpin signalname="XLXN_3" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_6">
            <blockpin signalname="XLXN_3" name="CLKIN" />
            <blockpin signalname="XLXN_4" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_7">
            <blockpin signalname="XLXN_4" name="CLKIN" />
            <blockpin signalname="XLXN_5" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_8">
            <blockpin signalname="XLXN_5" name="CLKIN" />
            <blockpin signalname="XLXN_15" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_9">
            <blockpin signalname="XLXN_15" name="CLKIN" />
            <blockpin signalname="XLXN_6" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_10">
            <blockpin signalname="XLXN_6" name="CLKIN" />
            <blockpin signalname="XLXN_7" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_11">
            <blockpin signalname="XLXN_7" name="CLKIN" />
            <blockpin signalname="XLXN_8" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_12">
            <blockpin signalname="XLXN_8" name="CLKIN" />
            <blockpin signalname="XLXN_9" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_13">
            <blockpin signalname="XLXN_9" name="CLKIN" />
            <blockpin signalname="XLXN_10" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_14">
            <blockpin signalname="XLXN_10" name="CLKIN" />
            <blockpin signalname="XLXN_11" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_15">
            <blockpin signalname="XLXN_11" name="CLKIN" />
            <blockpin signalname="XLXN_16" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_16">
            <blockpin signalname="XLXN_16" name="CLKIN" />
            <blockpin signalname="XLXN_17" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_18">
            <blockpin signalname="XLXN_27" name="CLKIN" />
            <blockpin signalname="CLK_OUT" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_22">
            <blockpin signalname="XLXN_17" name="CLKIN" />
            <blockpin signalname="XLXN_21" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_23">
            <blockpin signalname="XLXN_22" name="CLKIN" />
            <blockpin signalname="XLXN_25" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_25">
            <blockpin signalname="XLXN_24" name="CLKIN" />
            <blockpin signalname="XLXN_27" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_26">
            <blockpin signalname="XLXN_21" name="CLKIN" />
            <blockpin signalname="XLXN_22" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_27">
            <blockpin signalname="XLXN_25" name="CLKIN" />
            <blockpin signalname="XLXN_26" name="CLKOUT" />
        </block>
        <block symbolname="Divider" name="XLXI_28">
            <blockpin signalname="XLXN_26" name="CLKIN" />
            <blockpin signalname="XLXN_24" name="CLKOUT" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="880" y="976" name="XLXI_2" orien="R0">
        </instance>
        <branch name="XLXN_1">
            <wire x2="1296" y1="944" y2="944" x1="1264" />
        </branch>
        <instance x="1296" y="976" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_2">
            <wire x2="1712" y1="944" y2="944" x1="1680" />
        </branch>
        <instance x="1712" y="976" name="XLXI_5" orien="R0">
        </instance>
        <branch name="XLXN_3">
            <wire x2="2128" y1="944" y2="944" x1="2096" />
        </branch>
        <instance x="2128" y="976" name="XLXI_6" orien="R0">
        </instance>
        <branch name="XLXN_4">
            <wire x2="2544" y1="944" y2="944" x1="2512" />
        </branch>
        <instance x="2544" y="976" name="XLXI_7" orien="R0">
        </instance>
        <branch name="XLXN_5">
            <wire x2="2960" y1="944" y2="944" x1="2928" />
        </branch>
        <instance x="2960" y="976" name="XLXI_8" orien="R0">
        </instance>
        <instance x="336" y="1216" name="XLXI_9" orien="R0">
        </instance>
        <branch name="XLXN_6">
            <wire x2="752" y1="1184" y2="1184" x1="720" />
        </branch>
        <instance x="752" y="1216" name="XLXI_10" orien="R0">
        </instance>
        <branch name="XLXN_7">
            <wire x2="1168" y1="1184" y2="1184" x1="1136" />
        </branch>
        <instance x="1168" y="1216" name="XLXI_11" orien="R0">
        </instance>
        <branch name="XLXN_8">
            <wire x2="1584" y1="1184" y2="1184" x1="1552" />
        </branch>
        <instance x="1584" y="1216" name="XLXI_12" orien="R0">
        </instance>
        <branch name="XLXN_9">
            <wire x2="2000" y1="1184" y2="1184" x1="1968" />
        </branch>
        <instance x="2000" y="1216" name="XLXI_13" orien="R0">
        </instance>
        <branch name="XLXN_10">
            <wire x2="2416" y1="1184" y2="1184" x1="2384" />
        </branch>
        <instance x="2416" y="1216" name="XLXI_14" orien="R0">
        </instance>
        <branch name="XLXN_11">
            <wire x2="2832" y1="1184" y2="1184" x1="2800" />
        </branch>
        <instance x="2832" y="1216" name="XLXI_15" orien="R0">
        </instance>
        <instance x="528" y="1424" name="XLXI_16" orien="R0">
        </instance>
        <instance x="1360" y="1424" name="XLXI_18" orien="R0">
        </instance>
        <branch name="CLK_OUT">
            <wire x2="1808" y1="1392" y2="1392" x1="1744" />
        </branch>
        <branch name="XLXN_15">
            <wire x2="336" y1="1184" y2="1184" x1="256" />
            <wire x2="256" y1="1184" y2="1280" x1="256" />
            <wire x2="3424" y1="1280" y2="1280" x1="256" />
            <wire x2="3424" y1="944" y2="944" x1="3344" />
            <wire x2="3424" y1="944" y2="1280" x1="3424" />
        </branch>
        <branch name="XLXN_16">
            <wire x2="528" y1="1392" y2="1392" x1="464" />
            <wire x2="464" y1="1392" y2="1488" x1="464" />
            <wire x2="3264" y1="1488" y2="1488" x1="464" />
            <wire x2="3264" y1="1184" y2="1184" x1="3216" />
            <wire x2="3264" y1="1184" y2="1488" x1="3264" />
        </branch>
        <branch name="CLK_IN">
            <wire x2="880" y1="944" y2="944" x1="848" />
        </branch>
        <iomarker fontsize="28" x="848" y="944" name="CLK_IN" orien="R180" />
        <iomarker fontsize="28" x="1808" y="1392" name="CLK_OUT" orien="R0" />
        <instance x="592" y="1712" name="XLXI_22" orien="R0">
        </instance>
        <branch name="XLXN_17">
            <wire x2="512" y1="1584" y2="1680" x1="512" />
            <wire x2="592" y1="1680" y2="1680" x1="512" />
            <wire x2="944" y1="1584" y2="1584" x1="512" />
            <wire x2="928" y1="1392" y2="1392" x1="912" />
            <wire x2="944" y1="1392" y2="1392" x1="928" />
            <wire x2="944" y1="1392" y2="1584" x1="944" />
        </branch>
        <instance x="1056" y="1904" name="XLXI_23" orien="R0">
        </instance>
        <instance x="1984" y="1904" name="XLXI_25" orien="R0">
        </instance>
        <instance x="624" y="1904" name="XLXI_26" orien="R0">
        </instance>
        <branch name="XLXN_21">
            <wire x2="624" y1="1872" y2="1872" x1="560" />
            <wire x2="560" y1="1872" y2="1968" x1="560" />
            <wire x2="1456" y1="1968" y2="1968" x1="560" />
            <wire x2="1008" y1="1680" y2="1680" x1="976" />
            <wire x2="1008" y1="1664" y2="1680" x1="1008" />
            <wire x2="1040" y1="1664" y2="1664" x1="1008" />
            <wire x2="1424" y1="1664" y2="1664" x1="1040" />
            <wire x2="1440" y1="1664" y2="1664" x1="1424" />
            <wire x2="1440" y1="1648" y2="1664" x1="1440" />
            <wire x2="1456" y1="1648" y2="1648" x1="1440" />
            <wire x2="1456" y1="1648" y2="1968" x1="1456" />
        </branch>
        <branch name="XLXN_22">
            <wire x2="1056" y1="1872" y2="1872" x1="1008" />
        </branch>
        <branch name="XLXN_24">
            <wire x2="1984" y1="1872" y2="1872" x1="1872" />
            <wire x2="1872" y1="1872" y2="1968" x1="1872" />
            <wire x2="2144" y1="1968" y2="1968" x1="1872" />
            <wire x2="2144" y1="1968" y2="2160" x1="2144" />
            <wire x2="2144" y1="2160" y2="2160" x1="2080" />
        </branch>
        <instance x="960" y="2208" name="XLXI_27" orien="R0">
        </instance>
        <instance x="1696" y="2192" name="XLXI_28" orien="R0">
        </instance>
        <branch name="XLXN_25">
            <wire x2="960" y1="2176" y2="2176" x1="896" />
            <wire x2="896" y1="2176" y2="2272" x1="896" />
            <wire x2="1488" y1="2272" y2="2272" x1="896" />
            <wire x2="1488" y1="1872" y2="1872" x1="1440" />
            <wire x2="1488" y1="1872" y2="2272" x1="1488" />
        </branch>
        <branch name="XLXN_26">
            <wire x2="1520" y1="2176" y2="2176" x1="1344" />
            <wire x2="1520" y1="2160" y2="2176" x1="1520" />
            <wire x2="1696" y1="2160" y2="2160" x1="1520" />
        </branch>
        <branch name="XLXN_27">
            <wire x2="1360" y1="1392" y2="1392" x1="1280" />
            <wire x2="1280" y1="1392" y2="1472" x1="1280" />
            <wire x2="1888" y1="1472" y2="1472" x1="1280" />
            <wire x2="1888" y1="1472" y2="1680" x1="1888" />
            <wire x2="1856" y1="1648" y2="1648" x1="1840" />
            <wire x2="1856" y1="1648" y2="1680" x1="1856" />
            <wire x2="1888" y1="1680" y2="1680" x1="1856" />
            <wire x2="1840" y1="1648" y2="1792" x1="1840" />
            <wire x2="2432" y1="1792" y2="1792" x1="1840" />
            <wire x2="2432" y1="1792" y2="1872" x1="2432" />
            <wire x2="2432" y1="1872" y2="1872" x1="2368" />
        </branch>
    </sheet>
</drawing>