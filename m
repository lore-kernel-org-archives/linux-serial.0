From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 10/10] serial: sirf: Staticize local symbols
Date: Mon, 12 Aug 2013 10:07:49 +0800
Message-ID: <CAGsJ_4xxcL8PNmWTM9a5GUhhHafj29HD-W-hPKSF4bmZfrNdBQ@mail.gmail.com>
References: <006601ce9413$1bd386e0$537a94a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:33770 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab3HLCIK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Aug 2013 22:08:10 -0400
Received: by mail-qc0-f179.google.com with SMTP id n10so1299099qcx.38
        for <linux-serial@vger.kernel.org>; Sun, 11 Aug 2013 19:08:09 -0700 (PDT)
In-Reply-To: <006601ce9413$1bd386e0$537a94a0$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Barry Song <baohua.song@csr.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>

2013/8/8 Jingoo Han <jg1.han@samsung.com>:
> From 0170294084877d365fbd1b369cd4dedfc3749ee5 Mon Sep 17 00:00:00 2001
> From: Jingoo Han <jg1.han@samsung.com>
> Date: Thu, 8 Aug 2013 17:24:38 +0900
> Subject: [PATCH 10/10] serial: sirf: Staticize local symbols
>
> These local symbols are used only in this file.
> Fix the following sparse warnings:
>
> drivers/tty/serial/sirfsoc_uart.c:147:6: warning: symbol 'sirfsoc_uart_start_tx' was not declared. Should it be static?
> drivers/tty/serial/sirfsoc_uart.c:636:5: warning: symbol 'sirfsoc_uart_probe' was not declared. Should it be static?
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---

Acked-by: Barry Song <Baohua.Song@csr.com>

>  drivers/tty/serial/sirfsoc_uart.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
> index 67a0d1b..3b38137 100644
> --- a/drivers/tty/serial/sirfsoc_uart.c
> +++ b/drivers/tty/serial/sirfsoc_uart.c
> @@ -144,7 +144,7 @@ static void sirfsoc_uart_stop_tx(struct uart_port *port)
>         wr_regl(port, SIRFUART_INT_EN, regv & ~SIRFUART_TX_INT_EN);
>  }
>
> -void sirfsoc_uart_start_tx(struct uart_port *port)
> +static void sirfsoc_uart_start_tx(struct uart_port *port)
>  {
>         struct sirfsoc_uart_port *sirfport = to_sirfport(port);
>         unsigned long regv;
> @@ -633,7 +633,7 @@ static struct uart_driver sirfsoc_uart_drv = {
>  #endif
>  };
>
> -int sirfsoc_uart_probe(struct platform_device *pdev)
> +static int sirfsoc_uart_probe(struct platform_device *pdev)
>  {
>         struct sirfsoc_uart_port *sirfport;
>         struct uart_port *port;
> --
> 1.7.10.4
>
