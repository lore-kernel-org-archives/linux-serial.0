From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH] tty: serial: fix typo "ARCH_S5P6450"
Date: Mon, 11 Mar 2013 10:35:43 +0900
Message-ID: <04f801ce1df8$bf644ec0$3e2cec40$%kim@samsung.com>
References: <1362867404.3137.44.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41905 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab3CKBfp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Mar 2013 21:35:45 -0400
In-reply-to: <1362867404.3137.44.camel@x61.thuisdomein>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Paul Bolle' <pebolle@tiscali.nl>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Jiri Slaby' <jslaby@suse.cz>
Cc: 'Ben Dooks' <ben-linux@fluff.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Bolle wrote:
> 
> This could have been either ARCH_S5P64X0 or CPU_S5P6450. Looking at
> commit 2555e663b367b8d555e76023f4de3f6338c28d6c ("ARM: S5P64X0: Add UART
> serial support for S5P6450") - which added this typo - makes clear this
> should be CPU_S5P6450.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

> ---
> Bravely untested.
> 
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index cf9210d..40ddbe4 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -218,7 +218,7 @@ config SERIAL_SAMSUNG_UARTS_4
>  config SERIAL_SAMSUNG_UARTS
>  	int
>  	depends on PLAT_SAMSUNG
> -	default 6 if ARCH_S5P6450
> +	default 6 if CPU_S5P6450
>  	default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
>  	default 3
>  	help
> --
> 1.7.11.7

