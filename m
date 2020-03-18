Return-Path: <SRS0=ll96=5D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185A9C10DCE
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0C520757
	for <linux-serial@archiver.kernel.org>; Wed, 18 Mar 2020 15:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgCRPTy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:19:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:57375 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRPTy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Mar 2020 11:19:54 -0400
IronPort-SDR: YWz3gEMFqEa0nBGi4nTX6awGYuH3towsi8iAL9ZbrrMK30pc/Sz3fY7OsJBKcQ/KWluZ2o3B4h
 ZZBxPnysPddQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 08:19:53 -0700
IronPort-SDR: v5XPXOcbe+Us1sMjH0K6Kx08j1G+jZiB4xwrAD3aqDsyV9Lllqq2ZxBtPtNsndDfrRx+TqWSlL
 v9dkAXrgeJdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="291344180"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Mar 2020 08:19:50 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEaU5-00AnRR-2D; Wed, 18 Mar 2020 17:19:53 +0200
Date:   Wed, 18 Mar 2020 17:19:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     linux-serial@vger.kernel.org,
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
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] serial: 8250_dw: Fix common clocks usage race condition
Message-ID: <20200318151953.GQ1922688@smile.fi.intel.com>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200306134049.86F8180307C2@mail.baikalelectronics.ru>
 <20200310001444.B0F50803087C@mail.baikalelectronics.ru>
 <20200310141715.7063280307CA@mail.baikalelectronics.ru>
 <20200312184450.co5o6zm6qniptfuv@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312184450.co5o6zm6qniptfuv@ubsrv2.baikal.int>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 12, 2020 at 09:47:02PM +0300, Sergey Semin wrote:
> On Tue, Mar 10, 2020 at 04:17:08PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 10, 2020 at 03:13:53AM +0300, Sergey Semin wrote:
> > > On Fri, Mar 06, 2020 at 03:40:44PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Mar 06, 2020 at 04:02:20PM +0300, Sergey.Semin@baikalelectronics.ru wrote:

...

