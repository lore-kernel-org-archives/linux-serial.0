Return-Path: <SRS0=8UUK=5M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA3C2D0E7
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B2C20714
	for <linux-serial@archiver.kernel.org>; Fri, 27 Mar 2020 09:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgC0JMm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:12:42 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:55300 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgC0JMl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 27 Mar 2020 05:12:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6552B8030886;
        Fri, 27 Mar 2020 09:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id e8trym8yYIyf; Fri, 27 Mar 2020 12:12:33 +0300 (MSK)
Date:   Fri, 27 Mar 2020 12:12:26 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
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
        Catalin Marina s <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        <linux-clk@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] serial: 8250_dw: Fix common clocks usage race
 condition
Message-ID: <20200327091226.7kgpum3td3blubsn@ubsrv2.baikal.int>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru>
 <20200323100109.k2gckdyneyzo23fb@gilmour.lan>
 <20200323135017.4vi5nwam2rlpepgn@ubsrv2.baikal.int>
 <20200324101243.GG1922688@smile.fi.intel.com>
 <20200325171109.cohnsw3s57ckaqud@ubsrv2.baikal.int>
 <158518709322.125146.10069235641747677647@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <158518709322.125146.10069235641747677647@swboyd.mtv.corp.google.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello Stephen

Thanks for reply. My comment is below.

On Wed, Mar 25, 2020 at 06:44:53PM -0700, Stephen Boyd wrote:
> Quoting Sergey Semin (2020-03-25 10:11:09)
> > On Tue, Mar 24, 2020 at 12:12:43PM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 23, 2020 at 04:50:17PM +0300, Sergey Semin wrote:
> > > > On Mon, Mar 23, 2020 at 11:01:09AM +0100, Maxime Ripard wrote:
> > > 
> > > > > clk_rate_exclusive_get is pretty intrusive, and due to the usual
> > > > > topology of clock trees, this will lock down 3-4 parent clocks to
> > > > > their current rate as well. In the Allwinner SoCs case for example,
> > > > > this will lock down the same PLL than the one used by the CPU,
> > > > > preventing cpufreq from running.
> > > > 
> > > > Speaking about weak design of a SoC' clock tree. Our problems are nothing
> > > > with respect to the Allwinner SoC, in which case of changing the
> > > > CPU-frequency may cause the UART glitches subsequently causing data
> > > > transfer artefacts.) Moreover as I can see the same issue may raise for
> > > > I2C, QSPI, PWM devices there.
> > > > 
> > > > Anyway your concern does make sense.
> > > > 
> > > > > However, the 8250 has a pretty wide range of dividers and can adapt to
> > > > > any reasonable parent clock rate, so we don't really need to lock the
> > > > > rate either, we can simply react to a parent clock rate change using
> > > > > the clock notifiers, just like the SiFive UART is doing.
> > > > > 
> > > > > I tried to do that, but given that I don't really have an extensive
> > > > > knowledge of the 8250, I couldn't find a way to stop the TX of chars
> > > > > while we change the clock rate. I'm not sure if this is a big deal or
> > > > > not, the SiFive UART doesn't seem to care.
> > > > 
> > > > Yes, your solution is also possible, but even in case of stopping Tx/Rx it
> > > > doesn't lack drawbacks. First of all AFAIK there is no easy way to just
> > > > pause the transfers. We'd have to first wait for the current transfers
> > > > to be completed, then somehow lock the port usage (both Tx and Rx
> > > > traffic), permit the reference clock rate change, accordingly adjust the
> > > > UART clock divider, and finally unlock the port. While if we don't mind
> > > > to occasionally have UART data glitches, we can just adjust the UART ref
> > > > divider synchronously with ref clock rate change as you and SiFive UART
> > > > driver suggest.
> > > > 
> > > > So we are now at a zugzwang - a fork to three not that good solutions:
> > > > 1) lock the whole clock branch and provide a glitchless interfaces. But
> > > > by doing so we may (in case of Allwinner SoCs we will) lockup some very
> > > > important functionality like CPU-frequency change while the UART port is
> > > > started up. In this case we won't have the data glitches.
> > > > 2) just adjust the UART clock divider in case of reference clock rate
> > > > change (use the SiFive UART driver approach). In this case we may have the
> > > > data corruption.
> > > > 3) somehow implement the algo: wait for the transfers to be completed,
> > > > lock UART interface (it's possible for Tx, but for Rx in case of no handshake
> > > > enabled it's simply impossible), permit the ref clock rate change,
> > > > adjust the UART divider, then unlock the UART interface. In this case the data
> > > > glitches still may happen (if no modem control is available or
> > > > handshakes are disabled).
> > > > 
> > > > As for the cases of Baikal-T1 UARTs the first solutions is the most suitable.
> > > > We don't lock anything valuable, since a base PLL output isn't directly
> > > > connected to any device and it's rate once setup isn't changed during the
> > > > system running. On the other hand I don't mind to implement the second
> > > > solution, even though it's prone to data glitches. Regarding the solution
> > > > 3) I won't even try. It's too complicated, I don't have time and
> > > > test-infrastructure for this.
> > > > 
> > > > So Andy what do you think?
> > > 
> > > From Intel HW perspective the first two are okay, but since Maxime is against
> > > first, you have the only option from your list. Perhaps somebody may give
> > > option 4) here...
> > > 
> > 
> > Ok then. I'll implement the option 2) in v3 if noone gives any alternatives
> > before that.
> > 
> 
> Sorry, I haven't really read the thread but I'll quickly reply with
> this.
> 
> Maybe option 4 is to make the uart driver a clk provider that consumes
> the single reference clk like it is already doing today? Then when the
> rate changes up above for the clk implemented here the clk set rate op
> for the newly implemented clk can go poke the uart registers to maintain
> the baud or whatever?
> 
> That is close to how the notifier design would work, but it avoids
> keeping the notifiers around given that the notifiers are not preferred.
> It is also closer to reality, the uart has a divider or mux internally
> that we don't model as a clk, but we could just as easily model as such.

AFAIU your suggestion is pretty similar to the option 2), but it concerns
the fixup implementation. So instead of subscribing to the reference clock
change event and directly adjusting the UART clock divider when the change
happens, you suggest to convert the divisor setting code into a clock
provider, which in case of the parental clocks rate change shall
automatically cause the rate adjustment of the clocks hierarchy below.

While your proposal looks neat and better suits a common approach of
the drivers design, it won't be that easy to be implemented for the serial
subsystem. As far as I can see serial and 8250 code is too coupled with
manual divisor and reference clock settings. Common 8250 port code gets
and sets the divisor and relies on the reference clock value. Similarly
the 8250-compatible vendor specific devices may also have custom divisor
settings. Moreover uartclk field, which indicates the reference clock rate
value, is used in many placed over the serial code, so if we implemented
your design we would have to update it value anyway, which means to
subscribe to the reference clock rate change event.

So in order to do what you said, the serial subsystem would have to be
seriously refactored, which taking into account the subsystem age and
number of driver, will be very painful.

-Sergey

