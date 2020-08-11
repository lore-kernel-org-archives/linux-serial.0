Return-Path: <SRS0=7S4r=BV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CFFC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184A9206DC
	for <linux-serial@archiver.kernel.org>; Tue, 11 Aug 2020 17:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="klLz6wKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgHKRQE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgHKRQD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 11 Aug 2020 13:16:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C65C06174A
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 10:16:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g11so3724879ual.2
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 10:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcOJfgPH+kookjeNTFA/a55bCUyOIBtLpH9z1xzQ2Dk=;
        b=klLz6wKUUtyx3zTEv9yLDqYfCzgIBog5o60iZxU1w4FeSRHRE0b71zp3P+GhyIdo5T
         rChF30fNgQprCmJxLbQr1YPJFiBv6guVBUBCqfTSS5M8aXfntO6UJTZ/p6Op2XHdn7TR
         o2TnLXcqhz88ByC7UnvSIlo/qFjwfFZF2Gawg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcOJfgPH+kookjeNTFA/a55bCUyOIBtLpH9z1xzQ2Dk=;
        b=Z7XDhTm2rWtidHtFKq4OW8DOtp7kkA/F0A6Aj09zj18+auEKLi0hVsC405ViZ/h9dG
         qfZiGcOhindobN1gRApA1mKBKafiBmvU6GyIYdzGGJ3QDGdTsHU4jDsnKnnyD2oup5Nz
         vPVJ9bpe6i4bb3vhvbiV7AwVSQiC0GnQRoeoefQWI0ljw+C9bvHMijTv6vCKCRExNNY9
         EhuSAwgTgm32ZT8qLx07BLNYXYz3R61tGHSfV95A56CoSMR1UMEPMeBfqVieLA7imlrV
         o0d4sL08ORW/OB6ZRblzGdXI3MchSH/Islf8qZP83IPswKodWfRbbOJYXjx+rj6tKc7r
         N+cg==
X-Gm-Message-State: AOAM533K2Gw/uD+kFQ4wyORscWlfnK2WCr2/s1DvZFB+2NRmb6BjfkAC
        zW/L4dEheKnzT8gYM5zWbnAWIJnicXg=
X-Google-Smtp-Source: ABdhPJzlhyAvVjPkOMVeTcSlBmdCauWlxH+bFO2F3BBFZUBdSuMALXHUvgMXaKzZzZBC0KgDXig+9w==
X-Received: by 2002:ab0:c3:: with SMTP id 61mr4027266uaj.106.1597166160656;
        Tue, 11 Aug 2020 10:16:00 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id x25sm3963629ual.2.2020.08.11.10.15.59
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 10:15:59 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id g20so2786050uap.8
        for <linux-serial@vger.kernel.org>; Tue, 11 Aug 2020 10:15:59 -0700 (PDT)
X-Received: by 2002:ab0:37d3:: with SMTP id e19mr24271569uav.64.1597166159205;
 Tue, 11 Aug 2020 10:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com>
