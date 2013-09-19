<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE eagle SYSTEM "eagle.dtd">
<eagle version="6.3">
<drawing>
<settings>
<setting alwaysvectorfont="no"/>
<setting verticaltext="up"/>
</settings>
<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/>
<layers>
<layer number="1" name="Top" color="4" fill="1" visible="no" active="no"/>
<layer number="16" name="Bottom" color="1" fill="1" visible="no" active="no"/>
<layer number="17" name="Pads" color="2" fill="1" visible="no" active="no"/>
<layer number="18" name="Vias" color="2" fill="1" visible="no" active="no"/>
<layer number="19" name="Unrouted" color="6" fill="1" visible="no" active="no"/>
<layer number="20" name="Dimension" color="15" fill="1" visible="no" active="no"/>
<layer number="21" name="tPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="22" name="bPlace" color="7" fill="1" visible="no" active="no"/>
<layer number="23" name="tOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="24" name="bOrigins" color="15" fill="1" visible="no" active="no"/>
<layer number="25" name="tNames" color="7" fill="1" visible="no" active="no"/>
<layer number="26" name="bNames" color="7" fill="1" visible="no" active="no"/>
<layer number="27" name="tValues" color="7" fill="1" visible="no" active="no"/>
<layer number="28" name="bValues" color="7" fill="1" visible="no" active="no"/>
<layer number="29" name="tStop" color="7" fill="3" visible="no" active="no"/>
<layer number="30" name="bStop" color="7" fill="6" visible="no" active="no"/>
<layer number="31" name="tCream" color="7" fill="4" visible="no" active="no"/>
<layer number="32" name="bCream" color="7" fill="5" visible="no" active="no"/>
<layer number="33" name="tFinish" color="6" fill="3" visible="no" active="no"/>
<layer number="34" name="bFinish" color="6" fill="6" visible="no" active="no"/>
<layer number="35" name="tGlue" color="7" fill="4" visible="no" active="no"/>
<layer number="36" name="bGlue" color="7" fill="5" visible="no" active="no"/>
<layer number="37" name="tTest" color="7" fill="1" visible="no" active="no"/>
<layer number="38" name="bTest" color="7" fill="1" visible="no" active="no"/>
<layer number="39" name="tKeepout" color="4" fill="11" visible="no" active="no"/>
<layer number="40" name="bKeepout" color="1" fill="11" visible="no" active="no"/>
<layer number="41" name="tRestrict" color="4" fill="10" visible="no" active="no"/>
<layer number="42" name="bRestrict" color="1" fill="10" visible="no" active="no"/>
<layer number="43" name="vRestrict" color="2" fill="10" visible="no" active="no"/>
<layer number="44" name="Drills" color="7" fill="1" visible="no" active="no"/>
<layer number="45" name="Holes" color="7" fill="1" visible="no" active="no"/>
<layer number="46" name="Milling" color="3" fill="1" visible="no" active="no"/>
<layer number="47" name="Measures" color="7" fill="1" visible="no" active="no"/>
<layer number="48" name="Document" color="7" fill="1" visible="no" active="no"/>
<layer number="49" name="Reference" color="7" fill="1" visible="no" active="no"/>
<layer number="51" name="tDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="52" name="bDocu" color="7" fill="1" visible="no" active="no"/>
<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/>
<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/>
<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/>
<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/>
<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/>
<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/>
<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/>
<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/>
</layers>
<schematic xreflabel="%F%N/%S.%C%R" xrefpart="/%S.%C%R">
<libraries>
<library name="LibTsu">
<packages>
<package name="DIL16">
<description>&lt;b&gt;Dual In Line Package&lt;/b&gt;</description>
<wire x1="10.16" y1="2.921" x2="-10.16" y2="2.921" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-2.921" x2="10.16" y2="-2.921" width="0.1524" layer="21"/>
<wire x1="10.16" y1="2.921" x2="10.16" y2="-2.921" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="2.921" x2="-10.16" y2="1.016" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="-2.921" x2="-10.16" y2="-1.016" width="0.1524" layer="21"/>
<wire x1="-10.16" y1="1.016" x2="-10.16" y2="-1.016" width="0.1524" layer="21" curve="-180"/>
<pad name="1" x="-8.89" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="2" x="-6.35" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="7" x="6.35" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="8" x="8.89" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="3" x="-3.81" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="4" x="-1.27" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="6" x="3.81" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="5" x="1.27" y="-3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="9" x="8.89" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="10" x="6.35" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="11" x="3.81" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="12" x="1.27" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="13" x="-1.27" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="14" x="-3.81" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="15" x="-6.35" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<pad name="16" x="-8.89" y="3.81" drill="0.8128" shape="long" rot="R90"/>
<text x="-10.541" y="-2.921" size="1.27" layer="25" ratio="10" rot="R90">&gt;NAME</text>
<text x="-7.493" y="-0.635" size="1.27" layer="27" ratio="10">&gt;VALUE</text>
</package>
</packages>
<symbols>
<symbol name="74HC4051">
<wire x1="7.62" y1="12.7" x2="7.62" y2="-10.16" width="0.254" layer="94"/>
<wire x1="-7.62" y1="-10.16" x2="-7.62" y2="12.7" width="0.254" layer="94"/>
<wire x1="-7.62" y1="12.7" x2="7.62" y2="12.7" width="0.254" layer="94"/>
<pin name="VCC" x="12.7" y="10.16" length="middle" rot="R180"/>
<pin name="Y2" x="12.7" y="7.62" length="middle" rot="R180"/>
<pin name="Y1" x="12.7" y="5.08" length="middle" rot="R180"/>
<pin name="Y0" x="12.7" y="2.54" length="middle" rot="R180"/>
<pin name="Y3" x="12.7" y="0" length="middle" rot="R180"/>
<pin name="S0" x="12.7" y="-2.54" length="middle" rot="R180"/>
<pin name="S1" x="12.7" y="-5.08" length="middle" rot="R180"/>
<pin name="S2" x="12.7" y="-7.62" length="middle" rot="R180"/>
<pin name="Y6" x="-12.7" y="7.62" length="middle"/>
<pin name="Z" x="-12.7" y="5.08" length="middle"/>
<pin name="Y7" x="-12.7" y="2.54" length="middle"/>
<pin name="/E" x="-12.7" y="-2.54" length="middle" function="dot"/>
<wire x1="-7.62" y1="-10.16" x2="7.62" y2="-10.16" width="0.254" layer="94"/>
<pin name="Y4" x="-12.7" y="10.16" length="middle"/>
<pin name="Y5" x="-12.7" y="0" length="middle"/>
<pin name="VEE" x="-12.7" y="-5.08" length="middle"/>
<pin name="GND" x="-12.7" y="-7.62" length="middle"/>
<text x="-7.62" y="12.7" size="1.778" layer="95">&gt;NAME</text>
<text x="-7.62" y="-12.7" size="1.778" layer="95">&gt;VALUE</text>
</symbol>
</symbols>
<devicesets>
<deviceset name="74HC4051" prefix="IC">
<gates>
<gate name="G$1" symbol="74HC4051" x="0" y="0"/>
</gates>
<devices>
<device name="DIL16" package="DIL16">
<connects>
<connect gate="G$1" pin="/E" pad="6"/>
<connect gate="G$1" pin="GND" pad="8"/>
<connect gate="G$1" pin="S0" pad="11"/>
<connect gate="G$1" pin="S1" pad="10"/>
<connect gate="G$1" pin="S2" pad="9"/>
<connect gate="G$1" pin="VCC" pad="16"/>
<connect gate="G$1" pin="VEE" pad="7"/>
<connect gate="G$1" pin="Y0" pad="13"/>
<connect gate="G$1" pin="Y1" pad="14"/>
<connect gate="G$1" pin="Y2" pad="15"/>
<connect gate="G$1" pin="Y3" pad="12"/>
<connect gate="G$1" pin="Y4" pad="1"/>
<connect gate="G$1" pin="Y5" pad="5"/>
<connect gate="G$1" pin="Y6" pad="2"/>
<connect gate="G$1" pin="Y7" pad="4"/>
<connect gate="G$1" pin="Z" pad="3"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="supply2">
<description>&lt;b&gt;Supply Symbols&lt;/b&gt;&lt;p&gt;
GND, VCC, 0V, +5V, -5V, etc.&lt;p&gt;
Please keep in mind, that these devices are necessary for the
automatic wiring of the supply signals.&lt;p&gt;
The pin name defined in the symbol is identical to the net which is to be wired automatically.&lt;p&gt;
In this library the device names are the same as the pin names of the symbols, therefore the correct signal names appear next to the supply symbols in the schematic.&lt;p&gt;
&lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
</packages>
<symbols>
<symbol name="VCC">
<circle x="0" y="1.27" radius="1.27" width="0.254" layer="94"/>
<text x="-1.905" y="3.175" size="1.778" layer="96">&gt;VALUE</text>
<pin name="VCC" x="0" y="-2.54" visible="off" length="short" direction="sup" rot="R90"/>
</symbol>
<symbol name="GND">
<wire x1="-1.27" y1="0" x2="1.27" y2="0" width="0.254" layer="94"/>
<wire x1="1.27" y1="0" x2="0" y2="-1.27" width="0.254" layer="94"/>
<wire x1="0" y1="-1.27" x2="-1.27" y2="0" width="0.254" layer="94"/>
<text x="-1.905" y="-3.175" size="1.778" layer="96">&gt;VALUE</text>
<pin name="GND" x="0" y="2.54" visible="off" length="short" direction="sup" rot="R270"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="VCC" prefix="SUPPLY">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="G$1" symbol="VCC" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="GND" prefix="SUPPLY">
<description>&lt;b&gt;SUPPLY SYMBOL&lt;/b&gt;</description>
<gates>
<gate name="GND" symbol="GND" x="0" y="0"/>
</gates>
<devices>
<device name="">
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
<library name="con-amp">
<description>&lt;b&gt;AMP Connectors&lt;/b&gt;&lt;p&gt;
RJ45 Jack connectors&lt;br&gt;
 Based on the previous libraris:
 &lt;ul&gt;
 &lt;li&gt;amp.lbr
 &lt;li&gt;amp-j.lbr
 &lt;li&gt;amp-mta.lbr
 &lt;li&gt;amp-nlok.lbr
 &lt;li&gt;amp-sim.lbr
 &lt;li&gt;amp-micro-match.lbr
 &lt;/ul&gt;
 Sources :
 &lt;ul&gt;
 &lt;li&gt;Catalog 82066 Revised 11-95 
 &lt;li&gt;Product Guide 296785 Rev. 8-99
 &lt;li&gt;Product Guide CD-ROM 1999
 &lt;li&gt;www.amp.com
 &lt;/ul&gt;
 &lt;author&gt;Created by librarian@cadsoft.de&lt;/author&gt;</description>
