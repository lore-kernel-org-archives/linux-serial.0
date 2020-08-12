Return-Path: <SRS0=P72y=BW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90392C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 14:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6045C2076C
	for <linux-serial@archiver.kernel.org>; Wed, 12 Aug 2020 14:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWIcmh+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHLOw6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgHLOw5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Aug 2020 10:52:57 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AACC061383
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 07:52:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d2so1320512lfj.1
        for <linux-serial@vger.kernel.org>; Wed, 12 Aug 2020 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X0h4prE1/dfEQyJnaFNa6jomqbA4bO8a3Wzee/NAw3o=;
        b=oWIcmh+JROkwUVsZgF/Sf2LlA9vlbm92Q9bjnITSSsniz3pZAeEhWOPOUOaOi2gERj
         A8+Y8xPgMCj2ldO1CCD/jQJPKUC4drpl2473TRdXRs0iMiu4r5Sb//miP5vDJakH5/sS
         qbsl3pgvPNq7BeZXOfdBgDu/DHLrevAha2IsLRdsj8L8b2/I+dNwjt97YfjuR+Tww3uw
         PlnnbrNCq062e9sx53T0atE9Q9sgxPUDg8QjIescOAyqwGGJxEWnNG2tNEh0RsuLUMLb
         4Rv5dqrT4YeGPx0pi76aT8GLxzAeorslmjoAldtCGhl/f4Tmo9nNVMSFDTQ9dfo4D+Fe
         pU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X0h4prE1/dfEQyJnaFNa6jomqbA4bO8a3Wzee/NAw3o=;
        b=i/PJZka1AeIVXy4/VlsbJIrH7qsKmHCSk5tUYSXYYkw/SMw/ynC2tt+gxAOwyG5Iyr
         r3CbNDMz51Iy97HsLOJTgYJTujpqTLJV7adfPOdz63SYGWPjzjGafgUqH7Pv1Q20WosV
         BcntwW++GPtJt/dqvDEqVbYaY5+Byrfm525xSC6OsgJztErCrCafqpkPiheQDM0dFYSn
         YzfNCvtslDFFvTtfAnlBzbAUa1BIxiq9r71gpf4/LP5i1QfoGoKgdYHGULYwiZ4BIk/v
         e/52OrZmt9csOl8WzXyGqRHy0Iw5Ov4sF3WLU/rvk86hrDAjt8gVyg57YI/HdiWXTsAy
         Aalw==
X-Gm-Message-State: AOAM530D06JHRa+Fw9rus5qO4g0ZtxtT+yKng0AForc3Tn71wWY+g2zx
        nCW9ZkJFODiKVukJqs+aiPmR1q2LyVd834zjukYQ6B1oznY=
X-Google-Smtp-Source: ABdhPJxQ0ICsn187Frur7vnkvV+tpxPzwHk5zySW8LwRKRELMDl+2K1/RYHzai3dt9sc5rlAu57i6WN7RCDsEZ0Cz6U=
X-Received: by 2002:a19:86c3:: with SMTP id i186mr6008228lfd.59.1597243974916;
 Wed, 12 Aug 2020 07:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
In-Reply-To: <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 12 Aug 2020 20:22:42 +0530
Message-ID: <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

Hi Doug,

On Tue, 11 Aug 2020 at 22:46, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Aug 11, 2020 at 7:58 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 11, 2020 at 07:59:24PM +0530, Sumit Garg wrote:
> > > Hi Greg,
> > >
> > > Thanks for your comments.
> > >
> > > On Tue, 11 Aug 2020 at 19:27, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> > > > > On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > >
> > > > > > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > > > > > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > > > > > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > > > > > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > > > > > kernel debugger in NMI context.
> > > > > >
> > > > > > The major use-case is to add NMI debugging capabilities to the kernel
> > > > > > in order to debug scenarios such as:
> > > > > > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> > > > > >   doesn't honor serial device interrupt. So having magic sysrq triggered
> > > > > >   as an NMI is helpful for debugging.
> > > > > > - Always enabled NMI based magic sysrq irrespective of whether the serial
> > > > > >   TTY port is active or not.
> > > > > >
> > > > > > Currently there is an existing kgdb NMI serial driver which provides
> > > > > > partial implementation in upstream to have a separate ttyNMI0 port but
> > > > > > that remained in silos with the serial core/drivers which made it a bit
> > > > > > odd to enable using serial device interrupt and hence remained unused. It
> > > > > > seems to be clearly intended to avoid almost all custom NMI changes to
> > > > > > the UART driver.
> > > > > >
> > > > > > But this patch-set allows the serial core/drivers to be NMI aware which
> > > > > > in turn provides NMI debugging capabilities via magic sysrq and hence
> > > > > > there is no specific reason to keep this special driver. So remove it
> > > > > > instead.
> > > > > >
> > > > > > Approach:
> > > > > > ---------
> > > > > >
> > > > > > The overall idea is to intercept serial RX characters in NMI context, if
> > > > > > those are specific to magic sysrq then allow corresponding handler to run
> > > > > > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > > > > > work queue in order to run those in normal interrupt context.
> > > > > >
> > > > > > This approach is demonstrated using amba-pl011 driver.
> > > > > >
> > > > > > Patch-wise description:
> > > > > > -----------------------
> > > > > >
> > > > > > Patch #1 prepares magic sysrq handler to be NMI aware.
> > > > > > Patch #2 adds NMI framework to serial core.
> > > > > > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > > > > > Patch #5 removes kgdb NMI serial driver.
> > > > > >
> > > > > > Goal of this RFC:
> > > > > > -----------------
> > > > > >
> > > > > > My main reason for sharing this as an RFC is to help decide whether or
> > > > > > not to continue with this approach. The next step for me would to port
> > > > > > the work to a system with an 8250 UART.
> > > > > >
> > > > >
> > > > > A gentle reminder to seek feedback on this series.
>
> It's been on my list for a while.  I started it Friday but ran out of
> time.  This week hasn't been going as smoothly as I hoped but I'll
> prioritize this since it's been too long.
>

