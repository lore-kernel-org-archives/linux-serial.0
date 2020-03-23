Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA920C3F2CD
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D6020753
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 13:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgCWNum (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:50:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36408 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgCWNul (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 09:50:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 849BB80307CB;
        Mon, 23 Mar 2020 13:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6-JY67QKGzOR; Mon, 23 Mar 2020 16:50:33 +0300 (MSK)
Date:   Mon, 23 Mar 2020 16:50:17 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Chen-Yu Tsai <wens@csie.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Fix common clocks usage race
 condition
Message-ID: <20200323135017.4vi5nwam2rlpepgn@ubsrv2.baikal.int>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru>
 <20200323100109.k2gckdyneyzo23fb@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200323100109.k2gckdyneyzo23fb@gilmour.lan>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Maxime

On Mon, Mar 23, 2020 at 11:01:09AM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Mar 23, 2020 at 05:46:09AM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >
> > There are races possible in the dw8250_set_termios() callback method
> > and while the device is in PM suspend state. A race condition may
> > happen if the baudrate clock source device is shared with some other
> > device (in our machine it's another DW UART port). In this case if that
> > device changes the clock rate while serial console is using it the
> > DW 8250 UART port might not only end up with an invalid uartclk value
> > saved, but may also experience a distorted output data since baud-clock
> > could have been changed. In order to fix this lets enable an exclusive
> > reference clock rate access in case if "baudclk" device is specified.
> >
> > So if some other device also acquires the rate exclusivity during the
> > time of a DW UART 8250 port being opened, then DW UART 8250 driver
> > won't be able to alter the baud-clock. It shall just use the available
> > clock rate. Similarly another device also won't manage to change the
> > rate at that time. If nothing else have the exclusive rate access
> > acquired except DW UART 8250 driver, then the driver will be able to
> > alter the rate as much as it needs to in accordance with the currently
> > implemented logic.
> >
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> > Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > CC: Ray Jui <rjui@broadcom.com>
> > Cc: Scott Branden <sbranden@broadcom.com>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: Wei Xu <xuwei5@hisilicon.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@bootlin.com>
> > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> >
> > ---
> >
> > Changelog v2:
> > - Move exclusive ref clock lock/unlock precudures to the 8250 port
> >   startup/shutdown methods.
> > - The changelog message has also been slightly modified due to the
> >   alteration.
> > - Remove Alexey' SoB tag.
> > - Cc someone from ARM who might be concerned regarding this change.
> > - Cc someone from Clocks Framework to get their comments on this patch.
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 36 +++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> > index aab3cccc6789..08f3f745ed54 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -319,6 +319,40 @@ static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
> >  	serial8250_do_set_ldisc(p, termios);
> >  }
> >
> > +static int dw8250_startup(struct uart_port *p)
> > +{
> > +	struct dw8250_data *d = to_dw8250_data(p->private_data);
> > +
> > +	/*
> > +	 * Some platforms may provide a reference clock shared between several
> > +	 * devices. In this case before using the serial port first we have to
> > +	 * make sure nothing will change the rate behind our back and second
> > +	 * the tty/serial subsystem knows the actual reference clock rate of
> > +	 * the port.
> > +	 */
> > +	if (clk_rate_exclusive_get(d->clk)) {
> > +		dev_warn(p->dev, "Couldn't lock the clock rate\n");
> > +	} else if (d->clk) {
> > +		p->uartclk = clk_get_rate(d->clk);
> > +		if (!p->uartclk) {
> > +			clk_rate_exclusive_put(d->clk);
> > +			dev_err(p->dev, "Clock rate not defined\n");
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return serial8250_do_startup(p);
> > +}
> 
> I've been facing that issue, so it would be great to get it fixed, but
> I'm not sure this is the right solution.
> 
> clk_rate_exclusive_get is pretty intrusive, and due to the usual
> topology of clock trees, this will lock down 3-4 parent clocks to
> their current rate as well. In the Allwinner SoCs case for example,
> this will lock down the same PLL than the one used by the CPU,
> preventing cpufreq from running.
> 

Speaking about weak design of a SoC' clock tree. Our problems are nothing
with respect to the Allwinner SoC, in which case of changing the
CPU-frequency may cause the UART glitches subsequently causing data
transfer artefacts.) Moreover as I can see the same issue may raise for
I2C, QSPI, PWM devices there.

Anyway your concern does make sense.

> However, the 8250 has a pretty wide range of dividers and can adapt to
> any reasonable parent clock rate, so we don't really need to lock the
> rate either, we can simply react to a parent clock rate change using
> the clock notifiers, just like the SiFive UART is doing.
> 
> I tried to do that, but given that I don't really have an extensive
> knowledge of the 8250, I couldn't find a way to stop the TX of chars
> while we change the clock rate. I'm not sure if this is a big deal or
> not, the SiFive UART doesn't seem to care.
> 
> Maxime

Yes, your solution is also possible, but even in case of stopping Tx/Rx it
doesn't lack drawbacks. First of all AFAIK there is no easy way to just
pause the transfers. We'd have to first wait for the current transfers
to be completed, then somehow lock the port usage (both Tx and Rx
traffic), permit the reference clock rate change, accordingly adjust the
UART clock divider, and finally unlock the port. While if we don't mind
to occasionally have UART data glitches, we can just adjust the UART ref
divider synchronously with ref clock rate change as you and SiFive UART
driver suggest.

So we are now at a zugzwang - a fork to three not that good solutions:
1) lock the whole clock branch and provide a glitchless interfaces. But
by doing so we may (in case of Allwinner SoCs we will) lockup some very
important functionality like CPU-frequency change while the UART port is
started up. In this case we won't have the data glitches.
2) just adjust the UART clock divider in case of reference clock rate
change (use the SiFive UART driver approach). In this case we may have the
data corruption.
3) somehow implement the algo: wait for the transfers to be completed,
lock UART interface (it's possible for Tx, but for Rx in case of no handshake
enabled it's simply impossible), permit the ref clock rate change,
adjust the UART divider, then unlock the UART interface. In this case the data
glitches still may happen (if no modem control is available or
handshakes are disabled).

As for the cases of Baikal-T1 UARTs the first solutions is the most suitable.
We don't lock anything valuable, since a base PLL output isn't directly
connected to any device and it's rate once setup isn't changed during the
system running. On the other hand I don't mind to implement the second
solution, even though it's prone to data glitches. Regarding the solution
3) I won't even try. It's too complicated, I don't have time and
test-infrastructure for this.

So Andy what do you think?

Regards,
-Sergey
