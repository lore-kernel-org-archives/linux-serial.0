From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: serial: clk: bcm2835: Strange effects when using aux-uart in
 console
Date: Thu, 11 Feb 2016 18:55:06 +0100 (CET)
Message-ID: <1617009200.323700.219000a8-c162-4594-aacc-a7e9894518b2.open-xchange@email.1und1.de>
References: <A5F427B7-9B78-4892-9722-69418C4D0C10@martin.sperl.org>
 <56BC895E.2010108@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <56BC895E.2010108@sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Martin Sperl <martin@sperl.org>, Eric Anholt <eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

> Martin Sperl <martin@sperl.org> hat am 11. Februar 2016 um 14:15 geschrieben:
>
> The only real difference is this diff:
> @@ -41,6 +41,4 @@
> 20101000.cprman: bcm2835_clock_get_parent - pwm
> 20101000.cprman: bcm2835_clock_get_parent - hsm
> 20101000.cprman: bcm2835_pll_on - pllc
> - 20101000.cprman: bcm2835_pll_on - plld
> - 20101000.cprman: bcm2835_clock_on - uart
> 20101000.cprman: bcm2835_clock_on - emmc
>
> so plld and uart are not started for the console=ttyS0 case.
>
> After I instrumented clk-bcm2835.c to see what happens in the driver
> and running: /sbin/getty -a root -L ttyAMA0 115200 vt100
>
> I get the following:
> [ 146.342341] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
> [ 146.348426] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
> [ 146.354639] uart-pl011 20201000.uart: no DMA platform data
> [ 146.375535] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
> [ 146.381776] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - uart
> [ 146.388595] bcm2835-clk 20101000.cprman: bcm2835_pll_off - plld
> [ 146.396574] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
> [ 146.502551] bcm2835-clk 20101000.cprman: plld: couldn't lock PLL
> [ 146.508726] ------------[ cut here ]------------
> [ 146.513448] WARNING: CPU: 0 PID: 2349 at drivers/clk/clk.c:680
> clk_core_disa)
> [ 146.522673] ---[ end trace 33268753126338e9 ]---
> [ 146.527478] ------------[ cut here ]------------
> [ 146.532224] WARNING: CPU: 0 PID: 2349 at drivers/clk/clk.c:575
> clk_core_unpr)
> [ 146.541866] ---[ end trace 33268753126338ea ]---
>
> So I wonder why we would disable and reenable the plld and uart clock

I think the reason for this behavior can be found in the uart-pl011 driver which
plays with the clocks.

According to the clock tree "plld" seems to be critical and shouldn't be
disabled?

>
> Note that just adding a return in bcm2835_pll_off like this:
> @@ -900,6 +905,9 @@ static void bcm2835_pll_off(struct clk_hw *hw)
> struct bcm2835_cprman *cprman = pll->cprman;
> const struct bcm2835_pll_data *data = pll->data;
>
> + dev_err(cprman->dev, "%s - %s\n", __FUNCTION__, clk_hw_get_name(hw));
> + return;
> +
> cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
> cprman_write(cprman, data->a2w_ctrl_reg, A2W_PLL_CTRL_PWRDN);
> }
>
> avoids the crash, but the tty is non-functional.
>
> Calling sequence of the clock driver is:
> [ 145.022546] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
> [ 145.028619] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
> [ 145.034807] uart-pl011 20201000.uart: no DMA platform data
> [ 145.045089] bcm2835-clk 20101000.cprman: bcm2835_clock_off - uart
> [ 145.051418] bcm2835-clk 20101000.cprman: bcm2835_clock_wait_busy - uart
> [ 145.058215] bcm2835-clk 20101000.cprman: bcm2835_pll_off - plld
> [ 145.065779] bcm2835-clk 20101000.cprman: bcm2835_pll_on - plld
> [ 145.071761] bcm2835-clk 20101000.cprman: bcm2835_clock_on - uart
>
> debugfs shows the following after the above:
> root@raspcm:~# head /sys/kernel/debug/clk/uart*/clk_rate
> ==> /sys/kernel/debug/clk/uart0_pclk/clk_rate <==
> 3000000
>
> ==> /sys/kernel/debug/clk/uart1_pclk/clk_rate <==
> 125000000
>
> ==> /sys/kernel/debug/clk/uart/clk_rate <==
> 2997598
>
> Is this maybe related to the uart0_pclk, uart1_pclk, apb_pclk
> clocks created and registered in bcm2835_init_clocks?

Related or not i think we should get the rid off them.

>
> Any Ideas?
>
> Thanks,
> Martin
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
