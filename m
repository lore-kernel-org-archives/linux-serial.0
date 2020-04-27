Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D8DC55199
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 09:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546512087E
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 09:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9jfsLt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgD0JCi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0JCi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 05:02:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF4EC061A41;
        Mon, 27 Apr 2020 02:02:38 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d17so8433120pgo.0;
        Mon, 27 Apr 2020 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=No3l3tVxMOYI0sBvPh0yz49YIT/rbemERKzXNkg42cM=;
        b=S9jfsLt2b0vbA6WMBsREA7m6FlxSVBc3AMXqrbDArXxsA8rUUnJxJIRlxKInrpwWlp
         lTlJL9PCHUkvCXneeeWDf1hQTWBvUtrBro/PDbKbsOsi43NNcuGxsClyz7dos/p2c64d
         1o3oygCQlmNgD8D0lhNQiPMoEr+uCpLCTDS513OTOJ1wgZ/iNJksjU6PfSPGrWNXnWFs
         8MHPpa9vpG1DH8nOcul/+7xQMs9uT1in+UJ0Uk/4oYsoulT7yRiHw3HVfdm0wvrS9tNd
         gMzZ7vpDlx0gD1YMGHmcEkcHGgrLvNiYBMUxtr+hdMM1nkdBKgE40Uyoqd71BEG0u4F2
         wmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=No3l3tVxMOYI0sBvPh0yz49YIT/rbemERKzXNkg42cM=;
        b=Qy6pbG8Zla65RNPpzsXOHV+28mimg9YB34w7/skunzoaPI9gj1MGn30AjipxCnWsHy
         3B98Dk+brsawthE5qx6Wku0CNKOCx3S76pKLCMtW65Ir0L6ybWMC242ZwOJMqjZIiFI7
         J2lJBqg1zZM0kElgfpTo+VNSwhlml3e0YFFB2bh/tfeBPN3l54sbA2RYTgiZTixTlmB1
         SJnageh6U0jF1KzY5T3PmCwT/rYCuXef+JU2PdOPrYEYnJ3n/4+/DW/OsfEv8uNjs7qV
         DIp7LDsZ2V0jy0zgPR58ETLSec+qAUBAk6hc4u7N/yyf609ndE8pb1YghdfflR8zIlhS
         I7/Q==
X-Gm-Message-State: AGi0PuaztzWuNj9PFfa2gfnaPzmOSB9sPqQwIZzZMeJcnStOzLyH535G
        wfh3TqHAso91QxGiyczPAOfNmfHr26iYx+GmNRE=
X-Google-Smtp-Source: APiQypJ+Jt4WQy9vMmOsUAtVuDSHxHzYtDKBigHQS2Y661NcJP6vx/MNPwb77T1Un8B+rTqcsUpaPObPtJOd/VetSz4=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr22398681pfb.130.1587978158112;
 Mon, 27 Apr 2020 02:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200423220056.29450-1-john.stultz@linaro.org>
 <jhj1rodyeu1.mognet@arm.com> <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com>
 <jhj1ro9bzhg.mognet@arm.com>
In-Reply-To: <jhj1ro9bzhg.mognet@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Apr 2020 12:02:31 +0300
Message-ID: <CAHp75VeE_J-GE9o6QVxBk6RJ2fjSwATfR1etaT0CXCgAiidjPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] serial: amba-pl011: Make sure we initialize the
 port.lock spinlock
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 27, 2020 at 2:29 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 25/04/20 05:04, John Stultz wrote:
> > On Thu, Apr 23, 2020 at 4:14 PM Valentin Schneider
> > <valentin.schneider@arm.com> wrote:
> >> On 23/04/20 23:00, John Stultz wrote:
> >> > Which seems to be due to the fact that after allocating the uap
> >> > structure, the pl011 code doesn't initialize the spinlock.
> >> >
> >> > This patch fixes it by initializing the spinlock and the warning
> >> > has gone away.
> >> >
> >>
> >> Thanks for having a look. It does seem like the reasonable thing to do, and
> >> I no longer get the warning on h960.
> >>
> >> That said, I got more curious as this doesn't show up on my Juno (same
> >> Image). Digging into it I see that uart_add_one_port() has a call to
> >> uart_port_spin_lock_init() a few lines before uart_configure_port() (in
> >> which the above warning gets triggered). That thing says:
> >>
> >>  * Ensure that the serial console lock is initialised early.
> >>  * If this port is a console, then the spinlock is already initialised.
> >>
> >> Which requires me to ask: are we doing the right thing here?
> >
> > So I got a little bit of time to look at this before I got pulled off
> > to other things (and now its Friday night, so I figured I'd reply
> > before I forget it on Monday).
> >
> > I did check and lockdep is tripping when we add ttyAMA6 which is the
> > serial console on the board. I wasn't able to trace back to why we
> > hadn't already called spin_lock_init() in the console code, but it
> > seems we haven't.
> >
>
> So on the Juno (ttyAMA0), the first time I see us hitting
> uart_port_spin_lock_init() is via:
>
>   uart_add_one_port() ->  uart_port_spin_lock_init()
>
> Since port->cons->(index, line) is (-1, 0) at this point in time,
> uart_console(port) returns false and we init the spinlock. When then
> happily trickle down to uart_configure_port() -> register_console()
>
>
> On the Hikey960 (ttyAMA6) I see the same initial flow, but (index, line)
> is (6, 6), so uart_console(port) returns true and we skip the
> spin_lock_init(). When then hit the splat on the rest of the way down
> uart_add_one_port().
>
>
> I did a tiny bit of git spelunking; I found a commit that changed
> uart_console_enabled() into uart_console() within
> uart_port_spin_lock_init():
>
>   a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
>
> Reverting just that one change in uart_port_spin_lock_init() seems to go
> fine on both Juno & HiKey960, but I think that doesn't play well with the
> rest of the aforementioned commit. I think that this initial (index, line)
> tuple is to blame, though I've added Andy in Cc just in case.

The above mentioned commit reveals the issue in the code which doesn't
register console properly.

See what I put in 0f87aa66e8c31 ("serial: sunhv: Initialize lock for
non-registered console").

-- 
With Best Regards,
Andy Shevchenko
