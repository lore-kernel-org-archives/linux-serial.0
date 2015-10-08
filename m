From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] serial: atmel: fix compiler warning on address cast
Date: Thu, 8 Oct 2015 11:01:48 +0200
Message-ID: <20151008090148.GE3485@piout.net>
References: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 05/10/2015 at 18:00:52 +0100, Andre Przywara wrote :
> Turning on KVM and LPAE support on top of a multi_v7_defconfig will
> produce a compiler warning in the Atmel serial driver:
> drivers/tty/serial/atmel_serial.c: In function 'atmel_verify_port':
> drivers/tty/serial/atmel_serial.c:2299:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   if ((void *)port->mapbase != ser->iomem_base)
>       ^
> 
> Fix that by using the cast on the right hand side instead, as similar
> code already does in other drivers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/tty/serial/atmel_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index cd30a45..28039ce 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2296,7 +2296,7 @@ static int atmel_verify_port(struct uart_port *port, struct serial_struct *ser)
>  		ret = -EINVAL;
>  	if (port->uartclk / 16 != ser->baud_base)
>  		ret = -EINVAL;
> -	if ((void *)port->mapbase != ser->iomem_base)
> +	if (port->mapbase != (unsigned long)ser->iomem_base)
>  		ret = -EINVAL;
>  	if (port->iobase != ser->port)
>  		ret = -EINVAL;
> -- 
> 2.5.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
