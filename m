From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: restart callback not supposed to sleep?
Date: Mon, 20 Aug 2012 10:24:23 +0200
Message-ID: <20120820082423.GJ2232@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42993 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab2HTIYY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 04:24:24 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Hello,

while triggering a reboot via sysrq on an ARM machine I saw a "BUG:
sleeping function called from invalid context" message (details below).
The reason is that the sysrq handler is calling the restart hook in irq
context. So what should be done about that? The obvious possiblities
are:

 a) ignore the problem as it won't result in problems (and maybe someho=
w
    silence the warnign); or
 b) make the restart hook atomic; or
 c) assert sysrq not calling the hook in atomic mode

What do you think?

Best regards
Uwe

[  357.957733] SysRq : Resetting
[  357.960772] BUG: sleeping function called from invalid context at ke=
rnel/mutex.c:269
[  357.973053] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swappe=
r
[  357.979508] 2 locks held by swapper/0:
[  357.983268]  #0:  (&port_lock_key){-.-...}, at: [<801df9ec>] imx_rxi=
nt+0x24/0x2a4
[  357.990887]  #1:  (sysrq_key_table_lock){-.....}, at: [<801cda7c>] _=
_handle_sysrq+0x1c/0x188
[  357.999442] Backtrace:=20
[  358.001962] [<80010e9c>] (dump_backtrace+0x0/0x10c) from [<80365da0>=
] (dump_stack+0x18/0x1c)
[  358.010415]  r6:0000166c r5:804dbc00 r4:804ce000 r3:60000113
[  358.016200] [<80365d88>] (dump_stack+0x0/0x1c) from [<80040f70>] (__=
might_sleep+0xe0/0x11c)
[  358.024590] [<80040e90>] (__might_sleep+0x0/0x11c) from [<80369d8c>]=
 (mutex_lock_nested+0x2c/0x2d0)
[  358.033649]  r6:804e90dc r5:80425b9c r4:804fb224
[  358.038372] [<80369d60>] (mutex_lock_nested+0x0/0x2d0) from [<8028ff=
dc>] (clk_get_sys+0x24/0x110)
[  358.047290] [<8028ffb8>] (clk_get_sys+0x0/0x110) from [<800188c8>] (=
mxc_restart+0x18/0xb8)
[  358.055588] [<800188b0>] (mxc_restart+0x0/0xb8) from [<8000ed70>] (m=
achine_restart+0x24/0x60)
[  358.064126]  r5:804e4d70 r4:804dab3c
[  358.067863] [<8000ed4c>] (machine_restart+0x0/0x60) from [<8002d554>=
] (emergency_restart+0x1c/0x20)
[  358.076961]  r5:00000062 r4:804dab3c
[  358.080615] [<8002d538>] (emergency_restart+0x0/0x20) from [<801cd93=
c>] (sysrq_handle_reboot+0x1c/0x20)
[  358.090073] [<801cd920>] (sysrq_handle_reboot+0x0/0x20) from [<801cd=
b6c>] (__handle_sysrq+0x10c/0x188)
[  358.099441] [<801cda60>] (__handle_sysrq+0x0/0x188) from [<801cde00>=
] (handle_sysrq+0x30/0x38)
[  358.108115] [<801cddd0>] (handle_sysrq+0x0/0x38) from [<801dfba8>] (=
imx_rxint+0x1e0/0x2a4)
[  358.116440] [<801df9c8>] (imx_rxint+0x0/0x2a4) from [<801e0b0c>] (im=
x_int+0xa0/0xb8)
[  358.124224] [<801e0a6c>] (imx_int+0x0/0xb8) from [<80063f44>] (handl=
e_irq_event_percpu+0x54/0x1bc)
[  358.133226]  r6:00000000 r5:87808e90 r4:870e9000 r3:801e0a6c
[  358.139026] [<80063ef0>] (handle_irq_event_percpu+0x0/0x1bc) from [<=
800640f0>] (handle_irq_event+0x44/0x64)
[  358.148834] [<800640ac>] (handle_irq_event+0x0/0x64) from [<80066414=
>] (handle_level_irq+0x94/0xf0)
[  358.157923]  r6:00000000 r5:87808e90 r4:87808e40 r3:00020000
[  358.163698] [<80066380>] (handle_level_irq+0x0/0xf0) from [<800637a8=
>] (generic_handle_irq+0x28/0x38)
[  358.172961]  r5:0000003d r4:0000003d
[  358.176635] [<80063780>] (generic_handle_irq+0x0/0x38) from [<8000e9=
2c>] (handle_IRQ+0x38/0x8c)
[  358.185347]  r4:804e4da4 r3:000000b4
[  358.189023] [<8000e8f4>] (handle_IRQ+0x0/0x8c) from [<800084c4>] (av=
ic_handle_irq+0x3c/0x5c)
[  358.197502]  r6:0000ffff r5:804cff18 r4:80502e58 r3:00000010
[  358.203272] [<80008488>] (avic_handle_irq+0x0/0x5c) from [<8000dd24>=
] (__irq_svc+0x44/0x58)
[  358.211670] Exception stack(0x804cff18 to 0x804cff60)
[  358.216769] ff00:                                                   =
    00000001 00000001
