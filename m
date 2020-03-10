Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFBEC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F422467F
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 08:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCJIra (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:47:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38077 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgCJIra (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 04:47:30 -0400
Received: by mail-ot1-f65.google.com with SMTP id i14so12389317otp.5;
        Tue, 10 Mar 2020 01:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boOApZIKCOv83J2w3ZeGrsmLMsYMcv80baJK+BIb6gY=;
        b=PrqyokW3eqeHEHJSNtkFm3gg5WvwC77Avr8OrS0JALnN81S5J4uZoVqIK+ChI7zRKN
         HpJeIrN5szGAfd7TDcaWtus2vFHM/uxd2/AF5yzMOJ/p7fnLSBxw6MtmIgCZCvjhVevi
         /EQGRLl3AGmKKqloWU/jh4G27WGhlDNI6P3cxwgcy99ht+QrJqgUVHRCsst7MjM/sG7D
         g8WLKkshgylOCVgdILH4K6UUhjxv+xP/+c75sIHZ504SFRRj2GuSLkU1kUZnnOrTY0Eq
         rJ+MtrVBWJNmKOMz5ZLsqWP79vmn0r9CeqgTPBNReunI5SgyoovRVzcFhB3pq4ZFkWz+
         kEKA==
X-Gm-Message-State: ANhLgQ3PAdm1gJJ550rQs4UtbBC2Sy6jfCGng/CNCSqA1+VAmufIgyuO
        XG7ZIeg/NRpMICZJyL8bnpVGbiCznwllo8pXAkE=
X-Google-Smtp-Source: ADFU+vty+TpRY4Ac1mTTlnhKuNFwJ1A6bGkpI8IVtjqbOXVyaswgRUMHHcn54Y1V4g21JKdrGDCvoZTaA2BR/9GgTms=
X-Received: by 2002:a9d:8d0:: with SMTP id 74mr3528400otf.39.1583830047801;
 Tue, 10 Mar 2020 01:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
 <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com>
 <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
 <20200310041903.GA260998@google.com> <20200310042739.GB260998@google.com>
In-Reply-To: <20200310042739.GB260998@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Mar 2020 09:47:16 +0100
Message-ID: <CAMuHMdXRPBwFo2zAb99gMLP_+KaTHZ261fLYa+cbG6DEH_EP_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
To:     Sandeep Patil <sspatil@android.com>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sandeep,

On Tue, Mar 10, 2020 at 5:27 AM Sandeep Patil <sspatil@android.com> wrote:
> On Mon, Mar 09, 2020 at 09:19:03PM -0700, Sandeep Patil wrote:
> > On Mon, Mar 09, 2020 at 11:32:06AM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Mar 9, 2020 at 9:32 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > On Mon, 9 Mar 2020 at 16:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > >
> > > > > > The default value of Kconfig for almost all sprd drivers are the same with
> > > > > > ARCH_SPRD, making these drivers built as modules as default would be easier
> > > > > > if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.
> > > > > >
> > > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > >
> > > > > Can you actually boot a kernel on a Spreadtrum platform when all platform
> > > > > and driver support is modular?
> > > >
> > > > Yes, even if all drivers are modular.
> > >
> > > Cool. No hard dependencies on e.g. regulators that are turned off when
> > > unused?
> > >
> > > > But I hope serial can be builtin, then I can have a console to see
> > > > kernel output before loading modules.
> > >
> > > No dependency on the clock driver?
> > > Oh, I see you have a hack in the serial driver, to assume default
> > > values when the serial port's parent clock is not found.  That may
> > > limit use of the other serial ports, depending on the actual serial
> > > hardware.
> > > And on Sharkl64, the serial port's clock is a fixed-clock anyway, so
> > > you don't even need the hack.
> > >
> > > But in general you cannot rely on that, especially if your SoC has clock
> > > and/or power domains.

So I gave it a try on my platform (R-Car), with just the serial driver
builtin.  I can see the kernel booting using earlycon.
However, the serial driver is never probed, as the pin control driver is
missing. And after that, it would need the clock domain (power domain
and clock drivers), and more serial clock inputs (clock driver, again).
Fortunately DMA is optional (dmac driver, and optional iommu driver).

I guess core platform-specific drivers can be loaded from the initramfs,
after which the serial driver would be probed, finally.  If the
initramfs includes a storage driver, anything else can be loaded from
e.g. eMMC.

> > > > Also, this's what Google GKI [1] asked :)

> > > > [1] https://arstechnica.com/gadgets/2019/11/google-outlines-plans-for-mainline-linux-kernel-support-in-android/
> > >
> > > Let's see how having everything modular works out on an SoC where all
> > > hardware is part of a clock and power domain.
> >
> > I'm curious, are there any problems that we should be aware of? We know about
> > the regulator sync state and consumer-supplier dependencies. [1]

Care must be taken, as probe deferral behaves differently after
late_initcall time (see driver_deferred_probe_check_state_continue),
which may cause issues with "optional" components like DMA controllers
and IOMMUs.  Unused clocks and power domains are not turned off,
unlike for the builtin case.

On some SoCs, even the interrupt controller (GIC) may be part of a clock
and/or power domain, while the GIC driver is not aware of that.
For the clock, that is handled by CLK_IS_CRITICAL in the clock driver.
For power domains, that is not handled explicitly on Renesas SoCs, as
the GIC is always in the same power domain as other devices that are
Runtime PM-aware.  But if those devices would have modular drivers, that
power domain could still be turned off.

So on a modern ARM system, I assume a generic kernel with no
vendor-specific drivers builtin can indeed work.
On older systems, without an ARM architectured timer, you will need at
least the platform-specific timer driver (and the clock driver) builtin.
Assumed the timer's power domain has been powered up by the firmware.

> (oops, forgot to paste the link to presentation)
> 1. https://linuxplumbersconf.org/event/4/contributions/402/attachments/320/544/Solving_issues_associated_with_modules_and_supplier-consumer_dependencies.pdf

Thanks, hadn't seen that presentation.
It matches my understanding.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
