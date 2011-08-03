From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/4] serial: s5pv210: Add device tree support
Date: Wed, 3 Aug 2011 10:12:49 +0100
Message-ID: <20110803091249.GB28651@trinity.fluff.org>
References: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org> <1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1312326509-2723-3-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, kgene.kim@samsung.com, Ben Dooks <ben-linux@fluff.org>, patches@linaro.org, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 03, 2011 at 12:08:27AM +0100, Thomas Abraham wrote:
> For device tree based probe, the dependecy on pdev->id to attach a
> corresponding default port info to the driver's private data is
> removed. The fifosize parameter is obtained from the device tree
> node and the next available instance of port info is updated
> with the fifosize value and attached to the driver's private data.
> The default platform data is selected based on the compatible property.
> 
> CC: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  .../devicetree/bindings/serial/samsung_uart.txt    |   16 +++++++
>  drivers/tty/serial/s5pv210.c                       |   43 +++++++++++++++++++-
>  drivers/tty/serial/samsung.c                       |    5 ++-
>  3 files changed, 62 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
> 
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> new file mode 100644
> index 0000000..9174499
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.txt
> @@ -0,0 +1,16 @@
> +* Samsung's UART Controller
> +
> +The Samsung's UART controller is used for serial communications on all of
> +Samsung's s3c24xx, s3c64xx and s5p series application processors.
> +
> +Required properties:
> +- compatible: should be specific to the application processor
> +    - "samsung,s5pv310-uart" , for Exynos4 processors.
> +
> +- reg: base physical address of the controller and length of memory mapped
> +  region.
> +
> +- interrupts : Three interrupt numbers should be specified in the following
> +  order - Rx interrupt, Tx interrupt, Error Interrupt.
> +
> +- samsung,uart-fifosize: Size of the tx/rx fifo used in the controller.
> diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
> index fb0806c..a44b599 100644
> --- a/drivers/tty/serial/s5pv210.c
> +++ b/drivers/tty/serial/s5pv210.c
> @@ -19,6 +19,7 @@
>  #include <linux/serial_core.h>
>  #include <linux/serial.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
>  
>  #include <asm/irq.h>
>  #include <mach/hardware.h>
> @@ -132,10 +133,49 @@ static struct s3c24xx_uart_info *s5p_uart_inf[] = {
>  	[3] = &s5p_port_fifo16,
>  };
>  
> +#ifdef CONFIG_OF
> +static struct s3c2410_uartcfg s5pv310_uart_defcfg = {
> +	.ucon	= 0x3c5,
> +	.ufcon	= 0x111,
> +	.flags	= NO_NEED_CHECK_CLKSRC,
> +	.has_fracval = 1,
> +};
> +
> +static const struct of_device_id s5pv210_uart_dt_match[] = {
> +	{ .compatible = "samsung,s5pv310-uart", .data = &s5pv310_uart_defcfg },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, s5pv210_uart_match);
> +#else
> +#define s5pv210_uart_match NULL
> +#endif
> +
>  /* device management */
>  static int s5p_serial_probe(struct platform_device *pdev)
>  {
> -	return s3c24xx_serial_probe(pdev, s5p_uart_inf[pdev->id]);
> +	static unsigned int probe_index;
> +	unsigned int port = pdev->id;
> +	const struct of_device_id *match;
> +	struct s3c2410_uartcfg *cfg;
> +
> +	if (pdev->dev.of_node) {
> +		if (of_property_read_u32(pdev->dev.of_node,
> +				"samsung,uart-fifosize",
> +				&s5p_uart_inf[probe_index]->fifosize))
> +			return -EINVAL;

I'd rather see the fifo size either being a property of the soc itself
or being inferred by the compatible field. 

>  	.driver		= {
>  		.name	= "s5pv210-uart",
>  		.owner	= THIS_MODULE,
> +		.of_match_table	= s5pv210_uart_dt_match,

I think maybe doing something like

		.of_match_table = of_match_ptr(5pv210_uart_dt_match),

so we can avoid having the #else and #define 5pv210_uart_dt_match NULL
in a number of places.

>  	},
>  };

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
