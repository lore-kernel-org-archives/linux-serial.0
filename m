From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250_uniphier: add earlycon support
Date: Wed, 28 Oct 2015 11:21:00 -0400
Message-ID: <5630E7DC.3050506@hurleysoftware.com>
References: <1445503154-14340-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445503154-14340-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Masahiro,

On 10/22/2015 04:39 AM, Masahiro Yamada wrote:
> This reuses the code of drivers/tty/serial/8250/8250_early.c except
> 
>   - Overwrite device->port.iotype and device->port.regshift for
>     UPIO_MEM32 because of_setup_earlycon() has set them for UPIO_MEM.
> 
>   - Set device->baud to zero to prevent early8250_setup() from
>     initializing the divisor register because port->uartclk does not
>     match the frequency expected by this hardware.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/tty/serial/8250/8250_uniphier.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
> index 245edbb..c1075c5 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -13,6 +13,7 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/console.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -34,6 +35,29 @@ struct uniphier8250_priv {
>  	spinlock_t atomic_write_lock;
>  };
>  
> +#if IS_ENABLED(CONFIG_SERIAL_8250_CONSOLE)

#ifdef CONFIG_SERIAL_8250_CONSOLE


Customarily, IS_ENABLED() is only used in-function with control flow
statements; eg.,

	if (IS_ENABLED() && .... )
		....

> +static int __init uniphier_early_console_setup(struct earlycon_device *device,
> +					       const char *options)
> +{
> +	if (!device->port.membase)
> +		return -ENODEV;
> +
> +	/* This hardware always expects MMIO32 register interface. */
> +	device->port.iotype = UPIO_MEM32;
> +	device->port.regshift = 2;
> +
> +	/*
> +	 * Do not touch the divisor register in early_serial8250_setup();
> +	 * we assume it has been initialized by a boot loader.
> +	 */
> +	device->baud = 0;
> +
> +	return early_serial8250_setup(device, options);
> +}
> +OF_EARLYCON_DECLARE(uniphier_uart, "socionext,uniphier-uart",
> +		    uniphier_early_console_setup);

Please change the earlycon name to just "uniphier" or "uniphier8250"; eg.,

OF_EARLYCON_DECLARE(uniphier, "socionext,uniphier-uart",
		    uniphier_early_console_setup);


My earlycon series merges OF_EARLYCON_DECLARE() => EARLYCON_DECLARE()
and "uniphier" is simpler on the command line.

Regards,
Peter Hurley

> +#endif
> +
>  /*
>   * The register map is slightly different from that of 8250.
>   * IO callbacks must be overridden for correct access to FCR, LCR, and MCR.
> 
