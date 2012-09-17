From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH] serial: Samsung: Fix return value
Date: Mon, 17 Sep 2012 16:09:49 +0530
Message-ID: <CAK9yfHxwjuzpspksweVvWn4xEuFtWA-xXmAME_B=-zLKb3Vadw@mail.gmail.com>
References: <1347431401-3306-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:36475 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab2IQKjt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 06:39:49 -0400
Received: by vbbff1 with SMTP id ff1so2621453vbb.19
        for <linux-serial@vger.kernel.org>; Mon, 17 Sep 2012 03:39:49 -0700 (PDT)
In-Reply-To: <1347431401-3306-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@linux.intel.com, gregkh@linuxfoundation.org, sachin.kamat@linaro.org, patches@linaro.org, alan@lxorguk.ukuu.org.uk

ping..

On 12 September 2012 12:00, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Return the value returned by the failing function instead
> of -1 (which does not convey the right error information).
>
> Fixes the following smatch warning:
> drivers/tty/serial/samsung.c:1687 s3c24xx_serial_modinit() info:
> why not propagate 'ret' from uart_register_driver() instead of -1?
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/tty/serial/samsung.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index bdaa06f..8eef114 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -1684,7 +1684,7 @@ static int __init s3c24xx_serial_modinit(void)
>         ret = uart_register_driver(&s3c24xx_uart_drv);
>         if (ret < 0) {
>                 pr_err("Failed to register Samsung UART driver\n");
> -               return -1;
> +               return ret;
>         }
>
>         return platform_driver_register(&samsung_serial_driver);
> --
> 1.7.4.1
>



-- 
With warm regards,
Sachin