> > > > > There are races possible in the dw8250_set_termios() callback method
> > > > > and while the device is in PM suspend state. A race condition may
> > > > > happen if the baudrate clocks source device is shared with some other
> > > > > device (in our machine it's another DW UART port). In this case if that
> > > > > device changes the clocks rate while serial console is using it the
> > > > > DW 8250 UART port might not only end up with an invalid uartclk value
> > > > > saved, but might also experience a distorted output data since
> > > > > baud-clock might have been changed. In order to fix this lets enable
> > > > > an exclusive clocks rate access in case if "baudclk" device is
> > > > > specified and is successfully enabled.
> > > > > 
> > > > > So if some other device also acquires the rate exclusivity, then
> > > > > DW UART 8250 driver won't be able to alter the baud-clock. It shall
> > > > > just use the available clocks rate. Similarly another device also
> > > > > won't manage to change the rate. If nothing else have the exclusive
> > > > > rate access acquired except DW UART 8250 driver, then the driver
> > > > > will be able to alter the rate as much as needs to in accordance
> > > > > with the currently implemented logic.
> > > > 
> > > > Thank you for the patch.
> > > > 
> > > > I honestly consider that this is kinda bad hardware design. If two devices are
> > > > fighting for the best rate, there is a room to make the second one always miss.
> > > > 
> > > > (Imagine 1834200 UART clock and first asked for 115200, while second
> > > >  desperately tries for 4M).
> > > > 
> > > > I think that the clock driver of the corresponding platform should actually
> > > > keep track of the users and give the best for both.
> > > > 
> > > 
> > > Hmm, this is discussable.
> > > 
> > > While I do agree that two serial ports using a common reference clock
> > > was a bad hw design (it was nothing for the hw designers to add an
> > > extra clock divider), and do understand the concern you mentioned in the
> > > example I disagree that the hw clock driver should handle the clock usage
> > > races. There is a possible alternative but the current solution seemed
> > > to me most suitable and here is why.
> > > 
> > > First of all, if I implemented something like a users tracking algo in
> > > the hw clock driver, It would be similar to the already developed and
> > > suggested to be used in this patch clock exclusivity approach anyway,
> > > since there would be no way to change the clock rate behind the uart drivers
> > > back to adjust the clock frequency so making it suitable for both users.
> > > In this case we would have the same race condition you described in the
> > > parentheses.
> > > 
> > > Secondly why would we need to have the clk_rate_exlusive_{get,put}()
> > > interface exported from the clk subsystem anyway if not for the cases
> > > like described in this commit message? These functions were designed for
> > > devices, which require the exclusive rate lock at some point. As for me
> > > I would have added the clock rate exclusive lock to all the drivers
> > > handling devices (not only UARTs), which depend not only on a clock being
> > > enabled but also on it having a particular rate value. But this is too
> > > much work, which alas I don't have time for at the moment.
> > > 
> > > Thirdly. Much easier solution would be to pretend, that the actual clock
> > > device doesn't provide the rate change capability and work with a value
> > > pre-initialized in the clock divider register (this is necessary because
> > > on most of known to me Baikal-T1-based platforms one of these UARTs is
> > > always used as a system/boot serial console). But in this case we would
> > > have to artificially bind a different driver to the clock divider interface,
> > > which wouldn't reflect the actual clock capability.
> > > 
> > > Finally in my opinion the suggested in this patch solution is the most
> > > suitable. It solves the problem on the common clock interface usage
> > > by two independent UART ports. It also provides a portable solution for
> > > platforms, which have the similar problem. And it doesn't affect the
> > > devices lacking the described clock rate race condition.
> > > 
> > > By the way I came up with an upgrade, which would make the solution even
> > > better. Instead of using the clock exclusive rate lock/unlock in the
> > > probe()/remove() methods, we could be calling them from the UART-port
> > > startup()/shutdown() functions instead. In this case the clock rate would
> > > be fixed only if both ports are opened at the same time. This would
> > > lighten the limitations on the rates change conditions. What do you think
> > > of this?
> > 
> > The use of clk_set_rate_exclusive()/clk_rate_exclusive_put() seems better.
> > But, while from our (Intel) perspective this looks like no-op, for others,
> > especially zillions of ARM boards using DesignWare UART it might be crucial.
> > 
> 
> Using clk_set_rate_exclusive() isn't that appropriate at the port->startup()
> callback. Firstly because it may fail due to not being able to update the rate,
> then I would have to try to perform just clk_rate_exclusive_get(),
> retrieve currently set clock rate and update the port uartclk field. Secondly
> an attempt to update the rate will be performed in set_termios() anyway,
> so the calling of clk_set_rate() in the port->startup() is redundant. Thirdly
> I also can't use  clk_set_rate_exclusive() in set_termios(), because it doesn't
> have some antagonist like unset_termios() to perform the same number of
> clk_rate_exclusive_put() to appropriately free the exclusive lock of the clock.
> And I don't want to manually calculate the numbers of exclusive locking.
> 
> So the easiest way would be to just lock the reference clock in the
> port->startup() method and update the port->uartclk field with current
> reference clock rate. Clock unlocking will be performed in the port-shutdown()
> callback. I'll send v2 patch with this solution. You'll see what it
> looks like.
> 
> > I would suggest to Cc new version to some ARM people (homework: filter
> > MAINTAINERS along with `git log -- drivers/tty/serial/8250/8520_dw.c`
> > to see who may have relation to this driver).
> > 
> 
> Nice homework. Although I'd prefer to utilize the get_maintainers.pl script
> for the same purpose. It has the --git argument for it, which also tunable
> for parameters like deepness of the git-history, number of signatures, number
> of maintainers, etc.

You may send a new version with a bit more elaboration in the commit message
followed by Cc'ing few people from ARM side. I'm okay with it from Intel
hardware perspective, but I can't tell about the rest of the world.

Also it would be nice to see come clock framework guys' opinions...

-- 
With Best Regards,
Andy Shevchenko