[  358.224977] ff20: 00000000 804d8600 804ce000 80502a68 804d98d0 804ce=
000 80004008 4117b363
[  358.233211] ff40: 804c1cec 804cff6c 804cff30 804cff60 800530e0 8000e=
aac 20000013 ffffffff
[  358.241430]  r6:ffffffff r5:20000013 r4:8000eaac r3:804d8600
[  358.247229] [<8000ea84>] (default_idle+0x0/0x40) from [<8000ec88>] (=
cpu_idle+0x64/0xd0)
[  358.255281] [<8000ec24>] (cpu_idle+0x0/0xd0) from [<803605a8>] (rest=
_init+0xc4/0xec)
[  358.263069]  r7:00000002 r6:00000001 r5:804dc534 r4:804ce000
[  358.268876] [<803604e4>] (rest_init+0x0/0xec) from [<804a27d0>] (sta=
rt_kernel+0x2ac/0x2fc)
[  358.277184]  r7:80b4e620 r6:804c31bc r5:805029c0 r4:804d6140
[  358.282954] [<804a2524>] (start_kernel+0x0/0x2fc) from [<80008040>] =
(0x80008040)
[  358.290400] BUG: scheduling while atomic: swapper/0/0x40010004
[  358.296277] 2 locks held by swapper/0:
[  358.300038]  #0:  (&port_lock_key){-.-...}, at: [<801df9ec>] imx_rxi=
nt+0x24/0x2a4
[  358.307669]  #1:  (sysrq_key_table_lock){-.....}, at: [<801cda7c>] _=
_handle_sysrq+0x1c/0x188
[  358.316253] Modules linked in:
[  358.319337] Backtrace:=20
[  358.321837] [<80010e9c>] (dump_backtrace+0x0/0x10c) from [<80365da0>=
] (dump_stack+0x18/0x1c)
[  358.330320]  r6:804d8600 r5:80425b9c r4:804d8600 r3:20000113
[  358.336121] [<80365d88>] (dump_stack+0x0/0x1c) from [<803664cc>] (__=
schedule_bug+0x64/0x78)
[  358.344505] [<80366468>] (__schedule_bug+0x0/0x78) from [<8036acf8>]=
 (__schedule+0x3fc/0x464)
[  358.353072]  r4:804ce000 r3:00000000
[  358.356752] [<8036a8fc>] (__schedule+0x0/0x464) from [<8004153c>] (_=
_cond_resched+0x28/0x38)
[  358.365225] [<80041514>] (__cond_resched+0x0/0x38) from [<8036adf4>]=
 (_cond_resched+0x38/0x48)
