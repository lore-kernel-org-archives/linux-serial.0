From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Tue, 16 Feb 2016 17:31:41 +0100
Message-ID: <D4D8C3EE-7BDC-44F4-A54F-A6861FE0A174@martin.sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org> <56BC895E.2010108@sperl.org> <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de> <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org> <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org> <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org> <470852136.382408.76a8faee-9235-4ee0-9fd1-e25a1e9f0bb3.open-xchange@email.1und1.de> <EE05C090-EB8A-41E8-B9C3-8CCC79F15FE9@martin.sperl.org> <359843746.379810.6eb6c2f5-8282-417a-83d1-1fa79425ff73.open-xchange@email.1und1.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <359843746.379810.6eb6c2f5-8282-417a-83d1-1fa79425ff73.open-xchange@email.1und1.de>
Sender: linux-clk-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


> On 13.02.2016, at 21:45, Stefan Wahren <stefan.wahren@i2se.com> wrote=
:
>=20
>=20
> According to the datasheet busy bit shouldn't be set while changing t=
he clock.
> So this isn't good. I hope this could be fixed, too.
>=20

I had hoped that the patch by Eric:
"clk: bcm2835: Fix setting of PLL divider clock rates"
would fix the issue, but that was unfortunately not the case.

Some more investigation using the debugfs patch I had posted,
which exposes the registers showed that:
plld_per_a2w had a value of 4 before starting getty
and a value of 0 after starting getty.

That made me investigate why this value was changed and I found
the culprit in the form of:
@@ -1167,7 +1171,9 @@ static void bcm2835_pll_divider_off(struct clk_hw=
 *hw)
        cprman_write(cprman, data->cm_reg,
                     (cprman_read(cprman, data->cm_reg) &
                      ~data->load_mask) | data->hold_mask);
-       cprman_write(cprman, data->a2w_reg, A2W_PLL_CHANNEL_DISABLE);
+       cprman_write(cprman, data->a2w_reg,
+                    cprman_read(cprman, data->a2w_reg) |
+                       A2W_PLL_CHANNEL_DISABLE);
 }

after that (with plld itself marked as =E2=80=9Cprepared=E2=80=9D durin=
g probe) everything is
working fine.

bcm2835_pll_off shows a similar pattern, but patching that
the same way:
@@ -955,8 +955,12 @@ static void bcm2835_pll_off(struct clk_hw *hw)
        struct bcm2835_cprman *cprman =3D pll->cprman;
        const struct bcm2835_pll_data *data =3D pll->data;

-       cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
-       cprman_write(cprman, data->a2w_ctrl_reg, A2W_PLL_CTRL_PWRDN);
+       cprman_write(cprman, data->cm_ctrl_reg,
+                    cprman_read(cprman, data->cm_ctrl_reg) |
+                    CM_PLL_ANARST);
+       cprman_write(cprman, data->a2w_ctrl_reg,
+                    cprman_read(cprman, data->a2w_ctrl_reg) |
+                    A2W_PLL_CTRL_PWRDN);
 }

does not resolve the issue - the system crashes - but without he pll
lock message=E2=80=A6

With some debugging messages in place (the register names are
added as a comments indicated via >):

the complete list of writes to the clocks during boot:
[    2.021473] bcm2835_pll_on - pllc - start
[    2.025635] cprman_write - 0x0108 =3D 0x00000228
> CM_PLLC
[    2.030313] bcm2835_pll_on - pllc - before_wait_pll_lock
[    2.035773] bcm2835_pll_on - pllc - end
[    2.039785] cprman_write - 0x1620 =3D 0x00000002
> A2W_PLLC_CORE0
[    2.044373] cprman_write - 0x0108 =3D 0x00000228
> CM_PLLC
[    2.049430] console [ttyS0] disabled
[    2.053237] 20215040.serial: ttyS0 at MMIO 0x0 (irq =3D 53, base_bau=
d =3D 31224999) is a 16550
[    2.061878] console [ttyS0] enabled
[    2.069085] bootconsole [earlycon0] disabled
[    2.078668] cprman_write - 0x1520 =3D 0x00000002
> A2W_PLLC_PER
[    2.083201] cprman_write - 0x0108 =3D 0x00000228
> CM_PLLC
[    2.087801] cprman_write - 0x01c0 =3D 0x000002d5
> CM_EMMCCTL
[    2.136432] mmc0: SDHCI controller on 20300000.sdhci [20300000.sdhci=
] using PIO

