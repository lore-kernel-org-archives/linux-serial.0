From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Fri, 31 Mar 2017 15:31:20 +0200
Message-ID: <20170331133120.GA26078@kroah.com>
References: <20170328054458.29341-1-joel@jms.id.au>
 <20170328054458.29341-3-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170328054458.29341-3-joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
Cc: Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 04:14:58PM +1030, Joel Stanley wrote:
> From: Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
> 
> This change adds a driver for the 16550-based Aspeed virtual UART
> device. We use a similar process to the of_serial driver for device
> probe, but expose some VUART-specific functions through sysfs too.
> 
> OpenPOWER host firmware doesn't like it when the host-side of the
> VUART's FIFO is not drained. This driver only disables host TX discard
> mode when the port is in use. We set the VUART enabled bit when we bind
> to the device, and clear it on unbind.
> 
> We don't want to do this on open/release, as the host may be using this
> bit to configure serial output modes, which is independent of whether
> the devices has been opened by BMC userspace.
> 
> Signed-off-by: Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/serial/8250.txt |   2 +
>  drivers/tty/serial/Kconfig                        |  10 +
>  drivers/tty/serial/Makefile                       |   1 +
>  drivers/tty/serial/aspeed-vuart.c                 | 335 ++++++++++++++++++++++
>  4 files changed, 348 insertions(+)
>  create mode 100644 drivers/tty/serial/aspeed-vuart.c
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index f86bb06c39e9..a12e9277ac5d 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -19,6 +19,8 @@ Required properties:
>  	- "altr,16550-FIFO128"
>  	- "fsl,16550-FIFO64"
>  	- "fsl,ns16550"
> +	- "aspeed,ast2400-vuart"
> +	- "aspeed,ast2500-vuart"
>  	- "serial" if the port type is unknown.
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index e9cf5b67f1b7..758b69a51078 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1129,6 +1129,16 @@ config SERIAL_NETX_CONSOLE
>  	  If you have enabled the serial port on the Hilscher NetX SoC
>  	  you can make it the console by answering Y to this option.
>  
> +config SERIAL_ASPEED_VUART
> +	tristate "Aspeed Virtual UART"
> +	depends on OF
> +	depends on SERIAL_8250
> +	help
> +	  If you want to use the virtual UART (VUART) device on Aspeed
> +	  BMC platforms, enable this option. This enables the 16550A-
> +	  compatible device on the local LPC bus, giving a UART device
> +	  with no physical RS232 connections.
> +
>  config SERIAL_OMAP
>  	tristate "OMAP serial port support"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index 2d6288bc4554..5b97b0fa29e2 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_SERIAL_8250) += 8250/
>  
>  obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
>  obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
> +obj-$(CONFIG_SERIAL_ASPEED_VUART) += aspeed-vuart.o
>  obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
>  obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
>  obj-$(CONFIG_SERIAL_PNX8XXX) += pnx8xxx_uart.o
> diff --git a/drivers/tty/serial/aspeed-vuart.c b/drivers/tty/serial/aspeed-vuart.c
> new file mode 100644
> index 000000000000..fc6fa6d243c8
> --- /dev/null
> +++ b/drivers/tty/serial/aspeed-vuart.c
> @@ -0,0 +1,335 @@
> +/*
> + *  Serial Port driver for Aspeed VUART device
> + *
> + *    Copyright (C) 2016 Jeremy Kerr <jk-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, IBM Corp.
> + *    Copyright (C) 2006 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, IBM Corp.
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + *
> + */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/clk.h>
> +
> +#include "8250/8250.h"
> +
> +#define AST_VUART_GCRA		0x20
> +#define AST_VUART_GCRA_VUART_EN		0x01
> +#define AST_VUART_GCRA_HOST_TX_DISCARD	0x20
> +#define AST_VUART_GCRB		0x24
> +#define AST_VUART_GCRB_HOST_SIRQ_MASK	0xf0
> +#define AST_VUART_GCRB_HOST_SIRQ_SHIFT	4
> +#define AST_VUART_ADDRL		0x28
> +#define AST_VUART_ADDRH		0x2c
> +
> +struct ast_vuart {
> +	struct platform_device *pdev;
> +	void __iomem		*regs;
> +	struct clk		*clk;
> +	int			line;
> +};
> +
> +static ssize_t ast_vuart_show_addr(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ast_vuart *vuart = dev_get_drvdata(dev);
> +	u16 addr;
> +
> +	addr = (readb(vuart->regs + AST_VUART_ADDRH) << 8) |
> +		(readb(vuart->regs + AST_VUART_ADDRL));
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "0x%x\n", addr);
> +}
> +
> +static ssize_t ast_vuart_set_addr(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct ast_vuart *vuart = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int err;
> +
> +	err = kstrtoul(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +	writeb((val >> 8) & 0xff, vuart->regs + AST_VUART_ADDRH);
> +	writeb((val >> 0) & 0xff, vuart->regs + AST_VUART_ADDRL);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(lpc_address, 0664,
> +		ast_vuart_show_addr, ast_vuart_set_addr);

DEVICE_ATTR_RW()?

And why random sysfs files for a uart?  Where have you documented these?

> +
> +static ssize_t ast_vuart_show_sirq(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct ast_vuart *vuart = dev_get_drvdata(dev);
> +	u8 reg;
> +
> +	reg = readb(vuart->regs + AST_VUART_GCRB);
> +	reg &= AST_VUART_GCRB_HOST_SIRQ_MASK;
> +	reg >>= AST_VUART_GCRB_HOST_SIRQ_SHIFT;
> +
> +	return snprintf(buf, PAGE_SIZE - 1, "%u\n", reg);
> +}
> +
> +static ssize_t ast_vuart_set_sirq(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct ast_vuart *vuart = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int err;
> +	u8 reg;
> +
> +	err = kstrtoul(buf, 0, &val);
> +	if (err)
> +		return err;
> +
> +	val <<= AST_VUART_GCRB_HOST_SIRQ_SHIFT;
> +	val &= AST_VUART_GCRB_HOST_SIRQ_MASK;
> +
> +	reg = readb(vuart->regs + AST_VUART_GCRB);
> +	reg &= ~AST_VUART_GCRB_HOST_SIRQ_MASK;
> +	reg |= val;
> +	writeb(reg, vuart->regs + AST_VUART_GCRB);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(sirq, 0664,
> +		ast_vuart_show_sirq, ast_vuart_set_sirq);

DEVICE_ATTR_RW().

> +
> +static void ast_vuart_set_enabled(struct ast_vuart *vuart, bool enabled)
> +{
> +	u8 reg;
> +
> +	reg = readb(vuart->regs + AST_VUART_GCRA);
> +	reg &= ~AST_VUART_GCRA_VUART_EN;
> +	if (enabled)
> +		reg |= AST_VUART_GCRA_VUART_EN;
> +	writeb(reg, vuart->regs + AST_VUART_GCRA);
> +}
> +
> +static void ast_vuart_set_host_tx_discard(struct ast_vuart *vuart, bool discard)
> +{
> +	u8 reg;
> +
> +	reg = readb(vuart->regs + AST_VUART_GCRA);
> +
> +	/* if the HOST_TX_DISCARD bit is set, discard is *disabled* */
> +	reg &= ~AST_VUART_GCRA_HOST_TX_DISCARD;
> +	if (!discard)
> +		reg |= AST_VUART_GCRA_HOST_TX_DISCARD;
> +
> +	writeb(reg, vuart->regs + AST_VUART_GCRA);
> +}
> +
> +static int ast_vuart_startup(struct uart_port *uart_port)
> +{
> +	struct uart_8250_port *uart_8250_port = up_to_u8250p(uart_port);
> +	struct ast_vuart *vuart = uart_8250_port->port.private_data;
> +	int rc;
> +
> +	rc = serial8250_do_startup(uart_port);
> +	if (rc)
> +		return rc;
> +
> +	ast_vuart_set_host_tx_discard(vuart, false);
> +
> +	return 0;
> +}
> +
> +static void ast_vuart_shutdown(struct uart_port *uart_port)
> +{
> +	struct uart_8250_port *uart_8250_port = up_to_u8250p(uart_port);
> +	struct ast_vuart *vuart = uart_8250_port->port.private_data;
> +
> +	ast_vuart_set_host_tx_discard(vuart, true);
> +
> +	serial8250_do_shutdown(uart_port);
> +}
> +
> +
> +/**
> + * The device tree parsing code here is heavily based on that of the of_serial
> + * driver, but we have a few core differences, as we need to use our own
> + * ioremapping for extra register support
> + */
> +static int ast_vuart_probe(struct platform_device *pdev)
> +{
> +	struct uart_8250_port port;
> +	struct resource resource;
> +	struct ast_vuart *vuart;
> +	struct device_node *np;
> +	u32 clk, prop;
> +	int rc;
> +
> +	np = pdev->dev.of_node;
> +
> +	vuart = devm_kzalloc(&pdev->dev, sizeof(*vuart), GFP_KERNEL);
> +	if (!vuart)
> +		return -ENOMEM;
> +
> +	vuart->pdev = pdev;
> +	rc = of_address_to_resource(np, 0, &resource);
> +	if (rc) {
> +		dev_warn(&pdev->dev, "invalid address\n");
> +		return rc;
> +	}
> +
> +	/* create our own mapping for VUART-specific registers */
> +	vuart->regs = devm_ioremap_resource(&pdev->dev, &resource);
> +	if (IS_ERR(vuart->regs)) {
> +		dev_warn(&pdev->dev, "failed to map registers\n");
> +		return PTR_ERR(vuart->regs);
> +	}
> +
> +	memset(&port, 0, sizeof(port));
> +	port.port.private_data = vuart;
> +	port.port.membase = vuart->regs;
> +	port.port.mapbase = resource.start;
> +	port.port.mapsize = resource_size(&resource);
> +	port.port.startup = ast_vuart_startup;
> +	port.port.shutdown = ast_vuart_shutdown;
> +
> +	if (of_property_read_u32(np, "clock-frequency", &clk)) {
> +		vuart->clk = devm_clk_get(&pdev->dev, NULL);
> +		if (IS_ERR(vuart->clk)) {
> +			dev_warn(&pdev->dev,
> +				"clk or clock-frequency not defined\n");
> +			return PTR_ERR(vuart->clk);
> +		}
> +
> +		rc = clk_prepare_enable(vuart->clk);
> +		if (rc < 0)
> +			return rc;
> +
> +		clk = clk_get_rate(vuart->clk);
> +	}
> +
> +	/* If current-speed was set, then try not to change it. */
> +	if (of_property_read_u32(np, "current-speed", &prop) == 0)
> +		port.port.custom_divisor = clk / (16 * prop);
> +
> +	/* Check for shifted address mapping */
> +	if (of_property_read_u32(np, "reg-offset", &prop) == 0)
> +		port.port.mapbase += prop;
> +
> +	/* Check for registers offset within the devices address range */
> +	if (of_property_read_u32(np, "reg-shift", &prop) == 0)
> +		port.port.regshift = prop;
> +
> +	/* Check for fifo size */
> +	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
> +		port.port.fifosize = prop;
> +
> +	/* Check for a fixed line number */
> +	rc = of_alias_get_id(np, "serial");
> +	if (rc >= 0)
> +		port.port.line = rc;
> +
> +	port.port.irq = irq_of_parse_and_map(np, 0);
> +	port.port.irqflags = IRQF_SHARED;
> +	port.port.iotype = UPIO_MEM;
> +	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +		switch (prop) {
> +		case 1:
> +			port.port.iotype = UPIO_MEM;
> +			break;
> +		case 4:
> +			port.port.iotype = of_device_is_big_endian(np) ?
> +				       UPIO_MEM32BE : UPIO_MEM32;
> +			break;
> +		default:
> +			dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> +				 prop);
> +			rc = -EINVAL;
> +			goto err_clk_disable;
> +		}
> +	}
> +
> +	port.port.type = PORT_16550A;
> +	port.port.uartclk = clk;
> +	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> +		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
> +
> +	if (of_find_property(np, "no-loopback-test", NULL))
> +		port.port.flags |= UPF_SKIP_TEST;
> +
> +	port.port.dev = &pdev->dev;
> +
> +	if (port.port.fifosize)
> +		port.capabilities = UART_CAP_FIFO;
> +
> +	if (of_property_read_bool(pdev->dev.of_node,
> +				  "auto-flow-control"))
> +		port.capabilities |= UART_CAP_AFE;
> +
> +	rc = serial8250_register_8250_port(&port);
> +	if (rc < 0)
> +		goto err_clk_disable;
> +
> +
> +	vuart->line = rc;
> +	ast_vuart_set_enabled(vuart, true);
> +	ast_vuart_set_host_tx_discard(vuart, true);
> +	platform_set_drvdata(pdev, vuart);
> +
> +	/* extra sysfs control */
> +	rc = device_create_file(&pdev->dev, &dev_attr_lpc_address);
> +	if (rc)
> +		dev_warn(&pdev->dev, "can't create lpc_address file\n");
> +	rc = device_create_file(&pdev->dev, &dev_attr_sirq);
> +	if (rc)
> +		dev_warn(&pdev->dev, "can't create sirq file\n");

use an attribute group?  You just raced userspace and lost :(

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
