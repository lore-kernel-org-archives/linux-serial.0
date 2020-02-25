Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D762EC35DFC
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73AD24656
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgBYIwx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:52:53 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33943 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBYIwu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 03:52:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so11815544oig.1;
        Tue, 25 Feb 2020 00:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCcXPgvLR7piGFPRQkQUMaxV6B+dhlZh7qpZmokhosQ=;
        b=WWLYOKo6b6/sElVaLhoomClIWzW2SQkNPXSxN1oHRYPdoivfgL4ax4weSL8/KmD/Hi
         D5lICtQqOeQEXCJjJumqkqPgoBOOOWvrw/ReXODG5RwT3vZHPMHOj7p7uMRKmEhtApCd
         9J/0RUDL0SruV1JKuvtBOKEciggN9aoY0N/FiOgY0gMQmVjaPpNeU8TNiWqfSRZs19bu
         cj5AMqRoe0ZT08POHggndekY0bpXPgZVGwx3Qf5DB33hkckld25EAw2pZQfxjuxu+etV
         408g/dhk0gS4AgRBv1kvH5G3f56VtUqzbPfM2pMK7V5F4N2GtfjqLU8MfQtk20YFbpoC
         Yb8Q==
X-Gm-Message-State: APjAAAUVqAnF0c9NnkoxQbtqSR7dTwjHFU4Q8XsiqtlCbmBwm6lszGth
        8OEfRrPEDJBBmhCzvOiSOeJfuNpxaoKxVTeueh9+1g==
X-Google-Smtp-Source: APXvYqz7lmhUeSfLmWKkIYk5sXq/O3b4LGrwEfCtT6NjjC+E5sVm0CRMbzawuf071lueIUP7GDqOPvgv08/U/Hcn99E=
X-Received: by 2002:aca:52d0:: with SMTP id g199mr2443241oib.153.1582620769070;
 Tue, 25 Feb 2020 00:52:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc@eucas1p2.samsung.com>
 <20200220102628.3371996-1-gregkh@linuxfoundation.org> <b04ad319-9986-c357-ad37-937bbb06bc02@samsung.com>
In-Reply-To: <b04ad319-9986-c357-ad37-937bbb06bc02@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Feb 2020 09:52:38 +0100
Message-ID: <CAMuHMdXzPPNqQom82frY1B6LMre+VD9fPAf98BZ3eo2DhgwoYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: build it for any platform
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Donghoon Yu <hoony.yu@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Hyunki Koo <kkoos00@naver.com>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Feb 20, 2020 at 1:13 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On 2/20/20 11:26 AM, Greg Kroah-Hartman wrote:
> > There is no need to tie this driver to only a specific SoC, or compile
> > test, so remove that dependancy from the Kconfig rules.
>
> samsung_tty driver is hardware specific driver so why should we
> build it for any platform?
>
> This change seems to defeat the whole purpose behind COMPILE_TEST
> config option (which allows us to build hardware-specific drivers
> without needlessly presenting the user with tons of non-relevant
> config options).
>
> Please explain this change some more, are you planing to remove
> COMPILE_TEST config option?

+1

I was just going to send a revert...

> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -237,7 +237,6 @@ config SERIAL_CLPS711X_CONSOLE
> >
> >  config SERIAL_SAMSUNG
> >       tristate "Samsung SoC serial support"
> > -     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> >       select SERIAL_CORE
> >       help
> >         Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> >
> > base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
