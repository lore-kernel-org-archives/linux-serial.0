Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF70C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 11 Jan 2022 20:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiAKUNJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:13:09 -0500
Received: from air.basealt.ru ([194.107.17.39]:60460 "EHLO air.basealt.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236743AbiAKUNJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Jan 2022 15:13:09 -0500
Received: by air.basealt.ru (Postfix, from userid 490)
        id DB1835895D8; Tue, 11 Jan 2022 20:13:07 +0000 (UTC)
Received: from localhost (unknown [88.147.173.226])
        by air.basealt.ru (Postfix) with ESMTPSA id D880858942B;
        Tue, 11 Jan 2022 20:13:05 +0000 (UTC)
Date:   Wed, 12 Jan 2022 00:12:58 +0400
From:   Alexey Sheplyakov <asheplyakov@basealt.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        "Vadim V . Vlasov" <vadim.vlasov@elpitech.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH] serial: 8250_dw: verify clock rate in dw8250_set_termios
Message-ID: <Yd3kyuBf680xvHMR@asheplyakov-rocket>
References: <20220111132847.218193-1-asheplyakov@basealt.ru>
 <Yd3MxFo/R4C/0uvg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yd3MxFo/R4C/0uvg@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello, Andy,

On Tue, Jan 11, 2022 at 08:30:28PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 11, 2022 at 05:28:47PM +0400, asheplyakov@basealt.ru wrote:
> > From: Alexey Sheplyakov <asheplyakov@basealt.ru>
> 
> Thanks for your patch, my comments below.

Thanks for the comments.
 
> > Refuse to change the clock rate if clk_round_rate() returns
> > a rate which is way too off (i.e. by more than 1/16 from the one
> > necessary for a given baud rate). In particular this happens if
> > the requested rate is below the minimum supported by the clock.
> > 
> > Fixes the UART console on BE-M1000 SoC. Without this patch the
> > console gets garbled immediately after loading the driver.
> > dw8250_set_termios tries to configure the baud rate (115200),
> > and calls clk_round_rate to figure out the supported rate closest
> > to 1843200 Hz (which is 115200 * 16). However the (SoC-specific)
> > clock driver returns 4705882 Hz. This frequency is way too off,
> > hence after setting it the console gets garbled.
> 
> So, the root cause is to understand _why_ the clock provider is uncapable
> to fulfil the request. Any investigation has been conducted?

Yes. On BE-M1000 SoC Linux has no direct control over (most) clocks.
The registers of CMU (clock management unit) are accessible only from
the secure world, therefore clocks are managed by the firmware (ARM-TF).
Linux' driver is a shim which calls into the firmware. And that
4705882 Hz is exactly what is returned by firmware.

> > Signed-off-by: Alexey Sheplyakov <asheplyakov@basealt.ru>
> > Signed-off-by: Vadim V. Vlasov <vadim.vlasov@elpitech.ru>
> 
> > 
> 
> Should be no blank lines in the tag block, but...
> 
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ...I recommend to use --cc parameter to git send-email instead of polluting
> commit message.

Got it.
 
> ...
> 
> > -	if (rate > 0) {
> > +	if (rate > 0 && rate >= baud * 15 && rate <= baud * 17) {
> 
> It doesn't fell like a correct fix.

What is the correct way to check if the rate returned by clk_round_rate
makes sense for the (new) baud rate? See, clk_round_rate is supposed to
give a supported rate which is closest to the requested one. Usually it
appears to be "close enough" to the requested rate (or an error), however
(as far as I understand) there is no a formal requirement (and it's up
to the driver to decide how close is "close enough").

Or should we just hope that the clock provider does the right thing?

Best regards,
   Alexey
