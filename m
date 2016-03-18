From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v2] serial: 8250_ingenic: Remove global variable
Date: Fri, 18 Mar 2016 08:30:36 -0700
Message-ID: <56EC1F1C.2070402@hurleysoftware.com>
References: <1457781733-2643-1-git-send-email-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457781733-2643-1-git-send-email-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Paul,

On 03/12/2016 03:22 AM, Paul Cercueil wrote:

Changelog?

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  v2: Added changelog; nothing else changed
>  v1: First version of this patch
>  drivers/tty/serial/8250/8250_ingenic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
> index 155b785..aa1f156 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -49,8 +49,6 @@ static const struct of_device_id of_match[];
>  #define UART_MCR_FCM	BIT(6)
>  
>  #ifdef CONFIG_SERIAL_EARLYCON
> -static struct earlycon_device *early_device;
> -
>  static uint8_t __init early_in(struct uart_port *port, int offset)
>  {
>  	return readl(port->membase + (offset << 2));
> @@ -75,6 +73,8 @@ static void __init ingenic_early_console_putc(struct uart_port *port, int c)
>  static void __init ingenic_early_console_write(struct console *console,
>  					      const char *s, unsigned int count)
>  {
> +	struct earlycon_device *early_device = console->data;
> +
>  	uart_console_write(&early_device->port, s, count,
>  			   ingenic_early_console_putc);
>  }
> @@ -124,7 +124,7 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
>  	early_out(port, UART_DLM, (divisor >> 8) & 0xff);
>  	early_out(port, UART_LCR, UART_LCR_WLEN8);
>  
> -	early_device = dev;
> +	dev->con->data = dev;

dev->con->data is already initialized.

Regards,
Peter Hurley

>  	dev->con->write = ingenic_early_console_write;
>  
>  	return 0;
> 
