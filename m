From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Sat, 13 Feb 2016 12:24:43 +0100
Message-ID: <F7B22AC0-58A7-431D-B203-0C7A9802A040@martin.sperl.org>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org> <56BC895E.2010108@sperl.org> <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de> <662D2FB2-B088-4CFC-8416-A4F35BBAD7DD@sperl.org> <F7A2533A-D64C-4187-ABD4-416C446D1637@martin.sperl.org> <6CD3FC59-BA17-43D9-897C-A2D122D26EF8@martin.sperl.org> <470852136.382408.76a8faee-9235-4ee0-9fd1-e25a1e9f0bb3.open-xchange@email.1und1.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <470852136.382408.76a8faee-9235-4ee0-9fd1-e25a1e9f0bb3.open-xchange@email.1und1.de>
Sender: linux-clk-owner@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Eric Anholt <eric@anholt.net>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


> On 13.02.2016, at 11:01, Stefan Wahren <stefan.wahren@i2se.com> wrote=
:
>=20
> Hi Martin,
>=20
>> Martin Sperl <kernel@martin.sperl.org> hat am 12. Februar 2016 um 20=
:44
>> geschrieben:
>>=20
>> So the issue is triggered as soon as the plld_per
>> pll divider gets disabled/reenabled.
>>=20
>> This happens because the clk_hw.core.prepare_count
>> drops down to 0 and then unprepare is called.
>>=20
>> So we need to increase the ref-count for the pll
>> and pll_dividers to at least 1 so that these never
>> get disabled - at least for now until we can come
>> up with a better contract with the firmware.
>>=20
>> Obviously this may impact other drivers as well
>> where a pll is used for the first time - if nothing
>> else uses it and the clock gets released, then
>> the clock would trigger a unprepare of the whole
>> branch of the clock tree.
>>=20
>> The question is: how can we solve it in an acceptable
>> manner?
>>=20
>> Do we need a driver that just holds a reference to
>> those clocks? Or should we just prepare the clock
>> after registering it in clk-bcm2835.c?
>>=20
>> As for why does this not show up when compiled in?
>> It seems that in that case the amba_pl011 driver
>> never gets removed and then probed again.
>>=20
>> This is possibly related to the optional use of DMA,
>> with the amba-pl011 driver that retries the install,
>> which is not supported on the bcm2835 - at least that
>> is what the datasheet says. And DMA is (probably) not
>> enabled during the early boot stages, so it does not
>> fail once when it tries to register DMA.
>>=20
>> Thanks,
>> Martin
>>=20
>=20
> i think i must correct myself. The fixed apb should stay since there =
is no
> dynamic replacement and a proper disabling of plld shouldn't cause th=
is freeze.
>=20
> I have the suspicion the freeze is caused by a clock glitch or lock-u=
p.
>=20
> Could you please revert your changes and apply the attached patch? Ma=
ybe we can
> see more.

I will give it a try.

But to me it seems as if the disabling of PLLD produces a hickup in the=
=20
firmware (which relies on PLLD-DIV and thus PLL).

This would also explain the 3-4 second bar/blanking pattern seen on HDM=
I,
which I would guess is related to a reset loop...

I got a simple fix for now, that just prepares a few clocks/pll/pll_div=
s
during probing, so that they will never get unprepared/fully stopped):

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm283=
5.c
index 015e687..fe0c401 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -37,6 +37,7 @@
  * generator).
  */

+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/bcm2835.h>
@@ -1504,6 +1505,7 @@ static int bcm2835_clk_probe(struct platform_devi=
ce *pdev)
        struct clk **clks;
        struct bcm2835_cprman *cprman;
        struct resource *res;
+       int ret;

        cprman =3D devm_kzalloc(dev, sizeof(*cprman), GFP_KERNEL);
        if (!cprman)
@@ -1597,6 +1599,37 @@ static int bcm2835_clk_probe(struct platform_dev=
ice *pdev
        clks[BCM2835_CLOCK_PWM] =3D
                bcm2835_register_clock(cprman, &bcm2835_clock_pwm_data)=
;

+       /*
+        * Several PLLs, PLL-dividers and clocks need to get prepared
+        * so that they are never unprepared and released.
+        * We run this separately as there may be dependencies that wou=
ld
+        * need to be fullfilled first...
+        * Note: Especially unpreparing PLLD_PER will kill the system
+        *       (even if it is prepared again almost immediately
+        *        the HDMI display will fail)
+        */
+#define CLK_PREPARE_INITIAL(clkid)                                    =
 \
+       if (clks[clkid] && (ret =3D clk_prepare(clks[clkid])))         =
   \
+               dev_err(dev, "could not prepare clock %pC - %d\n",     =
 \
+                       clks[clkid], ret);
+       CLK_PREPARE_INITIAL(BCM2835_PLLA);
+       CLK_PREPARE_INITIAL(BCM2835_PLLB);
+       CLK_PREPARE_INITIAL(BCM2835_PLLC);
+       CLK_PREPARE_INITIAL(BCM2835_PLLD);
+       CLK_PREPARE_INITIAL(BCM2835_PLLH);
+       CLK_PREPARE_INITIAL(BCM2835_PLLA_CORE);
+       CLK_PREPARE_INITIAL(BCM2835_PLLA_PER);
+       CLK_PREPARE_INITIAL(BCM2835_PLLC_CORE0);
+       CLK_PREPARE_INITIAL(BCM2835_PLLC_CORE1);
+       CLK_PREPARE_INITIAL(BCM2835_PLLC_CORE2);
+       CLK_PREPARE_INITIAL(BCM2835_PLLC_PER);
+       CLK_PREPARE_INITIAL(BCM2835_PLLD_CORE);
+       CLK_PREPARE_INITIAL(BCM2835_PLLD_PER);
+       CLK_PREPARE_INITIAL(BCM2835_PLLH_RCAL);
+       CLK_PREPARE_INITIAL(BCM2835_PLLH_AUX);
+       CLK_PREPARE_INITIAL(BCM2835_PLLH_PIX);
+       CLK_PREPARE_INITIAL(BCM2835_CLOCK_VPU);
+
        return of_clk_add_provider(dev->of_node, of_clk_src_onecell_get=
,
                                   &cprman->onecell);
 }

And that resolves the issue and also allows loading/unloading of the
amba-pl011 module as well without any hickups.

I guess it would be better if we did make this configurable in the DT.
(See patch 1 of my RFC patchset, which could get extended to handle thi=
s
as well - at least a portion thereof).

But in more general terms: we need to come up with some agreement
on ownership of the clocks between linux and the firmware and how
to change them without impacting the other.=20

One example is the =E2=80=9Coverclocking=E2=80=9D that currently happen=
s for
downstream kernels in the firmware, which impacts some of the
plls and PLLdivs as well as the sram control registers.

The reason for this seems to be that for overclocking the SRAM
parameters also need to get changed and that can only get done
reliably when running the code from L1/L2 caches - and that
requirement of not touching SRAM while changing the SRAM parameters
is probably hard to achieve cleanly on ARM alone.

Ciao,
	Martin

P.s: unloading amba_pl011 gives the following error:
root@raspcm:~# rmmod amba_pl011
[  142.318263] Trying to free nonexistent resource <0000000020201000-00=
00000020201fff>
but that is an issue not related to clock...

