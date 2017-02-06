From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v13 1/2] serial: exar: split out the exar code from
 8250_pci
Date: Mon, 6 Feb 2017 20:37:44 +0100
Message-ID: <062c2d4f-8546-abdd-dbee-8f3871683147@siemens.com>
References: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485815302-5708-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2017-01-30 23:28, Sudip Mukherjee wrote:
> From: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> 
> Add the serial driver for the Exar chips. And also register the
> platform device for the GPIO provided by the Exar chips.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

...

> +static int default_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +			 int idx, unsigned int offset,
> +			 struct uart_8250_port *port)
> +{
> +	const struct exar8250_board *board = priv->board;
> +	unsigned int bar = 0;
> +
> +	port->port.iotype = UPIO_MEM;
> +	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> +	port->port.membase = pcim_iomap_table(pcidev)[bar] + offset;

This always gives you 0 for membase because you missed to call
pcim_iomap for bar 0.

Sorry to pick on this piece-wise, but I just ran into this bug now while
porting patches over.

> +	port->port.regshift = board->reg_shift;
> +
> +	return 0;
> +}
> +
> +static int
> +pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +		       struct uart_8250_port *port, int idx)
> +{
> +	unsigned int offset = idx * 0x200;
> +	unsigned int baud = 1843200;
> +
> +	port->port.uartclk = baud * 16;
> +	return default_setup(priv, pcidev, idx, offset, port);
> +}
> +
> +static int
> +pci_xr17c154_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +		   struct uart_8250_port *port, int idx)
> +{
> +	unsigned int offset = idx * 0x200;
> +	unsigned int baud = 921600;
> +
> +	port->port.uartclk = baud * 16;
> +	return default_setup(priv, pcidev, idx, offset, port);
> +}
> +
> +static void setup_gpio(u8 __iomem *p)
> +{
> +	writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
> +	writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
> +	writeb(0x00, p + UART_EXAR_MPIO3T_7_0);
> +	writeb(0x00, p + UART_EXAR_MPIOINV_7_0);
> +	writeb(0x00, p + UART_EXAR_MPIOSEL_7_0);
> +	writeb(0x00, p + UART_EXAR_MPIOOD_7_0);
> +	writeb(0x00, p + UART_EXAR_MPIOINT_15_8);
> +	writeb(0x00, p + UART_EXAR_MPIOLVL_15_8);
> +	writeb(0x00, p + UART_EXAR_MPIO3T_15_8);
> +	writeb(0x00, p + UART_EXAR_MPIOINV_15_8);
> +	writeb(0x00, p + UART_EXAR_MPIOSEL_15_8);
> +	writeb(0x00, p + UART_EXAR_MPIOOD_15_8);
> +}
> +
> +static void *
> +xr17v35x_register_gpio(struct pci_dev *pcidev)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_alloc("gpio_exar", PLATFORM_DEVID_AUTO);
> +	if (!pdev)
> +		return NULL;
> +
> +	platform_set_drvdata(pdev, pcidev);
> +	if (platform_device_add(pdev) < 0) {
> +		platform_device_put(pdev);
> +		return NULL;
> +	}
> +
> +	return pdev;
> +}
> +
> +static int
> +pci_xr17v35x_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> +		   struct uart_8250_port *port, int idx)
> +{
> +	const struct exar8250_board *board = priv->board;
> +	unsigned int offset = idx * 0x400;
> +	unsigned int baud = 7812500;
> +	u8 __iomem *p;
> +	int ret;
> +
> +	port->port.uartclk = baud * 16;
> +	/*
> +	 * Setup the uart clock for the devices on expansion slot to
> +	 * half the clock speed of the main chip (which is 125MHz)
> +	 */
> +	if (board->has_slave && idx >= 8)
> +		port->port.uartclk /= 2;
> +
> +	p = pci_ioremap_bar(pcidev, 0);

If we move the default_setup before this, we can use pcim_iomap_table()
and avoid this temporary mapping completely.

> +	if (!p)
> +		return -ENOMEM;
> +
> +	/* Setup Multipurpose Input/Output pins. */
> +	if (idx == 0)
> +		setup_gpio(p);
> +
> +	writeb(0x00, p + UART_EXAR_8XMODE);
> +	writeb(UART_FCTR_EXAR_TRGD, p + UART_EXAR_FCTR);
> +	writeb(128, p + UART_EXAR_TXTRG);
> +	writeb(128, p + UART_EXAR_RXTRG);
> +	iounmap(p);
> +
> +	ret = default_setup(priv, pcidev, idx, offset, port);
> +	if (ret)
> +		return ret;
> +
> +	if (idx == 0)
> +		port->port.private_data =
> +			xr17v35x_register_gpio(pcidev);
> +
> +	return 0;
> +}

I suppose I should still send patches on top, right?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
