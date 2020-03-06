Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46051C10F26
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB37208C3
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583498178;
	bh=rzOWClmTA9ckPlsQ5/4LHXWBmd4wP2fGMrRZpfa0lko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ohWrp5HnOJouw4mp8D35fKqXXlo+7g3D53uwq1pkgAXlG8JAliwRO9DCuRChsFWMI
	 AHXcI1anlk7z/ZpmV9goMP267njUNldTaQ5/vDB+P9rG3T8NYMawENs7fSp5xSUVwd
	 4uq2QjnSmeKc++e0EmSJ6Vc7m7WclCZQfT6mYoTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFMgR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:36:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgCFMgR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 07:36:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63DB52072A;
        Fri,  6 Mar 2020 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583498176;
        bh=rzOWClmTA9ckPlsQ5/4LHXWBmd4wP2fGMrRZpfa0lko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CYR820gNYO/xKXhALVF1nw6ps0ddLTtE4nNt6uoXwN3Fhu6z388kjc6WWSWZYwRnW
         uOvMhdXYbE6u0DHP5X/7v5OFHLJrtbNjpTa/vceuGGfC6HEb5t3QKHfzgghVGaF8iK
         /aO9yZFhaeK6u2hqrb/bc+Wo8/twIt+NXnxjVzMg=
Date:   Fri, 6 Mar 2020 13:32:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any
 platform"
Message-ID: <20200306123227.GA3689963@kroah.com>
References: <20200306102301.16870-1-geert+renesas@glider.be>
 <20200306103652.GA3634389@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306103652.GA3634389@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 06, 2020 at 11:36:52AM +0100, Greg Kroah-Hartman wrote:
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
> >  	tristate "Samsung SoC serial support"
> > +	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
> >  	select SERIAL_CORE
> >  	help
> >  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
> 
> {sigh}
> 
> No, I don't want this.  My "goal" is to be able to get rid of all of the
> crazy "PLAT_*" symbols as they make it impossible to build a single
> kernel that supports multiple ARM64 systems.
> 
> As an example of just such a system, see the 5.4 tree here:
> 	https://android.googlesource.com/kernel/common/+/refs/heads/android-5.4
> it is now building and booting on multiple SoCs.
> 
> But yes, it still does have to enable some PLAT_* config options, but
> the goal is to not have to do that eventually.
> 
> There is no reason that we need vendor-specific config options just to
> lump random drivers into, like serial drivers.  If the hardware is not
> present, the driver will just not bind to the hardware, and all is fine.
> 
> Just like x86, we don't have this issue there, and ARM64 should also not
> have this.
> 
> Sorry for delay in writing this back to the original thread where you
> objected to the original patch, it's still in my review queue along with
> a ton of other serial patches.

Here's another good example of this happening, it's not just me working
toward this goal:
	https://lore.kernel.org/lkml/20200305103228.9686-2-zhang.lyra@gmail.com/
