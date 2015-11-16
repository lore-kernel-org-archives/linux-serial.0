From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] serial: imx: fix clk_prepare/unprepare usage
Date: Mon, 16 Nov 2015 14:52:52 +0100
Message-ID: <20151116135252.GA14555@gmail.com>
References: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
 <20151116121625.GD22022@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151116121625.GD22022@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 16, 2015 at 01:16:25PM +0100, Uwe Kleine-K=F6nig wrote:
> On Thu, Nov 12, 2015 at 10:58:48AM +0100, Marcus Folkesson wrote:
> > clk_prepare/unprapare APIs are not allowed in atomic context, so
> > move prepare/unprepare to probe/remove and use clk_enable/disable
> > instead.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>=20
> Do you see a problem? I don't claim your patch is wrong, I just wonde=
r
> why nobody else noticed it earlier (including me).
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig      =
      |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/  |


Sorry, seems like the cover-letter was never sent.
The patch solves this issue:


[    6.374678] ------------[ cut here ]------------
[    6.374716] WARNING: CPU: 0 PID: 113 at kernel/locking/mutex.c:868 m=
utex_trylock+0x234/0x238()
[    6.374733] DEBUG_LOCKS_WARN_ON(in_interrupt())
[    6.374741] Modules linked in:
[    6.374762] CPU: 0 PID: 113 Comm: mmcqd/0 Not tainted 4.3.0-rc4-dirt=
y #18
[    6.374772] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[    6.374785] Backtrace:
[    6.374822] [<80013fe8>] (dump_backtrace) from [<800141d8>] (show_st=
ack+0x18/0x1c)
[    6.374856]  r6:80726734 r5:00000000 r4:8081bd80 r3:00000000
[    6.374890] [<800141c0>] (show_stack) from [<80235210>] (dump_stack+=
0x8c/0x9c)
[    6.374920] [<80235184>] (dump_stack) from [<800264a8>] (warn_slowpa=
th_common+0x88/0xb8)
[    6.374940]  r5:00000364 r4:9dc3b978
[    6.374962] [<80026420>] (warn_slowpath_common) from [<80026510>] (w=
arn_slowpath_fmt+0x38/0x40)
[    6.374999]  r8:8041270c r7:802b3f14 r6:810422ec r5:00000001 r4:8084=
5494
[    6.375024] [<800264dc>] (warn_slowpath_fmt) from [<805f571c>] (mute=
x_trylock+0x234/0x238)
[    6.375042]  r3:8072674c r2:80724180
[    6.375072] [<805f54e8>] (mutex_trylock) from [<8041270c>] (clk_prep=
are_lock+0x18/0x100)
[    6.375113]  r9:00000037 r8:805fcc20 r7:802b3f14 r6:9e604e00 r5:0000=
0037 r4:9e604e00
[    6.375138] [<804126f4>] (clk_prepare_lock) from [<80413cd4>] (clk_p=
repare+0x18/0x38)
[    6.375158]  r5:00000037 r4:9e604e00
[    6.375185] [<80413cbc>] (clk_prepare) from [<802b3f48>] (imx_consol=
e_write+0x34/0x230)
[    6.375203]  r4:80fffac8 r3:8105dd6c
[    6.375236] [<802b3f14>] (imx_console_write) from [<80073d8c>] (call=
_console_drivers.constprop.13+0x108/0x120)
[    6.375276]  r10:00000000 r9:00000037 r8:805fcc20 r7:802b3f14 r6:9dc=
3a000 r5:80fff5c0
[    6.375287]  r4:80827a9c
[    6.375317] [<80073c84>] (call_console_drivers.constprop.13) from [<=
80075088>] (console_unlock+0x4e0/0x5c4)
[    6.375356]  r10:00000006 r9:8103f4c0 r8:00000006 r7:00000000 r6:000=
00005 r5:00000037
[    6.375369]  r4:81002fb8
[    6.375397] [<80074ba8>] (console_unlock) from [<800753e4>] (vprintk=
_emit+0x278/0x5e0)
[    6.375437]  r10:00000027 r9:00000000 r8:00000000 r7:00000005 r6:80f=
ff5c0 r5:00000027
[    6.375448]  r4:00000001
[    6.375474] [<8007516c>] (vprintk_emit) from [<800758b8>] (vprintk_d=
efault+0x2c/0x34)
[    6.375515]  r10:00001ffe r9:00001000 r8:00000008 r7:60000193 r6:808=
27e94 r5:80827e94
[    6.375526]  r4:80827cd8
[    6.375557] [<8007588c>] (vprintk_default) from [<800c3da4>] (printk=
+0x38/0x40)
[    6.375590] [<800c3d70>] (printk) from [<802b9b6c>] (credit_entropy_=
bits+0x2f4/0x300)
[    6.375624]  r3:00000000 r2:9e7df300 r1:80749354 r0:80749268
[    6.375659] [<802b9878>] (credit_entropy_bits) from [<802bac34>] (ad=
d_interrupt_randomness+0x16c/0x1e8)
[    6.375699]  r10:8084ebf7 r9:000000d5 r8:9dc3bcc0 r7:80827dd0 r6:fff=
f8d4c r5:80827d9c
[    6.375711]  r4:9ebd2650
[    6.375744] [<802baac8>] (add_interrupt_randomness) from [<80076ef8>=
] (handle_irq_event_percpu+0x98/0x138)
[    6.375783]  r9:9e4e6900 r8:000000d5 r7:00000080 r6:00000001 r5:0000=
0001 r4:00000000
[    6.375814] [<80076e60>] (handle_irq_event_percpu) from [<80076fe0>]=
 (handle_irq_event+0x48/0x6c)
