Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28191C5519F
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5DA208C3
	for <linux-serial@archiver.kernel.org>; Wed, 25 Nov 2020 08:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WhO7O8h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgKYIWS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:22:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgKYIWS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Nov 2020 03:22:18 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772B520872;
        Wed, 25 Nov 2020 08:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606292522;
        bh=c31BDmTLEV4FMcug5uxV48YAVVL4Rj6QheMRDc0/HuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WhO7O8h3fGqlCou/wbB1RU5jLXJz4XvcYGvFCy6unPng05okq3DVQdc8uCthFuv84
         upBtYUGjlenOvkkY2lARSmJ3Z/7pS6owS8Lo8PZN+1FpIqIx7y/d7VDwYunJahi6gv
         Iudo+6ErqhkqakbyoP04eMf6/FKSMdVAdou+KvN4=
Date:   Wed, 25 Nov 2020 09:23:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] tty: serial: bcm63xx: allow building on ARM64
Message-ID: <X74Uanu26sx4Hait@kroah.com>
References: <20201125081352.25409-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125081352.25409-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 25, 2020 at 09:13:52AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Hardware supported by bcm63xx is also used by BCM4908 SoCs family that
> is ARM64.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  drivers/tty/serial/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 28f22e58639c..6907c5b17a0e 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1133,7 +1133,8 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>  	tristate "Broadcom BCM63xx/BCM33xx UART support"
>  	select SERIAL_CORE
> -	depends on MIPS || ARM || COMPILE_TEST
> +	depends on MIPS || ARM || ARM64 || COMPILE_TEST

Why do we have an arch dependancy at all now?

> +	default ARCH_BCM4908

Really?  I thought we were getting rid of these "ARCH_platform_type" of
things.  That's what a defconfig file is for, right?

thanks,

greg k-h
