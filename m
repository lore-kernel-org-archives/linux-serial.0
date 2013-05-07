From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 13/15] serial: sirfsoc: remove unnecessary platform_set_drvdata()
Date: Tue, 7 May 2013 16:11:32 +0800
Message-ID: <CAGsJ_4x83G0fyZn2XFjOW38HQzTbkkzDBa17GqmAyjjs2w5MmA@mail.gmail.com>
References: <009201ce4af9$d5e4b210$81ae1630$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:50369 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346Ab3EGK41 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 06:56:27 -0400
Received: by mail-qe0-f54.google.com with SMTP id q19so199474qeb.13
        for <linux-serial@vger.kernel.org>; Tue, 07 May 2013 03:56:26 -0700 (PDT)
In-Reply-To: <009201ce4af9$d5e4b210$81ae1630$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Barry Song <baohua.song@csr.com>, Rong Wang <Rong.Wang@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2013/5/7 Jingoo Han <jg1.han@samsung.com>
>
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Barry Song <baohua.song@csr.com>

> ---
>  drivers/tty/serial/sirfsoc_uart.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/sirfsoc_uart.c
> b/drivers/tty/serial/sirfsoc_uart.c
> index 03465b6..f256440 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -716,7 +716,6 @@ port_err:
>         clk_disable_unprepare(sirfport->clk);
>         clk_put(sirfport->clk);
>  clk_err:
> -       platform_set_drvdata(pdev, NULL);
>         if (sirfport->hw_flow_ctrl)
>                 pinctrl_put(sirfport->p);
>  err:
> @@ -727,7 +726,7 @@ static int sirfsoc_uart_remove(struct platform_device
> *pdev)
>  {
>         struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
>         struct uart_port *port = &sirfport->port;
> -       platform_set_drvdata(pdev, NULL);
> +
>         if (sirfport->hw_flow_ctrl)
>                 pinctrl_put(sirfport->p);
>         clk_disable_unprepare(sirfport->clk);
> --
> 1.7.2.5
>
