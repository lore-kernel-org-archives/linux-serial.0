From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH 1/3] serial: amba-pl011: make platform driver generic
Date: Mon, 15 Feb 2016 20:18:32 +0800
Message-ID: <56C1C218.3050106@linaro.org>
References: <1455538393-7038-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455538393-7038-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andre.przywara@arm.com, timur@codeaurora.org, linux@arm.linux.org.uk, graeme.gregory@linaro.org, peter@hurleysoftware.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org
Cc: jason.liu@linaro.org
List-Id: linux-serial@vger.kernel.org

There are only two patches for this PL011 UART changes actually. The 
third is for platform config and shall not be posted here. Sorry for 
misleading you by email title.

Jun
> make sbsa uart platform driver more generic so that platform
> driver code can be reused by ZTE uart platform driver.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>   drivers/tty/serial/amba-pl011.c | 57 +++++++++++++++++++++++++++--------------
>   1 file changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 500232a..f52a243 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -73,6 +73,9 @@
>   #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
>   #define UART_DUMMY_DR_RX	(1 << 16)
>
> +static const struct uart_ops amba_pl011_pops;
> +static const struct uart_ops sbsa_uart_pops;
> +
>   static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
>   	[REG_DR] = UART01x_DR,
>   	[REG_FR] = UART01x_FR,
> @@ -92,6 +95,7 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
>   /* There is by now at least one vendor with differing details, so handle it */
>   struct vendor_data {
>   	const u16		*reg_offset;
> +	const struct uart_ops	*uart_pops;
>   	unsigned int		ifls;
>   	bool			access_32b;
>   	bool			oversampling;
> @@ -119,13 +123,20 @@ static struct vendor_data vendor_arm = {
>   	.get_fifosize		= get_fifosize_arm,
>   };
>
> +static unsigned int get_fifosize_sbsa(struct amba_device *dev)
> +{
> +	return 32;
> +}
> +
>   static struct vendor_data vendor_sbsa = {
>   	.reg_offset		= pl011_std_offsets,
> +	.uart_pops		= &sbsa_uart_pops,
>   	.oversampling		= false,
>   	.dma_threshold		= false,
>   	.cts_event_workaround	= false,
>   	.always_enabled		= true,
>   	.fixed_options		= true,
> +	.get_fifosize		= get_fifosize_sbsa,
>   };
>
>   static u16 pl011_st_offsets[REG_ARRAY_SIZE] = {
> @@ -189,6 +200,7 @@ static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
>
>   static struct vendor_data vendor_zte __maybe_unused = {
>   	.reg_offset		= pl011_zte_offsets,
> +	.uart_pops		= &amba_pl011_pops,
>   	.access_32b		= true,
>   	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
>   	.get_fifosize		= get_fifosize_arm,
> @@ -2084,7 +2096,7 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
>   	return ret;
>   }
>
> -static struct uart_ops amba_pl011_pops = {
> +static const struct uart_ops amba_pl011_pops = {
>   	.tx_empty	= pl011_tx_empty,
>   	.set_mctrl	= pl011_set_mctrl,
>   	.get_mctrl	= pl011_get_mctrl,
> @@ -2519,10 +2531,12 @@ static int pl011_resume(struct device *dev)
>   #endif
>
>   static SIMPLE_DEV_PM_OPS(pl011_dev_pm_ops, pl011_suspend, pl011_resume);
> +static const struct of_device_id pl011_uart_plat_of_match[];
>
> -static int sbsa_uart_probe(struct platform_device *pdev)
> +static int pl011_uart_plat_probe(struct platform_device *pdev)
>   {
>   	struct uart_amba_port *uap;
> +	struct vendor_data *vendor;
>   	struct resource *r;
>   	int portnr, ret;
>   	int baudrate;
> @@ -2533,11 +2547,15 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>   	 */
>   	if (pdev->dev.of_node) {
>   		struct device_node *np = pdev->dev.of_node;
> +		const struct of_device_id *of_id =
> +			of_match_device(pl011_uart_plat_of_match, &pdev->dev);
>
>   		ret = of_property_read_u32(np, "current-speed", &baudrate);
>   		if (ret)
>   			return ret;
> +		vendor = (struct vendor_data *)of_id->data;
>   	} else {
> +		vendor = &vendor_sbsa;
>   		baudrate = 115200;
>   	}
>
> @@ -2550,15 +2568,15 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>   	if (!uap)
>   		return -ENOMEM;
>
> -	uap->reg_offset	= vendor_sbsa.reg_offset;
> -	uap->vendor	= &vendor_sbsa;
> -	uap->fifosize	= 32;
> -	uap->port.iotype = vendor_sbsa.access_32b ? UPIO_MEM32 : UPIO_MEM;
> +	uap->vendor	= vendor;
> +	uap->reg_offset	= vendor->reg_offset;
> +	uap->fifosize	= vendor->get_fifosize(NULL);
> +	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
>   	uap->port.irq	= platform_get_irq(pdev, 0);
> -	uap->port.ops	= &sbsa_uart_pops;
> +	uap->port.ops	= vendor->uart_pops;
>   	uap->fixed_baud = baudrate;
>
> -	snprintf(uap->type, sizeof(uap->type), "SBSA");
> +	snprintf(uap->type, sizeof(uap->type), "PL011 plat");
>
>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> @@ -2571,7 +2589,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>   	return pl011_register_port(uap);
>   }
>
> -static int sbsa_uart_remove(struct platform_device *pdev)
> +static int pl011_uart_plat_remove(struct platform_device *pdev)
>   {
>   	struct uart_amba_port *uap = platform_get_drvdata(pdev);
>
> @@ -2580,11 +2598,12 @@ static int sbsa_uart_remove(struct platform_device *pdev)
>   	return 0;
>   }
>
> -static const struct of_device_id sbsa_uart_of_match[] = {
> -	{ .compatible = "arm,sbsa-uart", },
> +static const struct of_device_id pl011_uart_plat_of_match[] = {
> +	{ .compatible = "arm,sbsa-uart", .data = &vendor_sbsa },
> +	{ .compatible = "zte,zx296702-uart", .data = &vendor_zte },
>   	{},
>   };
> -MODULE_DEVICE_TABLE(of, sbsa_uart_of_match);
> +MODULE_DEVICE_TABLE(of, pl011_uart_plat_of_match);
>
>   static const struct acpi_device_id sbsa_uart_acpi_match[] = {
>   	{ "ARMH0011", 0 },
> @@ -2592,12 +2611,12 @@ static const struct acpi_device_id sbsa_uart_acpi_match[] = {
>   };
>   MODULE_DEVICE_TABLE(acpi, sbsa_uart_acpi_match);
>
> -static struct platform_driver arm_sbsa_uart_platform_driver = {
> -	.probe		= sbsa_uart_probe,
> -	.remove		= sbsa_uart_remove,
> +static struct platform_driver pl011_uart_platform_driver = {
> +	.probe		= pl011_uart_plat_probe,
> +	.remove		= pl011_uart_plat_remove,
>   	.driver	= {
> -		.name	= "sbsa-uart",
> -		.of_match_table = of_match_ptr(sbsa_uart_of_match),
> +		.name	= "uart-pl011-plat",
> +		.of_match_table = of_match_ptr(pl011_uart_plat_of_match),
>   		.acpi_match_table = ACPI_PTR(sbsa_uart_acpi_match),
>   	},
>   };
> @@ -2632,14 +2651,14 @@ static int __init pl011_init(void)
>   {
>   	printk(KERN_INFO "Serial: AMBA PL011 UART driver\n");
>
> -	if (platform_driver_register(&arm_sbsa_uart_platform_driver))
> +	if (platform_driver_register(&pl011_uart_platform_driver))
>   		pr_warn("could not register SBSA UART platform driver\n");
>   	return amba_driver_register(&pl011_driver);
>   }
>
>   static void __exit pl011_exit(void)
>   {
> -	platform_driver_unregister(&arm_sbsa_uart_platform_driver);
> +	platform_driver_unregister(&pl011_uart_platform_driver);
>   	amba_driver_unregister(&pl011_driver);
>   }
>
>
