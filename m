Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBD7C54EEB
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C6520722
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 17:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCWRHc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:07:32 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:37190 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCWRHc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 13:07:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3FBFD803087C;
        Mon, 23 Mar 2020 17:07:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kJbE8wblbHHU; Mon, 23 Mar 2020 20:07:26 +0300 (MSK)
Date:   Mon, 23 Mar 2020 20:07:09 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Maxime Ripard <mripard@kernel.org>,
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
Message-ID: <20200323170709.izdecff3hfctzumv@ubsrv2.baikal.int>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200323024611.16039-1-Sergey.Semin@baikalelectronics.ru>
 <20200323092051.GB1922688@smile.fi.intel.com>
 <20200323111149.73wqrd7qnkkiitbe@ubsrv2.baikal.int>
 <20200323115225.GJ1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200323115225.GJ1922688@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Mar 23, 2020 at 01:52:25PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 02:11:49PM +0300, Sergey Semin wrote:
> > On Mon, Mar 23, 2020 at 11:20:51AM +0200, Andy Shevchenko wrote:
> > > On Mon, Mar 23, 2020 at 05:46:09AM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > The question to CLK framework maintainers, is it correct approach in general
> > > for this case?
> > 
> > You should have been more specific then, if you wanted to see someone
> > special.
> 
> I didn't get your comment here. Since you put the question under a pile of
> words in the commit message, and actually in the changelog, not even in the
> message, I repeated it clearly that clock maintainers can see it.
> 
> > > On Wed, Mar 18, 2020 at 05:19:53PM +0200, Andy Shevchenko wrote:
> > >> Also it would be nice to see come clock framework guys' opinions...
> > 
> > Who can give a better comments regarding the clk API if not the
> > subsystem maintainers?
> 
> You already got one from Maxime.
> 
> ...
> 
> > > > +	/*
> > > > +	 * Some platforms may provide a reference clock shared between several
> > > > +	 * devices. In this case before using the serial port first we have to
> > > > +	 * make sure nothing will change the rate behind our back and second
> > > > +	 * the tty/serial subsystem knows the actual reference clock rate of
> > > > +	 * the port.
> > > > +	 */
> > > 
> > > > +	if (clk_rate_exclusive_get(d->clk)) {
> > > > +		dev_warn(p->dev, "Couldn't lock the clock rate\n");
> > > 
> > > So, if this fails, in ->shutdown you will disbalance reference count, or did I
> > > miss something?
> > > 
> > 
> > Hm, you are right. I didn't fully thought this through. The thing is
> > that according to the clk_rate_exclusive_get() function code currently
> > it never fails. Though this isn't excuse for introducing a prone to future
> > bugs code.
> > 
> > Anyway if according to design a function may return an error we must take
> > into account in the code using it. Due to this obligation and seeing we can't
> > easily detect whether clk_rate_exclusive_get() has been failed while the
> > driver is being executed in the shutdown method, the best approach would be
> > to just return an error in startup method in case of the clock rate exclusivity
> > acquisition failure. If you are ok with this, I'll have it fixed in v3
> > patchset.
> 
> It needs to be carefully tested on other platforms than yours.
> 

Alas I don't have one. But it can be done by other kernel users at rc-s stage
of the next kernel release.

> > > > +	} else if (d->clk) {
> > > 
> > > > +		p->uartclk = clk_get_rate(d->clk);
> > > > +		if (!p->uartclk) {
> > > > +			clk_rate_exclusive_put(d->clk);
> > > > +			dev_err(p->dev, "Clock rate not defined\n");
> > > > +			return -EINVAL;
> > > > +		}
> > > 
> > > This operations I didn't get. If we have d->clk and suddenly get 0 as a rate
> > > (and note, that we still update uartclk member!), we try to put (why?) the
> > > exclusiveness of rate.
> > > 
> > 
> > Here is what I had in my mind while implementing this code. If d->clk
> > isn't NULL, then there is a "baudclk" clock handler and we can use it to
> > alter/retrieve the baud clock rate. But the same clock could be used by
> > some other driver and that driver could have changed the rate while we
> > didn't have this tty port started up (opened). In this case that driver
> > could also have the clock exclusively acquired. So instead of trying to
> > set the current p->uartclk rate to the clock, check the return value,
> > if it's an error, try to get the current clock rate, check the return
> > value, and so on, I just get the current baud clock rate and make sure
> > the value is not zero
> 
> > (clk_get_rate() returns a zero rate in case of
> > internal errors).
> 
> Have you considered !CLK case?
> 

Yes. It's a case of optional clock. Have a look at how the clock API
works. You are already using it here in this driver when calling
clk_prepare_enable()/clk_disable_unprepare().

> > At the same time dw8250_set_termios() will try to update
> > the baud clock rate anyway (also by the serial core at the point of the port
> > startup), so we don't need such complication in the DW 8250 port startup
> > code.
> > 
> > > (and note, that we still update uartclk member!),
> > 
> > Yes, if we can't determine the current baud clock rate, then the there is
> > a problem with the clock device, so we don't know at what rate it's
> > currently working. Zero is the most appropriate value to be set in this case.
> > 
> > > we try to put (why?) the > exclusiveness of rate.
> > 
> > Yes, we put the exclusivity and return an error, because this if-branch has
> > been taken only if the exclusivity has been successfully acquired.
> 
> So, this means that above code requires elaboration in the comments to explain
> how it supposed to work.
> 

That's what I did by the comment: "... second the tty/serial subsystem knows
the actual reference clock rate of the port." If you think, that checking a
return value and undoing things in case of an error need elaboration in a
comment I'll do it in v3.

-Regards,
Sergey

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
