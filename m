Return-Path: <SRS0=hLv5=BX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42919C433E3
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 09:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D26E20781
	for <linux-serial@archiver.kernel.org>; Thu, 13 Aug 2020 09:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yu+SbLup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMJZ1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 13 Aug 2020 05:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgHMJZ0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 13 Aug 2020 05:25:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1209AC061383
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 02:25:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so5414557ljk.6
        for <linux-serial@vger.kernel.org>; Thu, 13 Aug 2020 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77hxUNMDXx1TkOETyYbeW1D4qmhSIYpoh1BsirngSVQ=;
        b=yu+SbLupDZq0IXwtevl1p7b23YCume+VhpFVbBTYcNZv/vlx287qpNSmWjR8LHhuAe
         zpgPXzPweDDJmlIogq6S6xphPDuAvuKNDqi+r4N0uzlSK/MwiuGJ+/h9T5GiVisMayGd
         OrJvmjH8SVAZ47k+/Bf+HVbS3x6qYt9xspTwfpJyrt6YAqVPIPrYLZh+KfDwksV0gufd
         bfiIpvHDcPBObpbt+50b0zr495HlbcH31LQ4alFHyUENdNvVIHlW7SJOed29HBnx/t/l
         h9PyZ5CNnBIm+V+9XYZGbz0iqt0sewlAjCe/Th72gVgX87ODr8QCo+5r0fHWqw8m40Oh
         VAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77hxUNMDXx1TkOETyYbeW1D4qmhSIYpoh1BsirngSVQ=;
        b=heaGHN12IcdmiY8kvpATV84GVh1coEG0wwxP27AGrRcFTpkgtcgtNl1TVzpcT0SoNW
         DPjs2Kg/69OeWznBjUSaiqynGvBXNGDkIoZUcZTLxPNg2VtLW13orQTjgSG2wRsS+lw0
         cWvUti73Ex/xvuosIsOmpRzwAPRUKr0vEwtCFLVL+8hSqF4QK4Kgo+2maOSBcqZSc4GM
         lCdYgokBSHnCnjULfAts22K+yA56fBTwK/DUtCr+eDr33c2br0Be+93+EMrF2rsi79r9
         5ExQlgbhlPb4OBJ9YMT60tD/H52PcwYb2GjM97y2w654cYn0sUcS0FmbZsOq7UICpbxw
         zaMw==
X-Gm-Message-State: AOAM531O8rInnRkKPwAHDBbzz/yoSyv9ZKn0FiLpqIGdTWEs5QpEfUDj
        NlT0A+NCJF/nbDf20aBlwDAUN4aCq9wilg+cSX8zLw==
X-Google-Smtp-Source: ABdhPJyPK4DPHHD55S2xANgp+3FYQtyR1zzh/60AtAFyGOvgRV/WpDgK6NeD1rHR65oNWCNxdQz25TacXvWjM8amVpA=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr1503400ljh.372.1597310724016;
 Thu, 13 Aug 2020 02:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com>
 <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com> <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
In-Reply-To: <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 13 Aug 2020 14:55:12 +0530
Message-ID: <CAFA6WYPxieH6ZTa_BFdaLuiwbqAs6r7eKmxG7ci4XtyRONGN7g@mail.gmail.com>
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

