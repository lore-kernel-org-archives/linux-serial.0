Return-Path: <SRS0=J/Eu=AI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA74C433DF
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 14:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5EF21883
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593267803;
	bh=z+LI4rDwcqdPllTBWP3ve1Yz1MaJfOlnanpyQgYW/k4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KWzJJJjXoq2v+zD66COIA1haegT0NPt2URlghLPTStubdjTw9eGQzS2M/h+wnpF4E
	 LK4vwAEOyiqexjDNAhQdWF9N140o2dRtk/+kGo0X5yWqD1DE5lTVDVgRlHXOLnqRDa
	 QGE0TyIbISqOIUKfOHdindHptIJSyoDRTNlSpcRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgF0OXX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Jun 2020 10:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0OXW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jun 2020 10:23:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F38320672;
        Sat, 27 Jun 2020 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593267801;
        bh=z+LI4rDwcqdPllTBWP3ve1Yz1MaJfOlnanpyQgYW/k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFVJfwSjRJyhEigz/7AFA+Ob7mOkqMvCoTPKZrOJ7UsG+Dy2kZqHjsqylmNuTOor8
         X7+7bmps7/9K6vRNJik2XzGaqiBfUb7c5cSh2tfuJtC7RBUffBozSV5ckCqLl4UXNa
         L3dUIBhpviOzJwbGDQuW6pQ+0flXGXeoHJe+bwWo=
Date:   Sat, 27 Jun 2020 16:23:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fugang Duan <fugang.duan@nxp.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        lukas@wunner.de, jslaby@suse.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH tty/serial 1/1] tty: serial: imx: enable imx serial
 console port as module
Message-ID: <20200627142315.GA1959761@kroah.com>
References: <20200605084321.26255-1-fugang.duan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605084321.26255-1-fugang.duan@nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 05, 2020 at 04:43:21PM +0800, Fugang Duan wrote:
> GKI kernel requires drivers built as modules including
> console driver, so add the support that imx serial console
> driver can be built as module.
> 
> The changes of the patch:
> - imx console driver can be built as module.
> - move out earlycon code to separated driver like imx_earlycon.c,
>   and imx earlycon driver only support build-in.
> 
> Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> ---
>  drivers/tty/serial/Kconfig        | 17 +++++++----
>  drivers/tty/serial/Makefile       |  1 +
>  drivers/tty/serial/imx.c          | 37 ++---------------------
>  drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..890cbf214561 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -502,20 +502,27 @@ config SERIAL_IMX
>  	  can enable its onboard serial port by enabling this option.
>  
>  config SERIAL_IMX_CONSOLE
> -	bool "Console on IMX serial port"
> -	depends on SERIAL_IMX=y
> +	tristate "Console on IMX serial port"
> +	depends on SERIAL_IMX
>  	select SERIAL_CORE_CONSOLE
> -	select SERIAL_EARLYCON if OF
>  	help
>  	  If you have enabled the serial port on the Freescale IMX
> -	  CPU you can make it the console by answering Y to this option.
> +	  CPU you can make it the console by answering Y/M to this option.
>  
> -	  Even if you say Y here, the currently visible virtual console
> +	  Even if you say Y/M here, the currently visible virtual console
>  	  (/dev/tty0) will still be used as the system console by default, but
>  	  you can alter that using a kernel command line option such as
>  	  "console=ttymxc0". (Try "man bootparam" or see the documentation of
>  	  your bootloader about how to pass options to the kernel at boot time.)
>  
> +config SERIAL_IMX_EARLYCON
> +	bool "Earlycon on IMX serial port"
> +	depends OF
> +	select SERIAL_EARLYCON if OF
> +	help
> +	  If you have enabled the earlycon on the Freescale IMX
> +	  CPU you can make it the earlycon by answering Y to this option.
> +

Did you test this?

I get the folllowing errors with this patch:
	scripts/kconfig/conf  --oldconfig Kconfig
	drivers/tty/serial/Kconfig:521: syntax error
	drivers/tty/serial/Kconfig:520: invalid statement
	drivers/tty/serial/Kconfig:521: invalid statement
	drivers/tty/serial/Kconfig:522: invalid statement
	drivers/tty/serial/Kconfig:523: unknown statement "If"
	drivers/tty/serial/Kconfig:524:warning: ignoring unsupported character '.'
	drivers/tty/serial/Kconfig:524: unknown statement "CPU"
	make[1]: *** [scripts/kconfig/Makefile:71: oldconfig] Error 1
	make: *** [Makefile:606: oldconfig] Error 2

I'll let you make the obvious fix and actually test it this time before
resending :)

thanks,

greg k-h