<packages>
<package name="1X4MTA">
<description>&lt;b&gt;AMP MTA connector&lt;/b&gt;</description>
<wire x1="8.3312" y1="6.35" x2="8.3312" y2="3.81" width="0.4064" layer="21"/>
<wire x1="8.3312" y1="3.81" x2="8.3312" y2="-3.81" width="0.4064" layer="21"/>
<wire x1="-8.1788" y1="-3.81" x2="-8.1788" y2="3.81" width="0.4064" layer="21"/>
<wire x1="-8.1788" y1="3.81" x2="-8.1788" y2="6.35" width="0.4064" layer="21"/>
<wire x1="-8.1788" y1="6.35" x2="8.3312" y2="6.35" width="0.4064" layer="21"/>
<wire x1="-8.1788" y1="3.81" x2="8.3312" y2="3.81" width="0.3048" layer="21"/>
<wire x1="-8.1788" y1="-3.81" x2="8.3312" y2="-3.81" width="0.4064" layer="21"/>
<pad name="3" x="-1.9812" y="0" drill="1.6764" shape="long" rot="R90"/>
<pad name="2" x="1.9812" y="0" drill="1.6764" shape="long" rot="R90"/>
<pad name="1" x="5.9436" y="0" drill="1.6764" shape="long" rot="R90"/>
<pad name="4" x="-5.9436" y="0" drill="1.6764" shape="long" rot="R90"/>
<text x="-3.175" y="-7.0612" size="1.778" layer="25">&gt;NAME</text>
<text x="-7.1389" y="4.4148" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="5.4356" y1="-0.508" x2="6.4516" y2="0.508" layer="21"/>
<rectangle x1="1.4732" y1="-0.508" x2="2.4892" y2="0.508" layer="21"/>
<rectangle x1="-2.4892" y1="-0.508" x2="-1.4732" y2="0.508" layer="21"/>
<rectangle x1="-6.4516" y1="-0.508" x2="-5.4356" y2="0.508" layer="21"/>
</package>
<package name="794623-8">
<description>&lt;b&gt;MICRO MATE N LOK&lt;/b&gt; Dual Row, grid 1.5 mm&lt;p&gt;
Source: http://catalog.tycoelectronics.com .. ENG_CD_794623_F.pdf</description>
<wire x1="-6.4" y1="4.525" x2="-5.675" y2="4.525" width="0.2032" layer="21"/>
<wire x1="-6.4" y1="4.525" x2="-6.4" y2="-4.5" width="0.2032" layer="21"/>
<wire x1="-6.4" y1="-4.5" x2="6.4" y2="-4.5" width="0.2032" layer="21"/>
<wire x1="6.4" y1="-4.5" x2="6.4" y2="4.525" width="0.2032" layer="21"/>
<wire x1="6.4" y1="4.525" x2="5.6" y2="4.525" width="0.2032" layer="21"/>
<wire x1="5.6" y1="4.525" x2="5.075" y2="4.525" width="0.2032" layer="51"/>
<wire x1="5.075" y1="4.525" x2="5.075" y2="3.4" width="0.2032" layer="51"/>
<wire x1="5.075" y1="3.4" x2="3.925" y2="3.4" width="0.2032" layer="51"/>
<wire x1="3.925" y1="3.4" x2="3.925" y2="4.175" width="0.2032" layer="51"/>
<wire x1="-5.075" y1="3.4" x2="-5.075" y2="4.525" width="0.2032" layer="51"/>
<wire x1="-5.075" y1="4.525" x2="-5.675" y2="4.525" width="0.2032" layer="51"/>
<wire x1="-6.5" y1="1.45" x2="-7.25" y2="1.45" width="0.2032" layer="25"/>
<wire x1="-7.25" y1="1.45" x2="-7.975" y2="1.025" width="0.2032" layer="25"/>
<wire x1="-7.975" y1="1.025" x2="-7.975" y2="-0.425" width="0.2032" layer="25"/>
<wire x1="-7.975" y1="-0.425" x2="-7.25" y2="-0.85" width="0.2032" layer="25"/>
<wire x1="-7.25" y1="-0.85" x2="-7.025" y2="-0.85" width="0.2032" layer="25"/>
<wire x1="-7.025" y1="-0.85" x2="-7.025" y2="-0.35" width="0.2032" layer="25"/>
<wire x1="-7.025" y1="-0.35" x2="-6.5" y2="-0.35" width="0.2032" layer="25"/>
<wire x1="-7.4" y1="-0.7" x2="-7.4" y2="1.3" width="0.2032" layer="25"/>
<wire x1="6.5" y1="-1.45" x2="7.25" y2="-1.45" width="0.2032" layer="25"/>
<wire x1="7.25" y1="-1.45" x2="7.975" y2="-1.025" width="0.2032" layer="25"/>
<wire x1="7.975" y1="-1.025" x2="7.975" y2="0.425" width="0.2032" layer="25"/>
<wire x1="7.975" y1="0.425" x2="7.25" y2="0.85" width="0.2032" layer="25"/>
<wire x1="7.25" y1="0.85" x2="7.025" y2="0.85" width="0.2032" layer="25"/>
<wire x1="7.025" y1="0.85" x2="7.025" y2="0.35" width="0.2032" layer="25"/>
<wire x1="7.025" y1="0.35" x2="6.5" y2="0.35" width="0.2032" layer="25"/>
<wire x1="7.4" y1="-1.3" x2="7.4" y2="0.7" width="0.2032" layer="25"/>
<wire x1="-1.8" y1="-4.4" x2="-1.8" y2="-1.2" width="0.2032" layer="25"/>
<wire x1="-1.8" y1="-1.2" x2="1.8" y2="-1.2" width="0.2032" layer="25"/>
<wire x1="1.8" y1="-1.2" x2="1.8" y2="-4.4" width="0.2032" layer="25"/>
<wire x1="-1.2" y1="-2.65" x2="1.2" y2="-2.65" width="0.2032" layer="25"/>
<wire x1="1.2" y1="-2.65" x2="1.2" y2="-1.75" width="0.2032" layer="25"/>
<wire x1="1.2" y1="-1.75" x2="-1.2" y2="-1.75" width="0.2032" layer="25"/>
<wire x1="-1.2" y1="-1.75" x2="-1.2" y2="-2.65" width="0.2032" layer="25"/>
<wire x1="-1.2" y1="-2.65" x2="-1.2" y2="-3.775" width="0.2032" layer="25"/>
<wire x1="-1.2" y1="-3.775" x2="-1.425" y2="-4.45" width="0.2032" layer="25" curve="-36.869898"/>
<wire x1="1.2" y1="-2.65" x2="1.2" y2="-3.775" width="0.2032" layer="25"/>
<wire x1="1.2" y1="-3.775" x2="1.425" y2="-4.45" width="0.2032" layer="25" curve="36.869898"/>
<wire x1="-0.925" y1="3.4" x2="-2.075" y2="3.4" width="0.2032" layer="51"/>
<wire x1="-2.075" y1="3.4" x2="-2.075" y2="4.175" width="0.2032" layer="51"/>
<wire x1="-0.925" y1="4.175" x2="-0.925" y2="3.4" width="0.2032" layer="51"/>
<wire x1="-0.425" y1="4.175" x2="-0.925" y2="4.175" width="0.2032" layer="51"/>
<wire x1="-2.075" y1="4.175" x2="-2.55" y2="4.175" width="0.2032" layer="51"/>
<wire x1="0.45" y1="4.175" x2="-0.425" y2="4.175" width="0.2032" layer="21"/>
<wire x1="2.575" y1="4.175" x2="2.075" y2="4.175" width="0.2032" layer="51"/>
<wire x1="0.925" y1="4.175" x2="0.45" y2="4.175" width="0.2032" layer="51"/>
<wire x1="0.925" y1="3.4" x2="0.925" y2="4.175" width="0.2032" layer="51"/>
<wire x1="2.075" y1="3.4" x2="0.925" y2="3.4" width="0.2032" layer="51"/>
<wire x1="2.075" y1="4.175" x2="2.075" y2="3.4" width="0.2032" layer="51"/>
<wire x1="3.45" y1="4.175" x2="2.575" y2="4.175" width="0.2032" layer="21"/>
<wire x1="3.925" y1="4.175" x2="3.45" y2="4.175" width="0.2032" layer="51"/>
<wire x1="-2.55" y1="4.175" x2="-3.425" y2="4.175" width="0.2032" layer="21"/>
<wire x1="-3.925" y1="3.4" x2="-5.075" y2="3.4" width="0.2032" layer="51"/>
<wire x1="-3.925" y1="4.175" x2="-3.925" y2="3.4" width="0.2032" layer="51"/>
<wire x1="-3.425" y1="4.175" x2="-3.925" y2="4.175" width="0.2032" layer="51"/>
<smd name="1" x="4.5" y="10.1" dx="1.3" dy="2.92" layer="1"/>
<smd name="2" x="4.5" y="5.48" dx="1.3" dy="2.92" layer="1"/>
<smd name="3" x="1.5" y="10.1" dx="1.3" dy="2.92" layer="1"/>
<smd name="4" x="1.5" y="5.48" dx="1.3" dy="2.92" layer="1"/>
<smd name="5" x="-1.5" y="10.1" dx="1.3" dy="2.92" layer="1"/>
<smd name="6" x="-1.5" y="5.48" dx="1.3" dy="2.92" layer="1"/>
<smd name="7" x="-4.5" y="10.1" dx="1.3" dy="2.92" layer="1"/>
<smd name="8" x="-4.5" y="5.48" dx="1.3" dy="2.92" layer="1"/>
<text x="10.5" y="-4.5" size="1.27" layer="25" rot="R90">&gt;NAME</text>
<text x="6" y="6" size="1.27" layer="27">&gt;VALUE</text>
<rectangle x1="4.1875" y1="3.5125" x2="4.8249" y2="11.025" layer="51"/>
<rectangle x1="1.1875" y1="3.5125" x2="1.8249" y2="11.025" layer="51"/>
<rectangle x1="-1.8125" y1="3.5125" x2="-1.1751" y2="11.025" layer="51"/>
<rectangle x1="-4.8125" y1="3.5125" x2="-4.1751" y2="11.025" layer="51"/>
<hole x="-2.35" y="0" drill="3"/>
<hole x="2.35" y="0" drill="3"/>
<polygon width="0.01" layer="25" spacing="0.254">
<vertex x="-4.865" y="2.14"/>
<vertex x="-4.71" y="2.14"/>
<vertex x="-4.6875" y="2.225"/>
<vertex x="-4.47" y="2.28"/>
<vertex x="-4.51" y="2.14"/>
<vertex x="-4.32" y="2.14"/>
<vertex x="-4.35" y="2.04"/>
<vertex x="-4.54" y="2.04"/>
<vertex x="-4.61" y="1.81" curve="107.492325"/>
<vertex x="-4.565" y="1.75" curve="-1.23212"/>
<vertex x="-4.445" y="1.75"/>
<vertex x="-4.475" y="1.64"/>
<vertex x="-4.755" y="1.64" curve="-115.057615"/>
<vertex x="-4.825" y="1.75"/>
<vertex x="-4.74" y="2.04"/>
<vertex x="-4.895" y="2.04"/>
</polygon>
<polygon width="0.01" layer="25" spacing="0.254">
<vertex x="-4.23" y="2.14"/>
<vertex x="-4.03" y="2.14"/>
<vertex x="-4.12" y="1.845" curve="114.249552"/>
<vertex x="-4.04" y="1.75"/>
<vertex x="-3.96" y="1.75"/>
<vertex x="-3.84" y="2.14"/>
<vertex x="-3.645" y="2.14"/>
<vertex x="-3.86" y="1.435"/>
<vertex x="-4.055" y="1.435"/>
<vertex x="-3.995" y="1.64"/>
<vertex x="-4.285" y="1.64" curve="-114.113525"/>
<vertex x="-4.35" y="1.74"/>
</polygon>
<polygon width="0.01" layer="25" spacing="0.254">
<vertex x="-3.16" y="1.96"/>
<vertex x="-2.94" y="1.96"/>
<vertex x="-2.925" y="2.01" curve="105.642164"/>
<vertex x="-3.02" y="2.14"/>
<vertex x="-3.42" y="2.14" curve="70.280225"/>
<vertex x="-3.555" y="2.045"/>
<vertex x="-3.63" y="1.805" curve="106.773065"/>
<vertex x="-3.51" y="1.64"/>
<vertex x="-3.11" y="1.64" curve="71.682021"/>
<vertex x="-3.02" y="1.705"/>
<vertex x="-2.985" y="1.825"/>
<vertex x="-3.2" y="1.825"/>
<vertex x="-3.215" y="1.78" curve="-75.804848"/>
<vertex x="-3.26" y="1.75"/>
<vertex x="-3.355" y="1.75" curve="-106.260205"/>
<vertex x="-3.4" y="1.81"/>
<vertex x="-3.35" y="1.98" curve="-70.964895"/>
<vertex x="-3.28" y="2.035"/>
<vertex x="-3.195" y="2.035" curve="-112.619865"/>
<vertex x="-3.155" y="1.975"/>
</polygon>
<polygon width="0.01" layer="25" spacing="0.254">
<vertex x="-2.45" y="1.825"/>
<vertex x="-2.23" y="1.825"/>
<vertex x="-2.175" y="2.005" curve="105.642164"/>
<vertex x="-2.27" y="2.135"/>
<vertex x="-2.67" y="2.135" curve="70.280225"/>
<vertex x="-2.805" y="2.04"/>
<vertex x="-2.88" y="1.8" curve="106.773065"/>
<vertex x="-2.76" y="1.635"/>
<vertex x="-2.36" y="1.635" curve="71.682021"/>
<vertex x="-2.27" y="1.7"/>
<vertex x="-2.23" y="1.825"/>
<vertex x="-2.45" y="1.82"/>
<vertex x="-2.465" y="1.775" curve="-75.804848"/>
<vertex x="-2.51" y="1.745"/>
<vertex x="-2.605" y="1.745" curve="-106.260205"/>
<vertex x="-2.65" y="1.805"/>
<vertex x="-2.6" y="1.975" curve="-70.964895"/>
<vertex x="-2.53" y="2.03"/>
<vertex x="-2.445" y="2.03" curve="-112.619865"/>
<vertex x="-2.405" y="1.97"/>
</polygon>
</package>
</packages>
<symbols>
<symbol name="MTA-04">
<wire x1="-1.27" y1="1.27" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<wire x1="8.89" y1="-1.905" x2="-1.27" y2="-1.905" width="0.254" layer="94"/>
<wire x1="8.89" y1="-1.905" x2="8.89" y2="1.27" width="0.254" layer="94"/>
<wire x1="-1.27" y1="1.27" x2="8.89" y2="1.27" width="0.254" layer="94"/>
<circle x="0" y="0" radius="0.635" width="0.254" layer="94"/>
<circle x="2.54" y="0" radius="0.635" width="0.254" layer="94"/>
<circle x="5.08" y="0" radius="0.635" width="0.254" layer="94"/>
<circle x="7.62" y="0" radius="0.635" width="0.254" layer="94"/>
<text x="10.16" y="0" size="1.778" layer="95">&gt;NAME</text>
<text x="10.16" y="-3.81" size="1.778" layer="96">&gt;VALUE</text>
<text x="-2.54" y="-1.27" size="1.27" layer="95">1</text>
<pin name="1" x="0" y="-2.54" visible="off" length="short" direction="pas" rot="R90"/>
<pin name="2" x="2.54" y="-2.54" visible="off" length="short" direction="pas" rot="R90"/>
<pin name="3" x="5.08" y="-2.54" visible="off" length="short" direction="pas" rot="R90"/>
<pin name="4" x="7.62" y="-2.54" visible="off" length="short" direction="pas" rot="R90"/>
</symbol>
<symbol name="P8-2">
<wire x1="3.81" y1="-6.35" x2="-4.445" y2="-6.35" width="0.254" layer="94"/>
<wire x1="-4.445" y1="3.81" x2="-4.445" y2="-6.35" width="0.254" layer="94"/>
<wire x1="-4.445" y1="3.81" x2="3.81" y2="3.81" width="0.254" layer="94"/>
<wire x1="3.81" y1="-6.35" x2="3.81" y2="3.81" width="0.254" layer="94"/>
<circle x="-2.54" y="-5.08" radius="0.635" width="0.254" layer="94"/>
<circle x="-2.54" y="-2.54" radius="0.635" width="0.254" layer="94"/>
<circle x="2.54" y="-5.08" radius="0.635" width="0.254" layer="94"/>
<circle x="2.54" y="-2.54" radius="0.635" width="0.254" layer="94"/>
<circle x="-2.54" y="0" radius="0.635" width="0.254" layer="94"/>
<circle x="2.54" y="0" radius="0.635" width="0.254" layer="94"/>
<circle x="-2.54" y="2.54" radius="0.635" width="0.254" layer="94"/>
<circle x="2.54" y="2.54" radius="0.635" width="0.254" layer="94"/>
<text x="-5.08" y="-8.89" size="1.778" layer="95">&gt;NAME</text>
<text x="-5.08" y="5.08" size="1.778" layer="96">&gt;VALUE</text>
<text x="-1.524" y="-5.588" size="1.27" layer="95">1</text>
<text x="1.524" y="-4.318" size="1.27" layer="95" rot="R180">2</text>
<pin name="1" x="-5.08" y="-5.08" visible="off" length="short" direction="pas"/>
<pin name="2" x="5.08" y="-5.08" visible="off" length="short" direction="pas" rot="R180"/>
<pin name="3" x="-5.08" y="-2.54" visible="off" length="short" direction="pas"/>
<pin name="4" x="5.08" y="-2.54" visible="off" length="short" direction="pas" rot="R180"/>
<pin name="5" x="-5.08" y="0" visible="off" length="short" direction="pas"/>
<pin name="6" x="5.08" y="0" visible="off" length="short" direction="pas" rot="R180"/>
<pin name="7" x="-5.08" y="2.54" visible="off" length="short" direction="pas"/>
<pin name="8" x="5.08" y="2.54" visible="off" length="short" direction="pas" rot="R180"/>
</symbol>
</symbols>
<devicesets>
<deviceset name="MTA04-156" prefix="J" uservalue="yes">
<description>&lt;b&gt;AMP connector&lt;/b&gt;</description>
<gates>
<gate name="G$3" symbol="MTA-04" x="0" y="0"/>
</gates>
<devices>
<device name="" package="1X4MTA">
<connects>
<connect gate="G$3" pin="1" pad="1"/>
<connect gate="G$3" pin="2" pad="2"/>
<connect gate="G$3" pin="3" pad="3"/>
<connect gate="G$3" pin="4" pad="4"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
<deviceset name="794623-8" prefix="J">
<description>&lt;b&gt;MICRO MATE N LOK&lt;/b&gt; Dual Row, grid 1.5 mm&lt;p&gt;
Source: http://catalog.tycoelectronics.com .. ENG_CD_794623_F.pdf</description>
<gates>
<gate name="G$1" symbol="P8-2" x="0" y="0"/>
</gates>
<devices>
<device name="" package="794623-8">
<connects>
<connect gate="G$1" pin="1" pad="1"/>
<connect gate="G$1" pin="2" pad="2"/>
<connect gate="G$1" pin="3" pad="3"/>
<connect gate="G$1" pin="4" pad="4"/>
<connect gate="G$1" pin="5" pad="5"/>
<connect gate="G$1" pin="6" pad="6"/>
<connect gate="G$1" pin="7" pad="7"/>
<connect gate="G$1" pin="8" pad="8"/>
</connects>
<technologies>
<technology name=""/>
</technologies>
</device>
</devices>
</deviceset>
</devicesets>
</library>
</libraries>
<attributes>
</attributes>
<variantdefs>
</variantdefs>
<classes>
<class number="0" name="default" width="0" drill="0">
</class>
</classes>
<parts>
<part name="IC1" library="LibTsu" deviceset="74HC4051" device="DIL16"/>
<part name="IC2" library="LibTsu" deviceset="74HC4051" device="DIL16"/>
<part name="SUPPLY1" library="supply2" deviceset="VCC" device="" value="+3.3V"/>
<part name="SUPPLY2" library="supply2" deviceset="VCC" device="" value="+3.3V"/>
<part name="SUPPLY3" library="supply2" deviceset="GND" device=""/>
<part name="SUPPLY4" library="supply2" deviceset="GND" device=""/>
<part name="SUPPLY5" library="supply2" deviceset="VCC" device="" value="+3.3V"/>
<part name="DIG1" library="con-amp" deviceset="MTA04-156" device=""/>
<part name="DIG2" library="con-amp" deviceset="MTA04-156" device=""/>
<part name="DIG3" library="con-amp" deviceset="MTA04-156" device=""/>
<part name="AN1" library="con-amp" deviceset="MTA04-156" device=""/>
<part name="SUPPLY8" library="supply2" deviceset="VCC" device="" value="+3.3V"/>
<part name="SUPPLY9" library="supply2" deviceset="GND" device=""/>
<part name="COL" library="con-amp" deviceset="794623-8" device=""/>
<part name="ROW" library="con-amp" deviceset="794623-8" device=""/>
</parts>
<sheets>
<sheet>
<plain>
<text x="-43.18" y="66.04" size="1.778" layer="91">Date: 2013 Sep 15
Author: Yuri Valentini
Version: 1.2.0</text>
</plain>
<instances>
<instance part="IC1" gate="G$1" x="33.02" y="73.66"/>
<instance part="IC2" gate="G$1" x="-5.08" y="27.94"/>
<instance part="SUPPLY1" gate="G$1" x="45.72" y="86.36"/>
<instance part="SUPPLY2" gate="G$1" x="7.62" y="40.64"/>
<instance part="SUPPLY3" gate="GND" x="20.32" y="63.5"/>
<instance part="SUPPLY4" gate="GND" x="-17.78" y="15.24"/>
<instance part="SUPPLY5" gate="G$1" x="12.7" y="81.28"/>
<instance part="DIG1" gate="G$3" x="58.42" y="48.26" rot="R180"/>
<instance part="DIG2" gate="G$3" x="27.94" y="58.42" rot="MR0"/>
<instance part="DIG3" gate="G$3" x="30.48" y="22.86" rot="R270"/>
<instance part="AN1" gate="G$3" x="-40.64" y="33.02" rot="MR270"/>
<instance part="SUPPLY8" gate="G$1" x="-33.02" y="33.02"/>
<instance part="SUPPLY9" gate="GND" x="-33.02" y="20.32"/>
<instance part="COL" gate="G$1" x="33.02" y="106.68"/>
<instance part="ROW" gate="G$1" x="-2.54" y="2.54" rot="R180"/>
</instances>
<busses>
</busses>
<nets>
<net name="VCC" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="VCC"/>
<pinref part="SUPPLY1" gate="G$1" pin="VCC"/>
</segment>
<segment>
<pinref part="IC2" gate="G$1" pin="VCC"/>
<pinref part="SUPPLY2" gate="G$1" pin="VCC"/>
</segment>
<segment>
<pinref part="SUPPLY5" gate="G$1" pin="VCC"/>
<pinref part="IC1" gate="G$1" pin="Z"/>
<wire x1="12.7" y1="78.74" x2="20.32" y2="78.74" width="0.1524" layer="91"/>
</segment>
<segment>
<pinref part="SUPPLY8" gate="G$1" pin="VCC"/>
<wire x1="-33.02" y1="30.48" x2="-33.02" y2="27.94" width="0.1524" layer="91"/>
<pinref part="AN1" gate="G$3" pin="3"/>
<wire x1="-33.02" y1="27.94" x2="-38.1" y2="27.94" width="0.1524" layer="91"/>
</segment>
</net>
<net name="GND" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="GND"/>
<pinref part="SUPPLY3" gate="GND" pin="GND"/>
<junction x="20.32" y="66.04"/>
<pinref part="IC1" gate="G$1" pin="VEE"/>
<wire x1="20.32" y1="68.58" x2="20.32" y2="66.04" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="/E"/>
<wire x1="20.32" y1="71.12" x2="20.32" y2="68.58" width="0.1524" layer="91"/>
<junction x="20.32" y="68.58"/>
</segment>
<segment>
<pinref part="IC2" gate="G$1" pin="/E"/>
<pinref part="IC2" gate="G$1" pin="VEE"/>
<wire x1="-17.78" y1="25.4" x2="-17.78" y2="22.86" width="0.1524" layer="91"/>
<pinref part="IC2" gate="G$1" pin="GND"/>
<wire x1="-17.78" y1="22.86" x2="-17.78" y2="20.32" width="0.1524" layer="91"/>
<junction x="-17.78" y="22.86"/>
<pinref part="SUPPLY4" gate="GND" pin="GND"/>
<wire x1="-17.78" y1="20.32" x2="-17.78" y2="17.78" width="0.1524" layer="91"/>
<junction x="-17.78" y="20.32"/>
</segment>
<segment>
<pinref part="AN1" gate="G$3" pin="4"/>
<pinref part="SUPPLY9" gate="GND" pin="GND"/>
<wire x1="-38.1" y1="25.4" x2="-33.02" y2="25.4" width="0.1524" layer="91"/>
<wire x1="-33.02" y1="25.4" x2="-33.02" y2="22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$1" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y3"/>
<wire x1="45.72" y1="73.66" x2="60.96" y2="73.66" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="4"/>
<wire x1="38.1" y1="104.14" x2="60.96" y2="104.14" width="0.1524" layer="91"/>
<wire x1="60.96" y1="104.14" x2="60.96" y2="73.66" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$2" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y0"/>
<wire x1="45.72" y1="76.2" x2="58.42" y2="76.2" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="1"/>
<wire x1="27.94" y1="101.6" x2="25.4" y2="101.6" width="0.1524" layer="91"/>
<wire x1="25.4" y1="101.6" x2="25.4" y2="96.52" width="0.1524" layer="91"/>
<wire x1="25.4" y1="96.52" x2="58.42" y2="96.52" width="0.1524" layer="91"/>
<wire x1="58.42" y1="96.52" x2="58.42" y2="76.2" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$3" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y1"/>
<wire x1="45.72" y1="78.74" x2="55.88" y2="78.74" width="0.1524" layer="91"/>
<wire x1="55.88" y1="78.74" x2="55.88" y2="101.6" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="2"/>
<wire x1="55.88" y1="101.6" x2="38.1" y2="101.6" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$4" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y2"/>
<wire x1="45.72" y1="81.28" x2="53.34" y2="81.28" width="0.1524" layer="91"/>
<wire x1="53.34" y1="81.28" x2="53.34" y2="93.98" width="0.1524" layer="91"/>
<wire x1="53.34" y1="93.98" x2="22.86" y2="93.98" width="0.1524" layer="91"/>
<wire x1="22.86" y1="93.98" x2="22.86" y2="104.14" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="3"/>
<wire x1="22.86" y1="104.14" x2="27.94" y2="104.14" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$6" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y5"/>
<wire x1="15.24" y1="73.66" x2="20.32" y2="73.66" width="0.1524" layer="91"/>
<wire x1="15.24" y1="73.66" x2="15.24" y2="55.88" width="0.1524" layer="91"/>
<wire x1="15.24" y1="55.88" x2="-12.7" y2="55.88" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="55.88" x2="-12.7" y2="114.3" width="0.1524" layer="91"/>
<wire x1="-12.7" y1="114.3" x2="45.72" y2="114.3" width="0.1524" layer="91"/>
<wire x1="45.72" y1="114.3" x2="45.72" y2="106.68" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="6"/>
<wire x1="45.72" y1="106.68" x2="38.1" y2="106.68" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$8" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y6"/>
<wire x1="17.78" y1="81.28" x2="20.32" y2="81.28" width="0.1524" layer="91"/>
<wire x1="17.78" y1="81.28" x2="17.78" y2="109.22" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="7"/>
<wire x1="17.78" y1="109.22" x2="27.94" y2="109.22" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$5" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="Y4"/>
<wire x1="20.32" y1="83.82" x2="20.32" y2="106.68" width="0.1524" layer="91"/>
<pinref part="COL" gate="G$1" pin="5"/>
<wire x1="20.32" y1="106.68" x2="27.94" y2="106.68" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$9" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="S0"/>
<pinref part="DIG1" gate="G$3" pin="1"/>
<wire x1="45.72" y1="71.12" x2="58.42" y2="71.12" width="0.1524" layer="91"/>
<wire x1="58.42" y1="71.12" x2="58.42" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$10" class="0">
<segment>
<pinref part="IC1" gate="G$1" pin="S1"/>
<pinref part="DIG1" gate="G$3" pin="2"/>
<wire x1="45.72" y1="68.58" x2="55.88" y2="68.58" width="0.1524" layer="91"/>
<wire x1="55.88" y1="68.58" x2="55.88" y2="50.8" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$11" class="0">
<segment>
<pinref part="DIG2" gate="G$3" pin="1"/>
<wire x1="27.94" y1="55.88" x2="27.94" y2="53.34" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="S2"/>
<wire x1="27.94" y1="53.34" x2="45.72" y2="53.34" width="0.1524" layer="91"/>
<wire x1="45.72" y1="53.34" x2="45.72" y2="66.04" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$12" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="S0"/>
<wire x1="7.62" y1="25.4" x2="25.4" y2="25.4" width="0.1524" layer="91"/>
<wire x1="25.4" y1="25.4" x2="25.4" y2="55.88" width="0.1524" layer="91"/>
<pinref part="DIG2" gate="G$3" pin="2"/>
</segment>
</net>
<net name="N$13" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="S1"/>
<pinref part="DIG3" gate="G$3" pin="1"/>
<wire x1="7.62" y1="22.86" x2="27.94" y2="22.86" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$14" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="S2"/>
<pinref part="DIG3" gate="G$3" pin="2"/>
<wire x1="7.62" y1="20.32" x2="27.94" y2="20.32" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$7" class="0">
<segment>
<pinref part="COL" gate="G$1" pin="8"/>
<wire x1="38.1" y1="109.22" x2="43.18" y2="109.22" width="0.1524" layer="91"/>
<wire x1="43.18" y1="109.22" x2="43.18" y2="111.76" width="0.1524" layer="91"/>
<wire x1="43.18" y1="111.76" x2="-10.16" y2="111.76" width="0.1524" layer="91"/>
<wire x1="-10.16" y1="111.76" x2="-10.16" y2="58.42" width="0.1524" layer="91"/>
<wire x1="-10.16" y1="58.42" x2="12.7" y2="58.42" width="0.1524" layer="91"/>
<pinref part="IC1" gate="G$1" pin="Y7"/>
<wire x1="12.7" y1="76.2" x2="20.32" y2="76.2" width="0.1524" layer="91"/>
<wire x1="12.7" y1="58.42" x2="12.7" y2="76.2" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$16" class="0">
<segment>
<pinref part="ROW" gate="G$1" pin="1"/>
<wire x1="2.54" y1="7.62" x2="12.7" y2="7.62" width="0.1524" layer="91"/>
<wire x1="12.7" y1="7.62" x2="12.7" y2="30.48" width="0.1524" layer="91"/>
<pinref part="IC2" gate="G$1" pin="Y0"/>
<wire x1="12.7" y1="30.48" x2="7.62" y2="30.48" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$17" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y1"/>
<wire x1="7.62" y1="33.02" x2="10.16" y2="33.02" width="0.1524" layer="91"/>
<wire x1="10.16" y1="33.02" x2="10.16" y2="50.8" width="0.1524" layer="91"/>
<wire x1="10.16" y1="50.8" x2="-45.72" y2="50.8" width="0.1524" layer="91"/>
<wire x1="-45.72" y1="50.8" x2="-45.72" y2="7.62" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="2"/>
<wire x1="-45.72" y1="7.62" x2="-7.62" y2="7.62" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$18" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y2"/>
<wire x1="7.62" y1="35.56" x2="15.24" y2="35.56" width="0.1524" layer="91"/>
<wire x1="15.24" y1="35.56" x2="15.24" y2="5.08" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="3"/>
<wire x1="15.24" y1="5.08" x2="2.54" y2="5.08" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$19" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y3"/>
<wire x1="7.62" y1="27.94" x2="20.32" y2="27.94" width="0.1524" layer="91"/>
<wire x1="20.32" y1="27.94" x2="20.32" y2="53.34" width="0.1524" layer="91"/>
<wire x1="20.32" y1="53.34" x2="-48.26" y2="53.34" width="0.1524" layer="91"/>
<wire x1="-48.26" y1="53.34" x2="-48.26" y2="5.08" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="4"/>
<wire x1="-48.26" y1="5.08" x2="-7.62" y2="5.08" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$20" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y4"/>
<wire x1="-17.78" y1="38.1" x2="-17.78" y2="45.72" width="0.1524" layer="91"/>
<wire x1="-17.78" y1="45.72" x2="17.78" y2="45.72" width="0.1524" layer="91"/>
<wire x1="17.78" y1="45.72" x2="17.78" y2="2.54" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="5"/>
<wire x1="17.78" y1="2.54" x2="2.54" y2="2.54" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$21" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y5"/>
<wire x1="-17.78" y1="27.94" x2="-25.4" y2="27.94" width="0.1524" layer="91"/>
<wire x1="-25.4" y1="27.94" x2="-25.4" y2="2.54" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="6"/>
<wire x1="-25.4" y1="2.54" x2="-7.62" y2="2.54" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$23" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y6"/>
<wire x1="-17.78" y1="35.56" x2="-25.4" y2="35.56" width="0.1524" layer="91"/>
<wire x1="-25.4" y1="35.56" x2="-25.4" y2="48.26" width="0.1524" layer="91"/>
<wire x1="-25.4" y1="48.26" x2="22.86" y2="48.26" width="0.1524" layer="91"/>
<wire x1="22.86" y1="48.26" x2="22.86" y2="0" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="7"/>
<wire x1="22.86" y1="0" x2="2.54" y2="0" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$24" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Y7"/>
<wire x1="-17.78" y1="30.48" x2="-27.94" y2="30.48" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="30.48" x2="-27.94" y2="0" width="0.1524" layer="91"/>
<pinref part="ROW" gate="G$1" pin="8"/>
<wire x1="-27.94" y1="0" x2="-7.62" y2="0" width="0.1524" layer="91"/>
</segment>
</net>
<net name="N$15" class="0">
<segment>
<pinref part="IC2" gate="G$1" pin="Z"/>
<wire x1="-17.78" y1="33.02" x2="-27.94" y2="33.02" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="33.02" x2="-27.94" y2="40.64" width="0.1524" layer="91"/>
<wire x1="-27.94" y1="40.64" x2="-35.56" y2="40.64" width="0.1524" layer="91"/>
<wire x1="-35.56" y1="40.64" x2="-35.56" y2="33.02" width="0.1524" layer="91"/>
<pinref part="AN1" gate="G$3" pin="1"/>
<wire x1="-35.56" y1="33.02" x2="-38.1" y2="33.02" width="0.1524" layer="91"/>
</segment>
</net>
</nets>
</sheet>
</sheets>
</schematic>
</drawing>
<compatibility>
<note version="6.3" minversion="6.2.2" severity="warning">
Since Version 6.2.2 text objects can contain more than one line,
which will not be processed correctly with this version.
</note>
</compatibility>
</eagle>
