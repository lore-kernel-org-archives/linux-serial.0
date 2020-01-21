Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6575C2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F214217F4
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 09:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgAUJAD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:00:03 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:33871 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUJAD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 04:00:03 -0500
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 04:00:01 EST
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9A15028005389;
        Tue, 21 Jan 2020 09:49:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 6406035EEC; Tue, 21 Jan 2020 09:49:48 +0100 (CET)
Date:   Tue, 21 Jan 2020 09:49:48 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Ivan
         =?iso-8859-15?B?pmmodO1rIC0gM0sgU29sdXRpb25zLCBzLiByLiBvLg==?= 
        <sistik@3ksolutions.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] tty: serial: amba-pl011: added RS485 support
Message-ID: <20200121084948.7d6om2fgaa7ikmof@wunner.de>
References: <20200106235203.27256-1-sistik@3ksolutions.sk>
 <20200116132954.5tcxmezs5qhseiem@wunner.de>
 <4e082c29-9a47-accc-425b-8d1854fb6ac6@3ksolutions.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e082c29-9a47-accc-425b-8d1854fb6ac6@3ksolutions.sk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 17, 2020 at 01:58:57AM +0100, Ivan ¦i¨tík - 3K Solutions, s. r. o. wrote:
> On 16. 1. 2020 at 14:29 Lukas Wunner wrote:
> > So I've implemented rs485 support for amba-pl011.c two years ago
> > but the patches need a little more polishing before they can be
> > upstreamed and I haven't gotten around to that yet.  I apologize
> > that it meant you had to reinvent the wheel.
> > You can find my implementation on this branch:
> > https://github.com/RevolutionPi/linux/commits/revpi-4.19
> > 
> > Specifically this commit:
> > https://github.com/RevolutionPi/linux/commit/0099313962a5
> 
> The wheel with octagonal shape is still not perfect. I made it more
> smoother. Your implementation in recommended commit use an active
> waiting (pl011_rs485_tx_start, pl011_rs485_tx_stop) and that could
> cause lots of problems in upper layers of tty driver or application.
> I think you forgot to implement possibility to start TX during
> "delay after send", too.

Are these delays ever set to a value > 0 in practice?  struct serial_rs485
supports millisecond delays, but all RS485 transceivers I know of only
require delays in the microsecond or nanosecond range.  It was likely
a mistake that the delays were originally declared as millisecond values.
However we can't easily change that now because it's ABI and thus set in
stone.

E.g. the MAXM22510 has a "Driver Enable to Output" delay of 2.540 usec.
In practice no delay is necessary at all because the MMIO operations
performed by the driver take longer:

https://datasheets.maximintegrated.com/en/ds/MAXM22510-MAXM22511.pdf


> > I took a completely different approach:  I converted amba-pl011.c
> > to threaded interrupt handling using two kthreads, one for sending,
> > one for receiving.  This allows simultaneous writing to and reading
> > from the FIFO.  The driver keeps track of the FIFO fill level,
> > which allows writing to the FIFO blindly.  The hardirq handler
> > updates the fill level counter and wakes either of the IRQ threads.
> 
> I do not see any used thread in link:
> https://github.com/RevolutionPi/linux/commit/0099313962a5
> I am not kernel thread expert but I think that thread is not as
> lightweight as hrtimer. According to my knowledge the hrtimer use some
> kind of interrupt. Compare to this the kthread is created as thread
> with all its scheduling structures. Did you implemented proper thread
> shutdown? Has the thread right priority? There are many questions
> like this...

You're not seeing the conversion to threaded IRQ handling because it's
in separate commits on the above-linked branch, e.g.

serial: pl011: Use threaded interrupt for RX
https://github.com/RevolutionPi/linux/commit/4f3a6e9ea335

serial: pl011: Use threaded interrupt for TX
https://github.com/RevolutionPi/linux/commit/fae65b5a2c5b

I implemented threaded IRQ handling to maximize TX throughput
and minimize RX FIFO overruns at high baudrates.  Additionally,
threaded IRQ handling integrates more nicely with the realtime
patch set.  So the ability to simply use msleep() for rs485 delays
is merely a by-product.

The IRQ threads run at RT priority -50 with SCHED_FIFO policy just
as any other IRQ thread and user space may adjust that with chrt(1)
if desired.

Thanks,

Lukas
