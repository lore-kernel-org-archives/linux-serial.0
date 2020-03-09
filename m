Return-Path: <SRS0=G73M=42=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737FAC18E5A
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 10:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507BD20409
	for <linux-serial@archiver.kernel.org>; Mon,  9 Mar 2020 10:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCIKcS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:32:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46846 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgCIKcS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Mar 2020 06:32:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id 111so4671253oth.13;
        Mon, 09 Mar 2020 03:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN1NhwV5FZU7mvbB/Fyos9y0uYvy+acNwUtvUwLUiRQ=;
        b=XaEw1XPNkCWpXCIrYhb8n9WMjq3gpxMNPICsgt0nJJcLRh9wf7y3cC8T100TasrsDU
         boWrnxRUfzkG3J97SSWVkq2SfAnAkkNjuV+pgfpik4uAT+kKsVN2EJl7DcETEUr4BibK
         BdaJqva7UgM1YyyNN0Tk1l/EAu7HhKCcpqSA9aRNSS7jAR/ptv9krG0MxUEC9Dj4pCfy
         t5TK1+okij+Sx8bnaJuJ74B7Z4deRg8yy/b1m1Xv8I4b5a2TLIZTa2pW7wtXNmbOqDq8
         bv+IvzQsGD68A0Ik9sbVmHPSauNix0a1fau3k+/MeeG6n0dV+iojLybkL62mKAWSyO1f
         AWgg==
X-Gm-Message-State: ANhLgQ0g2yYfskHAZZ7SY2s7EEvLymXnooZMLGWcCSTc49MezVxvJRdd
        f6ezOPn8FQF8OxIcZCY02LUSz3DYZCMBmnzDC3g=
X-Google-Smtp-Source: ADFU+vvWEUII/TFq+DBVwE8+/gWKHsyLSflVItjuPLkHr74fKp/RQBIfJzV4NZ2ge/14b9Bn2Mfny2XLzY2FCAHqPAU=
X-Received: by 2002:a9d:b89:: with SMTP id 9mr12586549oth.297.1583749937349;
 Mon, 09 Mar 2020 03:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
 <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com>
In-Reply-To: <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Mar 2020 11:32:06 +0100
Message-ID: <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Chunyan,

On Mon, Mar 9, 2020 at 9:32 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> On Mon, 9 Mar 2020 at 16:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > The default value of Kconfig for almost all sprd drivers are the same with
> > > ARCH_SPRD, making these drivers built as modules as default would be easier
> > > if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Can you actually boot a kernel on a Spreadtrum platform when all platform
> > and driver support is modular?
>
> Yes, even if all drivers are modular.

Cool. No hard dependencies on e.g. regulators that are turned off when
unused?

> But I hope serial can be builtin, then I can have a console to see
> kernel output before loading modules.

No dependency on the clock driver?
Oh, I see you have a hack in the serial driver, to assume default
values when the serial port's parent clock is not found.  That may
limit use of the other serial ports, depending on the actual serial
hardware.
And on Sharkl64, the serial port's clock is a fixed-clock anyway, so
you don't even need the hack.

But in general you cannot rely on that, especially if your SoC has clock
and/or power domains.

BTW, what about the watchdog driver? That one does need a clock, and
loading it too late will reboot your system.

> Also, this's what Google GKI [1] asked :)
>
> Regards,
> Chunyan
>
> [1] https://arstechnica.com/gadgets/2019/11/google-outlines-plans-for-mainline-linux-kernel-support-in-android/

Let's see how having everything modular works out on an SoC where all
hardware is part of a clock and power domain.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
