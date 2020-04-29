Return-Path: <SRS0=H8bb=6N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D7BC83000
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B66208FE
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588181910;
	bh=wpTOYouiloF5faZNVYgumYgBYjyDmpGfSW9BOGjUSrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g1iO8iFn/rocdS9ugcb1XYPTc6hq9sfpZ50N6Kl2z3aqob1cxGHuj680RABouwltX
	 /Xzc9AeJVaPUlUqqFaWexnaWuBuIH3d1/dieUNftmYVZxG/vZvwjeAWbA8IjPbdYEn
	 x/znCJL13r25kXLuNxKackRRJrxyVjzARMuKckIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2Ria (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:38:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2Ria (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Apr 2020 13:38:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA0C20757;
        Wed, 29 Apr 2020 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588181908;
        bh=wpTOYouiloF5faZNVYgumYgBYjyDmpGfSW9BOGjUSrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jx9gG3By37E5E15S6w0nk1o/Plx5r1x39ORfxmLjMDjnmtXTb/uo6uuMyqrtYHYp6
         TvP34D2BIJp8+HNWdO5u2Ys4Hw+oswqkwAVrlLYVIhigVSk5aTKXgKimLOtzNe3fPM
         jxS5GjDHULgFW/eFnYDGk5aphDgO2b3qv7ku2Huc=
Date:   Wed, 29 Apr 2020 19:38:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Cc:     akashast@codeaurora.org, linux-serial@vger.kernel.org,
        saravanak@google.com, sspatil@google.com, tkjos@google.com
Subject: Re: [PATCH] serial: msm_geni_serial_console : Add Earlycon support
Message-ID: <20200429173826.GB2332435@kroah.com>
References: <20200429171934.17376-1-msavaliy@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429171934.17376-1-msavaliy@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 29, 2020 at 10:49:34PM +0530, Mukesh, Savaliya wrote:
> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> 
> This change enables earlyconsole support as static driver for geni
> based UART. Kernel space UART console driver will be generic for
> console and other usecases of UART.
> 
> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> ---
>  drivers/tty/serial/Kconfig                   |  15 +
>  drivers/tty/serial/Makefile                  |   1 +
>  drivers/tty/serial/msm_geni_serial_console.c | 525 +++++++++++++++++++
>  3 files changed, 541 insertions(+)
>  create mode 100644 drivers/tty/serial/msm_geni_serial_console.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 0aea76cd67ff..ded19d80e696 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -956,6 +956,21 @@ config SERIAL_MSM_CONSOLE
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  
> +config SERIAL_MSM_GENI_HALF_SAMPLING
> +	bool "Changes clock divider which impacts sampling rate for QUP HW ver greater than 2.5.0"
> +	help
> +	  Clock divider value should be doubled for QUP hardware version
> +	  greater than 2.5.0.

How do we know this?  Can't this be dynamically determined at runtime?
What about kernels that want to be built for both types of hardware at
the same time?

> +	  As earlycon can't have HW version awareness, decision is taken
> +	  based on the configuration.
> +
> +config SERIAL_MSM_GENI_EARLY_CONSOLE
> +	bool "MSM on-chip GENI HW based early console support"
> +	select SERIAL_MSM_GENI_HALF_SAMPLING
> +	help
> +	  Serial early console driver for Qualcomm Technologies Inc's GENI
> +	  based QUP hardware.

Why can't we have early console without SERIAL_MSM_GENI_HALF_SAMPLING?

Why are these tied directly to each other?  Do you really need 2
options?

> +
>  config SERIAL_QCOM_GENI
>  	tristate "QCOM on-chip GENI based serial port support"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index d056ee6cca33..9790ef2d802c 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
>  obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
>  obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
>  obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
> +obj-$(SERIAL_MSM_GENI_EARLY_CONSOLE) += msm_geni_serial_console.o

I don't think you tested this at all :(

I've stopped here in the review for this obvious reason...

thanks,

greg k-h
