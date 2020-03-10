Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0256FC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 09:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C589F24681
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmgqsy1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgCJJla (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:41:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45874 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgCJJla (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 05:41:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id e18so13299683ljn.12;
        Tue, 10 Mar 2020 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YaRVVvZe82f7PICjBJhATGndS8gB7Og7ojx2leFE1C8=;
        b=qmgqsy1VrS/eXemTV3L1tff6TLx+hApE+cDMEYWENUlA6Av/G7trT0ltO5rIGfkQJJ
         OXvdTrGt/0U40hM4O7FqrYhV3r5umIg14moWgX9nIgdV/Xsw8+NPTLNoylDs9IO4KFJL
         E2yAhSSaSCPeOgNeWS2+XC0J/ov0dh179PkFTN52VQDsuZNrKvzgLVA1nRBLp6aaYafH
         4DH6ou71NI1ibntcUjiAHDUjMi3fysWfyCxQ748ycUqtSlC/qrR59MqLk4wBIsaLoPJq
         qF10hhSm/blyptIxwZ/XV/poEwkFUkX4V7qdXxMdRUU7hEcbusG2pbixW74lC13GuIuk
         oK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YaRVVvZe82f7PICjBJhATGndS8gB7Og7ojx2leFE1C8=;
        b=WK2KKVUfTrsBh1OTcANICUG2RAg632S4Uf/dNMX3gSRNkVVj/PBHDmgppxKk4A1IuQ
         O3eFIzP0IziIQKaBqgE4DKJ+ls9Cj+x8wOKYmenAxF3aBJS/Nw+MHahISa/paLRo0wcH
         Yg+tZJGX8rCqKG5f+Lb7PZ1E5+j0UrlEvhkiDo4U1xUB6vM/bl0yxNprLbNRjHbWL7Dz
         ZYkIr28/tiuOpYiTKHWv6qlgMhVeEFFJsNlIeQousR3PqWemPfAxDXLZVPQ7ZXJtrV8K
         uboqfqIvtPwhuUhPSdNRh4haFBgj5HtPYQ9B7uIuBeQT+Q+/BCLoFELs16IU2Zakza5M
         /DFw==
X-Gm-Message-State: ANhLgQ3bD42Dd7OoAfBCdtLz3G9ORWz9brhb3MpimtE0vQpZdWIr+ZVr
        54uXe+kkRkbOx0lVIFMlN/0Vdtv6U5zEVcMHCnc=
X-Google-Smtp-Source: ADFU+vtRC8LeiEKpj+k2mKLQ0pmXFHNR7wTfcHTUGrxFaLczWpylo9qeN63FCf2joLyGJrDrt/Jrju/Zs/E9NzKJKug=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr4602504lji.148.1583833286522;
 Tue, 10 Mar 2020 02:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
 <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com> <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
In-Reply-To: <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Tue, 10 Mar 2020 17:41:14 +0800
Message-ID: <CA+H2tpEzFAbfzMuUGMfW3BqCKv2+kk+cLL5gWpR-zJZFYwWKqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: change ARCH_SPRD Kconfig to tristate
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Geert,

On Mon, Mar 9, 2020 at 6:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Chunyan,
>
> On Mon, Mar 9, 2020 at 9:32 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > On Mon, 9 Mar 2020 at 16:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Mar 5, 2020 at 11:33 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > The default value of Kconfig for almost all sprd drivers are the same with
> > > > ARCH_SPRD, making these drivers built as modules as default would be easier
> > > > if we can set ARCH_SPRD as 'm', so this patch change ARCH_SPRD to tristate.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > Can you actually boot a kernel on a Spreadtrum platform when all platform
> > > and driver support is modular?
> >
> > Yes, even if all drivers are modular.
>
> Cool. No hard dependencies on e.g. regulators that are turned off when
> unused?
>
> > But I hope serial can be builtin, then I can have a console to see
> > kernel output before loading modules.
>
> No dependency on the clock driver?
> Oh, I see you have a hack in the serial driver, to assume default
> values when the serial port's parent clock is not found.  That may
> limit use of the other serial ports, depending on the actual serial
> hardware.

There is an function named "sprd_uart_is_console()" in the driver
code. So the hack could be only applied when the
port is identified as console. And other ports might return
PROBE_DEFER until the clock is ready.

Could it work out of the limitation?

-Orson

> And on Sharkl64, the serial port's clock is a fixed-clock anyway, so
> you don't even need the hack.
>
> But in general you cannot rely on that, especially if your SoC has clock
> and/or power domains.
>
> BTW, what about the watchdog driver? That one does need a clock, and
> loading it too late will reboot your system.
>
> > Also, this's what Google GKI [1] asked :)
> >
> > Regards,
> > Chunyan
> >
> > [1] https://arstechnica.com/gadgets/2019/11/google-outlines-plans-for-mainline-linux-kernel-support-in-android/
>
> Let's see how having everything modular works out on an SoC where all
> hardware is part of a clock and power domain.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
