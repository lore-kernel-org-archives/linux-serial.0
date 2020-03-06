Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459C5C10F25
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 13:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABE121739
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583499798;
	bh=VVRxE1ypOJ8srcC7LLX0LtBXm0AbUPHOxVu5LaCMObg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IFdv00vzTn9JJiFG/spaXYHDObQ9MP0rfBDIBNypdxCUtmOREoLUa4CTFiqbEP7+g
	 JuDLExy8zFtz8EJN/ir9AYAPFXRSTL8do+Aspyk1N835l4ek2+h46iDqUghQFeDxkK
	 rvEn5zozX+ZG1PQtowQMfbml7nt56Wj/ff+4SW5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgCFNDR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:03:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgCFNDR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 08:03:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23F672084E;
        Fri,  6 Mar 2020 13:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583499796;
        bh=VVRxE1ypOJ8srcC7LLX0LtBXm0AbUPHOxVu5LaCMObg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssvTYItgqsL/fFkrbDCYB6S6LfrpBM9vGaduHvfn1cPU8coIxOa44zazQtmjF1i8l
         Lkb76hnGVgoD20fqMVBRJNb6aDLsXkBG4S4vtQL5JPm9CbLbtpfbqw+2OEHsdSq0nn
         1c/zGsYmsjxMeuE747KynPODoMF6Ky/kEpPbhILs=
Date:   Fri, 6 Mar 2020 14:03:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any
 platform"
Message-ID: <20200306130314.GA3778623@kroah.com>
References: <20200306102301.16870-1-geert+renesas@glider.be>
 <20200306103652.GA3634389@kroah.com>
 <CAMuHMdUy8RjkY+0gBv-=mpcuamNQgB=k4rvNsiaj2s4uUDc5UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUy8RjkY+0gBv-=mpcuamNQgB=k4rvNsiaj2s4uUDc5UA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 06, 2020 at 01:53:01PM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, Mar 6, 2020 at 1:29 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Mar 06, 2020 at 11:23:01AM +0100, Geert Uytterhoeven wrote:
> > > This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
> > >
> > > When the user configures a kernel without support for Samsung SoCs, it
> > > makes no sense to ask the user about enabling "Samsung SoC serial
> > > support", as Samsung serial ports can only be found on Samsung SoCs.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/tty/serial/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > > index 880b962015302dca..932ad51099deae7d 100644
> > > --- a/drivers/tty/serial/Kconfig
> > > +++ b/drivers/tty/serial/Kconfig
> > > @@ -237,6 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
> > >
> > >  config SERIAL_SAMSUNG
> > >       tristate "Samsung SoC serial support"
> > > +     depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> > >       select SERIAL_CORE
> > >       help
> > >         Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> >
> > {sigh}
> 
> Exactly my feeling.
> 
> > No, I don't want this.  My "goal" is to be able to get rid of all of the
> > crazy "PLAT_*" symbols as they make it impossible to build a single
> > kernel that supports multiple ARM64 systems.
> 
> This dependency does not make it impossible to build a single
> kernel that supports multiple ARM64 systems.
> 
> Those "PLAT_*" symbols are not crazy.  They are needed to configure a
> kernel for your specific hardware, leaving out support you don't need.
> Not everyone has the hardware resources to run an allyesconfig kernel.
> 
> > As an example of just such a system, see the 5.4 tree here:
> >         https://android.googlesource.com/kernel/common/+/refs/heads/android-5.4
> > it is now building and booting on multiple SoCs.
> 
> arm/multi_v7_defconfig and arm64/defconfig kernels are already booting
> on multiple SoCs in upstream, and have done so for years.
> 
> > But yes, it still does have to enable some PLAT_* config options, but
> > the goal is to not have to do that eventually.
> 
> Whether the dependency is present or not does not change this.
> 
> > There is no reason that we need vendor-specific config options just to
> > lump random drivers into, like serial drivers.  If the hardware is not
> > present, the driver will just not bind to the hardware, and all is fine.
> 
> Not having the dependency means you will ask the user useless questions
> when configuring his kernel.
> My goal is to make kernel configuration easier, not more difficult.
> 
> > Just like x86, we don't have this issue there, and ARM64 should also not
> > have this.
> 
> No, because x86 is considered the golden standard ;-)
> 
> Dropping those dependencies is similar to always having a simple PCI
> core without any host PCI bridges, dropping "depends on PCI" from all
> PCI drivers, and building an all*config kernel for your old i386 that
> predates PCI (you can replace PCI by ACPI to modernize the example).
> 
> What am I missing?!?

"depends on PCI" describes the hardware bus that a driver depends on.

PLAT_FOO is just trying to somehow classify that this type of driver
only shows up on this vendor's devices.  It is not defining the hardware
at all.  We try to always describe functionality of hardware, not try to
declare specific vendor's hardware choices, right?

PLAT_FOO is interesting, but given that a specific driver is really not
tied to that platform logically, only by virtue that no one else might
not happen to have that hardware, it seems odd to have that.

Yes, asking lots of questions is tough, but we passed that problem so
long ago.  Are we now trying to add PLAT_FOO entries to all hardware
drivers in order to make this type of selection easier?  I thought we
were just doing that by providing defconfig files to make the initial
selection saner.

thanks,

greg k-h
