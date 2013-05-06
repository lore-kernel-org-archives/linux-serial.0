From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH V2] tty/serial/mvf: add MVF uart driver support
Date: Mon, 6 May 2013 16:46:03 +0800
Message-ID: <20130506084601.GG1749@S2101-09.ap.freescale.net>
References: <1367480506-13220-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:58429
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752643Ab3EFIpu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 May 2013 04:45:50 -0400
Content-Disposition: inline
In-Reply-To: <1367480506-13220-1-git-send-email-b35083@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingchang Lu <b35083@freescale.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de

On Thu, May 02, 2013 at 03:41:46PM +0800, Jingchang Lu wrote:
> It adds Freescale Vybrid Family uart driver support
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>
> ---
> V2:
>   Remove unused variables and clean up the code
>   based on the comments for last version.
> 
>  drivers/tty/serial/Kconfig       |   17 +
>  drivers/tty/serial/Makefile      |    1 +
>  drivers/tty/serial/mvf.c         | 1053 ++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |    3 +

You should have a binding doc added in
Documentation/devicetree/bindings/tty/serial/.

>  4 files changed, 1074 insertions(+)
>  create mode 100644 drivers/tty/serial/mvf.c
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 7e7006f..032df6f 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -574,6 +574,23 @@ config SERIAL_IMX_CONSOLE
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>  
> +config SERIAL_MVF
> +	bool "Freescale Vybrid serial port support"
> +	depends on SOC_MVF600
> +	select SERIAL_CORE
> +	select RATIONAL
> +	help
> +	  If you have a machine based on a Freescale Vybrid CPU you
> +	  can enable its onboard serial port by enabling this option.
> +
> +config SERIAL_MVF_CONSOLE
> +	bool "Console on Vybrid serial port"
> +	depends on SERIAL_MVF
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  If you have enabled the serial port on the Freescale Vybrid family
> +	  CPU you can make it the console by answering Y to this option.
> +
>  config SERIAL_UARTLITE
>  	tristate "Xilinx uartlite serial port support"
>  	depends on PPC32 || MICROBLAZE || MFD_TIMBERDALE
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index eedfec4..be2ed68 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
>  obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) += sn_console.o
>  obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
>  obj-$(CONFIG_SERIAL_IMX) += imx.o
> +obj-$(CONFIG_SERIAL_MVF) += mvf.o
>  obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
>  obj-$(CONFIG_SERIAL_ICOM) += icom.o
>  obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
> diff --git a/drivers/tty/serial/mvf.c b/drivers/tty/serial/mvf.c
> new file mode 100644
> index 0000000..e265e14
> --- /dev/null
> +++ b/drivers/tty/serial/mvf.c
> @@ -0,0 +1,1053 @@
> +/*
> + *  Driver for Freescale Vybrid Family serial ports
> + *
> + *  Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#if defined(CONFIG_SERIAL_MVF_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/init.h>
> +#include <linux/console.h>
> +#include <linux/sysrq.h>
> +#include <linux/platform_device.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/rational.h>
> +#include <linux/slab.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/io.h>
> +#include <asm/irq.h>
> +#include <linux/platform_data/serial-imx.h>

You do not need this header at all.

It seems you copied all these headers from imx.c, but you should really
scan them to pick out what you actually need.

> +
> +/* All uart module registers for MVF is 8-bit width */
> +#define MXC_UARTBDH		0x00 /* Baud rate reg: high */

I do not like the prefix "MXC_".  You can use "MVF_" but I prefer to
not use any prefix.

I'm not sure how useful those comments following the definitions are.
I can even know the registers from the macro names.

Scanning the following bunch of marcos in the file, I found that many of
them are not used at all.  And I guess mostly they will never used in
this file.  I'm wondering why we define those unused registers and bits
at all.