[  358.373880]  r4:804fb224 r3:00010003
[  358.377553] [<8036adbc>] (_cond_resched+0x0/0x48) from [<80369d90>] =
(mutex_lock_nested+0x30/0x2d0)
[  358.386580] [<80369d60>] (mutex_lock_nested+0x0/0x2d0) from [<8028ff=
dc>] (clk_get_sys+0x24/0x110)
[  358.395492] [<8028ffb8>] (clk_get_sys+0x0/0x110) from [<800188c8>] (=
mxc_restart+0x18/0xb8)
[  358.403824] [<800188b0>] (mxc_restart+0x0/0xb8) from [<8000ed70>] (m=
achine_restart+0x24/0x60)
[  358.412393]  r5:804e4d70 r4:804dab3c
[  358.416046] [<8000ed4c>] (machine_restart+0x0/0x60) from [<8002d554>=
] (emergency_restart+0x1c/0x20)
[  358.425135]  r5:00000062 r4:804dab3c
[  358.428810] [<8002d538>] (emergency_restart+0x0/0x20) from [<801cd93=
c>] (sysrq_handle_reboot+0x1c/0x20)
[  358.438265] [<801cd920>] (sysrq_handle_reboot+0x0/0x20) from [<801cd=
b6c>] (__handle_sysrq+0x10c/0x188)
[  358.447631] [<801cda60>] (__handle_sysrq+0x0/0x188) from [<801cde00>=
] (handle_sysrq+0x30/0x38)
[  358.456308] [<801cddd0>] (handle_sysrq+0x0/0x38) from [<801dfba8>] (=
imx_rxint+0x1e0/0x2a4)
[  358.464604] [<801df9c8>] (imx_rxint+0x0/0x2a4) from [<801e0b0c>] (im=
x_int+0xa0/0xb8)
[  358.472410] [<801e0a6c>] (imx_int+0x0/0xb8) from [<80063f44>] (handl=
e_irq_event_percpu+0x54/0x1bc)
[  358.481411]  r6:00000000 r5:87808e90 r4:870e9000 r3:801e0a6c
[  358.487210] [<80063ef0>] (handle_irq_event_percpu+0x0/0x1bc) from [<=
800640f0>] (handle_irq_event+0x44/0x64)
[  358.497013] [<800640ac>] (handle_irq_event+0x0/0x64) from [<80066414=
>] (handle_level_irq+0x94/0xf0)
[  358.506072]  r6:00000000 r5:87808e90 r4:87808e40 r3:00020000
[  358.511877] [<80066380>] (handle_level_irq+0x0/0xf0) from [<800637a8=
>] (generic_handle_irq+0x28/0x38)
[  358.521139]  r5:0000003d r4:0000003d
[  358.524787] [<80063780>] (generic_handle_irq+0x0/0x38) from [<8000e9=
2c>] (handle_IRQ+0x38/0x8c)
[  358.533529]  r4:804e4da4 r3:000000b4
[  358.537199] [<8000e8f4>] (handle_IRQ+0x0/0x8c) from [<800084c4>] (av=
ic_handle_irq+0x3c/0x5c)
[  358.545650]  r6:0000ffff r5:804cff18 r4:80502e58 r3:00000010
[  358.551450] [<80008488>] (avic_handle_irq+0x0/0x5c) from [<8000dd24>=
] (__irq_svc+0x44/0x58)
[  358.559847] Exception stack(0x804cff18 to 0x804cff60)
[  358.564918] ff00:                                                   =
    00000001 00000001
