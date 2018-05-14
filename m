From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
Date: Mon, 14 May 2018 12:57:23 +0200
Message-ID: <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180511103822.31698-7-radu.pirea@microchip.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Radu Pirea <radu.pirea@microchip.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc: mark.rutland@arm.com, alexandre.belloni@bootlin.com, richard.genoud@gmail.com, gregkh@linuxfoundation.org, broonie@kernel.org, robh+dt@kernel.org, jslaby@suse.com, lee.jones@linaro.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 11/05/2018 12:38, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 29 +++++++++++++++--------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3682fd3e960c..25e55332f8b1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -119,6 +119,7 @@ config SERIAL_ATMEL
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	select SERIAL_CORE
>  	select SERIAL_MCTRL_GPIO if GPIOLIB
> +	select MFD_AT91_USART
>  	help
>  	  This enables the driver for the on-chip UARTs of the Atmel
>  	  AT91 processors.
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index df46a9e88c34..6b4494352853 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -193,8 +193,8 @@ static struct console atmel_console;
>  
>  #if defined(CONFIG_OF)
>  static const struct of_device_id atmel_serial_dt_ids[] = {
> -	{ .compatible = "atmel,at91rm9200-usart" },
> -	{ .compatible = "atmel,at91sam9260-usart" },
> +	{ .compatible = "atmel,at91rm9200-usart-serial" },
> +	{ .compatible = "atmel,at91sam9260-usart-serial" },
>  	{ /* sentinel */ }
>  };
>  #endif
> @@ -1631,7 +1631,7 @@ static void atmel_tasklet_tx_func(unsigned long data)
>  static void atmel_init_property(struct atmel_uart_port *atmel_port,
>  				struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.parent->of_node;
>  
>  	/* DMA/PDC usage specification */
>  	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
> @@ -2223,7 +2223,8 @@ static const char *atmel_type(struct uart_port *port)
>  static void atmel_release_port(struct uart_port *port)
>  {
>  	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	int size = to_platform_device(pdev->dev.parent)->resource[0].end -
> +		to_platform_device(pdev->dev.parent)->resource[0].start + 1;
I think it may be simpler with something like:
+	struct platform_device *mfd_pdev = to_platform_device(port->dev->parent);
+	int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;

>  
>  	release_mem_region(port->mapbase, size);
>  
> @@ -2239,7 +2240,8 @@ static void atmel_release_port(struct uart_port *port)
>  static int atmel_request_port(struct uart_port *port)
>  {
>  	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	int size = to_platform_device(pdev->dev.parent)->resource[0].end -
> +		to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>  
ditto

>  	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
>  		return -EBUSY;
> @@ -2345,23 +2347,23 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
Here, we could also add:
+	struct device *mfd_dev = pdev->dev.parent;
+	struct platform_device *mfd_pdev = to_platform_device(mfd_dev);

>  	atmel_init_property(atmel_port, pdev);
>  	atmel_set_ops(port);
>  
> -	uart_get_rs485_mode(&pdev->dev, &port->rs485);
> +	uart_get_rs485_mode(pdev->dev.parent, &port->rs485);
...and use them here

>  
>  	port->iotype		= UPIO_MEM;
>  	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
>  	port->ops		= &atmel_pops;
>  	port->fifosize		= 1;
>  	port->dev		= &pdev->dev;
> -	port->mapbase	= pdev->resource[0].start;
> -	port->irq	= pdev->resource[1].start;
> +	port->mapbase		= to_platform_device(pdev->dev.parent)->resource[0].start;
> +	port->irq		= to_platform_device(pdev->dev.parent)->resource[1].start;
and here
I think it would be easier to read.

>  	port->rs485_config	= atmel_config_rs485;
> -	port->membase	= NULL;
> +	port->membase		= NULL;
>  
>  	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
>  
>  	/* for console, the clock could already be configured */
>  	if (!atmel_port->clk) {
> -		atmel_port->clk = clk_get(&pdev->dev, "usart");
> +		atmel_port->clk = clk_get(pdev->dev.parent, "usart");
and here

>  		if (IS_ERR(atmel_port->clk)) {
>  			ret = PTR_ERR(atmel_port->clk);
>  			atmel_port->clk = NULL;
> @@ -2656,7 +2658,7 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
>  	atmel_port->rts_low = 0;
>  	atmel_port->rts_high = 0;
>  
> -	if (of_property_read_u32(pdev->dev.of_node,
> +	if (of_property_read_u32(pdev->dev.parent->of_node,
>  				 "atmel,fifo-size",
>  				 &atmel_port->fifo_size))
>  		return;
> @@ -2694,11 +2696,10 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
>  static int atmel_serial_probe(struct platform_device *pdev)
>  {
>  	struct atmel_uart_port *atmel_port;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.parent->of_node;
>  	void *data;
>  	int ret = -ENODEV;
>  	bool rs485_enabled;
> -
I think this line feed wasn't so bad.

>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>  
>  	ret = of_alias_get_id(np, "serial");
> @@ -2845,7 +2846,7 @@ static struct platform_driver atmel_serial_driver = {
>  	.suspend	= atmel_serial_suspend,
>  	.resume		= atmel_serial_resume,
>  	.driver		= {
> -		.name			= "atmel_usart",
> +		.name			= "atmel_usart_serial",
>  		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
>  	},
>  };
> 

After your patch, the DMA is not selected anymore:
atmel_usart_serial atmel_usart_serial.0.auto: TX channel not available, switch to pio
instead of:
atmel_usart fffff200.serial: using dma1chan2 for tx DMA transfers

And the kernel doesn't log anymore on the serial console, despite the loglevel=8
(after reverting this series, the kernel logs reappears on the serial console)

(tests done on sam9g35)

regards,
Richard
