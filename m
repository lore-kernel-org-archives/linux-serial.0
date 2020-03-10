Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE6BC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 10:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D4220637
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 10:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8ZD6JIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCJKOH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:14:07 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40729 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgCJKOH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 06:14:07 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so5821494lfe.7;
        Tue, 10 Mar 2020 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H41EK6fFWsu7lc3SctFKC6jvmteBRlGuxbpCpld6vno=;
        b=g8ZD6JIS5Nbi5VQkoVKI9M/R0asumknvg+5tJnMpLTrwLqopBa459G+Q/XQzcwPv1A
         dnFXMhqtT5oJqRaM0Kwk034c0qEj7/G4f0UyF3vC+FunNgutepJnWbUIIsGWNMpGPrij
         jCA2K6vv24K2GdNo8Kj6muOUhaj5wLjo7+xZTE36a18WvipB2aBXdQTWg0csU9DCnIdr
         zMRrnaF4sdNWdxAyrCOzLDh60CE54BVAevIoJBTwsg102Mg3I3iWoDVg8tiNJ8LskBgt
         3Uik+QIPptsu2Tb68aLInTso3Nwoo+3e8nPPA+WZWFbBl4GCkwQ4O6CZhst/1TtrprRx
         aaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H41EK6fFWsu7lc3SctFKC6jvmteBRlGuxbpCpld6vno=;
        b=hWR5rykeIlqbSGtI2aeckCYNP3m4mdHHaCugsc7Zle8BbfH6WG/bL+EgPgdmMBSmRY
         UOL8UfnYyUi7G8+3hM4topFjO6EF6seuJVwXGpDDuQMk3NjZpm+6PLAzJ5ch9nVfgx4z
         BKSYiZIfRfdj5Ri++KZJD+9bgn4PfufS44lUXLiR+a9KgKMPXJhBWJsowxddkuWk6YD+
         Pw65yTaDBBVBzPTXtDp2C3Qv4sKIjVHDF8DZZWfWIbfysVW28AbeXEmad8n3Tt1Dcalw
         KPWqWD/tbRGf6n2DKKqzqDF3QW1Ivch7TF/NaP0i08QdNzuHWAyMezgPmx+jK0MkJm3e
         LXNA==
X-Gm-Message-State: ANhLgQ0jRLhnM1E9H+szgp4wURDOQmJOF22mnIOQ1m58Motg3sWgTEnQ
        kBF2VIZ/DU6b5lmvq+sNXZvEOHoHCiQNHZGnCWU=
X-Google-Smtp-Source: ADFU+vsQgLEAeKs3QBpJxub3atlz11c+n+Pl9FnwgZlDHA1wgeUPgTtZl/KRIlugnXJikY9VrxzECcYh0hftZrqU0oQ=
X-Received: by 2002:a19:f615:: with SMTP id x21mr325697lfe.47.1583835244537;
 Tue, 10 Mar 2020 03:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200305103228.9686-1-zhang.lyra@gmail.com> <CAMuHMdVyy3v24zBxJFe5hYdnzdj80dvE2Z9GO4=AC1N8fD64pw@mail.gmail.com>
 <CAAfSe-spu2oNmfEYt+WQvRQy1bCC0e1MFjbUyBAFzghd5XNBfw@mail.gmail.com>
 <CAMuHMdV1qQZF-kAwbcxhHQZZ9hs0dG-OTZ2NcB25Jtra6ii5iA@mail.gmail.com>
 <CA+H2tpEzFAbfzMuUGMfW3BqCKv2+kk+cLL5gWpR-zJZFYwWKqw@mail.gmail.com> <CAMuHMdUKD5Ob_o4E3bH9wx=6r2PU+7U3RQ_GVRj7ZQc-e5Y4TA@mail.gmail.com>
In-Reply-To: <CAMuHMdUKD5Ob_o4E3bH9wx=6r2PU+7U3RQ_GVRj7ZQc-e5Y4TA@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Tue, 10 Mar 2020 18:13:51 +0800
Message-ID: <CA+H2tpFaEp0Wbna=Z-A0bnno5hymVrSDE-397-Jdp6Uqsm0+qQ@mail.gmail.com>
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

On Tue, Mar 10, 2020 at 5:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Orson,
>
> On Tue, Mar 10, 2020 at 10:41 AM Orson Zhai <orsonzhai@gmail.com> wrote:
> > On Mon, Mar 9, 2020 at 6:32 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
> >
> > There is an function named "sprd_uart_is_console()" in the driver
> > code. So the hack could be only applied when the
> > port is identified as console. And other ports might return
> > PROBE_DEFER until the clock is ready.
> >
> > Could it work out of the limitation?
>
> Yes, that could work.  You also have only a single SPRD_DEFAULT_SOURCE_CLK,
> which makes it simple to handle.
> For other SoCs, there may be a variation of possible values, depending on
> SoC and/or board.

Ok, thanks.

-Orson

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
