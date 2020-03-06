Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8538DC10F25
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6892D20848
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 13:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFNVx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:21:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32938 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFNVw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 08:21:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so2525238oig.0;
        Fri, 06 Mar 2020 05:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4egTRk5WwAGOwPzaFlwylsTR4rm7/1ScQ/ZrAguvL58=;
        b=dGTR07CzdMlz4N/fXZgZUcbYfJFslijVR3UBFZ5IuGg0zE1l7K1zWQDY9HzJMVzoYa
         SoJBdPZFRQusKgYayrXpRMHaQqN4Ct+t0RVbb7fDiKvxnCfBYQcWX6GIYlbJeQaaD5NS
         oYY+wG9E4szG8AZpiQNNs7M3gYQJnxzA/lOUnzfyZZONsqJXZHI3FZRqj1COmv8KL498
         ju8mg3g9Qc9vw+YUbt0ftKU2il2rY1rFvgKeVBmKXtCfxx/pyyn9FeeoQubPTZIl9voz
         G0VOdlAiNZFeYve/+Jm1CRpr6xS/Y2tBtQPXNdFYzC4vaErhtyFdIeDmZ2g42ADOLzNF
         WDzA==
X-Gm-Message-State: ANhLgQ1yNmWGIfwuOs1nCsvgkI7mHHEY1O0d1OJCYflFwxEwKYjn/1ye
        GLXptGUVPcXXgkZRWkoN3z5RqhtWGWjnekiaKyEJyumT
X-Google-Smtp-Source: ADFU+vuZGLbnXTkhnQ8s6R8V7TRANbM+nGIn9F+2NHhqp1uQsKc1JP5svk0aPchpJM5g7mjfwjbhOSkCrkhgeWl/B5g=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr2446348oif.131.1583500911215;
 Fri, 06 Mar 2020 05:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20200306102301.16870-1-geert+renesas@glider.be>
 <20200306103652.GA3634389@kroah.com> <CAMuHMdUy8RjkY+0gBv-=mpcuamNQgB=k4rvNsiaj2s4uUDc5UA@mail.gmail.com>
 <20200306130314.GA3778623@kroah.com>
In-Reply-To: <20200306130314.GA3778623@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Mar 2020 14:21:40 +0100
Message-ID: <CAMuHMdUD1=qcG8NSYYnWZ0bLUBp0ys2ZQ=KqnxUKFb4gntBfJw@mail.gmail.com>
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

On Fri, Mar 6, 2020 at 2:03 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Mar 06, 2020 at 01:53:01PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Mar 6, 2020 at 1:29 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Fri, Mar 06, 2020 at 11:23:01AM +0100, Geert Uytterhoeven wrote:
> > > > This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
> > > >
> > > > When the user configures a kernel without support for Samsung SoCs, it
> > > > makes no sense to ask the user about enabling "Samsung SoC serial
> > > > support", as Samsung serial ports can only be found on Samsung SoCs.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  drivers/tty/serial/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > > index 880b962015302dca..932ad51099deae7d 100644
> > > > --- a/drivers/tty/serial/Kconfig
> > > > +++ b/drivers/tty/serial/Kconfig
> > > > @@ -237,6 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
> > > >
> > > >  config SERIAL_SAMSUNG
> > > >       tristate "Samsung SoC serial support"
> > > > +     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> > > >       select SERIAL_CORE
> > > >       help
> > > >         Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> > >
> > > {sigh}
> >
> > Exactly my feeling.
> >
> > > No, I don't want this.  My "goal" is to be able to get rid of all of the
> > > crazy "PLAT_*" symbols as they make it impossible to build a single
> > > kernel that supports multiple ARM64 systems.
> >
> > This dependency does not make it impossible to build a single
> > kernel that supports multiple ARM64 systems.
> >
> > Those "PLAT_*" symbols are not crazy.  They are needed to configure a
> > kernel for your specific hardware, leaving out support you don't need.
> > Not everyone has the hardware resources to run an allyesconfig kernel.
> >
> > > As an example of just such a system, see the 5.4 tree here:
> > >         https://android.googlesource.com/kernel/common/+/refs/heads/android-5.4
> > > it is now building and booting on multiple SoCs.
> >
> > arm/multi_v7_defconfig and arm64/defconfig kernels are already booting
> > on multiple SoCs in upstream, and have done so for years.
> >
> > > But yes, it still does have to enable some PLAT_* config options, but
> > > the goal is to not have to do that eventually.
> >
> > Whether the dependency is present or not does not change this.
> >
> > > There is no reason that we need vendor-specific config options just to
> > > lump random drivers into, like serial drivers.  If the hardware is not
> > > present, the driver will just not bind to the hardware, and all is fine.
> >
> > Not having the dependency means you will ask the user useless questions
> > when configuring his kernel.
> > My goal is to make kernel configuration easier, not more difficult.
> >
> > > Just like x86, we don't have this issue there, and ARM64 should also not
> > > have this.
> >
> > No, because x86 is considered the golden standard ;-)
> >
> > Dropping those dependencies is similar to always having a simple PCI
> > core without any host PCI bridges, dropping "depends on PCI" from all
> > PCI drivers, and building an all*config kernel for your old i386 that
> > predates PCI (you can replace PCI by ACPI to modernize the example).
> >
> > What am I missing?!?
>
> "depends on PCI" describes the hardware bus that a driver depends on.

Yes.

> PLAT_FOO is just trying to somehow classify that this type of driver
> only shows up on this vendor's devices.  It is not defining the hardware
> at all.  We try to always describe functionality of hardware, not try to
> declare specific vendor's hardware choices, right?

DT-based drivers do not bind to a hardware-specific bus, and thus there
is no config symbol for a hardware-specific bus they can depend on.
Still, there are hardware classes, based on SoC vendors and SoC families.
Hence PLAT_FOO describes the latter.

> PLAT_FOO is interesting, but given that a specific driver is really not
> tied to that platform logically, only by virtue that no one else might
> not happen to have that hardware, it seems odd to have that.

There exist IP cores that are present on either PCI and non-PCI hardware.
With hardware-specific bus drivers, drivers for these need to implement
both a pci_driver and <some_other>_driver.  And they depend on PCI
|| <OTHER>.
With DT and ACPI, and device properties, a single platform_driver
needs to be written, just the matching is done differently. And there is
no "hard" (no "else the driver doesn't link") need for a hardware-specific
config-symbol dependency.  But it's still good to have one.

> Yes, asking lots of questions is tough, but we passed that problem so
> long ago.  Are we now trying to add PLAT_FOO entries to all hardware
> drivers in order to make this type of selection easier?  I thought we
> were just doing that by providing defconfig files to make the initial
> selection saner.

Defconfigs were the previous step, from an evolutionary point of view.
Arm64 has a single defconfig.  All dependencies must be expressed in
Kconfig.  I can take arm64/defconfig, remove support for other SoC families,
and I'll have a good kernel for my hardware, without bagage I don't need.
Without these dependencies, I have to remove lots and lots of drivers
I won't need.

If you want to compile drivers for hardware that cannot be present, use
COMPILE_TEST=y.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