dumping the registers for PLLD=20
root@raspcm:~# cat /sys/kernel/debug/clk/plld/regdump
cm_ctrl =3D 0x0000020a
> CM_PLLD
a2w_ctrl =3D 0x00021034
> A2W_PLLD_PER
frac =3D 0x00015554
> A2W_PLLD_FRAC
ana0 =3D 0x00000000
> A2W_PLLD_ANA0
ana1 =3D 0x00144000
> A2W_PLLD_ANA1
ana2 =3D 0x00000000
> A2W_PLLD_ANA2
ana3 =3D 0x00000100
> A2W_PLLD_ANA3

running getty:
root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
[   71.110032] pl011_startup - start
[   71.113452] pl011_hwinit - prepare-enable
[   71.117656] bcm2835_pll_on - plld - start
[   71.121750] cprman_write - 0x010c =3D 0x0000020a
> CM_PLLD
[   71.126274] bcm2835_pll_on - plld - before_wait_pll_lock
[   71.131728] bcm2835_pll_on - plld - end
[   71.135648] cprman_write - 0x1540 =3D 0x00000004
> A2W_PLLD_PER
[   71.140228] cprman_write - 0x010c =3D 0x0000020a
> CM_PLLD
[   71.144760] cprman_write - 0x00f0 =3D 0x000002d6
> CM_UARTCTL
[   71.149340] pl011_hwinit - prepare-enable - ret =3D 0
[   71.156743] pl011_startup - exit
[   71.163324] pl011_shutdown - start
[   71.168032] pl011_shutdown - disable_unprepare
[   71.172603] cprman_write - 0x00f0 =3D 0x00000286
> CM_UARTCTL
[   71.177269] cprman_write - 0x010c =3D 0x0000028a
> CM_PLLD
[   71.181809] cprman_write - 0x1540 =3D 0x00000104
> A2W_PLLD_PER
[   71.186334] bcm2835_pll_off - plld - start
[   71.190547] cprman_write - 0x010c =3D 0x0000038a
> CM_PLLD
[   71.195088] cprman_write - 0x1140 =3D 0x00031034
> A2W_PLLD_CTRL
[   71.199643] bcm2835_pll_off - plld - end
[   71.203643] pl011_shutdown - exit
[   71.209122] pl011_startup - start
[   71.212522] pl011_hwinit - prepare-enable
[   71.216695] bcm2835_pll_on - plld - start
[   71.220801] cprman_write - 0x010c =3D 0x0000028a
>  CM_PLLD
[   71.225326] bcm2835_pll_on - plld - before_wait_pll_lock
[   71.230775] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.235840] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.240926] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.245983] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.251067] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.256123] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.261206] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.266272] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.271364] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.276419] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.281523] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.286691] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.291753] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.296838] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.301937] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.307030] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.312087] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.317180] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.322235] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.327319] bcm2835_pll_on - plld - in_pll_lock_loop
[   71.332387] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
[   71.338532] bcm2835_pll_on - plld - timeout
[   71.342801] pl011_hwinit - prepare-enable - ret =3D -110
[   71.348080] pl011_startup - error =3D -110 - disable_unprepare
[   71.353862] ------------[ cut here ]------------
[   71.358593] WARNING: CPU: 0 PID: 2339 at drivers/clk/clk.c:680 clk_c=
ore_disab
le+0x34/0xf0()
[   71.367840] ---[ end trace f080e315d858793e ]---
[   71.372614] ------------[ cut here ]------------
[   71.377408] WARNING: CPU: 0 PID: 2339 at drivers/clk/clk.c:575 clk_c=
ore_unpre
pare+0x34/0x110()
[   71.387073] ---[ end trace f080e315d858793f ]=E2=80=94

no more activity - system crashed - HDMI looses signal
So disabling PLL itself seems not to be recommended

I could create a patch with the following content as a bandaid:
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm283=
5.c
index 5293338..4dfb8e3 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -37,6 +37,7 @@
  * generator).
  */

+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/bcm2835.h>
@@ -1750,6 +1767,9 @@ static int bcm2835_clk_probe(struct platform_devi=
ce *pdev)
			clks[i] =3D desc->clk_register(cprman, desc->data);
 	}
=20
+	/* prepare PLLD, so that it never gets unprepared */
+	clk_prepare(clks[BCM2835_PLLD]);
+
 	return of_clk_add_provider(dev->of_node, of_clk_src_onecell_get,
 				   &cprman->onecell);
 }

Note that this this needed on top of the patch to bcm2835_pll_divider_o=
ff,
which is applied in the kernel used during reporting...

Martin