On Thu, 13 Aug 2020 at 05:38, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
>
> On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, Aug 12, 2020 at 7:53 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Hi Doug,
> > >
> > > On Tue, 11 Aug 2020 at 22:46, Doug Anderson <dianders@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Aug 11, 2020 at 7:58 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Aug 11, 2020 at 07:59:24PM +0530, Sumit Garg wrote:
> > > > > > Hi Greg,
> > > > > >
> > > > > > Thanks for your comments.
> > > > > >
> > > > > > On Tue, 11 Aug 2020 at 19:27, Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> > > > > > > > On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > > > > > > > > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > > > > > > > > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > > > > > > > > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > > > > > > > > kernel debugger in NMI context.
> > > > > > > > >
> > > > > > > > > The major use-case is to add NMI debugging capabilities to the kernel
> > > > > > > > > in order to debug scenarios such as:
> > > > > > > > > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> > > > > > > > >   doesn't honor serial device interrupt. So having magic sysrq triggered
> > > > > > > > >   as an NMI is helpful for debugging.
> > > > > > > > > - Always enabled NMI based magic sysrq irrespective of whether the serial
> > > > > > > > >   TTY port is active or not.
> > > > > > > > >
> > > > > > > > > Currently there is an existing kgdb NMI serial driver which provides
> > > > > > > > > partial implementation in upstream to have a separate ttyNMI0 port but
> > > > > > > > > that remained in silos with the serial core/drivers which made it a bit
> > > > > > > > > odd to enable using serial device interrupt and hence remained unused. It
> > > > > > > > > seems to be clearly intended to avoid almost all custom NMI changes to
> > > > > > > > > the UART driver.
> > > > > > > > >
> > > > > > > > > But this patch-set allows the serial core/drivers to be NMI aware which
> > > > > > > > > in turn provides NMI debugging capabilities via magic sysrq and hence
> > > > > > > > > there is no specific reason to keep this special driver. So remove it
> > > > > > > > > instead.
> > > > > > > > >
> > > > > > > > > Approach:
> > > > > > > > > ---------
> > > > > > > > >
> > > > > > > > > The overall idea is to intercept serial RX characters in NMI context, if
> > > > > > > > > those are specific to magic sysrq then allow corresponding handler to run
> > > > > > > > > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > > > > > > > > work queue in order to run those in normal interrupt context.
> > > > > > > > >
> > > > > > > > > This approach is demonstrated using amba-pl011 driver.
> > > > > > > > >
> > > > > > > > > Patch-wise description:
> > > > > > > > > -----------------------
> > > > > > > > >
> > > > > > > > > Patch #1 prepares magic sysrq handler to be NMI aware.
> > > > > > > > > Patch #2 adds NMI framework to serial core.
> > > > > > > > > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > > > > > > > > Patch #5 removes kgdb NMI serial driver.
> > > > > > > > >
> > > > > > > > > Goal of this RFC:
> > > > > > > > > -----------------
> > > > > > > > >
> > > > > > > > > My main reason for sharing this as an RFC is to help decide whether or
> > > > > > > > > not to continue with this approach. The next step for me would to port
> > > > > > > > > the work to a system with an 8250 UART.
> > > > > > > > >
> > > > > > > >
> > > > > > > > A gentle reminder to seek feedback on this series.
> > > >
> > > > It's been on my list for a while.  I started it Friday but ran out of
> > > > time.  This week hasn't been going as smoothly as I hoped but I'll
> > > > prioritize this since it's been too long.
> > > >
> > >
> > > No worries and thanks for your feedback.
> > >
> > > >
> > > > > > > It's the middle of the merge window, and I can't do anything.
> > > > > > >
> > > > > > > Also, I almost never review RFC patches as I have have way too many
> > > > > > > patches that people think are "right" to review first...
> > > > > > >
> > > > > >
> > > > > > Okay, I understand and I can definitely wait for your feedback.
> > > > >
> > > > > My feedback here is this:
> > > > >
> > > > > > > I suggest you work to flesh this out first and submit something that you
> > > > > > > feels works properly.
> > > > >
> > > > > :)
> > > > >
> > > > > > IIUC, in order to make this approach substantial I need to make it
> > > > > > work with 8250 UART (major serial driver), correct? As currently it
> > > > > > works properly for amba-pl011 driver.
> > > > >
> > > > > Yes, try to do that, or better yet, make it work with all serial drivers
> > > > > automatically.
> > > >
> > > > A bit of early feedback...
> > > >
> > > > Although I'm not sure we can do Greg's "make it work everywhere
> > > > automatically", it's possible you could get half of your patch done
> > > > automatically.  Specifically, your patch really does two things:
> > > >
> > > > a) It leaves the serial port "active" all the time to look for sysrq.
> > > > In other words even if there is no serial client it's always reading
> > > > the port looking for characters.  IMO this concept should be separated
> > > > out from the NMI concept and _could_ automatically work for all serial
> > > > drivers.  You'd just need something in the serial core that acted like
> > > > a default client if nobody else opened the serial port.  The nice
> > > > thing here is that we go through all the normal code paths and don't
> > > > need special cases in the driver.
> > >
> > > Okay, will try to explore this option to have default serial port
> > > client. Would this client be active in normal serial operation or only
> > > active when we have kgdb active? One drawback I see for normal
> > > operation could be power management as if user is not using serial
> > > port and would like to disable corresponding clock in order to reduce
> > > power consumption.
> >
> > If I could pick the ideal, I'd say we'd do it any time the console is
> > configured for that port and magic sysrq is enabled.  Presumably if
> > they're already choosing to output kernel log messages to the serial
> > port and they've enabled magic sysrq they're in a state where they'd
> > be OK with the extra power of also listening for characters?
> >

Okay, sounds reasonable to me.

> >
> > > > b) It enables NMI for your particular serial driver.  This seems like
> > > > it'd be hard to do automatically because you can't do the same things
> > > > at NMI that you could do in a normal interrupt handler.
> > >
> > > Agree.
> > >
> > > >
> > > > NOTE: to me, a) is more important than b) (though it'd be nice to have
> > > > both).  This would be especially true the earlier you could make a)
> > > > work since the main time when an "agetty" isn't running on my serial
> > > > port to read characters is during bootup.
> > > >
> > > > Why is b) less important to me? Sure, it would let you drop into the
> > > > debugger in the case where the CPU handling serial port interrupts is
> > > > hung with IRQs disabled, but it _woudln't_ let you drop into the
> > > > debugger in the case where a different CPU is hung with IRQs disabled.
> > > > To get that we need NMI roundup (which, I know, you are also working
> > > > on for arm64).  ...and, if we've got NMI roundup, presumably we can
> > > > find our way into the debugger by either moving the serial interrupt
> > > > to a different CPU ahead of time or using some type of lockup detector
> > > > (which I know you are also working on for arm64).
> > > >
> > >
> > > Thanks for sharing your preferences. I will try to get a) sorted out first.
> > >
> > > Overall I agree with your approaches to debug hard-lockup scenarios
> > > but they might not be so trivial for kernel engineers who doesn't
> > > posses kernel debugging experience as you do. :)
> > >
> > > And I still think NMI aware magic sysrq is useful for scenarios such as:
> > > - Try to get system information during hard-lockup rather than just
> > > panic via hard-lockup detection.
> > > - Do normal start/stop debugger activity on a core which was stuck in
> > > hard-lockup.
> > > - Random boot freezes which are not easily reproducible.
> >
> > Don't get me wrong.  Having sysrq from NMI seems like a good feature
> > to me.

