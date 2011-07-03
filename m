From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Sun, 3 Jul 2011 15:10:07 -0600
Message-ID: <20110703211007.GB13742@ponder.secretlab.ca>
References: <1309679760-22796-1-git-send-email-shawn.guo@linaro.org>
 <1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57379 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1GCVKI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Jul 2011 17:10:08 -0400
Received: by pzk9 with SMTP id 9so1191738pzk.19
        for <linux-serial@vger.kernel.org>; Sun, 03 Jul 2011 14:10:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309679760-22796-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-serial@vger.kernel.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Sun, Jul 03, 2011 at 03:55:59PM +0800, Shawn Guo wrote:
> The patch removes all the uses of cpu_is_mx1().  Instead, it uses
> the .id_table of platform_driver to distinguish the uart device type.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  arch/arm/mach-imx/clock-imx1.c                |    6 +-
>  arch/arm/plat-mxc/devices/platform-imx-uart.c |    2 +-
>  drivers/tty/serial/imx.c                      |   51 ++++++++++++++++++++++--
>  3 files changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
> index dcc4172..4aabeb2 100644
> --- a/arch/arm/mach-imx/clock-imx1.c
> +++ b/arch/arm/mach-imx/clock-imx1.c
> @@ -587,9 +587,9 @@ static struct clk_lookup lookups[] __initdata = {
>  	_REGISTER_CLOCK(NULL, "mma", mma_clk)
>  	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
>  	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
> -	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk)
> -	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
> -	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
> +	_REGISTER_CLOCK("imx1-uart.0", NULL, uart_clk)
> +	_REGISTER_CLOCK("imx1-uart.1", NULL, uart_clk)
> +	_REGISTER_CLOCK("imx1-uart.2", NULL, uart_clk)
>  	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
>  	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
>  	_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
> diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> index cfce8c9..477271a 100644
> --- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
> +++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
> @@ -152,7 +152,7 @@ struct platform_device *__init imx_add_imx_uart_3irq(
>  		},
>  	};
>  
> -	return imx_add_platform_device("imx-uart", data->id, res,
> +	return imx_add_platform_device("imx1-uart", data->id, res,
>  			ARRAY_SIZE(res), pdata, sizeof(*pdata));
>  }
>  
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 22fe801..983f3bd 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -48,7 +48,6 @@
>  
>  #include <asm/io.h>
>  #include <asm/irq.h>
> -#include <mach/hardware.h>
>  #include <mach/imx-uart.h>
>  
>  /* Register definitions */
> @@ -67,7 +66,8 @@
>  #define UBMR  0xa8 /* BRM Modulator Register */
>  #define UBRC  0xac /* Baud Rate Count Register */
>  #define MX2_ONEMS 0xb0 /* One Millisecond register */
> -#define UTS (cpu_is_mx1() ? 0xd0 : 0xb4) /* UART Test Register */
> +#define MX1_UTS 0xd0 /* UART Test Register on mx1 */
> +#define MX2_UTS 0xb4 /* UART Test Register on mx2 and later */
>  
>  /* UART Control Register Bit Fields.*/
>  #define  URXD_CHARRDY    (1<<15)
> @@ -181,6 +181,17 @@
>  
>  #define UART_NR 8
>  
> +enum imx_uart_type {
> +	IMX1_UART,
> +	IMX2_UART,
> +};
> +
> +/* device type dependent stuff */
> +struct imx_uart_data {
> +	unsigned uts_reg;
> +	enum imx_uart_type devtype;
> +};
> +
>  struct imx_port {
>  	struct uart_port	port;
>  	struct timer_list	timer;
> @@ -192,6 +203,7 @@ struct imx_port {
>  	unsigned int		irda_inv_tx:1;
>  	unsigned short		trcv_delay; /* transceiver delay */
>  	struct clk		*clk;
> +	struct imx_uart_data	*devdata;
>  };
>  
>  #ifdef CONFIG_IRDA
> @@ -200,6 +212,33 @@ struct imx_port {
>  #define USE_IRDA(sport)	(0)
>  #endif
>  
> +#define UTS (sport->devdata->uts_reg)
> +#define IS_IMX1_UART() (sport->devdata->devtype == IMX1_UART)
> +#define IS_IMX2_UART() (sport->devdata->devtype == IMX2_UART)
> +
> +static struct imx_uart_data imx_uart_devdata[] = {
> +	[IMX1_UART] = {
> +		.uts_reg = MX1_UTS,
> +		.devtype = IMX1_UART,
> +	},
> +	[IMX2_UART] = {
> +		.uts_reg = MX2_UTS,
> +		.devtype = IMX2_UART,
> +	},
> +};
> +
> +static struct platform_device_id imx_uart_devtype[] = {
> +	{
> +		.name = "imx1-uart",
> +		.driver_data = IMX1_UART,
> +	}, {
> +		.name = "imx-uart",
> +		.driver_data = IMX2_UART,

Rather than using driver_data as an index, and having a separate
table, you can use it as a pointer to the imx_uard_data structure.
That's why driver_data is declared as a kernel_ulong_t.  The only
reason it isn't a void* (AFAIK) is that mod_devicetable.h is exported
to userspace.

> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
>  /*
>   * Handle any change of modem status signal since we were last called.
>   */
> @@ -689,7 +728,7 @@ static int imx_startup(struct uart_port *port)
>  		}
>  	}
>  
> -	if (!cpu_is_mx1()) {
> +	if (IS_IMX2_UART()) {

The logic is getting reversed here, is this really what you want to
do?  I would think you'd want to preserve the !IS_IMX1_UART() logic.

>  		temp = readl(sport->port.membase + UCR3);
>  		temp |= MX2_UCR3_RXDMUXSEL;
>  		writel(temp, sport->port.membase + UCR3);
> @@ -923,7 +962,7 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
>  	writel(num, sport->port.membase + UBIR);
>  	writel(denom, sport->port.membase + UBMR);
>  
> -	if (!cpu_is_mx1())
> +	if (IS_IMX2_UART())
>  		writel(sport->port.uartclk / div / 1000,
>  				sport->port.membase + MX2_ONEMS);
>  
> @@ -1062,7 +1101,7 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
>  	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
>  	old_ucr2 = readl(sport->port.membase + UCR2);
>  
> -	if (cpu_is_mx1())
> +	if (IS_IMX1_UART())
>  		ucr1 |= MX1_UCR1_UARTCLKEN;
>  	ucr1 |= UCR1_UARTEN;
>  	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
> @@ -1262,6 +1301,7 @@ static int serial_imx_probe(struct platform_device *pdev)
>  	init_timer(&sport->timer);
>  	sport->timer.function = imx_timeout;
>  	sport->timer.data     = (unsigned long)sport;
> +	sport->devdata = &imx_uart_devdata[pdev->id_entry->driver_data];
>  
>  	sport->clk = clk_get(&pdev->dev, "uart");
>  	if (IS_ERR(sport->clk)) {
> @@ -1340,6 +1380,7 @@ static struct platform_driver serial_imx_driver = {
>  
>  	.suspend	= serial_imx_suspend,
>  	.resume		= serial_imx_resume,
> +	.id_table	= imx_uart_devtype,
>  	.driver		= {
>  		.name	= "imx-uart",
>  		.owner	= THIS_MODULE,
> -- 
> 1.7.4.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
