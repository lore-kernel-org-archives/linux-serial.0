Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF1FC4361B
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 12:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA65236FB
	for <linux-serial@archiver.kernel.org>; Tue,  8 Dec 2020 12:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLHMM7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Dec 2020 07:12:59 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35064 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgLHMM7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Dec 2020 07:12:59 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so9508214otr.2
        for <linux-serial@vger.kernel.org>; Tue, 08 Dec 2020 04:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c1lmHDq6kUKFUfRsb5jPpKpp+nyyxDlaHaUsvjjhI9w=;
        b=RIcDWp+xFB29MF3RUEgkB8dOYOEgHZbgfbExykeApXy+8AnP/Fgx3YVYzE80DuyREF
         d71KQzAVzUkoSDMBggfWFgpUwL9qp6W2yTIdMtQ6WTYovkjSSCsOmFYy5CINJ33J4u4x
         FwtiG6SzX9b6Di9NpZWceeGELi7tM4ueWNptx+KkyeWAdVtnqmjGfCoiiCsHaQYnLk+a
         +xa5wje0YigXCdBtHya2Sd8918qBv4yQ5wkwtv8gdFnvE/lFdEUx94RhuckmhPhZ6fp8
         ZGxBL18IORE/gX3ml98k9qvFLxRusSQCWCNIZ/bbmZjBfxwtJSq2VFLt1Fsj0fgQR5gB
         DtdA==
X-Gm-Message-State: AOAM532GBLYEOR6Cr0L9+lu2bqC3c3yyX8jSF4grc2j7TiKa8f2A8Lh1
        ZpcZ4ZGWf8W4oIQk8wurz7OUKeIvYa/Q/pyzqR0=
X-Google-Smtp-Source: ABdhPJyrs7apIyOmpCJTd9J9Oz4FlqbFEb5pbdofdTFrGC1syroQ7V4mP4GW7ov90Su7YJx/KVNsoipWDW4tLXJKUhY=
X-Received: by 2002:a9d:2203:: with SMTP id o3mr16521708ota.107.1607429538485;
 Tue, 08 Dec 2020 04:12:18 -0800 (PST)
MIME-Version: 1.0
References: <20201125081352.25409-1-zajec5@gmail.com> <X74Uanu26sx4Hait@kroah.com>
 <6b107933-9ab1-7c46-c383-ed39b71b4ecb@gmail.com> <X74bxfji0uTZV8y9@kroah.com>
 <CAMuHMdXA+B_=abXAzCt5m3djjhLpzuDEtEhF_8UYkm95hu_4PA@mail.gmail.com> <X89dni+AANpIiNW0@kroah.com>
In-Reply-To: <X89dni+AANpIiNW0@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Dec 2020 13:12:07 +0100
Message-ID: <CAMuHMdV25z=N6kXaSbaRn+JqyGj8oMumj3yw=YegtncbDb0HKg@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On Tue, Dec 8, 2020 at 12:02 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Dec 08, 2020 at 11:45:33AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Nov 25, 2020 at 9:53 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Wed, Nov 25, 2020 at 09:38:50AM +0100, Rafał Miłecki wrote:
> > > > On 25.11.2020 09:23, Greg Kroah-Hartman wrote:
> > > > > On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
> > > > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > > >
> > > > > > Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
> > > > > > is ARM64.
> > > > > >
> > > > > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

> > > > > > --- a/drivers/tty/serial/Kconfig
> > > > > > +++ b/drivers/tty/serial/Kconfig
> > > > > > @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
> > > > > >   config SERIAL_BCM63XX
> > > > > >           tristate "Broadcom BCM63xx/BCM33xx UART support"
> > > > > >           select SERIAL_CORE
> > > > > > - depends on MIPS || ARM || COMPILE_TEST
> > > > > > + depends on MIPS || ARM || ARM64 || COMPILE_TEST
> >
> > Why not s/ARM64/ARCH_BCM4908/?
> >
> > > > >
> > > > > Why do we have an arch dependancy at all now?
> > > >
> > > > From my experience "depends" is often used to limit symbol visibility to
> > > > applicable platforms only. I don't think Broadcom has any x86, risc, etc.
> > > > platforms so it's useless there.
> > > >
> > > > As for testing driver compilation on unused arch-s I thought that's what
> > > > COMPILE_TEST is for.
> > > >
> > > > Am I wrong there? I'm afraid we don't have clear Documentation on that.
> > > > Please kindly point me to some info if I'm wrong.
> > >
> > > If COMPILE_TEST is working for this driver, then trying to restrict it
> > > to a specific arch is usually pointless and the arch dependency can be
> > > removed, keeping patches like this from having to be made over time to
> > > add it to new arches :)
> > >
> > > > > > + default ARCH_BCM4908
> > > > >
> > > > > Really?  I thought we were getting rid of these "ARCH_platform_type" of
> >
> > No we are not.
>
> Ok, I keep getting mixed signals here.
>
> > > > > things.  That's what a defconfig file is for, right?
> >
> > FWIW, the arm64 defconfig file enables about everything, for all arm64
> > platforms.
>
> Then why are there ARCH_platforms for arm64 systems?

To enable core infrastructure or quirks for a certain SoC or SoC family,
and to have a symbol for individual drivers to depend on?
To make it easier to configure a kernel suited for a specific system?
Mostly, you can take arm64/defconfig, disable the ARCH_* guards
for SoC families you're not interested in, and have a suitable kernel
for your system.

> > > > I had to miss something, last time I checked Linus called defconfigs a
> > > > garbage and wanted to get rid of them:
> > > > https://lwn.net/Articles/391372/
> > > >
> > > > There are also no platform defconfigs in arch/arm64/ at all. Should I
> > > > handle it with arch/arm64/Kconfig.platforms and "select SERIAL_BCM63XX"?
> > >
> > > I thought we were trying to get rid of arm64 "platforms" as well.  My
> > > point being, why is this needed at all?
> >
> > To prevent asking the user about a driver that is completely useless for
> > the system(s) the user is compiling a kernel for.
>
> How do you "know" that given the huge number of different ip blocks in
> SoC systems these days?

E.g. by looking at which .dtsi files contain device nodes that have a
compatible value that matches the list of compatible values in the
driver.  Most IP cores are only present on a fairly limited set of SoCs
and SoC families. Designware IPs are the major exception.
And I hope the driver author/maintainer has some knowledge here.

> > Do you want to let distros compile all arm/arm64-only SoC drivers for x86, too?
>
> Sure, many have crossed over over the years and shown up there.
>
> But distro config owners are smarter than that, give them some credit :)

Let's repeat your question above: "How do they know that...?".
I guess the driver developer knows better (read: needs much less
investigation time) than the distro config owner.

It's not just for distros.  If we can make life easier for every single
developer or user who configures a kernel, by just storing that
information in the dependency system, I think that's a justification
for doing that.  And in fact we're already doing that in most
subsystems. Serial seems to be the only one that wants to move
in the other direction...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