[  358.573156] ff20: 00000000 804d8600 804ce000 80502a68 804d98d0 804ce=
000 80004008 4117b363
[  358.581391] ff40: 804c1cec 804cff6c 804cff30 804cff60 800530e0 8000e=
aac 20000013 ffffffff
[  358.589609]  r6:ffffffff r5:20000013 r4:8000eaac r3:804d8600
[  358.595383] [<8000ea84>] (default_idle+0x0/0x40) from [<8000ec88>] (=
cpu_idle+0x64/0xd0)
[  358.603455] [<8000ec24>] (cpu_idle+0x0/0xd0) from [<803605a8>] (rest=
_init+0xc4/0xec)
[  358.611241]  r7:00000002 r6:00000001 r5:804dc534 r4:804ce000
[  358.617041] [<803604e4>] (rest_init+0x0/0xec) from [<804a27d0>] (sta=
rt_kernel+0x2ac/0x2fc)
[  358.625319]  r7:80b4e620 r6:804c31bc r5:805029c0 r4:804d6140
[  358.631118] [<804a2524>] (start_kernel+0x0/0x2fc) from [<80008040>] =
(0x80008040)
[  358.686854] ------------[ cut here ]------------
[  358.691551] WARNING: at kernel/mutex.c:198 mutex_lock_nested+0x290/0=
x2d0()
[  358.703020] Modules linked in:
[  358.706145] Backtrace:=20
[  358.708665] [<80010e9c>] (dump_backtrace+0x0/0x10c) from [<80365da0>=
] (dump_stack+0x18/0x1c)
[  358.717153]  r6:000000c6 r5:80369ff0 r4:00000000 r3:00000000
[  358.722925] [<80365d88>] (dump_stack+0x0/0x1c) from [<8001b4d0>] (wa=
rn_slowpath_common+0x54/0x6c)
[  358.731860] [<8001b47c>] (warn_slowpath_common+0x0/0x6c) from [<8001=
b50c>] (warn_slowpath_null+0x24/0x2c)
[  358.741469]  r8:00000000 r7:804d8600 r6:804ce000 r5:8050401c r4:804f=
b224 r3:00000009
[  358.749478] [<8001b4e8>] (warn_slowpath_null+0x0/0x2c) from [<80369f=
f0>] (mutex_lock_nested+0x290/0x2d0)
[  358.759032] [<80369d60>] (mutex_lock_nested+0x0/0x2d0) from [<8028ff=
dc>] (clk_get_sys+0x24/0x110)
[  358.767984] [<8028ffb8>] (clk_get_sys+0x0/0x110) from [<800188c8>] (=
mxc_restart+0x18/0xb8)
[  358.776318] [<800188b0>] (mxc_restart+0x0/0xb8) from [<8000ed70>] (m=
achine_restart+0x24/0x60)
[  358.784858]  r5:804e4d70 r4:804dab3c
[  358.788547] [<8000ed4c>] (machine_restart+0x0/0x60) from [<8002d554>=
] (emergency_restart+0x1c/0x20)
[  358.797637]  r5:00000062 r4:804dab3c
[  358.801294] [<8002d538>] (emergency_restart+0x0/0x20) from [<801cd93=
c>] (sysrq_handle_reboot+0x1c/0x20)
[  358.810750] [<801cd920>] (sysrq_handle_reboot+0x0/0x20) from [<801cd=
b6c>] (__handle_sysrq+0x10c/0x188)
[  358.820115] [<801cda60>] (__handle_sysrq+0x0/0x188) from [<801cde00>=
] (handle_sysrq+0x30/0x38)
[  358.828795] [<801cddd0>] (handle_sysrq+0x0/0x38) from [<801dfba8>] (=
imx_rxint+0x1e0/0x2a4)
[  358.837123] [<801df9c8>] (imx_rxint+0x0/0x2a4) from [<801e0b0c>] (im=
x_int+0xa0/0xb8)
[  358.844909] [<801e0a6c>] (imx_int+0x0/0xb8) from [<80063f44>] (handl=
e_irq_event_percpu+0x54/0x1bc)
[  358.853909]  r6:00000000 r5:87808e90 r4:870e9000 r3:801e0a6c
[  358.859708] [<80063ef0>] (handle_irq_event_percpu+0x0/0x1bc) from [<=
800640f0>] (handle_irq_event+0x44/0x64)
[  358.869513] [<800640ac>] (handle_irq_event+0x0/0x64) from [<80066414=
>] (handle_level_irq+0x94/0xf0)
[  358.878602]  r6:00000000 r5:87808e90 r4:87808e40 r3:00020000
[  358.884374] [<80066380>] (handle_level_irq+0x0/0xf0) from [<800637a8=
>] (generic_handle_irq+0x28/0x38)
[  358.893635]  r5:0000003d r4:0000003d
[  358.897307] [<80063780>] (generic_handle_irq+0x0/0x38) from [<8000e9=
2c>] (handle_IRQ+0x38/0x8c)
[  358.906020]  r4:804e4da4 r3:000000b4
[  358.909693] [<8000e8f4>] (handle_IRQ+0x0/0x8c) from [<800084c4>] (av=
ic_handle_irq+0x3c/0x5c)
[  358.918173]  r6:0000ffff r5:804cff18 r4:80502e58 r3:00000010
[  358.923941] [<80008488>] (avic_handle_irq+0x0/0x5c) from [<8000dd24>=
] (__irq_svc+0x44/0x58)
[  358.932339] Exception stack(0x804cff18 to 0x804cff60)
[  358.937439] ff00:                                                   =
    00000001 00000001
