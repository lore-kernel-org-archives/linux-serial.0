Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C1CC2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F060461429
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 09:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFYJir (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 05:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhFYJir (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 05:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A35F561423;
        Fri, 25 Jun 2021 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624613787;
        bh=wZOr5b14kHcOzUT7JGKqLRQEjceB0LQHwm17YN7iF+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1FjTw1gyqm/UCABSL5L+juPKwm2ppL3RCo8ra3glYaTLOCZeEIYAh2ju2OPDFM2G
         JaiqC8GGG+I9hVZDIxFEIe6mXNP+llmpI5k3EuEvNZoyZnrqTfgb73FamweLijtSYw
         6EYedtQ/1kaLYzynOjmt9YhSx3/J1ewLG2y3YysQ=
Date:   Fri, 25 Jun 2021 11:36:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-serial@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com, edward.lee@sunix.com
Subject: Re: [PATCH] SUNIX SDC serial port driver
Message-ID: <YNWjmA9nAVhsDO0g@kroah.com>
References: <20210625092916.12502-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625092916.12502-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 25, 2021 at 05:29:16PM +0800, Moriis Ku wrote:
> From: Morris Ku <saumah@gmail.com>
> 
> Add support for SUNIX SDC serial port
> 
> Cc: Jason Lee <jason_lee@sunix.com>
> Cc: Taian Chen <taian.chen@sunix.com>
> Cc: Morris Ku <morris_ku@sunix.com>
> Cc: Edward Lee <Edward.lee@sunix.com>
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index a8bfb65..4dbe94c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -39,5 +39,7 @@ obj-$(CONFIG_SERIAL_8250_MID)		+= 8250_mid.o
>  obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
>  obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
>  obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
> +obj-$(CONFIG_SERIAL_8250_SDC)		+= 8250_sdc.o
> +obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o

Why did you add this last line again?

And you sent multiple emails with identical subject lines, yet they did
totally different things.

Please fix up and properly send a patch series that is numbered as is
documented.

thanks,

greg k-h
