From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v3 4/7] tty/serial: at91: use mctrl_gpio helpers
Date: Tue, 18 Feb 2014 19:04:42 +0400
Message-ID: <20140218190442.b5f5668e02e2dda0bf45d0b4@mail.ru>
References: <1392656247-3351-1-git-send-email-richard.genoud@gmail.com>
	<1392656247-3351-5-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp41.i.mail.ru ([94.100.177.101]:49597 "EHLO smtp41.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755299AbaBRPEt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 10:04:49 -0500
In-Reply-To: <1392656247-3351-5-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Uwe =?KOI8-R?Q?Kleine?= =?UTF-8?Q?-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 17 Feb 2014 17:57:24 +0100
Richard Genoud <richard.genoud@gmail.com> wrote:

> On sam9x5, dedicated CTS (and RTS) pins are unusable together with the
> LCDC, the EMAC, or the MMC because they share the same line.
> 
> Moreover, the USART controller doesn't handle DTR/DSR/DCD/RI signals,
> so we have to control them via GPIO.
> 
> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
> signals.
> 
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
...
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index 605add05af7e..6dd386e3d9fe 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
...
> @@ -961,7 +961,14 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
> +};
> +
> +struct gpiod_lookup_table uart0_gpios_table = {

static

> +	.dev_id = "atmel_usart",
> +	.table = {
> +		GPIO_LOOKUP("pioA", 21, "rts", GPIO_ACTIVE_LOW),
> +		{ },
> +	},
>  };
...

-- 
Alexander Shiyan <shc_work@mail.ru>