[  358.945645] ff20: 00000000 804d8600 804ce000 80502a68 804d98d0 804ce=
000 80004008 4117b363
[  358.953878] ff40: 804c1cec 804cff6c 804cff30 804cff60 800530e0 8000e=
aac 20000013 ffffffff
[  358.962095]  r6:ffffffff r5:20000013 r4:8000eaac r3:804d8600
[  358.967894] [<8000ea84>] (default_idle+0x0/0x40) from [<8000ec88>] (=
cpu_idle+0x64/0xd0)
[  358.975943] [<8000ec24>] (cpu_idle+0x0/0xd0) from [<803605a8>] (rest=
_init+0xc4/0xec)
[  358.983728]  r7:00000002 r6:00000001 r5:804dc534 r4:804ce000
[  358.989531] [<803604e4>] (rest_init+0x0/0xec) from [<804a27d0>] (sta=
rt_kernel+0x2ac/0x2fc)
[  358.997838]  r7:80b4e620 r6:804c31bc r5:805029c0 r4:804d6140
[  359.003606] [<804a2524>] (start_kernel+0x0/0x2fc) from [<80008040>] =
(0x80008040)
[  359.011047] ---[ end trace 1ad357144973f17c ]---
[  359.015715] BUG: sleeping function called from invalid context at ke=
rnel/mutex.c:269
[  359.028025] in_atomic(): 1, irqs_disabled(): 0, pid: 0, name: swappe=
r
[  359.034479] INFO: lockdep is turned off.
[  359.038440] Backtrace:=20
[  359.040946] [<80010e9c>] (dump_backtrace+0x0/0x10c) from [<80365da0>=
] (dump_stack+0x18/0x1c)
[  359.049430]  r6:000016d5 r5:804dbc00 r4:804ce000 r3:60000013
[  359.055216] [<80365d88>] (dump_stack+0x0/0x1c) from [<80040f70>] (__=
might_sleep+0xe0/0x11c)
[  359.063635] [<80040e90>] (__might_sleep+0x0/0x11c) from [<80369d8c>]=
 (mutex_lock_nested+0x2c/0x2d0)
[  359.072726]  r6:804e90dc r5:8780db40 r4:804fb274
[  359.077470] [<80369d60>] (mutex_lock_nested+0x0/0x2d0) from [<802914=
78>] (clk_prepare+0x20/0x40)
[  359.086333] [<80291458>] (clk_prepare+0x0/0x40) from [<800188d8>] (m=
xc_restart+0x28/0xb8)
[  359.094526]  r5:804e4d70 r4:8780db40
[  359.098207] [<800188b0>] (mxc_restart+0x0/0xb8) from [<8000ed70>] (m=
achine_restart+0x24/0x60)
[  359.106776]  r5:804e4d70 r4:804dab3c
[  359.110427] [<8000ed4c>] (machine_restart+0x0/0x60) from [<8002d554>=
] (emergency_restart+0x1c/0x20)
[  359.119517]  r5:00000062 r4:804dab3c
[  359.123166] [<8002d538>] (emergency_restart+0x0/0x20) from [<801cd93=
c>] (sysrq_handle_reboot+0x1c/0x20)
[  359.132621] [<801cd920>] (sysrq_handle_reboot+0x0/0x20) from [<801cd=
b6c>] (__handle_sysrq+0x10c/0x188)
[  359.141988] [<801cda60>] (__handle_sysrq+0x0/0x188) from [<801cde00>=
] (handle_sysrq+0x30/0x38)
[  359.150664] [<801cddd0>] (handle_sysrq+0x0/0x38) from [<801dfba8>] (=
imx_rxint+0x1e0/0x2a4)
[  359.158987] [<801df9c8>] (imx_rxint+0x0/0x2a4) from [<801e0b0c>] (im=
x_int+0xa0/0xb8)
[  359.166794] [<801e0a6c>] (imx_int+0x0/0xb8) from [<80063f44>] (handl=
e_irq_event_percpu+0x54/0x1bc)
[  359.175767]  r6:00000000 r5:87808e90 r4:870e9000 r3:801e0a6c
[  359.181569] [<80063ef0>] (handle_irq_event_percpu+0x0/0x1bc) from [<=
800640f0>] (handle_irq_event+0x44/0x64)
[  359.191374] [<800640ac>] (handle_irq_event+0x0/0x64) from [<80066414=
>] (handle_level_irq+0x94/0xf0)
[  359.200461]  r6:00000000 r5:87808e90 r4:87808e40 r3:00020000
[  359.206260] [<80066380>] (handle_level_irq+0x0/0xf0) from [<800637a8=
>] (generic_handle_irq+0x28/0x38)
[  359.215494]  r5:0000003d r4:0000003d
[  359.219168] [<80063780>] (generic_handle_irq+0x0/0x38) from [<8000e9=
2c>] (handle_IRQ+0x38/0x8c)
[  359.227911]  r4:804e4da4 r3:000000b4
[  359.231555] [<8000e8f4>] (handle_IRQ+0x0/0x8c) from [<800084c4>] (av=
ic_handle_irq+0x3c/0x5c)
[  359.240035]  r6:0000ffff r5:804cff18 r4:80502e58 r3:00000010
[  359.245803] [<80008488>] (avic_handle_irq+0x0/0x5c) from [<8000dd24>=
] (__irq_svc+0x44/0x58)
[  359.254198] Exception stack(0x804cff18 to 0x804cff60)
[  359.259296] ff00:                                                   =
    00000001 00000001
