<chart>
id=133668392588088657
symbol=EURJPY
period=240
leftpos=1788
digits=3
scale=8
graph=1
fore=0
grid=0
volume=0
scroll=0
shift=1
ohlc=1
one_click=0
one_click_btn=1
askline=1
days=1
descriptions=0
shift_size=20
fixed_pos=0
window_left=804
window_top=0
window_right=1608
window_bottom=711
window_type=3
background_color=16777215
foreground_color=0
barup_color=0
bardown_color=255
bullcandle_color=0
bearcandle_color=16777215
chartline_color=255
volumes_color=64636
grid_color=10061943
askline_color=255
stops_color=14381203

<window>
height=294
fixed_height=0
<indicator>
name=main
<object>
type=22
object_name=#89295720 sell 0.01 EURJPY at 165.72400
period_flags=0
create_time=1722406485
color=255
weight=1
background=0
symbol_code=1
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378877
value_0=165.724000
</object>
<object>
type=22
object_name=#89295720 sell 0.01 EURJPY at 165.724 stop loss at 166.739
period_flags=0
create_time=1722406485
color=255
weight=1
background=0
symbol_code=4
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378877
value_0=166.739000
</object>
<object>
type=22
object_name=#89295720 sell 0.01 EURJPY at 165.724 take profit at 164.975
period_flags=0
create_time=1722406485
color=16711680
weight=1
background=0
symbol_code=4
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378877
value_0=164.975000
</object>
<object>
type=22
object_name=#89295720 sell 0.01 EURJPY at 165.724 close at 164.975
period_flags=0
create_time=1722406485
color=2139610
weight=1
background=0
symbol_code=3
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722388033
value_0=164.975000
</object>
<object>
type=2
object_name=#89295720 165.724 -> 164.975
period_flags=0
create_time=1722406485
color=255
style=2
weight=1
background=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378877
value_0=165.724000
time_1=1722388033
value_1=164.975000
ray=0
</object>
<object>
type=23
object_name=CT1H4
period_flags=0
create_time=1722407487
description=10:29
color=0
font=Arial Bold
fontsize=13
angle=0
anchor_pos=6
background=0
filling=0
selectable=0
hidden=1
zorder=0
corner=1
x_distance=2
y_distance=14
</object>
<object>
type=22
object_name=#89295716 sell 0.01 EURJPY at 165.71300
period_flags=0
create_time=1722414060
color=255
weight=1
background=0
symbol_code=1
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378735
value_0=165.713000
</object>
<object>
type=22
object_name=#89295716 sell 0.01 EURJPY at 165.713 stop loss at 162.818
period_flags=0
create_time=1722414060
color=255
weight=1
background=0
symbol_code=4
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378735
value_0=162.818000
</object>
<object>
type=22
object_name=#89295716 sell 0.01 EURJPY at 165.713 take profit at 156.682
period_flags=0
create_time=1722414060
color=16711680
weight=1
background=0
symbol_code=4
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378735
value_0=156.682000
</object>
<object>
type=22
object_name=#89295716 sell 0.01 EURJPY at 165.713 close at 162.818
period_flags=0
create_time=1722414060
color=2139610
weight=1
background=0
symbol_code=3
anchor_pos=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722424807
value_0=162.818000
</object>
<object>
type=2
object_name=#89295716 165.713 -> 162.818
period_flags=0
create_time=1722414060
color=255
style=2
weight=1
background=0
filling=0
selectable=1
hidden=0
zorder=0
time_0=1722378735
value_0=165.713000
time_1=1722424807
value_1=162.818000
ray=0
</object>
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=Omega\Baseline\fantailvma3
flags=275
window_num=0
<inputs>
ADX_Length=10
Weighting=16.0
MA_Length=9
MA_Mode=0
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=16760576
style_0=0
weight_0=2
period_flags=0
show_data=1
</indicator>
<indicator>
name=Custom Indicator
<expert>
name=Market\Blahtech Candle Timer
flags=275
window_num=0
<inputs>
TextLocation=2
TextColourScheme=0
TextColour=0
TextColour2=0
TextColourCountdown=0
TextSize=13
TextShiftBars=2
TextShiftPrice=0.0
TextShiftX=2.0
TextShiftY=14.0
TextAnchor=0
TextFont=Arial Bold
TextPrefix=
ConnectedSuffix=
InactiveSuffix=(-)
DisconnectedSuffix=(x)
AlertsPopup=0
AlertsEmail=false
AlertsNotifications=false
AlertsSoundWavFile=Alert.wav
AlertsMessageText={date} - Blahtech Candle Timer ({acc_name}, {symbol}, {timeframe})
AlertsEmailSubject=Blahtech Candle Timer ({acc_name}, {symbol}, {timeframe})
AlertsEmailBodyText={date} - Blahtech Candle Timer ({acc_name}, {symbol}, {timeframe})
AlertsEarlySeconds=0
AlertsStartupDelay=10
CountdownSeconds=10
InactiveSeconds=20
CustomPeriodSeconds=0
CandleTimeOffsetSeconds=0
LocalTimerGmtOffset=0
InstanceId=1
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=4294967295
style_0=0
weight_0=0
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=6
fixed_height=0
<indicator>
name=Relative Vigor Index
period=10
color=32768
style=0
weight=1
color2=255
style2=0
weight2=1
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=6
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=Omega\Volume\William Vix-Fix
flags=275
window_num=4
<inputs>
iPeriod=81
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=255
style_0=0
weight_0=0
levels_color=16760576
levels_style=0
levels_weight=1
level_0=1.20000000
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=6
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=ATR
flags=275
window_num=4
<inputs>
InpAtrPeriod=14
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=16748574
style_0=0
weight_0=0
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=68
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=Omega\Confirmation\Top Bottom NR
flags=339
window_num=4
<inputs>
per=7
</inputs>
</expert>
shift_0=0
draw_0=0
color_0=3329330
style_0=0
weight_0=2
shift_1=0
draw_1=0
color_1=3937500
style_1=0
weight_1=2
period_flags=0
show_data=1
</indicator>
</window>

<window>
height=50
fixed_height=0
<indicator>
name=Custom Indicator
<expert>
name=Omega\Confirmation\glitch index fixed
flags=339
window_num=5
<inputs>
MaPeriod=22
MaMethod=7
Price=25
level1=1.0
level2=1.0
</inputs>
</expert>
shift_0=0
draw_0=2
color_0=3329330
style_0=0
weight_0=2
shift_1=0
draw_1=2
color_1=3329330
style_1=0
weight_1=2
shift_2=0
draw_2=2
color_2=3937500
style_2=0
weight_2=2
shift_3=0
draw_3=2
color_3=3937500
style_3=0
weight_3=2
shift_4=0
draw_4=0
color_4=4294967295
style_4=0
weight_4=1
shift_5=0
draw_5=0
color_5=4294967295
style_5=0
weight_5=0
shift_6=0
draw_6=0
color_6=4294967295
style_6=0
weight_6=0
levels_color=4294967295
levels_style=0
levels_weight=1
level_0=0.00000000
level_1=1.00000000
level_2=1.00000000
level_3=-1.00000000
level_4=-1.00000000
period_flags=0
show_data=1
</indicator>
</window>
</chart>