Yeah I understand what you meant but I was just trying to highlight
additional benefits that sysrq from NMI provides.

> > That being said, it will require non-trivial changes to each
> > serial driver to support it and that means that not all serial drivers
> > will support it.  It also starts requiring knowledge of how NMIs work
> > (what's allowed in NMI mode / not allowed / how to avoid races) for
> > authors of serial drivers.  I have a bit of a worry that the benefit
> > won't outweigh the extra complexity, but I guess time will tell.

Yes I understand these concerns as well. That's why I have tried to
defer almost all of the work to the IRQ work queue apart from
essential parsing of RX chars in NMI mode. Also, I tried to keep most
of this code common in serial core.

> > One
> > last worry is that I assume that most people testing (and even
> > automated testing labs) will either always enable NMI or won't enable
> > NMI.  That means that everyone will be only testing one codepath or
> > the other and (given the complexity) the non-tested codepath will
> > break.
> >

The current patch-set only makes this NMI to work when debugger (kgdb)
is enabled which I think is mostly suitable for development
environments. So most people testing will involve existing IRQ mode
only.

However, it's very much possible to make NMI mode as default for a
particular serial driver if the underlying irqchip supports it but it
depends if we really see any production level usage of NMI debug
feature.

> > Hrm.  Along the lines of the above, though: almost no modern systems
> > are uniprocessor.  That means that even if one CPU is stuck with IRQs
> > off it's fairly likely that some other CPU is OK.  Presumably you'd
> > get almost as much benefit as your patch but with more done
> > automatically if you could figure out how to detect that the serial
> > interrupt isn't being serviced and re-route it to a different CPU.
> > ...or possibly you could use some variant of the hard lockup detector
> > and move all interrupts off a locked up CPU?  You could make this an
> > option that's "default Y" when kgdb is turned on or something?

Yes we can reroute serial interrupts but what I meant to say is that
we can at most get a backtrace of CPU stuck in hard-lockup whereas
with NMI debugger entry on hard-lockup CPU, we can do normal
start/stop/single-step debugging on that CPU.

>
> One other idea occurred to me that's maybe simpler.  You could in
> theory just poll the serial port periodically to accomplish.  It would
> actually probably even work to call the normal serial port interrupt
> routine from any random CPU.  On many serial drivers the entire
> interrupt handler is wrapped with:
>
> spin_lock_irqsave(&uap->port.lock, flags);
> ...
> spin_unlock_irqrestore(&uap->port.lock, flags);
>
> And a few (the ones I was involved in fixing) have the similar pattern
> of using uart_unlock_and_check_sysrq().
>
> Any serial drivers following this pattern could have their interrupt
> routine called periodically just to poll for characters and it'd be
> fine, right?  ...and having it take a second before a sysrq comes in
> this case is probably not the end of the world?
>

Are you proposing to have complete RX operation in polling mode with
RX interrupt disabled (eg. using a kernel thread)?

>
> One nice benefit of this is that it would actually work _better_ on
> SMP systems for any sysrqs that aren't NMI safe.  Specifically with
> your patch series those would be queued with irq_work_queue() which
> means they'd be blocked if the CPU processing the NMI is stuck with
> IRQs disabled.

Yes, the sysrq handlers which aren't NMI safe will behave similarly to
existing IRQ based sysrq handlers.

> With the polling mechanism they'd nicely just run on a
> different CPU.

It looks like polling would cause much CPU overhead. So I am not sure
if that is the preferred approach.

-Sumit

>
>
> > > > One last bit of feedback is that I noticed that you didn't try to
> > > > implement the old "knock" functionality of the old NMI driver that's
> > > > being deleted.  That is: your new patches don't provide an alternate
> > > > way to drop into the debugger for systems where BREAK isn't hooked up.
> > > > That's not a hard requirement, but I was kinda hoping for it since I
> > > > have some systems that haven't routed BREAK properly.  ;-)
> > > >
> > >
> > > Yeah, this is on my TODO list to have a kgdb "knock" functionality to
> > > be implemented via a common hook in serial core.
> > >
> > > >
> > > > I'll try to get some more detailed feedback in the next few days.
> > >
> > > Thanks. I do look forward to your feedback.
> > >
> > > -Sumit
> > >
> > > >
> > > > -Doug