[  359.267530] ff20: 00000000 804d8600 804ce000 80502a68 804d98d0 804ce=
000 80004008 4117b363
[  359.275736] ff40: 804c1cec 804cff6c 804cff30 804cff60 800530e0 8000e=
aac 20000013 ffffffff
[  359.283951]  r6:ffffffff r5:20000013 r4:8000eaac r3:804d8600
[  359.289748] [<8000ea84>] (default_idle+0x0/0x40) from [<8000ec88>] (=
cpu_idle+0x64/0xd0)
[  359.297818] [<8000ec24>] (cpu_idle+0x0/0xd0) from [<803605a8>] (rest=
_init+0xc4/0xec)
[  359.305576]  r7:00000002 r6:00000001 r5:804dc534 r4:804ce000
[  359.311380] [<803604e4>] (rest_init+0x0/0xec) from [<804a27d0>] (sta=
rt_kernel+0x2ac/0x2fc)
[  359.319688]  r7:80b4e620 r6:804c31bc r5:805029c0 r4:804d6140
[  359.325454] [<804a2524>] (start_kernel+0x0/0x2fc) from [<80008040>] =
(0x80008040)
[  359.332899] BUG: scheduling while atomic: swapper/0/0x40010004
[  359.338769] INFO: lockdep is turned off.
[  359.342703] Modules linked in:
[  359.345783] Backtrace:=20
[  359.348312] [<80010e9c>] (dump_backtrace+0x0/0x10c) from [<80365da0>=
] (dump_stack+0x18/0x1c)
[  359.356797]  r6:804d8600 r5:8780db40 r4:804d8600 r3:60000013
[  359.362567] [<80365d88>] (dump_stack+0x0/0x1c) from [<803664cc>] (__=
schedule_bug+0x64/0x78)
[  359.370980] [<80366468>] (__schedule_bug+0x0/0x78) from [<8036acf8>]=
 (__schedule+0x3fc/0x464)
[  359.379546]  r4:804ce000 r3:00000000
[  359.383201] [<8036a8fc>] (__schedule+0x0/0x464) from [<8004153c>] (_=
_cond_resched+0x28/0x38)
[  359.391708] [<80041514>] (__cond_resched+0x0/0x38) from [<8036adf4>]=
 (_cond_resched+0x38/0x48)
