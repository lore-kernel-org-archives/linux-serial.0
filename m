Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD95C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816EC610E8
	for <linux-serial@archiver.kernel.org>; Thu, 14 Oct 2021 07:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJNHgC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhJNHgB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 14 Oct 2021 03:36:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1343060FDC;
        Thu, 14 Oct 2021 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634196837;
        bh=QbjVSs/mkuyafinqV5pNkJQdyxstX9GyrlCUWDfWOeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NynReL35KJPfJtBA5kY1TlgyQ7SoQssYd/JBPzSP2gPozZEKtjv6xtBMKNtDuMNCK
         TZHrOVoKt9MKZGpnl/Dqhdd67d9IvSTmsTNXMswiCmOW6OkKtgmpywO9Al8bgv50Vx
         el5OnsseoT6aFmG9i4oLNENppcMvyc0n3hRAR0pU=
Date:   Thu, 14 Oct 2021 09:33:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: imx: fix crash when un/re-binding console
Message-ID: <YWfdY/ws353nJEiE@kroah.com>
References: <20211014071053.568598-1-francesco.dolcini@toradex.com>
 <20211014071053.568598-2-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014071053.568598-2-francesco.dolcini@toradex.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Oct 14, 2021 at 09:10:52AM +0200, Francesco Dolcini wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> If the device used as a serial console gets un/re-binded, then
> register_console() will call imx_uart_setup_console() again.
> Drop __init so that imx_uart_setup_console() can be safely called
> at runtime.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/tty/serial/imx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What commit does this "fix"?  Should this go to stable kernels?  If so,
how far back?

> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 8b121cd869e9..51a9f9423b1a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2017,7 +2017,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
>   * If the port was already initialised (eg, by a boot loader),
>   * try to determine the current setup.
>   */
> -static void __init
> +static void
>  imx_uart_console_get_options(struct imx_port *sport, int *baud,
>  			     int *parity, int *bits)
>  {
> @@ -2076,7 +2076,7 @@ imx_uart_console_get_options(struct imx_port *sport, int *baud,
>  	}
>  }
>  
> -static int __init
> +static int
>  imx_uart_console_setup(struct console *co, char *options)

Why didn't we get a build warning about this section being called by
code that was not thrown away?  That feels odd...

thanks,

greg k-h
