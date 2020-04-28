Return-Path: <SRS0=KIft=6M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E2C83000
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 10:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0342D20663
	for <linux-serial@archiver.kernel.org>; Tue, 28 Apr 2020 10:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrCK7SnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgD1KDh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbgD1KDh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 06:03:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C6C03C1A9;
        Tue, 28 Apr 2020 03:03:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so2250913plr.0;
        Tue, 28 Apr 2020 03:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B47MWor82gS9pbzIegeM3QuLFmWB3mDHdrQ9VL++afI=;
        b=nrCK7SnAoBKnsW47PH6KdJVngh2wmddILURXMBln553biX696/xlswk8+NI/1huiq/
         WAUd13XaNPT/agYm3VF4fXKbJDWG2CXvOKTe/7X6KnmC67lkkTGb6oO9b8PedRKHbEyT
         RBYDscitMQ+Fim7G2Qx0nNTXy395hfXXdkDJx6rwMp82tLUu6EgmS42LAB2EFi6EUUJY
         hZBaNewYyMTmdIQJi2G6WImQvKHZbwoMXlQ+JxOqT5KOB9VF2CDqhSf8SVh7O+vRfusT
         nmVdC4HGEPmKO9VbnnAlKgKC+Z6lWj4eDnq4he3J0IkVJwyyP/1BmKICCYoD45iQ70WB
         unTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B47MWor82gS9pbzIegeM3QuLFmWB3mDHdrQ9VL++afI=;
        b=tvo+MWeeBOE7cVHhTUdaX5IoTUirn4YIPMvmQlQ42hSubkdrAQITNX0guJvj6Z8aBD
         wL4P5f7EtXTsCiliZrh7sTjyoaGkHcPPQUyrrzk6BKKgT7YXBJr1z0UODW/hdfikFxkY
         xUEwkYFcRx1fIt9kVTV3ERrnbKdTdGb0OyTpbbLsw7g79i03xJvL5z73FKOCvKP0I+pa
         lPot7i0K8nMUunWh344bH69737e8/FBQe7CIu7ilCpyBtqxC39db8bUobfoQMGtl/4qy
         OBsirPKTi6RpGrQC/8WMDOAGs0TkWVT2dVBQUqhGQoxVGkcdVVDnwDo8Fh2wgMiLClTU
         QJAg==
X-Gm-Message-State: AGi0PuawYZpu+qHAbm9fOYwZmuGQWbM7sjjxdmeCqzrOB7ShB7hkJYRQ
        vppuKjhyMXKHtf3mXDDTvu1AdKtswh0OZ1as8Oo=
X-Google-Smtp-Source: APiQypI5K60dAdHo8M/GOcGL+EVrmv/aPEuWFNph9FWRnFIr9C0KmKwQlz6TD7ILooulyHou0b63fJIotf/Kz9lrtlo=
X-Received: by 2002:a17:90a:224b:: with SMTP id c69mr4246982pje.8.1588068216432;
 Tue, 28 Apr 2020 03:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200423220056.29450-1-john.stultz@linaro.org>
 <jhj1rodyeu1.mognet@arm.com> <CALAqxLW+CBMxj_5gCF5yLcX8dhM7Fg6oOL-zot0ZZT6PW6R04g@mail.gmail.com>
 <jhj1ro9bzhg.mognet@arm.com> <CAHp75VeE_J-GE9o6QVxBk6RJ2fjSwATfR1etaT0CXCgAiidjPQ@mail.gmail.com>
 <jhjimhkrnw1.mognet@arm.com>
In-Reply-To: <jhjimhkrnw1.mognet@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Apr 2020 13:03:25 +0300
Message-ID: <CAHp75VfJCVh0HRw4G8o0603XEJe6LdUnvrrugxgU0oyOWRCBPA@mail.gmail.com>
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

On Tue, Apr 28, 2020 at 11:54 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On 27/04/20 10:02, Andy Shevchenko wrote:
> >> I did a tiny bit of git spelunking; I found a commit that changed
> >> uart_console_enabled() into uart_console() within
> >> uart_port_spin_lock_init():
> >>
> >>   a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
> >>
> >> Reverting just that one change in uart_port_spin_lock_init() seems to go
> >> fine on both Juno & HiKey960, but I think that doesn't play well with the
> >> rest of the aforementioned commit. I think that this initial (index, line)
> >> tuple is to blame, though I've added Andy in Cc just in case.
> >
> > The above mentioned commit reveals the issue in the code which doesn't
> > register console properly.
> >
> > See what I put in 0f87aa66e8c31 ("serial: sunhv: Initialize lock for
> > non-registered console").
>
> Thanks for the pointer. I'm still a puzzled as to why it goes fine on one
> board and not on another, but at this point I don't have any better
> suggestion than the unconditional init.

My patch relied on the behaviour of 8250 [1] and that comment (near to
spin lock initialization routine).
It seems AMBA UART drivers unconditionally assign consoles ([2], [3])
without registering it properly at console_initcall().

Least invasive fix is what John's patch does, but real fix is to do
something like 8250 does.

So, the rule of thumb is simple: if we assign console to the port we
must initialize the lock even if we are not registering console.
I dunno the history of different behaviours among drivers and what
change(s) brought us to the messy spin lock initialization code in
them.

[1]: https://elixir.bootlin.com/linux/v5.7-rc3/source/drivers/tty/serial/8250/8250_core.c#L684
[2]: https://elixir.bootlin.com/linux/v5.7-rc3/source/drivers/tty/serial/amba-pl010.c#L691
[3]: https://elixir.bootlin.com/linux/v5.7-rc3/source/drivers/tty/serial/amba-pl011.c#L2496

-- 
With Best Regards,
Andy Shevchenko
