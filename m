From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 2/3] serial: sirf: Use SIMPLE_DEV_PM_OPS macro
Date: Thu, 27 Feb 2014 20:04:58 +0800
Message-ID: <CAGsJ_4y0LQuhM0M16Me99xSCtHCty_sNjtjwzZW6eQna9F0RRw@mail.gmail.com>
References: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com> <001501cf33b1$5dfc0860$19f41920$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:37567 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbaB0MFT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Feb 2014 07:05:19 -0500
Received: by mail-pd0-f178.google.com with SMTP id x10so2359131pdj.9
        for <linux-serial@vger.kernel.org>; Thu, 27 Feb 2014 04:05:18 -0800 (PST)
In-Reply-To: <001501cf33b1$5dfc0860$19f41920$%han@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2014-02-27 19:45 GMT+08:00 Jingoo Han <jg1.han@samsung.com>:
> Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---

Acked-by: Barry Song <Baohua.Song@csr.com>

>  drivers/tty/serial/sirfsoc_uart.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> index 68b0fd4..da96502 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -1480,9 +1480,8 @@ static int sirfsoc_uart_resume(struct device *pdev)
>  }
>  #endif
>
> -static const struct dev_pm_ops sirfsoc_uart_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(sirfsoc_uart_suspend, sirfsoc_uart_resume)
> -};
> +static SIMPLE_DEV_PM_OPS(sirfsoc_uart_pm_ops, sirfsoc_uart_suspend,
> +                        sirfsoc_uart_resume);
>
>  static struct platform_driver sirfsoc_uart_driver = {
>         .probe          = sirfsoc_uart_probe,
> --
> 1.7.10.4