[    6.375854]  r10:9dc3bdbc r9:a0805000 r8:9e406000 r7:00000001 r6:9e7=
e9680 r5:9e4e6960
[    6.375866]  r4:9e4e6900
[    6.375895] [<80076f98>] (handle_irq_event) from [<8007a00c>] (handl=
e_fasteoi_irq+0xc0/0x194)
[    6.375926]  r6:8080dc88 r5:9e4e6960 r4:9e4e6900 r3:00000000
[    6.375950] [<80079f4c>] (handle_fasteoi_irq) from [<800764f8>] (gen=
eric_handle_irq+0x2c/0x3c)
[    6.375981]  r7:00000001 r6:00000000 r5:00000000 r4:808015fc
[    6.376009] [<800764cc>] (generic_handle_irq) from [<80076810>] (__h=
andle_domain_irq+0x64/0xb8)
[    6.376037] [<800767ac>] (__handle_domain_irq) from [<800094c0>] (gi=
c_handle_irq+0x50/0x90)
[    6.376077]  r8:9dc3bcc0 r7:a080400c r6:8081c000 r5:80808834 r4:a080=
4000 r3:9dc3bcc0
[    6.376101] [<80009470>] (gic_handle_irq) from [<80014eb8>] (__irq_s=
vc+0x58/0x78)
[    6.376113] Exception stack(0x9dc3bcc0 to 0x9dc3bd08)
[    6.376139] bcc0: 00000001 00000001 00000000 9e7df300 9dc3bdc0 9dc3b=
dc0 00000002 9dc3a000
[    6.376162] bce0: 00000000 00000000 9dc3bdbc 9dc3bd24 00000000 9dc3b=
d10 80069a88 805f9a04
[    6.376174] bd00: 20000113 ffffffff
[    6.376214]  r9:00000000 r8:00000000 r7:9dc3bcf4 r6:ffffffff r5:2000=
0113 r4:805f9a04
[    6.376248] [<805f99d4>] (_raw_spin_unlock_irq) from [<805f5260>] (w=
ait_for_common+0xb8/0x148)
[    6.376266]  r4:7fffffff r3:9e7df300
[    6.376294] [<805f51a8>] (wait_for_common) from [<805f5308>] (wait_f=
or_completion+0x18/0x1c)
[    6.376334]  r10:24590081 r9:00000000 r8:00000000 r7:9dc3bdbc r6:9dc=
3bdac r5:9e7fc800
[    6.376346]  r4:9dc3be14
[    6.376376] [<805f52f0>] (wait_for_completion) from [<803d07a4>] (mm=
c_wait_for_req_done+0x84/0x110)
[    6.376402] [<803d0720>] (mmc_wait_for_req_done) from [<803d08c4>] (=
mmc_wait_for_cmd+0x6c/0x8c)
[    6.376442]  r8:0000000d r7:00000015 r6:00000000 r5:9e7fc800 r4:9dc3=
be14 r3:00000000
[    6.376468] [<803d0858>] (mmc_wait_for_cmd) from [<803d1790>] (mmc_d=
o_erase+0x1bc/0x31c)
[    6.376492]  r6:0000776f r5:80808100 r4:9dc2c800
[    6.376518] [<803d15d4>] (mmc_do_erase) from [<803d1a0c>] (mmc_erase=
+0x11c/0x1c0)
[    6.376557]  r10:24590081 r9:00086787 r8:00086780 r7:00000001 r6:000=
00008 r5:00000000
[    6.376570]  r4:9dc2c800
[    6.376599] [<803d18f0>] (mmc_erase) from [<803e0adc>] (mmc_blk_issu=
e_rq+0x434/0x4d8)
[    6.376639]  r9:00000000 r8:9dc2bc00 r7:9dc2c800 r6:9dc471a0 r5:9dc2=
c800 r4:9dc2bc24
[    6.376667] [<803e06a8>] (mmc_blk_issue_rq) from [<803e20e0>] (mmc_q=
ueue_thread+0xb8/0x160)
[    6.376707]  r10:9dc471a0 r9:00000001 r8:24590081 r7:00000000 r6:9dc=
3a000 r5:9e71df90
[    6.376720]  r4:9dc2bc24
[    6.376748] [<803e2028>] (mmc_queue_thread) from [<80045c20>] (kthre=
ad+0xf0/0x104)
[    6.376789]  r10:00000000 r9:00000000 r8:00000000 r7:803e2028 r6:9dc=
2bc24 r5:00000000
[    6.376801]  r4:9dc09400
[    6.376829] [<80045b30>] (kthread) from [<8000faf0>] (ret_from_fork+=
0x14/0x24)
[    6.376860]  r7:00000000 r6:00000000 r5:80045b30 r4:9dc09400
[    6.376871] ---[ end trace 98f7b2a2644c179a ]---
[


Best regards
Marcus Folkesson
