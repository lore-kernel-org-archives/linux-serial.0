Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DF3C10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18822072D
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFMxO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:53:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32965 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFMxO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 07:53:14 -0500
Received: by mail-ot1-f66.google.com with SMTP id a20so2316997otl.0;
        Fri, 06 Mar 2020 04:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G7RZH2grPPSlWaJy572edYfyzqPGtp/kF1gZJ/HJVnY=;
        b=XfffoSdJjhjl13OERyrEqfo1Vf9K02NbJ5beUbLOPg0u6Yr2tjbK7b7YTN3Lhlc2Ii
         Bd9X2oxq/QCJS4I8p2Jc3Ne0ERjPS07WjKK+HjWRGgLDhDZpFQu9TSt2nx7bBdWXYCwF
         07+1Jvfc4FHu/sZTrXYvzITfwRMbc6tafXa6hH0biRDLyWiOuZ4sJvzXKqW5qtAGqC3k
         Dp5kbR50xMXzDJkQDZJC2T7vtHZiQX4HTUHZv2VjPBoGJt2HDKlkQ8lzmRzAWrsCDcvD
         6DgtTQMXKI3AaD08yjBYFBMCf5s3uBcYmI2diUT2qV9lt/frAyt8miIUhlcmZR4Kj4yS
         YdtQ==
X-Gm-Message-State: ANhLgQ2PblgHrS4iqIwsbmDbZyVpflUPtz/YkWz91E6g17basNkpW4Ea
        SjB1ubVmzCMn1BZXLxCBRq6gVfc5uJlyEGXGiyA=
X-Google-Smtp-Source: ADFU+vtBe3n4eCaY3wCA3slX91+7Q6wMQ3w6HE+ed7K5oJu4l5pvpMtzDHSTNT6ag6PqX15dexQ8of2CrzSAuNyuxlU=
X-Received: by 2002:a9d:5c0c:: with SMTP id o12mr2327664otk.145.1583499193335;
 Fri, 06 Mar 2020 04:53:13 -0800 (PST)
MIME-Version: 1.0
References: <20200306102301.16870-1-geert+renesas@glider.be> <20200306103652.GA3634389@kroah.com>
In-Reply-To: <20200306103652.GA3634389@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Mar 2020 13:53:01 +0100
Message-ID: <CAMuHMdUy8RjkY+0gBv-=mpcuamNQgB=k4rvNsiaj2s4uUDc5UA@mail.gmail.com>
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any platform"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On Fri, Mar 6, 2020 at 1:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Mar 06, 2020 at 11:23:01AM +0100, Geert Uytterhoeven wrote:
> > This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
> >
> > When the user configures a kernel without support for Samsung SoCs, it
> > makes no sense to ask the user about enabling "Samsung SoC serial
> > support", as Samsung serial ports can only be found on Samsung SoCs.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  drivers/tty/serial/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 880b962015302dca..932ad51099deae7d 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -237,6 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
> >
> >  config SERIAL_SAMSUNG
> >       tristate "Samsung SoC serial support"
> > +     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> >       select SERIAL_CORE
> >       help
> >         Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
>
> {sigh}

Exactly my feeling.

> No, I don't want this.  My "goal" is to be able to get rid of all of the
> crazy "PLAT_*" symbols as they make it impossible to build a single
> kernel that supports multiple ARM64 systems.

This dependency does not make it impossible to build a single
kernel that supports multiple ARM64 systems.

Those "PLAT_*" symbols are not crazy.  They are needed to configure a
kernel for your specific hardware, leaving out support you don't need.
Not everyone has the hardware resources to run an allyesconfig kernel.

> As an example of just such a system, see the 5.4 tree here:
>         https://android.googlesource.com/kernel/common/+/refs/heads/android-5.4
> it is now building and booting on multiple SoCs.

arm/multi_v7_defconfig and arm64/defconfig kernels are already booting
on multiple SoCs in upstream, and have done so for years.

> But yes, it still does have to enable some PLAT_* config options, but
> the goal is to not have to do that eventually.

Whether the dependency is present or not does not change this.

> There is no reason that we need vendor-specific config options just to
> lump random drivers into, like serial drivers.  If the hardware is not
> present, the driver will just not bind to the hardware, and all is fine.

Not having the dependency means you will ask the user useless questions
when configuring his kernel.
My goal is to make kernel configuration easier, not more difficult.

> Just like x86, we don't have this issue there, and ARM64 should also not
> have this.

No, because x86 is considered the golden standard ;-)

Dropping those dependencies is similar to always having a simple PCI
core without any host PCI bridges, dropping "depends on PCI" from all
PCI drivers, and building an all*config kernel for your old i386 that
predates PCI (you can replace PCI by ACPI to modernize the example).

What am I missing?!?

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