No worries and thanks for your feedback.

>
> > > > It's the middle of the merge window, and I can't do anything.
> > > >
> > > > Also, I almost never review RFC patches as I have have way too many
> > > > patches that people think are "right" to review first...
> > > >
> > >
> > > Okay, I understand and I can definitely wait for your feedback.
> >
> > My feedback here is this:
> >
> > > > I suggest you work to flesh this out first and submit something that you
> > > > feels works properly.
> >
> > :)
> >
> > > IIUC, in order to make this approach substantial I need to make it
> > > work with 8250 UART (major serial driver), correct? As currently it
> > > works properly for amba-pl011 driver.
> >
> > Yes, try to do that, or better yet, make it work with all serial drivers
> > automatically.
>
> A bit of early feedback...
>
> Although I'm not sure we can do Greg's "make it work everywhere
> automatically", it's possible you could get half of your patch done
> automatically.  Specifically, your patch really does two things:
>
> a) It leaves the serial port "active" all the time to look for sysrq.
> In other words even if there is no serial client it's always reading
> the port looking for characters.  IMO this concept should be separated
> out from the NMI concept and _could_ automatically work for all serial
> drivers.  You'd just need something in the serial core that acted like
> a default client if nobody else opened the serial port.  The nice
> thing here is that we go through all the normal code paths and don't
> need special cases in the driver.

Okay, will try to explore this option to have default serial port
client. Would this client be active in normal serial operation or only
active when we have kgdb active? One drawback I see for normal
operation could be power management as if user is not using serial
port and would like to disable corresponding clock in order to reduce
power consumption.

>
> b) It enables NMI for your particular serial driver.  This seems like
> it'd be hard to do automatically because you can't do the same things
> at NMI that you could do in a normal interrupt handler.

Agree.

>
> NOTE: to me, a) is more important than b) (though it'd be nice to have
> both).  This would be especially true the earlier you could make a)
> work since the main time when an "agetty" isn't running on my serial
> port to read characters is during bootup.
>
> Why is b) less important to me? Sure, it would let you drop into the
> debugger in the case where the CPU handling serial port interrupts is
> hung with IRQs disabled, but it _woudln't_ let you drop into the
> debugger in the case where a different CPU is hung with IRQs disabled.
> To get that we need NMI roundup (which, I know, you are also working
> on for arm64).  ...and, if we've got NMI roundup, presumably we can
> find our way into the debugger by either moving the serial interrupt
> to a different CPU ahead of time or using some type of lockup detector
> (which I know you are also working on for arm64).
>

Thanks for sharing your preferences. I will try to get a) sorted out first.

Overall I agree with your approaches to debug hard-lockup scenarios
but they might not be so trivial for kernel engineers who doesn't
posses kernel debugging experience as you do. :)

And I still think NMI aware magic sysrq is useful for scenarios such as:
- Try to get system information during hard-lockup rather than just
panic via hard-lockup detection.
- Do normal start/stop debugger activity on a core which was stuck in
hard-lockup.
- Random boot freezes which are not easily reproducible.

>
> One last bit of feedback is that I noticed that you didn't try to
> implement the old "knock" functionality of the old NMI driver that's
> being deleted.  That is: your new patches don't provide an alternate
> way to drop into the debugger for systems where BREAK isn't hooked up.
> That's not a hard requirement, but I was kinda hoping for it since I
> have some systems that haven't routed BREAK properly.  ;-)
>

Yeah, this is on my TODO list to have a kgdb "knock" functionality to
be implemented via a common hook in serial core.

>
> I'll try to get some more detailed feedback in the next few days.

Thanks. I do look forward to your feedback.

-Sumit

>
> -Doug