[  359.400365]  r4:804fb274 r3:00010003
[  359.404012] [<8036adbc>] (_cond_resched+0x0/0x48) from [<80369d90>] =
(mutex_lock_nested+0x30/0x2d0)
[  359.413041] [<80369d60>] (mutex_lock_nested+0x0/0x2d0) from [<802914=
78>] (clk_prepare+0x20/0x40)
[  359.421896] [<80291458>] (clk_prepare+0x0/0x40) from [<800188d8>] (m=
xc_restart+0x28/0xb8)
[  359.430116]  r5:804e4d70 r4:8780db40
[  359.433767] [<800188b0>] (mxc_restart+0x0/0xb8) from [<8000ed70>] (m=
achine_restart+0x24/0x60)
[  359.442336]  r5:804e4d70 r4:804dab3c
[  359.445986] [<8000ed4c>] (machine_restart+0x0/0x60) from [<8002d554>=
] (emergency_restart+0x1c/0x20)
[  359.455074]  r5:00000062 r4:804dab3c
[  359.458748] [<8002d538>] (emergency_restart+0x0/0x20) from [<801cd93=
c>] (sysrq_handle_reboot+0x1c/0x20)
[  359.468202] [<801cd920>] (sysrq_handle_reboot+0x0/0x20) from [<801cd=
b6c>] (__handle_sysrq+0x10c/0x188)
[  359.477569] [<801cda60>] (__handle_sysrq+0x0/0x188) from [<801cde00>=
] (handle_sysrq+0x30/0x38)
[  359.486242] [<801cddd0>] (handle_sysrq+0x0/0x38) from [<801dfba8>] (=
imx_rxint+0x1e0/0x2a4)
[  359.494538] [<801df9c8>] (imx_rxint+0x0/0x2a4) from [<801e0b0c>] (im=
x_int+0xa0/0xb8)
[  359.502344] [<801e0a6c>] (imx_int+0x0/0xb8) from [<80063f44>] (handl=
e_irq_event_percpu+0x54/0x1bc)
[  359.511344]  r6:00000000 r5:87808e90 r4:870e9000 r3:801e0a6c
[  359.517140] [<80063ef0>] (handle_irq_event_percpu+0x0/0x1bc) from [<=
800640f0>] (handle_irq_event+0x44/0x64)
[  359.526943] [<800640ac>] (handle_irq_event+0x0/0x64) from [<80066414=
>] (handle_level_irq+0x94/0xf0)
[  359.536002]  r6:00000000 r5:87808e90 r4:87808e40 r3:00020000
[  359.541803] [<80066380>] (handle_level_irq+0x0/0xf0) from [<800637a8=
>] (generic_handle_irq+0x28/0x38)
[  359.551064]  r5:0000003d r4:0000003d
[  359.554713] [<80063780>] (generic_handle_irq+0x0/0x38) from [<8000e9=
2c>] (handle_IRQ+0x38/0x8c)
[  359.563453]  r4:804e4da4 r3:000000b4
[  359.567121] [<8000e8f4>] (handle_IRQ+0x0/0x8c) from [<800084c4>] (av=
ic_handle_irq+0x3c/0x5c)
[  359.575572]  r6:0000ffff r5:804cff18 r4:80502e58 r3:00000010
[  359.581372] [<80008488>] (avic_handle_irq+0x0/0x5c) from [<8000dd24>=
] (__irq_svc+0x44/0x58)
[  359.589768] Exception stack(0x804cff18 to 0x804cff60)
[  359.594839] ff00:                                                   =
    00000001 00000001
[  359.603073] ff20: 00000000 804d8600 804ce000 80502a68 804d98d0 804ce=
000 80004008 4117b363
[  359.611307] ff40: 804c1cec 804cff6c 804cff30 804cff60 800530e0 8000e=
aac 20000013 ffffffff
[  359.619524]  r6:ffffffff r5:20000013 r4:8000eaac r3:804d8600
[  359.625296] [<8000ea84>] (default_idle+0x0/0x40) from [<8000ec88>] (=
cpu_idle+0x64/0xd0)
[  359.633366] [<8000ec24>] (cpu_idle+0x0/0xd0) from [<803605a8>] (rest=
_init+0xc4/0xec)
[  359.641152]  r7:00000002 r6:00000001 r5:804dc534 r4:804ce000
[  359.646950] [<803604e4>] (rest_init+0x0/0xec) from [<804a27d0>] (sta=
rt_kernel+0x2ac/0x2fc)
[  359.655227]  r7:80b4e620 r6:804c31bc r5:805029c0 r4:804d6140
[  359.661024] [<804a2524>] (start_kernel+0x0/0x2fc) from [<80008040>] =
(0x80008040)


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
