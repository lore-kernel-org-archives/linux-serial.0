From: Martin Sperl <kernel@martin.sperl.org>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in console
Date: Sat, 13 Feb 2016 12:53:26 +0100
Message-ID: <EE05C090-EB8A-41E8-B9C3-8CCC79F15FE9@martin.sperl.org>
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
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2=
835.c
> index 637f8ae..03d95c1 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1638,6 +1675,9 @@ static int bcm2835_clock_set_rate(struct clk_hw=
 *hw,
> 	enum bcm2835_clock_mash_type mash =3D divmash_get_mash(dm);
> 	u32 ctl;
>=20
> +	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
> +		pr_warn("%s: clk still busy from %d\n", __func__, cprman->func_cod=
e);
> +
> 	spin_lock(&cprman->regs_lock);
>=20
> 	/* if div and mash are identical, then there is nothing to do */
> @@ -1663,6 +1703,11 @@ static int bcm2835_clock_set_rate(struct clk_h=
w *hw,
> unlock_exit:
> 	spin_unlock(&cprman->regs_lock);
>=20
> +	cprman->func_code =3D 10;
> +
> +	if (cprman_read(cprman, data->ctl_reg) & CM_BUSY)
> +		pr_warn("%s: clk now busy from %d\n", __func__, cprman->func_code)=
;
> +
> 	return 0;
> }
>=20

Seems as if you apply it on top of (parts of) my patchset - not on top =
of a=20
clean 4.5-rc3.

Anyway - after some fixing I get the following outputs -
the amba-pl011 driver is still patched with debug messages:

After boot with aux-uart as tty:
root@raspcm:~# dmesg  | grep bcm2835
[    0.018172] bcm2835: system timer (irq =3D 27)
[    0.711388] bcm2835-aux-uart 20215040.serial: could not get clk: -51=
7
[    1.649124] bcm2835-rng 20104000.rng: hwrng registered
[    2.051190] bcm2835_clock_on: clk still busy from 6
[    2.056159] bcm2835_clock_on: clk now busy from 9
[    8.062743] bcm2835-wdt 20100000.watchdog: Broadcom BCM2835 watchdog=
 timer
[   12.042105] bcm2835-i2s 20203000.i2s: can't request region for resou=
rce [mem 0x20101098-0x20101099]
[   12.191701] bcm2835-i2s: probe of 20203000.i2s failed with error -16

Loading the module:
root@raspcm:~# modprobe amba-pl011
[  106.685812] Serial: AMBA PL011 UART driver
[  106.693702] uart-pl011 20201000.uart: pl011_setup_port: f0201000 202=
01000
[  106.702109] 20201000.uart: ttyAMA0 at MMIO 0x20201000 (irq =3D 81, b=
ase_baud =3D 0) is a PL011 rev2
root@raspcm:~#

and starting getty:
root@raspcm:~# /sbin/getty -a root -L ttyAMA0 115200 vt100
[  137.851123] pl011_startup - start
[  137.854538] pl011_hwinit - prepare-enable
[  137.858772] bcm2835_clock_on: clk still busy from 6
[  137.863755] bcm2835_clock_on: clk now busy from 9
[  137.868590] pl011_hwinit - prepare-enable - ret =3D 0
[  137.875249] uart-pl011 20201000.uart: no DMA platform data
[  137.880940] pl011_startup - exit
[  137.888840] pl011_shutdown - start
[  137.892360] pl011_shutdown - disable_unprepare
[  137.896933] bcm2835_clock_off: clk still busy from 9
[  137.902112] pl011_shutdown - exit
[  137.907233] pl011_startup - start
[  137.910713] pl011_hwinit - prepare-enable
[  137.914808] bcm2835_pll_on: PLL still locked from 1
[  138.019876] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
[  138.026000] pl011_hwinit - prepare-enable - ret =3D -110
[  138.031266] pl011_startup - error =3D -110 - disable_unprepare
[  138.037048] ------------[ cut here ]------------
[  138.041777] WARNING: CPU: 0 PID: 2377 at drivers/clk/clk.c:680 clk_c=
ore_disable+0x34/0xf0()
[  138.051063] ---[ end trace dd2f225b2af4c32c ]---
[  138.055859] ------------[ cut here ]------------
[  138.060627] WARNING: CPU: 0 PID: 2377 at drivers/clk/clk.c:575 clk_c=
ore_unprepare+0x34/0x110()
[  138.070321] ---[ end trace dd2f225b2af4c32d ]---

No HDMI output - this time no =E2=80=9Cflashing=E2=80=9D - just no sign=
al.
Machine is crashed - the attached AXIS USB network card (0b95:772b)
just transmits identical packets on the network without stopping=E2=80=A6

I have also disabled the DMA-engine in the amba-pl011 driver
(in the driver itself add: #undef CONFIG_DMA_ENGINE) and then I get:
root@raspcm:/build/linux# /sbin/getty -a root -L ttyAMA0 115200 vt100
[   97.010287] pl011_startup - start
[   97.013698] pl011_hwinit - prepare-enable
[   97.017931] bcm2835_clock_on: clk still busy from 6
[   97.022905] bcm2835_clock_on: clk now busy from 9
[   97.027755] pl011_hwinit - prepare-enable - ret =3D 0
[   97.034378] pl011_startup - exit
[   97.041197] pl011_shutdown - start
[   97.044728] pl011_shutdown - disable_unprepare
[   97.049386] bcm2835_clock_off: clk still busy from 9
[   97.054458] pl011_shutdown - exit
[   97.059633] pl011_startup - start
[   97.063033] pl011_hwinit - prepare-enable
[   97.067533] bcm2835_pll_on: PLL still locked from 1
[   97.172655] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
[   97.178838] pl011_hwinit - prepare-enable - ret =3D -110
[   97.184075] pl011_startup - error =3D -110 - disable_unprepare
[   97.189905] ------------[ cut here ]------------
[   97.194640] WARNING: CPU: 0 PID: 2442 at drivers/clk/clk.c:680 clk_c=
ore_disab
le+0x34/0xf0()
[   97.203924] ---[ end trace 3e878f70606eba69 ]---
[   97.208692] ------------[ cut here ]------------
[   97.213429] WARNING: CPU: 0 PID: 2442 at drivers/clk/clk.c:575 clk_c=
ore_unpre
pare+0x34/0x110()
[   97.223096] ---[ end trace 3e878f70606eba6a ]=E2=80=94

Not sure why the pl011 driver runs the startup/shutdown/startup
loop.

Martin




