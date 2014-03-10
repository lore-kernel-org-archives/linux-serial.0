From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v6 2/3] tty/serial: at91: use mctrl_gpio helpers
Date: Mon, 10 Mar 2014 18:20:22 +0100
Message-ID: <531DF456.6050506@atmel.com>
References: <1394469951-21192-1-git-send-email-richard.genoud@gmail.com> <1394469951-21192-3-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:15620 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbaCJRUR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Mar 2014 13:20:17 -0400
In-Reply-To: <1394469951-21192-3-git-send-email-richard.genoud@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Genoud <noreply.rgenoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Richard Genoud <richard.genoud@gmail.com>

On 10/03/2014 17:45, Richard Genoud :
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

Good for me: Greg are you okay to take the at91 bits included in this patch?

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  .../devicetree/bindings/serial/atmel-usart.txt     |  12 ++-
>  arch/arm/mach-at91/at91rm9200_devices.c            |  16 ++--
>  arch/arm/mach-at91/at91sam9260_devices.c           |   7 --
>  arch/arm/mach-at91/at91sam9261_devices.c           |   4 -
>  arch/arm/mach-at91/at91sam9263_devices.c           |   4 -
>  arch/arm/mach-at91/at91sam9g45_devices.c           |   5 -
>  arch/arm/mach-at91/at91sam9rl_devices.c            |   5 -
>  drivers/tty/serial/Kconfig                         |   1 +
>  drivers/tty/serial/atmel_serial.c                  | 105 ++++++++++++++-------
>  include/linux/platform_data/atmel.h                |   1 -
>  10 files changed, 90 insertions(+), 70 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> index 17c1042b2df8..a6391e70a8fd 100644
> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> @@ -13,8 +13,9 @@ Required properties:
>  Optional properties:
>  - atmel,use-dma-rx: use of PDC or DMA for receiving data
>  - atmel,use-dma-tx: use of PDC or DMA for transmitting data
> -- rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
> -  function pin for the USART RTS feature. If unsure, don't specify this property.
> +- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD line respectively.
> +  It will use specified PIO instead of the peripheral function pin for the USART feature.
> +  If unsure, don't specify this property.
>  - add dma bindings for dma transfer:
>  	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
>  		memory peripheral interface and USART DMA channel ID, FIFO configuration.
> @@ -35,7 +36,12 @@ Example:
>  		clock-names = "usart";
>  		atmel,use-dma-rx;
>  		atmel,use-dma-tx;
> -		rts-gpios = <&pioD 15 0>;
> +		rts-gpios = <&pioD 15 GPIO_ACTIVE_LOW>;
> +		cts-gpios = <&pioD 16 GPIO_ACTIVE_LOW>;
> +		dtr-gpios = <&pioD 17 GPIO_ACTIVE_LOW>;
> +		dsr-gpios = <&pioD 18 GPIO_ACTIVE_LOW>;
> +		dcd-gpios = <&pioD 20 GPIO_ACTIVE_LOW>;
> +		rng-gpios = <&pioD 19 GPIO_ACTIVE_LOW>;
>  	};
>  
>  - use DMA:
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index f3f19f21352a..291a90a5b1d4 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> @@ -15,6 +15,7 @@
>  
>  #include <linux/dma-mapping.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c-gpio.h>
>  
> @@ -923,7 +924,6 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -962,7 +962,14 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
> +};
> +
> +static struct gpiod_lookup_table uart0_gpios_table = {
> +	.dev_id = "atmel_usart",
> +	.table = {
> +		GPIO_LOOKUP("pioA", 21, "rts", GPIO_ACTIVE_LOW),
> +		{ },
> +	},
>  };
>  
>  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> @@ -993,7 +1000,7 @@ static inline void configure_usart0_pins(unsigned pins)
>  		 * We need to drive the pin manually. The serial driver will driver
>  		 * this to high when initializing.
>  		 */
> -		uart0_data.rts_gpio = AT91_PIN_PA21;
> +		gpiod_add_lookup_table(&uart0_gpios_table);
>  	}
>  }
>  
> @@ -1013,7 +1020,6 @@ static struct resource uart1_resources[] = {
>  static struct atmel_uart_data uart1_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> @@ -1065,7 +1071,6 @@ static struct resource uart2_resources[] = {
>  static struct atmel_uart_data uart2_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> @@ -1109,7 +1114,6 @@ static struct resource uart3_resources[] = {
>  static struct atmel_uart_data uart3_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 2ae7715f1309..a1b989eac8b8 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -820,7 +820,6 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -859,7 +858,6 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> @@ -911,7 +909,6 @@ static struct resource uart1_resources[] = {
>  static struct atmel_uart_data uart1_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> @@ -955,7 +952,6 @@ static struct resource uart2_resources[] = {
>  static struct atmel_uart_data uart2_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> @@ -999,7 +995,6 @@ static struct resource uart3_resources[] = {
>  static struct atmel_uart_data uart3_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> @@ -1043,7 +1038,6 @@ static struct resource uart4_resources[] = {
>  static struct atmel_uart_data uart4_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart4_dmamask = DMA_BIT_MASK(32);
> @@ -1082,7 +1076,6 @@ static struct resource uart5_resources[] = {
>  static struct atmel_uart_data uart5_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart5_dmamask = DMA_BIT_MASK(32);
> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index 80e35895d28f..b5f7a7226ff8 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -881,7 +881,6 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -920,7 +919,6 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> @@ -964,7 +962,6 @@ static struct resource uart1_resources[] = {
>  static struct atmel_uart_data uart1_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> @@ -1008,7 +1005,6 @@ static struct resource uart2_resources[] = {
>  static struct atmel_uart_data uart2_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index 43d53d6156dd..39803c3296b2 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -1325,7 +1325,6 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -1364,7 +1363,6 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> @@ -1408,7 +1406,6 @@ static struct resource uart1_resources[] = {
>  static struct atmel_uart_data uart1_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> @@ -1452,7 +1449,6 @@ static struct resource uart2_resources[] = {
>  static struct atmel_uart_data uart2_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 77b04c2edd78..4e53d8d9737b 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -1588,7 +1588,6 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -1627,7 +1626,6 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> @@ -1671,7 +1669,6 @@ static struct resource uart1_resources[] = {
>  static struct atmel_uart_data uart1_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> @@ -1715,7 +1712,6 @@ static struct resource uart2_resources[] = {
>  static struct atmel_uart_data uart2_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> @@ -1759,7 +1755,6 @@ static struct resource uart3_resources[] = {
>  static struct atmel_uart_data uart3_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> index 428fc412aaf1..f75985062913 100644
> --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> @@ -957,7 +957,6 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -996,7 +995,6 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart0_dmamask = DMA_BIT_MASK(32);
> @@ -1048,7 +1046,6 @@ static struct resource uart1_resources[] = {
>  static struct atmel_uart_data uart1_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart1_dmamask = DMA_BIT_MASK(32);
> @@ -1092,7 +1089,6 @@ static struct resource uart2_resources[] = {
>  static struct atmel_uart_data uart2_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart2_dmamask = DMA_BIT_MASK(32);
> @@ -1136,7 +1132,6 @@ static struct resource uart3_resources[] = {
>  static struct atmel_uart_data uart3_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> -	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 uart3_dmamask = DMA_BIT_MASK(32);
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e8f15cfb8d0..f4e20410a138 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -97,6 +97,7 @@ config SERIAL_ATMEL
>  	bool "AT91 / AT32 on-chip serial port support"
>  	depends on ARCH_AT91 || AVR32
>  	select SERIAL_CORE
> +	select SERIAL_MCTRL_GPIO
>  	help
>  	  This enables the driver for the on-chip UARTs of the Atmel
>  	  AT91 and AT32 processors.
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 53eeea13ff16..43ca659c1d4b 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -43,6 +43,8 @@
>  #include <linux/platform_data/atmel.h>
>  #include <linux/timer.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/err.h>
>  
>  #include <asm/io.h>
>  #include <asm/ioctls.h>
> @@ -57,6 +59,8 @@
>  
>  #include <linux/serial_core.h>
>  
> +#include "serial_mctrl_gpio.h"
> +
>  static void atmel_start_rx(struct uart_port *port);
>  static void atmel_stop_rx(struct uart_port *port);
>  
> @@ -162,7 +166,7 @@ struct atmel_uart_port {
>  	struct circ_buf		rx_ring;
>  
>  	struct serial_rs485	rs485;		/* rs485 settings */
> -	int			rts_gpio;	/* optional RTS GPIO */
> +	struct mctrl_gpios	*gpios;
>  	unsigned int		tx_done_mask;
>  	bool			is_usart;	/* usart or uart */
>  	struct timer_list	uart_timer;	/* uart timer */
> @@ -237,6 +241,50 @@ static bool atmel_use_dma_rx(struct uart_port *port)
>  	return atmel_port->use_dma_rx;
>  }
>  
> +static unsigned int atmel_get_lines_status(struct uart_port *port)
> +{
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	unsigned int status, ret = 0;
> +
> +	status = UART_GET_CSR(port);
> +
> +	mctrl_gpio_get(atmel_port->gpios, &ret);
> +
> +	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
> +						UART_GPIO_CTS))) {
> +		if (ret & TIOCM_CTS)
> +			status &= ~ATMEL_US_CTS;
> +		else
> +			status |= ATMEL_US_CTS;
> +	}
> +
> +	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
> +						UART_GPIO_DSR))) {
> +		if (ret & TIOCM_DSR)
> +			status &= ~ATMEL_US_DSR;
> +		else
> +			status |= ATMEL_US_DSR;
> +	}
> +
> +	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
> +						UART_GPIO_RI))) {
> +		if (ret & TIOCM_RI)
> +			status &= ~ATMEL_US_RI;
> +		else
> +			status |= ATMEL_US_RI;
> +	}
> +
> +	if (!IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(atmel_port->gpios,
> +						UART_GPIO_DCD))) {
> +		if (ret & TIOCM_CD)
> +			status &= ~ATMEL_US_DCD;
> +		else
> +			status |= ATMEL_US_DCD;
> +	}
> +
> +	return status;
> +}
> +
>  /* Enable or disable the rs485 support */
>  void atmel_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
>  {
> @@ -296,17 +344,6 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
>  	unsigned int mode;
>  	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
>  
> -	/*
> -	 * AT91RM9200 Errata #39: RTS0 is not internally connected
> -	 * to PA21. We need to drive the pin as a GPIO.
> -	 */
> -	if (gpio_is_valid(atmel_port->rts_gpio)) {
> -		if (mctrl & TIOCM_RTS)
> -			gpio_set_value(atmel_port->rts_gpio, 0);
> -		else
> -			gpio_set_value(atmel_port->rts_gpio, 1);
> -	}
> -
>  	if (mctrl & TIOCM_RTS)
>  		control |= ATMEL_US_RTSEN;
>  	else
> @@ -319,6 +356,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
>  
>  	UART_PUT_CR(port, control);
>  
> +	mctrl_gpio_set(atmel_port->gpios, mctrl);
> +
>  	/* Local loopback mode? */
>  	mode = UART_GET_MR(port) & ~ATMEL_US_CHMODE;
>  	if (mctrl & TIOCM_LOOP)
> @@ -346,7 +385,8 @@ static void atmel_set_mctrl(struct uart_port *port, u_int mctrl)
>   */
>  static u_int atmel_get_mctrl(struct uart_port *port)
>  {
> -	unsigned int status, ret = 0;
> +	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
> +	unsigned int ret = 0, status;
>  
>  	status = UART_GET_CSR(port);
>  
> @@ -362,7 +402,7 @@ static u_int atmel_get_mctrl(struct uart_port *port)
>  	if (!(status & ATMEL_US_RI))
>  		ret |= TIOCM_RI;
>  
> -	return ret;
> +	return mctrl_gpio_get(atmel_port->gpios, &ret);
>  }
>  
>  /*
> @@ -1042,7 +1082,7 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
>  	unsigned int status, pending, pass_counter = 0;
>  
>  	do {
> -		status = UART_GET_CSR(port);
> +		status = atmel_get_lines_status(port);
>  		pending = status & UART_GET_IMR(port);
>  		if (!pending)
>  			break;
> @@ -1568,7 +1608,7 @@ static int atmel_startup(struct uart_port *port)
>  	}
>  
>  	/* Save current CSR for comparison in atmel_tasklet_func() */
> -	atmel_port->irq_status_prev = UART_GET_CSR(port);
> +	atmel_port->irq_status_prev = atmel_get_lines_status(port);
>  	atmel_port->irq_status = atmel_port->irq_status_prev;
>  
>  	/*
> @@ -2324,6 +2364,15 @@ static int atmel_serial_resume(struct platform_device *pdev)
>  #define atmel_serial_resume NULL
>  #endif
>  
> +static int atmel_init_gpios(struct atmel_uart_port *p, struct device *dev)
> +{
> +	p->gpios = mctrl_gpio_init(dev, 0);
> +	if (IS_ERR_OR_NULL(p->gpios))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int atmel_serial_probe(struct platform_device *pdev)
>  {
>  	struct atmel_uart_port *port;
> @@ -2359,25 +2408,11 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	port = &atmel_ports[ret];
>  	port->backup_imr = 0;
>  	port->uart.line = ret;
> -	port->rts_gpio = -EINVAL; /* Invalid, zero could be valid */
> -	if (pdata)
> -		port->rts_gpio = pdata->rts_gpio;
> -	else if (np)
> -		port->rts_gpio = of_get_named_gpio(np, "rts-gpios", 0);
> -
> -	if (gpio_is_valid(port->rts_gpio)) {
> -		ret = devm_gpio_request(&pdev->dev, port->rts_gpio, "RTS");
> -		if (ret) {
> -			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
> -			goto err;
> -		}
> -		/* Default to 1 as RTS is active low */
> -		ret = gpio_direction_output(port->rts_gpio, 1);
> -		if (ret) {
> -			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
> -			goto err;
> -		}
> -	}
> +
> +	ret = atmel_init_gpios(port, &pdev->dev);
> +	if (ret < 0)
> +		dev_err(&pdev->dev, "%s",
> +			"Failed to initialize GPIOs. The serial port may not work as expected");
>  
>  	ret = atmel_init_port(port, pdev);
>  	if (ret)
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index e26b0c14edea..cea9f70133c5 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -84,7 +84,6 @@ struct atmel_uart_data {
>  	short			use_dma_rx;	/* use receive DMA? */
>  	void __iomem		*regs;		/* virt. base address, if any */
>  	struct serial_rs485	rs485;		/* rs485 settings */
> -	int			rts_gpio;	/* optional RTS GPIO */
>  };
>  
>   /* Touchscreen Controller */
> 


-- 
Nicolas Ferre
