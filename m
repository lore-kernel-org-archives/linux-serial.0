Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6FEC35E0E
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 21:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4D5222C2
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 21:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBYVWX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:22:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40035 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYVWX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 16:22:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id i6so914928otr.7;
        Tue, 25 Feb 2020 13:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWg7LhjnlzN8qbXzmL1qgYcPfVtZZxDcF8WgDS4BNis=;
        b=Sdu4yJV+1EbZMFPIeO95TmzflBM0aVTB8HUeYi8qxFgIN7xEdqzPBYch018gM6I+sy
         eDxMypnJbK07khORYF/C7i29H15tfk2AIZC4//FQgKRc6/+hm8zNvDkhZEYeleK4mpgN
         ms9Ep2OE+RFMo+gNjmZPHcp6gl0lfIjV3k6ofvpGli37FK5TENOXz1RAkWBNXcdn6cXh
         GGKlOdGc0O2w86OVU9BXDSNE2yJZpKBiKh4Sl3WMwYV6KO5qjuIYxbiN+L8wx0CkqH+f
         jWKl66Mg9hL9hUq9CJcEqXUi9cSEitbTA+FGVTrVmzJtyAIWl5cUo1TF6g9E/Evzk+Kw
         3cUg==
X-Gm-Message-State: APjAAAVhRNPN+l7AC/9F6PsBsmCYfylQo6jUQxTe1yMfFO7KFw3xNcK/
        QxGErREBXb3B6Lo0U2jRhcPFmbHcF1267K16dm8=
X-Google-Smtp-Source: APXvYqxe+316UT/SCWiuy4sLEY7XWxPrYWUERMzqJz9VPqMqTetdKn7vGBnMQS3GJcbzUtVO/pJmDbNDP3BO9m3K+Bg=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr428811otk.145.1582665742600;
 Tue, 25 Feb 2020 13:22:22 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200220121333eucas1p26befa95831b44a793822b4f07b37d2cc@eucas1p2.samsung.com>
 <20200220102628.3371996-1-gregkh@linuxfoundation.org> <b04ad319-9986-c357-ad37-937bbb06bc02@samsung.com>
 <CAMuHMdXzPPNqQom82frY1B6LMre+VD9fPAf98BZ3eo2DhgwoYg@mail.gmail.com> <20200225204151.GA13254@kroah.com>
In-Reply-To: <20200225204151.GA13254@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Feb 2020 22:22:11 +0100
Message-ID: <CAMuHMdVrVe37JyUNFSf9KRZTcndrvDaZvrVoBxzm_7J2nhg1kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: serial: samsung_tty: build it for any platform
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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

Hi Greg,

On Tue, Feb 25, 2020 at 9:41 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 25, 2020 at 09:52:38AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 20, 2020 at 1:13 PM Bartlomiej Zolnierkiewicz
> > <b.zolnierkie@samsung.com> wrote:
> > > On 2/20/20 11:26 AM, Greg Kroah-Hartman wrote:
> > > > There is no need to tie this driver to only a specific SoC, or compile
> > > > test, so remove that dependancy from the Kconfig rules.
> > >
> > > samsung_tty driver is hardware specific driver so why should we
> > > build it for any platform?
>
> Why not?

Because this driver won't bind to a device anyway, when the kernel is
configured without Samsung SoC support.  It will just bloat the kernel,
and asking this question is a silly waste of time for anyone building a
(non-generic) kernel for a non-Samsung SoC.

> Seriously, this "only this one specific SoC is allowed to build this
> driver" is crazy.  It prevents anyone from building a generic kernel
> with drivers as a module which are loaded as needed.

A generic kernel will include Samsung SoC support, hence PLAT_SAMSUNG
or ARCH_EXYNOS will be enabled.

> That needs to be fixed, and removing this unneeded dependancy on this
> driver allows it to be build for any system and then only loaded when
> needed.

It can only be loaded on a Samsung system, which requires PLAT_SAMSUNG
or ARCH_EXYNOS anyway.
It's not like a Samsung serial device can be plugged into your PC's PCI
bus or so, it only exists on Samsung SoCs.

> > > This change seems to defeat the whole purpose behind COMPILE_TEST
> > > config option (which allows us to build hardware-specific drivers
> > > without needlessly presenting the user with tons of non-relevant
> > > config options).
> > >
> > > Please explain this change some more, are you planing to remove
> > > COMPILE_TEST config option?
>
> I want to get rid of this:

IMHO we need _more_ of these dependencies, to avoid all these silly questions
when they don't make sense.

> > > > -     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
>
> We should not need PLAT_SAMSUNG or ARCH_EXYNOS at all, we should be able
> to build an arm64 kernel for all platforms.

An arm64 kernel for all platforms will have ARCH_EXYNOS enabled.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
