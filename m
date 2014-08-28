From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 14/14] tty/serial: samsung: add support for exynos7
Date: Wed, 27 Aug 2014 21:04:09 -0700
Message-ID: <20140828040409.GE4972@localhost>
References: <1409132795-1991-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59354 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaH1EFo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Aug 2014 00:05:44 -0400
Received: by mail-pa0-f54.google.com with SMTP id fb1so798875pad.41
        for <linux-serial@vger.kernel.org>; Wed, 27 Aug 2014 21:05:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409132795-1991-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-serial@vger.kernel.org, naveenkrishna.ch@gmail.com, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, cpgs@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Wed, Aug 27, 2014 at 03:16:35PM +0530, Naveen Krishna Chatradhi wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> This patch enables upcoming exynos7 SoCs serial driver.
> This also modifies various dependencies for Kconfig
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/Kconfig   |    6 +++---
>  drivers/tty/serial/samsung.c |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 26cec64..f858d57 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -220,7 +220,7 @@ config SERIAL_CLPS711X_CONSOLE
>  
>  config SERIAL_SAMSUNG
>  	tristate "Samsung SoC serial support"
> -	depends on PLAT_SAMSUNG
> +	depends on PLAT_SAMSUNG || ARCH_EXYNOS7

Same here, PLAT_SAMSUNG || ARCH_EXYNOS please.

> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1770,7 +1770,7 @@ static struct s3c24xx_serial_drv_data s5pv210_serial_drv_data = {
>  #define S5PV210_SERIAL_DRV_DATA	(kernel_ulong_t)NULL
>  #endif
>  
> -#if defined(CONFIG_ARCH_EXYNOS)
> +#if defined(CONFIG_ARCH_EXYNOS) || defined(CONFIG_ARCH_EXYNOS7)

And then this change won't be needed either.

>  static struct s3c24xx_serial_drv_data exynos4210_serial_drv_data = {
>  	.info = &(struct s3c24xx_uart_info) {
>  		.name		= "Samsung Exynos4 UART",

-Olof
