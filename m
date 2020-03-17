Return-Path: <SRS0=6uIZ=5C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB08C10F29
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DC820752
	for <linux-serial@archiver.kernel.org>; Tue, 17 Mar 2020 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584455100;
	bh=C+AKJMmNIOocGHrWI82rVJ/uLijcqWjxmUwAQWgQXsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YMqfhsllJEnVN922Aba5djJqehXzOLBJgN2hisq2rJL3fiMHMYdDGO1jNhYnFYpGG
	 DX4jDeSEYdw6NZbqpmn2yadM3exiUeM7hvQtaL7vUYVH5Rylogtriqp7hYHs/7eUIo
	 4g9YE+4Zauc2C8jjFzNe6Iw0VDSpmeaD62kvumVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgCQOY7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgCQOY7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 17 Mar 2020 10:24:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C9B20714;
        Tue, 17 Mar 2020 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584455099;
        bh=C+AKJMmNIOocGHrWI82rVJ/uLijcqWjxmUwAQWgQXsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkuH2+AJVm0PYaV0xFguzu5XRYGkMuefz9EXYjBydnSVQ2JIGw/sN26yP170tbrlB
         TSFZmJPcb1e+rlUlGHJOpru+TZGwHAwCTBq2V+gvMgglXMMcPDa5WKeQLC4aWfMy/P
         o/HSL4xa9KL0JRZYv9jUlZ+LypO2O8u+/n+EwmX8=
Date:   Tue, 17 Mar 2020 15:22:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jiri Slaby <jslaby@suse.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] Revert "tty: serial: samsung_tty: build it for any
 platform"
Message-ID: <20200317142206.GA1391636@kroah.com>
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
> -- 
> 2.17.1
> 

Ok, I really don't like the PLAT_* stuff, but I'll go apply this now and
push to remove that instead...

thanks,

greg k-h