> +#define MXC_UARTBDL		0x01 /* Baud rate reg: low */
> +#define MXC_UARTCR1		0x02 /* Control reg 1 */
> +#define MXC_UARTCR2		0x03 /* Control reg 2 */
> +#define MXC_UARTSR1		0x04 /* Status reg 1 */
> +#define MXC_UARTSR2		0x05 /* Status reg 2 */
> +#define MXC_UARTCR3		0x06 /* Control reg 3 */
> +#define MXC_UARTDR		0x07 /* Data reg */
> +#define MXC_UARTMAR1		0x08 /* Match address reg 1 */
> +#define MXC_UARTMAR2		0x09 /* Match address reg 2 */
> +#define MXC_UARTCR4		0x0A /* Control reg 4 */
> +#define MXC_UARTCR5		0x0B /* Control reg 5 */
> +#define MXC_UARTEDR		0x0C /* Extended data reg */
> +#define MXC_UARTMODEM		0x0D /* Modem reg */
> +#define MXC_UARTIR		0x0E /* Infrared reg */
> +#define MXC_UARTPFIFO		0x10 /* FIFO parameter reg */
> +#define MXC_UARTCFIFO		0x11 /* FIFO control reg */
> +#define MXC_UARTSFIFO		0x12 /* FIFO status reg */
> +#define MXC_UARTTWFIFO		0x13 /* FIFO transmit watermark reg */
> +#define MXC_UARTTCFIFO		0x14 /* FIFO transmit count reg */
> +#define MXC_UARTRWFIFO		0x15 /* FIFO receive watermark reg */
> +#define MXC_UARTRCFIFO		0x16 /* FIFO receive count reg */
> +#define MXC_UARTC7816		0x18 /* 7816 control reg */
> +#define MXC_UARTIE7816		0x19 /* 7816 interrupt enable reg */
> +#define MXC_UARTIS7816		0x1A /* 7816 interrupt status reg */
> +#define MXC_UARTWP7816T0	0x1B /* 7816 wait parameter reg */
> +#define MXC_UARTWP7816T1	0x1B /* 7816 wait parameter reg */
> +#define MXC_UARTWN7816		0x1C /* 7816 wait N reg */
> +#define MXC_UARTWF7816		0x1D /* 7816 wait FD reg */
> +#define MXC_UARTET7816		0x1E /* 7816 error threshold reg */
> +#define MXC_UARTTL7816		0x1F /* 7816 transmit length reg */
> +#define MXC_UARTCR6		0x21 /* CEA709.1-B contrl reg */
> +#define MXC_UARTPCTH		0x22 /* CEA709.1-B packet cycle counter high */
> +#define MXC_UARTPCTL		0x23 /* CEA709.1-B packet cycle counter low */
> +#define MXC_UARTB1T		0x24 /* CEA709.1-B beta 1 time */
> +#define MXC_UARTSDTH		0x25 /* CEA709.1-B secondary delay timer high */
> +#define MXC_UARTSDTL		0x26 /* CEA709.1-B secondary delay timer low */
> +#define MXC_UARTPRE		0x27 /* CEA709.1-B preamble */
> +#define MXC_UARTTPL		0x28 /* CEA709.1-B transmit packet length */
> +#define MXC_UARTIE		0x29 /* CEA709.1-B transmit interrupt enable */
> +#define MXC_UARTSR3		0x2B /* CEA709.1-B status reg */
> +#define MXC_UARTSR4		0x2C /* CEA709.1-B status reg */
> +#define MXC_UARTRPL		0x2D /* CEA709.1-B received packet length */
> +#define MXC_UARTRPREL		0x2E /* CEA709.1-B received preamble length */
> +#define MXC_UARTCPW		0x2F /* CEA709.1-B collision pulse width */
> +#define MXC_UARTRIDT		0x30 /* CEA709.1-B receive indeterminate time */
> +#define MXC_UARTTIDT		0x31 /* CEA709.1-B transmit indeterminate time*/
> +
> +/* Bit definations of BDH */
> +#define MXC_UARTBDH_LBKDIE	0x80 /* LIN break detect interrupt enable */
> +#define MXC_UARTBDH_RXEDGIE	0x40 /* RxD input Active edge interrupt enable*/
> +#define MXC_UARTBDH_SBR_MASK	0x1f /* Uart baud rate high 5-bits */
> +/* Bit definations of CR1 */
> +#define MXC_UARTCR1_LOOPS	0x80 /* Loop mode select */
> +#define MXC_UARTCR1_RSRC	0x20 /* Receiver source select */
> +#define MXC_UARTCR1_M		0x10 /* 9-bit 8-bit mode select */
> +#define MXC_UARTCR1_WAKE	0x08 /* Receiver wakeup method */
> +#define MXC_UARTCR1_ILT		0x04 /* Idle line type */
> +#define MXC_UARTCR1_PE		0x02 /* Parity enable */
> +#define MXC_UARTCR1_PT		0x01 /* Parity type */
> +/* Bit definations of CR2 */
> +#define MXC_UARTCR2_TIE		0x80 /* Tx interrupt or DMA request enable */
> +#define MXC_UARTCR2_TCIE	0x40 /* Transmission complete int enable */
> +#define MXC_UARTCR2_RIE		0x20 /* Rx full int or DMA request enable */
> +#define MXC_UARTCR2_ILIE	0x10 /* Idle line interrupt enable */
> +#define MXC_UARTCR2_TE		0x08 /* Transmitter enable */
> +#define MXC_UARTCR2_RE		0x04 /* Receiver enable */
> +#define MXC_UARTCR2_RWU		0x02 /* Receiver wakeup control */
> +#define MXC_UARTCR2_SBK		0x01 /* Send break */
> +/* Bit definations of SR1 */
> +#define MXC_UARTSR1_TDRE	0x80 /* Tx data reg empty */
> +#define MXC_UARTSR1_TC		0x40 /* Transmit complete */
> +#define MXC_UARTSR1_RDRF	0x20 /* Rx data reg full */
> +#define MXC_UARTSR1_IDLE	0x10 /* Idle line flag */
> +#define MXC_UARTSR1_OR		0x08 /* Receiver overrun */
> +#define MXC_UARTSR1_NF		0x04 /* Noise flag */
> +#define MXC_UARTSR1_FE		0x02 /* Frame error */
> +#define MXC_UARTSR1_PE		0x01 /* Parity error */
> +/* Bit definations of SR2 */
> +#define MXC_UARTSR2_LBKDIF	0x80 /* LIN brk detect interrupt flag */
> +#define MXC_UARTSR2_RXEDGIF	0x40 /* RxD pin active edge interrupt flag */
> +#define MXC_UARTSR2_MSBF	0x20 /* MSB first */
> +#define MXC_UARTSR2_RXINV	0x10 /* Receive data inverted */
> +#define MXC_UARTSR2_RWUID	0x08 /* Receive wakeup idle detect */
> +#define MXC_UARTSR2_BRK13	0x04 /* Break transmit character length */
> +#define MXC_UARTSR2_LBKDE	0x02 /* LIN break detection enable */
> +#define MXC_UARTSR2_RAF		0x01 /* Receiver active flag */
> +/* Bit definations of CR3 */
> +#define MXC_UARTCR3_R8		0x80 /* Received bit8, for 9-bit data format */
> +#define MXC_UARTCR3_T8		0x40 /* transmit bit8, for 9-bit data format */
> +#define MXC_UARTCR3_TXDIR	0x20 /* Tx pin direction in single-wire mode */
> +#define MXC_UARTCR3_TXINV	0x10 /* Transmit data inversion */
> +#define MXC_UARTCR3_ORIE	0x08 /* Overrun error interrupt enable */
> +#define MXC_UARTCR3_NEIE	0x04 /* Noise error interrupt enable */
> +#define MXC_UARTCR3_FEIE	0x02 /* Framing error interrupt enable */
> +#define MXC_UARTCR3_PEIE	0x01 /* Parity errror interrupt enable */
> +/* Bit definations of CR4 */
> +#define MXC_UARTCR4_MAEN1	0x80 /* Match address mode enable 1 */
> +#define MXC_UARTCR4_MAEN2	0x40 /* Match address mode enable 2 */
> +#define MXC_UARTCR4_M10		0x20 /* 10-bit mode select */
> +#define MXC_UARTCR4_BRFA_MASK	0x1F /* Baud rate fine adjust */
> +#define MXC_UARTCR4_BRFA_OFF	0
> +/* Bit definations of CR5 */
> +#define MXC_UARTCR5_TDMAS	0x80 /* Transmitter DMA select */
> +#define MXC_UARTCR5_RDMAS	0x20 /* Receiver DMA select */
> +/* Bit definations of Modem */
> +#define MXC_UARTMODEM_RXRTSE	0x08 /* Enable receiver request-to-send */
> +#define MXC_UARTMODEM_TXRTSPOL	0x04 /* Select transmitter RTS polarity */
> +#define MXC_UARTMODEM_TXRTSE	0x02 /* Enable transmitter request-to-send */
> +#define MXC_UARTMODEM_TXCTSE	0x01 /* Enable transmitter CTS clear-to-send */
> +/* Bit definations of EDR */
> +#define MXC_UARTEDR_NOISY	0x80 /* Current dataword received with noise */
> +#define MXC_UARTEDR_PARITYE	0x40 /* Dataword received with parity error */
> +/* Bit definations of Infrared reg(IR) */
> +#define MXC_UARTIR_IREN		0x04 /* Infrared enable */
> +#define MXC_UARTIR_TNP_MASK	0x03 /* Transmitter narrow pluse */
> +#define MXC_UARTIR_TNP_OFF	0
> +/* Bit definations of FIFO parameter reg */
> +#define MXC_UARTPFIFO_TXFE	0x80 /* Transmit fifo enable */
> +#define MXC_UARTPFIFO_FIFOSIZE_MASK	0x7
> +#define MXC_UARTPFIFO_TXFIFOSIZE_OFF	4
> +#define MXC_UARTPFIFO_RXFE	0x08 /* Receiver fifo enable */
> +#define MXC_UARTPFIFO_RXFIFOSIZE_OFF	0
> +/* Bit definations of FIFO control reg */
> +#define MXC_UARTCFIFO_TXFLUSH	0x80 /* Transmit FIFO/buffer flush */
> +#define MXC_UARTCFIFO_RXFLUSH	0x40 /* Receive FIFO/buffer flush */
> +#define MXC_UARTCFIFO_RXOFE	0x04 /* Receive fifo overflow INT enable */
> +#define MXC_UARTCFIFO_TXOFE	0x02 /* Transmit fifo overflow INT enable */
> +#define MXC_UARTCFIFO_RXUFE	0x01 /* Receive fifo underflow INT enable */
> +/* Bit definations of FIFO status reg */
> +#define MXC_UARTSFIFO_TXEMPT	0x80 /* Transmit fifo/buffer empty */
> +#define MXC_UARTSFIFO_RXEMPT	0x40 /* Receive fifo/buffer empty */
> +#define MXC_UARTSFIFO_RXOF	0x04 /* Rx buffer overflow flag */
> +#define MXC_UARTSFIFO_TXOF	0x02 /* Tx buffer overflow flag */
> +#define MXC_UARTSFIFO_RXUF	0x01 /* Rx buffer underflow flag */
> +
> +
> +/* follow IMX dev node number */
> +#define SERIAL_IMX_MAJOR	207
> +#define MINOR_START		24
> +#define DEV_NAME		"ttymxc"

