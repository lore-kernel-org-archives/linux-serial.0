From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] serial: clps711x: Use mctrl_gpio helpers for handling
 modem signals
Date: Wed, 6 Aug 2014 10:07:27 +0100
Message-ID: <20140806090726.GA5727@leverpostej>
References: <1407263841-14692-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:56008 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750773AbaHFJHl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Aug 2014 05:07:41 -0400
Content-Disposition: inline
In-Reply-To: <1407263841-14692-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Aug 05, 2014 at 07:37:21PM +0100, Alexander Shiyan wrote:
> This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
> signals.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../bindings/serial/cirrus,clps711x-uart.txt       |  7 +++--
>  drivers/tty/serial/Kconfig                         |  1 +
>  drivers/tty/serial/clps711x.c                      | 32 +++++++---------------
>  3 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
> index 12f3cf8..caaeb25 100644
> --- a/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt
> @@ -8,7 +8,8 @@ Required properties:
>  - syscon: Phandle to SYSCON node, which contain UART control bits.
>  
>  Optional properties:
> -- uart-use-ms: Indicate the UART has modem signal (DCD, DSR, CTS).
> +- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
> +  line respectively.

The commit message states you are adding a capability to the driver, but
you are removing portions of the driver and binding. Please come up with
a better commit message explaining why this is necessary.

Mark.

>  
>  Note: Each UART port should have an alias correctly numbered
>  in "aliases" node.
> @@ -24,5 +25,7 @@ Example:
>  		interrupts = <12 13>;
>  		clocks = <&clks 11>;
>  		syscon = <&syscon1>;
> -		uart-use-ms;
> +		cts-gpios = <&sysgpio 0 GPIO_ACTIVE_LOW>;
> +		dsr-gpios = <&sysgpio 1 GPIO_ACTIVE_LOW>;
> +		dcd-gpios = <&sysgpio 2 GPIO_ACTIVE_LOW>;
>  	};
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 26cec64..75cc59f 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -204,6 +204,7 @@ config SERIAL_CLPS711X
>  	tristate "CLPS711X serial port support"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
>  	select SERIAL_CORE
> +	select SERIAL_MCTRL_GPIO
>  	help
>  	  This enables the driver for the on-chip UARTs of the Cirrus
>  	  Logic EP711x/EP721x/EP731x processors.
> diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
> index f5b4c3d..acfe317 100644
> --- a/drivers/tty/serial/clps711x.c
> +++ b/drivers/tty/serial/clps711x.c
> @@ -33,6 +33,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/mfd/syscon/clps711x.h>
>  
> +#include "serial_mctrl_gpio.h"
> +
>  #define UART_CLPS711X_DEVNAME	"ttyCL"
>  #define UART_CLPS711X_NR	2
>  #define UART_CLPS711X_MAJOR	204
> @@ -62,7 +64,7 @@ struct clps711x_port {
>  	unsigned int		tx_enabled;
>  	int			rx_irq;
>  	struct regmap		*syscon;
> -	bool			use_ms;
> +	struct mctrl_gpios	*gpios;
>  };
>  
>  static struct uart_driver clps711x_uart = {
> @@ -198,28 +200,17 @@ static unsigned int uart_clps711x_tx_empty(struct uart_port *port)
>  
>  static unsigned int uart_clps711x_get_mctrl(struct uart_port *port)
>  {
> +	unsigned int result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
>  	struct clps711x_port *s = dev_get_drvdata(port->dev);
> -	unsigned int result = 0;
> -
> -	if (s->use_ms) {
> -		u32 sysflg = 0;
> -
> -		regmap_read(s->syscon, SYSFLG_OFFSET, &sysflg);
> -		if (sysflg & SYSFLG1_DCD)
> -			result |= TIOCM_CAR;
> -		if (sysflg & SYSFLG1_DSR)
> -			result |= TIOCM_DSR;
> -		if (sysflg & SYSFLG1_CTS)
> -			result |= TIOCM_CTS;
> -	} else
> -		result = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
>  
> -	return result;
> +	return mctrl_gpio_get(s->gpios, &result);
>  }
>  
>  static void uart_clps711x_set_mctrl(struct uart_port *port, unsigned int mctrl)
>  {
> -	/* Do nothing */
> +	struct clps711x_port *s = dev_get_drvdata(port->dev);
> +
> +	mctrl_gpio_set(s->gpios, mctrl);
>  }
>  
>  static void uart_clps711x_break_ctl(struct uart_port *port, int break_state)
> @@ -490,15 +481,10 @@ static int uart_clps711x_probe(struct platform_device *pdev)
>  		s->syscon = syscon_regmap_lookup_by_pdevname(syscon_name);
>  		if (IS_ERR(s->syscon))
>  			return PTR_ERR(s->syscon);
> -
> -		s->use_ms = !index;
>  	} else {
>  		s->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
>  		if (IS_ERR(s->syscon))
>  			return PTR_ERR(s->syscon);
> -
> -		if (!index)
> -			s->use_ms = of_property_read_bool(np, "uart-use-ms");
>  	}
>  
>  	s->port.line		= index;
> @@ -513,6 +499,8 @@ static int uart_clps711x_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, s);
>  
> +	s->gpios = mctrl_gpio_init(&pdev->dev, 0);
> +
>  	ret = uart_add_one_port(&clps711x_uart, &s->port);
>  	if (ret)
>  		return ret;
> -- 
> 1.8.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
