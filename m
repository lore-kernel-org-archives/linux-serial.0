Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE1C10F25
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8584320848
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 12:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583497753;
	bh=d17V1gYzsp+fRg5i888PyT+fPs0MnH0tdgO0t6VHh5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x4xsoKGCGj72kJbc1jizckrsIzwurVtNG+ZYqAf1qXdd6Q5X75+sEWyUla8vmhj2X
	 FcfpPAQq8Npc8zMViyiRxwDQlNEIOlM5B1zfivMN/HWlXhHehWmgCLmHDp8pky3uaA
	 PhwAv7dtG2sG2FYS44kj1ZVpTOvEN+O91jCC2N2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFM3M (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:29:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCFM3M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 07:29:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAB152072A;
        Fri,  6 Mar 2020 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583497752;
        bh=d17V1gYzsp+fRg5i888PyT+fPs0MnH0tdgO0t6VHh5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8BQ8YdbCK8NYU8ae8N+ekQAjgvaSQzA7GVKOg+FTl8RTt2VhDRHXrOS8WVRJe5Qs
         VKqUVw49sgIRfZ+yXYduMabcWYcoW/+Z16RanU9qF4gjAdeZ9POw8jLj/Nyaw+lLN1
         d+jW+ooS7YNAzqqMGQgAS8GB1DZJ+4fEGz9EpTWY=
Date:   Fri, 6 Mar 2020 11:36:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any
 platform"
Message-ID: <20200306103652.GA3634389@kroah.com>
References: <20200306102301.16870-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306102301.16870-1-geert+renesas@glider.be>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 06, 2020 at 11:23:01AM +0100, Geert Uytterhoeven wrote:
> This reverts commit 175b558d0efb8b4f33aa7bd2c1b5389b912d3019.
> 
> When the user configures a kernel without support for Samsung SoCs, it
> makes no sense to ask the user about enabling "Samsung SoC serial
> support", as Samsung serial ports can only be found on Samsung SoCs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 880b962015302dca..932ad51099deae7d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -237,6 +237,7 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> +	depends on PLAT_SAMSUNG || ARCH_EXYNOS || COMPILE_TEST
>  	select SERIAL_CORE
>  	help
>  	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,

{sigh}

No, I don't want this.  My "goal" is to be able to get rid of all of the
crazy "PLAT_*" symbols as they make it impossible to build a single
kernel that supports multiple ARM64 systems.

As an example of just such a system, see the 5.4 tree here:
	https://android.googlesource.com/kernel/common/+/refs/heads/android-5.4
it is now building and booting on multiple SoCs.

But yes, it still does have to enable some PLAT_* config options, but
the goal is to not have to do that eventually.

There is no reason that we need vendor-specific config options just to
lump random drivers into, like serial drivers.  If the hardware is not
present, the driver will just not bind to the hardware, and all is fine.

Just like x86, we don't have this issue there, and ARM64 should also not
have this.

Sorry for delay in writing this back to the original thread where you
objected to the original patch, it's still in my review queue along with
a ton of other serial patches.

thanks,

greg k-h