I don't think we will likely run into it.  But will it be a problem if
we have a future SoC integrating both imx-uart and mvf-uart blocks?

> +#define DRIVER_NAME		"MVF-uart"
> +#define UART_NR			6
> +
> +struct mvf_port {
> +	struct uart_port	port;
> +	struct clk		*clk;
> +	unsigned int		tx_fifo_size, rx_fifo_size;
> +};
> +

---8<-------
> +enum mvf_uart_type {
> +	MVF600_UART,
> +};
> +
> +struct mvf_uart_data {
> +	enum mvf_uart_type devtype;
> +};
> +
> +static struct mvf_uart_data mvf_uart_devdata[] = {
> +	[MVF600_UART] = {
> +		.devtype = MVF600_UART,
> +	},
> +};
> +
> +static struct platform_device_id mvf_uart_devtype[] = {
> +	{
> +		.name = "mvf600-uart",
> +		.driver_data = (kernel_ulong_t) &mvf_uart_devdata[MVF600_UART],
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(platform, mvf_uart_devtype);
------->8---

The above stuff is completely useless.  The imx driver uses it to
handle differences between two revision of the IP block.

> +
> +static struct of_device_id mvf_uart_dt_ids[] = {
> +	{
> +		.compatible = "fsl,mvf-uart",
> +		.data = &mvf_uart_devdata[MVF600_UART],
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mvf_uart_dt_ids);

Remove .data field, and move the mvf_uart_dt_ids[] to where it's being
used, right before serial_mvf_driver definition.

<snip>

> +static int serial_mvf_probe_dt(struct mvf_port *sport,
> +		struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	if (!np)
> +		return 1; /* no device tree device */
> +
> +	ret = of_alias_get_id(np, "serial");
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> +		return ret;
> +	}
> +	sport->port.line = ret;
> +
> +	return 0;
> +}
> +
> +static int serial_mvf_probe(struct platform_device *pdev)
> +{
> +	struct mvf_port *sport;
> +	void __iomem *base;
> +	struct resource *res;
> +	struct pinctrl *pinctrl;
> +	int ret = 0;
> +
> +	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
> +	if (!sport)
> +		return -ENOMEM;
> +
> +	pdev->dev.coherent_dma_mask = 0;
> +
> +	ret = serial_mvf_probe_dt(sport, pdev);

We have this function for imx, because imx support both non-dt and dt
boot.  Since mvf supports dt boot only, I do not see the need of a DT
specific setup function.

> +	if (ret < 0)
> +		return ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (!base)
> +		return -ENOMEM;
> +
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl))
> +		dev_warn(&pdev->dev,
> +			"did not get pinctrl for uart%i error: %li\n",
> +			sport->port.line, PTR_ERR(pinctrl));

Driver core already handles this type of pinctrl setup, so we do not
need to explicitly do it again here.

> +
> +	sport->port.dev = &pdev->dev;
> +	sport->port.mapbase = res->start;
> +	sport->port.membase = base;
> +	sport->port.type = PORT_MVF,
> +	sport->port.iotype = UPIO_MEM;
> +	sport->port.irq = platform_get_irq(pdev, 0);
> +	sport->port.ops = &mvf_pops;
> +	sport->port.flags = UPF_BOOT_AUTOCONF;
> +
> +	sport->clk = devm_clk_get(&pdev->dev, "ipg");
> +	if (IS_ERR(sport->clk)) {
> +		ret = PTR_ERR(sport->clk);
> +		dev_err(&pdev->dev, "failed to get uart clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	clk_prepare_enable(sport->clk);
> +
> +	sport->port.uartclk = clk_get_rate(sport->clk);
> +
> +	mvf_ports[sport->port.line] = sport;
> +
> +	platform_set_drvdata(pdev, &sport->port);
> +
> +	ret = uart_add_one_port(&mvf_reg, &sport->port);
> +
> +	if (ret)
> +		goto clkput;
> +
> +	return 0;
> +clkput:
> +	clk_disable_unprepare(sport->clk);

The label name mismatches what it does.  The name says it puts clk while
it disables clock acutally.

> +
> +	return ret;
> +}
> +
> +static int serial_mvf_remove(struct platform_device *pdev)
> +{
> +	struct mvf_port *sport = platform_get_drvdata(pdev);
> +
> +	uart_remove_one_port(&mvf_reg, &sport->port);
> +
> +	clk_disable_unprepare(sport->clk);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver serial_mvf_driver = {
> +	.probe		= serial_mvf_probe,
> +	.remove		= serial_mvf_remove,
> +
Remove the blank line.

> +	.suspend	= serial_mvf_suspend,
> +	.resume		= serial_mvf_resume,

Shouldn't they be protected by #ifdef CONFIG_PM check?

> +	.id_table       = mvf_uart_devtype,
> +	.driver		= {
> +		.name	= "mvf-uart",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = mvf_uart_dt_ids,
> +	},
> +};
> +
> +static int __init mvf_serial_init(void)
> +{
> +	int ret;
> +
> +	pr_info("Serial: Freescale Vybrid Family driver\n");
> +
> +	ret = uart_register_driver(&mvf_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&serial_mvf_driver);
> +	if (ret != 0)

This is inconsistent with if (ret) check right above.

Shawn

> +		uart_unregister_driver(&mvf_reg);
> +
> +	return 0;
> +}
> +
> +static void __exit mvf_serial_exit(void)
> +{
> +	platform_driver_unregister(&serial_mvf_driver);
> +	uart_unregister_driver(&mvf_reg);
> +}
> +
> +module_init(mvf_serial_init);
> +module_exit(mvf_serial_exit);
> +
> +MODULE_DESCRIPTION("Freescale Vybrid Family serial port driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 74c2bf7..ffb7192 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -226,4 +226,7 @@
>  /* Rocketport EXPRESS/INFINITY */
>  #define PORT_RP2	102
>  
> +/* Freescale Vybrid uart */
> +#define PORT_MVF	103
> +
>  #endif /* _UAPILINUX_SERIAL_CORE_H */
> -- 
> 1.8.0
> 
> 

