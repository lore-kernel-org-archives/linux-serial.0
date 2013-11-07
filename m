From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v3] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Thu, 7 Nov 2013 07:11:23 +0100
Message-ID: <20131107061123.GF28304@ns203013.ovh.net>
References: <1383749698-26523-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1383749698-26523-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, linux-serial@vger.kernel.org, Andrew Victor <linux@maxim.org.za>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 15:54 Wed 06 Nov     , Linus Walleij wrote:
> This passes the errata fix using a GPIO to control the RTS pin
> on one of the AT91 chips to use gpiolib instead of the
> AT91-specific interfaces. Also remove the reliance on
> compile-time #defines and the cpu_* check and rely on the
> platform passing down the proper GPIO pin through platform
> data.
> 
> This is a prerequisite for getting rid of the local GPIO
> implementation in the AT91 platform and move toward
> multiplatform.
> 
> The patch also adds device tree support for getting the
> RTS GPIO pin from the device tree on DT boot paths.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Instead of disallowing GPIO 0 to be used for the RTS
>   signal to allow null-initialized platform data to mean
>   "no RTS GPIO", be more generic and actually allow it,
>   and patch every instance of atmel_uart_data to set
>   .rts_gpio to -EINVAL except for the one case where we
>   actually use pin 21 for RTS over GPIO.
one small issue otherwise

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

> ChangeLog v1->v2:
> - Skip check for UART base address from leftover hack,
>   if we have an RTS GPIO we just use it.
> - Set default error value on GPIO pin to -EINVAL
> - Fold in a device tree support patch from Nicolas Ferre
> ---
>  .../devicetree/bindings/serial/atmel-usart.txt     |  3 ++
>  arch/arm/mach-at91/at91rm9200_devices.c            |  5 ++
>  arch/arm/mach-at91/at91sam9260_devices.c           |  7 +++
>  arch/arm/mach-at91/at91sam9261_devices.c           |  4 ++
>  arch/arm/mach-at91/at91sam9263_devices.c           |  4 ++
>  arch/arm/mach-at91/at91sam9g45_devices.c           |  5 ++
>  arch/arm/mach-at91/at91sam9rl_devices.c            |  5 ++
>  drivers/tty/serial/atmel_serial.c                  | 55 +++++++++++++++-------
>  include/linux/platform_data/atmel.h                |  1 +
>  9 files changed, 71 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> index 2191dcb9f1da..3adc61c2e4ca 100644
> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> @@ -10,6 +10,8 @@ Required properties:
>  Optional properties:
>  - atmel,use-dma-rx: use of PDC or DMA for receiving data
>  - atmel,use-dma-tx: use of PDC or DMA for transmitting data
> +- rts-gpios: specify a GPIO for RTS line. It will use specified PIO instead of the peripheral
> +  function pin for the USART RTS feature. If unsure, don't specify this property.
>  - add dma bindings for dma transfer:
>  	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
>  		memory peripheral interface and USART DMA channel ID, FIFO configuration.
> @@ -28,6 +30,7 @@ Example:
>  		interrupts = <7>;
>  		atmel,use-dma-rx;
>  		atmel,use-dma-tx;
> +		rts-gpios = <&pioD 15 0>;
>  	};
>  
>  - use DMA:
> diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
> index c721e9b08066..f46d0e92b2b6 100644
> --- a/arch/arm/mach-at91/at91rm9200_devices.c
> +++ b/arch/arm/mach-at91/at91rm9200_devices.c
> @@ -923,6 +923,7 @@ static struct resource dbgu_resources[] = {
>  static struct atmel_uart_data dbgu_data = {
>  	.use_dma_tx	= 0,
>  	.use_dma_rx	= 0,		/* DBGU not capable of receive DMA */
> +	.rts_gpio	= -EINVAL,
>  };
>  
>  static u64 dbgu_dmamask = DMA_BIT_MASK(32);
> @@ -961,6 +962,7 @@ static struct resource uart0_resources[] = {
>  static struct atmel_uart_data uart0_data = {
>  	.use_dma_tx	= 1,
>  	.use_dma_rx	= 1,
> +	.rts_gpio	= AT91_PIN_PA21,
here
	.rts_gpio	= -EINVAL,

as we need to only pass the rst_gpio if the rts is requested

so do you to do this too

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 3ebc979..d89af34 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -990,6 +990,7 @@ static inline void configure_usart0_pins(unsigned pins)
                *  We need to drive the pin manually.  Default is off (RTS is active low).
                */
               at91_set_gpio_output(AT91_PIN_PA21, 1);
+               uart0_data->rts-gpio = AT91_PIN_PA21;
       }
}

> -#endif
>  
>  	if (mctrl & TIOCM_RTS)
>  		control |= ATMEL_US_RTSEN;
> @@ -2365,6 +2359,31 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	port = &atmel_ports[ret];
>  	port->backup_imr = 0;
>  	port->uart.line = ret;
> +	port->rts_gpio = -EINVAL; /* Invalid, zero could be valid */
> +	/*
> +	 * In theory the GPIO pin controlling RTS could be zero and
> +	 * this would be an improper check, but we know that the only
> +	 * existing case is != 0 and it's nice to use the zero-initialized
> +	 * structs to indicate "no RTS GPIO" instead of open-coding some
> +	 * invalid value everywhere.
> +	 */
just a nip tick
> +	if (pdata && gpio_is_valid(pdata->rts_gpio))
> +		port->rts_gpio = pdata->rts_gpio;
why bother to check if the gpio is valid as if the pdata is passed we ignore the dts
and the check under will check if the gpio is valid too

Best Regards,
J.
> +	else if (np)
> +		port->rts_gpio = of_get_named_gpio(np, "rts-gpios", 0);
> +
> +	if (gpio_is_valid(port->rts_gpio)) {
> +		ret = devm_gpio_request(&pdev->dev, port->rts_gpio, "RTS");
> +		if (ret) {
> +			dev_err(&pdev->dev, "error requesting RTS GPIO\n");
> +			goto err;
> +		}
> +		ret = gpio_direction_output(port->rts_gpio, 0);
> +		if (ret) {
> +			dev_err(&pdev->dev, "error setting up RTS GPIO\n");
> +			goto err;
> +		}
> +	}
>  
>  	ret = atmel_init_port(port, pdev);
>  	if (ret)
> diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
> index cea9f70133c5..e26b0c14edea 100644
> --- a/include/linux/platform_data/atmel.h
> +++ b/include/linux/platform_data/atmel.h
> @@ -84,6 +84,7 @@ struct atmel_uart_data {
>  	short			use_dma_rx;	/* use receive DMA? */
>  	void __iomem		*regs;		/* virt. base address, if any */
>  	struct serial_rs485	rs485;		/* rs485 settings */
> +	int			rts_gpio;	/* optional RTS GPIO */
>  };
>  
>   /* Touchscreen Controller */
> -- 
> 1.8.3.1
> 
