From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v2] serial: 8250_early: Add earlycon support for Palmchip
 UART
Date: Thu, 13 Apr 2017 15:22:15 +0200
Message-ID: <01ed348b-1057-9089-bca3-433c7d7f9881@free.fr>
References: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@arm.linux.org.uk>, Andreas Farber <afaerber@suse.de>, Jean Delvare <jdelvare@suse.de>, Rob Herring <robh@kernel.org>, Mans Rullgard <mans@mansr.com>, Jiri Slaby <jslaby@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <vgupta@synopsys.com>, Scott Wood <oss@buserror.net>, Robin Murphy <robin.murphy@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 10/04/2017 11:47, Marc Gonzalez wrote:

> @@ -172,3 +179,20 @@ OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
>  OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
>  
>  #endif
> +
> +#ifdef CONFIG_SERIAL_8250_RT288X
> +
> +unsigned int au_serial_in(struct uart_port *p, int offset);
> +void au_serial_out(struct uart_port *p, int offset, int value);

Hmmm, I'm thinking that putting declarations in a .c file might
not be a very popular decision... ?

Would there be a header, shared by 8250_early.c and 8250_port.c
where it might be appropriate to declare au_serial_in/out?


> +static int __init early_au_setup(struct earlycon_device *dev, const char *opt)
> +{
> +	dev->port.serial_in = au_serial_in;
> +	dev->port.serial_out = au_serial_out;
> +	dev->port.iotype = UPIO_AU;
> +	dev->con->write = early_serial8250_write;
> +	return 0;
> +}
> +OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_au_setup);
> +
> +#endif
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 080d5a59d0a7..1f08d22d1a80 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -313,7 +313,7 @@ static const s8 au_io_out_map[8] = {
>  	-1,	/* UART_SCR (unmapped) */
>  };
>  
> -static unsigned int au_serial_in(struct uart_port *p, int offset)
> +unsigned int au_serial_in(struct uart_port *p, int offset)
>  {
>  	if (offset >= ARRAY_SIZE(au_io_in_map))
>  		return UINT_MAX;
> @@ -323,7 +323,7 @@ static unsigned int au_serial_in(struct uart_port *p, int offset)
>  	return __raw_readl(p->membase + (offset << p->regshift));
>  }
>  
> -static void au_serial_out(struct uart_port *p, int offset, int value)
> +void au_serial_out(struct uart_port *p, int offset, int value)
>  {
>  	if (offset >= ARRAY_SIZE(au_io_out_map))
>  		return;
> 
