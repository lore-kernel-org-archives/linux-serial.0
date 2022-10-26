Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F3EC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 07:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiJZH6S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJZH6R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 03:58:17 -0400
Received: from smtp-out-03.comm2000.it (smtp-out-03.comm2000.it [212.97.32.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2966DA52ED
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 00:58:16 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-03.comm2000.it (Postfix) with ESMTPSA id B48F1B41A6B;
        Wed, 26 Oct 2022 09:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1666771094;
        bh=ZOgJMxBDQOBCg/HQxuJvXyZEj+Qgl2m1AROZR1RKP4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=yUZhnyCYeTvknqsJb7lH41+PKI9UR9eQyBKIqWRegkIQUMoUWKKHOQfX+UJw94Jhx
         dG/Hjx9yHv1ej0g/fxpuvezRd0TyZcSP/Ycm1mtYy/rz1ILGfZckiljzBYY/ERI/kf
         m8jN6+Wi5lIyYqaV6ayHBm+ZINuQb/M71psXh8SobNGifGbJyGbAFpOhAj8LIKJNUK
         q8w9CsK7oWfw8QXEy7N0FL6273m1SZ0/gZMMAo8FnIelLX200q9SO3XolJJ8u1pTKt
         8/RIUlbdNZEIadcZ+hKeDJrGTQKRgYyTRGh5OsYUJAMOtxr0XLCSDNaHtydi37Wa/p
         WNi97OSKosP2A==
Date:   Wed, 26 Oct 2022 09:58:11 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-serial@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Johan Hovold <johan@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: imx serial chars lost issue
Message-ID: <Y1jok9FxV4K9q6nb@francesco-nb.int.toradex.com>
References: <20221003110850.GA28338@francesco-nb.int.toradex.com>
 <20221026065604.xp4lzysm2ag7bfmk@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221026065604.xp4lzysm2ag7bfmk@pengutronix.de>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 26, 2022 at 08:56:04AM +0200, Uwe Kleine-König wrote:
> On Mon, Oct 03, 2022 at 01:08:50PM +0200, Francesco Dolcini wrote:
> > recently I have been experiencing an issue with the imx uart on i.MX6ULL
> > SoC, on the tty console (no flow control, 1152008n1), chars after the 32nd
> > are lost when typing "fast" (copy/paste or writing to the uart using
> > automated tools).
> > 
> > This was tested on Linux 6.0, however it does not look like a brand new
> > regression, kernel 5.4 was somehow subject to the same issue, although
> > it was way more difficult to trigger it.
> > 
> > While I do understand that without flow control this is something that
> > cannot be prevented, it is pretty fishy that is always the chars after
> > the 32nd.
> > 
> > I guess that might be happening is that the FIFO is emptied only by a
> > timer or when it is full, instead of emptying it when half-full, and the
> > CPU might not be fast enough leading to an overflow and the chars lost.
> > 
> > Any idea?
> 
> It's not unheared that there are bugs in the imx serial driver, but I'm
> at least half confident that it's not a driver issue.
> 
> I guess commit 7a637784d517 ("serial: imx: reduce RX interrupt
> frequency") is relevant, this was added in v5.18-rc1.
> 
> If this is really the commit that made the issue easier to reproduce,
> then this is a hint that there is no functional problem and we're "just"
> talking about irq latency issues. If enabling flow control solves the
> issue, this is another hint in the same direction.

I can confirm that reverting 7a637784d517 makes the issue more difficult to
reproduce, and even when it is reproduced the amount of chars lost is
decreased. Enabling HW flow control is not trivial to test.

> The other side starts sending chars at a high frequency. Once the RX
> FIFO fill level reaches 8 an irq is triggered. Now if there are 25 more
> characters received before the irq is serviced you get an overflow and
> loose chars. Without 7a637784d517 there is a bit more time (i.e. 7
> character times).
> 
> So either you use a very high baud rate that is hard to handle (compared
> to the cpu frequency), or this is a side effect of increased irq
> latency (which is likely a problem somewhere else).

The uart is configured as 115200 8n1, 86usec per char, given the 25
chars FIFO is 2.150msec to service the irq and get the data out of the
fifo.

Just thinking at the MHz the CPU is 792MHz, however it can (and will)
scale down to 198MHz.

I would say that something like that should be reasonable to handle, but
it's just my gut feeling ...

Francesco