In-Reply-To: <20200811145816.GA424033@kroah.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 11 Aug 2020 10:15:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
Message-ID: <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Aug 11, 2020 at 7:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 11, 2020 at 07:59:24PM +0530, Sumit Garg wrote:
> > Hi Greg,
> >
> > Thanks for your comments.
> >
> > On Tue, 11 Aug 2020 at 19:27, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> > > > On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > > > > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > > > > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > > > > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > > > > kernel debugger in NMI context.
> > > > >
> > > > > The major use-case is to add NMI debugging capabilities to the kernel
> > > > > in order to debug scenarios such as:
> > > > > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> > > > >   doesn't honor serial device interrupt. So having magic sysrq triggered
> > > > >   as an NMI is helpful for debugging.
> > > > > - Always enabled NMI based magic sysrq irrespective of whether the serial
> > > > >   TTY port is active or not.
> > > > >
> > > > > Currently there is an existing kgdb NMI serial driver which provides
> > > > > partial implementation in upstream to have a separate ttyNMI0 port but
> > > > > that remained in silos with the serial core/drivers which made it a bit
> > > > > odd to enable using serial device interrupt and hence remained unused. It
> > > > > seems to be clearly intended to avoid almost all custom NMI changes to
> > > > > the UART driver.
> > > > >
> > > > > But this patch-set allows the serial core/drivers to be NMI aware which
> > > > > in turn provides NMI debugging capabilities via magic sysrq and hence
> > > > > there is no specific reason to keep this special driver. So remove it
> > > > > instead.
> > > > >
> > > > > Approach:
> > > > > ---------
> > > > >
> > > > > The overall idea is to intercept serial RX characters in NMI context, if
> > > > > those are specific to magic sysrq then allow corresponding handler to run
> > > > > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > > > > work queue in order to run those in normal interrupt context.
> > > > >
> > > > > This approach is demonstrated using amba-pl011 driver.
> > > > >
> > > > > Patch-wise description:
> > > > > -----------------------
> > > > >
> > > > > Patch #1 prepares magic sysrq handler to be NMI aware.
> > > > > Patch #2 adds NMI framework to serial core.
> > > > > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > > > > Patch #5 removes kgdb NMI serial driver.
> > > > >
> > > > > Goal of this RFC:
> > > > > -----------------
> > > > >
> > > > > My main reason for sharing this as an RFC is to help decide whether or
> > > > > not to continue with this approach. The next step for me would to port
> > > > > the work to a system with an 8250 UART.
> > > > >
> > > >
> > > > A gentle reminder to seek feedback on this series.

It's been on my list for a while.  I started it Friday but ran out of
time.  This week hasn't been going as smoothly as I hoped but I'll
prioritize this since it's been too long.


> > > It's the middle of the merge window, and I can't do anything.
> > >
> > > Also, I almost never review RFC patches as I have have way too many
> > > patches that people think are "right" to review first...
> > >
> >
> > Okay, I understand and I can definitely wait for your feedback.
>
> My feedback here is this:
>
> > > I suggest you work to flesh this out first and submit something that you
> > > feels works properly.
>
> :)
>
> > IIUC, in order to make this approach substantial I need to make it
> > work with 8250 UART (major serial driver), correct? As currently it
> > works properly for amba-pl011 driver.
>
> Yes, try to do that, or better yet, make it work with all serial drivers
> automatically.

A bit of early feedback...

Although I'm not sure we can do Greg's "make it work everywhere
automatically", it's possible you could get half of your patch done
automatically.  Specifically, your patch really does two things:

a) It leaves the serial port "active" all the time to look for sysrq.
In other words even if there is no serial client it's always reading
the port looking for characters.  IMO this concept should be separated
out from the NMI concept and _could_ automatically work for all serial
drivers.  You'd just need something in the serial core that acted like
a default client if nobody else opened the serial port.  The nice
thing here is that we go through all the normal code paths and don't
need special cases in the driver.

b) It enables NMI for your particular serial driver.  This seems like
it'd be hard to do automatically because you can't do the same things
at NMI that you could do in a normal interrupt handler.

NOTE: to me, a) is more important than b) (though it'd be nice to have
both).  This would be especially true the earlier you could make a)
work since the main time when an "agetty" isn't running on my serial
port to read characters is during bootup.

Why is b) less important to me? Sure, it would let you drop into the
debugger in the case where the CPU handling serial port interrupts is
hung with IRQs disabled, but it _woudln't_ let you drop into the
debugger in the case where a different CPU is hung with IRQs disabled.
To get that we need NMI roundup (which, I know, you are also working
on for arm64).  ...and, if we've got NMI roundup, presumably we can
find our way into the debugger by either moving the serial interrupt
to a different CPU ahead of time or using some type of lockup detector
(which I know you are also working on for arm64).


One last bit of feedback is that I noticed that you didn't try to
implement the old "knock" functionality of the old NMI driver that's
being deleted.  That is: your new patches don't provide an alternate
way to drop into the debugger for systems where BREAK isn't hooked up.
That's not a hard requirement, but I was kinda hoping for it since I
have some systems that haven't routed BREAK properly.  ;-)


I'll try to get some more detailed feedback in the next few days.

-Doug
