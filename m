Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EF3C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 13:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B962076B
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 13:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597154274;
	bh=AUalpQ/F4oVEJNL3cwT0Yq/xqScgJYySpJZPuhXviZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ag/op1drop0RcDMdQ5qKd1tSwBCgiJCJBGywy5lw4Zvfg2zy9mCkSUnAxIF/c1tre
	 ajkvoxwRlJv0UWV/OXh+Q0flhWI1h3gs588tFS0VSSSPfKBLJHZ4vNWy28MeSVzetw
	 5UcOwF4adddyTjBQ3F9pLXyUPnWj8+JbNuoRAPRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgHKN5x (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbgHKN5v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 09:57:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E83D7204FD;
        Tue, 11 Aug 2020 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597154271;
        bh=AUalpQ/F4oVEJNL3cwT0Yq/xqScgJYySpJZPuhXviZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjRy9cO/5e51Iv5u6EkzB0z5aEXggl0QXsYm602JCdsbHrWvMoezhNPKejp8T6hua
         z9gMtdDiOv1b60+J0o+xxaWQ4GI2j3wBB3wKP5g6njQr3BhCAffEweqP2jzGM9M1B7
         Lv9ZA07am5i8gsR1M9xvSTjV8uQKmk44NmK0fG+4=
Date:   Tue, 11 Aug 2020 15:58:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
Message-ID: <20200811135801.GA416071@kroah.com>
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > kernel debugger in NMI context.
> >
> > The major use-case is to add NMI debugging capabilities to the kernel
> > in order to debug scenarios such as:
> > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> >   doesn't honor serial device interrupt. So having magic sysrq triggered
> >   as an NMI is helpful for debugging.
> > - Always enabled NMI based magic sysrq irrespective of whether the serial
> >   TTY port is active or not.
> >
> > Currently there is an existing kgdb NMI serial driver which provides
> > partial implementation in upstream to have a separate ttyNMI0 port but
> > that remained in silos with the serial core/drivers which made it a bit
> > odd to enable using serial device interrupt and hence remained unused. It
> > seems to be clearly intended to avoid almost all custom NMI changes to
> > the UART driver.
> >
> > But this patch-set allows the serial core/drivers to be NMI aware which
> > in turn provides NMI debugging capabilities via magic sysrq and hence
> > there is no specific reason to keep this special driver. So remove it
> > instead.
> >
> > Approach:
> > ---------
> >
> > The overall idea is to intercept serial RX characters in NMI context, if
> > those are specific to magic sysrq then allow corresponding handler to run
> > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > work queue in order to run those in normal interrupt context.
> >
> > This approach is demonstrated using amba-pl011 driver.
> >
> > Patch-wise description:
> > -----------------------
> >
> > Patch #1 prepares magic sysrq handler to be NMI aware.
> > Patch #2 adds NMI framework to serial core.
> > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > Patch #5 removes kgdb NMI serial driver.
> >
> > Goal of this RFC:
> > -----------------
> >
> > My main reason for sharing this as an RFC is to help decide whether or
> > not to continue with this approach. The next step for me would to port
> > the work to a system with an 8250 UART.
> >
> 
> A gentle reminder to seek feedback on this series.

It's the middle of the merge window, and I can't do anything.

Also, I almost never review RFC patches as I have have way too many
patches that people think are "right" to review first...

I suggest you work to flesh this out first and submit something that you
feels works properly.

good luck!

greg k-h
