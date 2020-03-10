Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70120C18E5B
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAEA205C9
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 14:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgCJORP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:17:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:55885 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbgCJORP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 10:17:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 07:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="245714221"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 10 Mar 2020 07:17:06 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jBfgy-008TuI-13; Tue, 10 Mar 2020 16:17:08 +0200
Date:   Tue, 10 Mar 2020 16:17:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <20200310141708.GJ1922688@smile.fi.intel.com>
References: <20200306130231.05BBC8030795@mail.baikalelectronics.ru>
 <20200306134049.86F8180307C2@mail.baikalelectronics.ru>
 <20200310001444.B0F50803087C@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310001444.B0F50803087C@mail.baikalelectronics.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's pity we are discussing this off-list.
Cc linux-serial@ now and leaving original writings as is.

On Tue, Mar 10, 2020 at 03:13:53AM +0300, Sergey Semin wrote:
> On Fri, Mar 06, 2020 at 03:40:44PM +0200, Andy Shevchenko wrote:
> > On Fri, Mar 06, 2020 at 04:02:20PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > There are races possible in the dw8250_set_termios() callback method
> > > and while the device is in PM suspend state. A race condition may
> > > happen if the baudrate clocks source device is shared with some other
> > > device (in our machine it's another DW UART port). In this case if that
> > > device changes the clocks rate while serial console is using it the
> > > DW 8250 UART port might not only end up with an invalid uartclk value
> > > saved, but might also experience a distorted output data since
> > > baud-clock might have been changed. In order to fix this lets enable
> > > an exclusive clocks rate access in case if "baudclk" device is
> > > specified and is successfully enabled.
> > > 
> > > So if some other device also acquires the rate exclusivity, then
> > > DW UART 8250 driver won't be able to alter the baud-clock. It shall
> > > just use the available clocks rate. Similarly another device also
> > > won't manage to change the rate. If nothing else have the exclusive
> > > rate access acquired except DW UART 8250 driver, then the driver
> > > will be able to alter the rate as much as needs to in accordance
> > > with the currently implemented logic.
> > 
> > Thank you for the patch.
> > 
> > I honestly consider that this is kinda bad hardware design. If two devices are
> > fighting for the best rate, there is a room to make the second one always miss.
> > 
> > (Imagine 1834200 UART clock and first asked for 115200, while second
> >  desperately tries for 4M).
> > 
> > I think that the clock driver of the corresponding platform should actually
> > keep track of the users and give the best for both.
> > 
> 
> Hmm, this is discussable.
> 
> While I do agree that two serial ports using a common reference clock
> was a bad hw design (it was nothing for the hw designers to add an
> extra clock divider), and do understand the concern you mentioned in the
> example I disagree that the hw clock driver should handle the clock usage
> races. There is a possible alternative but the current solution seemed
> to me most suitable and here is why.
> 
> First of all, if I implemented something like a users tracking algo in
> the hw clock driver, It would be similar to the already developed and
> suggested to be used in this patch clock exclusivity approach anyway,
> since there would be no way to change the clock rate behind the uart drivers
> back to adjust the clock frequency so making it suitable for both users.
> In this case we would have the same race condition you described in the
> parentheses.
> 
> Secondly why would we need to have the clk_rate_exlusive_{get,put}()
> interface exported from the clk subsystem anyway if not for the cases
> like described in this commit message? These functions were designed for
> devices, which require the exclusive rate lock at some point. As for me
> I would have added the clock rate exclusive lock to all the drivers
> handling devices (not only UARTs), which depend not only on a clock being
> enabled but also on it having a particular rate value. But this is too
> much work, which alas I don't have time for at the moment.
> 
> Thirdly. Much easier solution would be to pretend, that the actual clock
> device doesn't provide the rate change capability and work with a value
> pre-initialized in the clock divider register (this is necessary because
> on most of known to me Baikal-T1-based platforms one of these UARTs is
> always used as a system/boot serial console). But in this case we would
> have to artificially bind a different driver to the clock divider interface,
> which wouldn't reflect the actual clock capability.
> 
> Finally in my opinion the suggested in this patch solution is the most
> suitable. It solves the problem on the common clock interface usage
> by two independent UART ports. It also provides a portable solution for
> platforms, which have the similar problem. And it doesn't affect the
> devices lacking the described clock rate race condition.
> 
> By the way I came up with an upgrade, which would make the solution even
> better. Instead of using the clock exclusive rate lock/unlock in the
> probe()/remove() methods, we could be calling them from the UART-port
> startup()/shutdown() functions instead. In this case the clock rate would
> be fixed only if both ports are opened at the same time. This would
> lighten the limitations on the rates change conditions. What do you think
> of this?

The use of clk_set_rate_exclusive()/clk_rate_exclusive_put() seems better.
But, while from our (Intel) perspective this looks like no-op, for others,
especially zillions of ARM boards using DesignWare UART it might be crucial.

I would suggest to Cc new version to some ARM people (homework: filter
MAINTAINERS along with `git log -- drivers/tty/serial/8250/8520_dw.c`
to see who may have relation to this driver).

> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > 
> > Why second SoB is here, it's not the same as the submitter's (usually,
> > submitter's one goes last in the chain)? Commit message or another tags,
> > like Co-developed-by, doesn't shed a light either.
> 
> Alexey as being our team-leader was in these patches delivery path, which
> according to [1] permits to add the SoB tag with his address:
> 
> "The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch’s delivery path."
> 
> So the SoB signify that all the changes provided by the patches I've sent
> and will yet send have been passed through his revision and can be
> opened at the corresponding license.
> 
> [1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Yes, and AFAIU the last person in a chain submits the work.

So, it should reflect how patch went thru people's trees. If you send from your
tree, where patches are created originally, there shouldn't be other SoBs (use
suitable Reviewed-by, etc). At least this is safest side. However, better to
ask maintainer (Greg KH in this case) and other senior developers.

-- 
With Best Regards,
Andy Shevchenko


