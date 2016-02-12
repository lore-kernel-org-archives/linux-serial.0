From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 6/6] serial: 8250/ingenic: fix building with SERIAL_8250=m
Date: Fri, 12 Feb 2016 18:45:58 +0900
Message-ID: <CAK7LNAT3xxJut0Dqu_Cy4CAVc1foBN93+nGhSFo=qOtjRhYjGw@mail.gmail.com>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
	<1455205297-1021302-7-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455205297-1021302-7-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,


2016-02-12 0:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> The Ingenic 8250 driver has a 'bool' Kconfig symbol, but that
> breaks when SERIAL_8250 is a loadable module:
>
> drivers/tty/built-in.o: In function `ingenic_uart_probe':
> 8250_ingenic.c:(.text+0x1c1a0): undefined reference to `serial8250_register_8250_port'
>
> This changes the symbol to a 'tristate', plus a dependency on
> SERIAL_8250, which makes it work again. Unlike the other
> soc-specific backends, this one has no dependency on an
> architecture or a platform. I'm adding a dependency on
> MIPS || COMPILE_TEST as well here, to avoid showing the driver
> on architectures that are not interested in it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 2 +-
>  drivers/tty/serial/8250/Kconfig        | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
> index 97b78558caed..b0677f610863 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -48,7 +48,7 @@ static const struct of_device_id of_match[];
>  #define UART_MCR_MDCE  BIT(7)
>  #define UART_MCR_FCM   BIT(6)
>
> -#ifdef CONFIG_SERIAL_EARLYCON
> +#if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
>  static struct earlycon_device *early_device;
>
>  static uint8_t __init early_in(struct uart_port *port, int offset)


The same comment applies here as 5/6.





-- 
Best Regards
Masahiro Yamada
