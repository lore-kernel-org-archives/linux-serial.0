From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] tty: serial: 8250: add MOXA Smartio MUE boards
 support
Date: Mon, 22 Feb 2016 11:15:48 +0200
Message-ID: <1456132548.13244.14.camel@linux.intel.com>
References: <1455966026-19245-1-git-send-email-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455966026-19245-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, JBeulich@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sat, 2016-02-20 at 12:00 +0100, Mathieu OTHACEHE wrote:
> Add support for :
>=20
> - CP-102E: 2 ports RS232 PCIE card
> - CP-102EL: 2 ports RS232 PCIE card
> - CP-132EL: 2 ports RS422/485 PCIE card
> - CP-114EL: 4 ports RS232/422/485 PCIE card
> - CP-104EL-A: 4 ports RS232 PCIE card
> - CP-168EL-A: 8 ports RS232 PCIE card
> - CP-118EL-A: 8 ports RS232/422/485 PCIE card
> - CP-118E-A: 8 ports RS422/485 PCIE card
> - CP-138E-A: 8 ports RS422/485 PCIE card
> - CP-134EL-A: 4 ports RS422/485 PCIE card
> - CP-116E-A (A): 8 ports RS232/422/485 PCIE card
> - CP-116E-A (B): 8 ports RS232/422/485 PCIE card
>=20
> This patch is based on information extracted from
> vendor mxupcie driver available on MOXA website.
>=20
> I was able to test it on a CP-168EL-A on PC.

Looks much better!
Though few comments below.

> +static int moxa8250_probe(struct pci_dev *pdev, const struct
> pci_device_id *id)
> +{
> +	struct uart_8250_port uart;
> +	struct moxa8250_board *brd;
> +	void __iomem *ioaddr;
> +	int nr_ports, ret, i, offset;

i looks like unsigned and maybe split per logical lines? I don't think
nr_ports correlates to ret somehow, same for the rest.

unsigned int i, nr_ports;
=2E.. offset;
int ret;

?

> +
> +	brd =3D &moxa8250_boards[id->driver_data];
> +	nr_ports =3D brd->num_ports;
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	brd =3D devm_kzalloc(&pdev->dev, sizeof(struct moxa8250_board)
> +
> +			=C2=A0=C2=A0=C2=A0sizeof(unsigned int) * nr_ports,
> GFP_KERNEL);
> +	if (!brd)
> +		return -ENOMEM;
> +
> +	memset(&uart, 0, sizeof(struct uart_8250_port));
> +
> +	uart.port.dev =3D &pdev->dev;
> +	uart.port.irq =3D pdev->irq;
> +	uart.port.private_data =3D brd;
> +	uart.port.uartclk =3D MOXA_BASE_BAUD * 16;
> +	uart.port.flags =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF |
> UPF_SHARE_IRQ;
> +
> +	ioaddr =3D pcim_iomap(pdev, 1, 0);

And if we got NULL here?

1 is magic bar number, perhaps define it.

> +
> +	for (i =3D 0; i < nr_ports; i++) {
> +
> +		/*
> +		=C2=A0* MOXA Smartio MUE boards with 4 ports have
> +		=C2=A0* a different offset for port #3
> +		=C2=A0*/
> +		if (nr_ports =3D=3D 4 && i =3D=3D 3)
> +			offset =3D 7 * MOXA_UART_OFFSET;
> +		else
> +			offset =3D i * MOXA_UART_OFFSET;
> +
> +		uart.port.iotype =3D UPIO_MEM;
> +		uart.port.iobase =3D 0;
> +		uart.port.mapbase =3D pci_resource_start(pdev, 1) +
> offset;
> +		uart.port.membase =3D ioaddr + offset;
> +		uart.port.regshift =3D 0;
> +
> +		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq
> %d, type %d\n",
> +			uart.port.iobase, uart.port.irq,
> uart.port.iotype);
> +
> +		brd->line[i] =3D serial8250_register_8250_port(&uart);
> +		if (brd->line[i] < 0) {
> +			dev_err(&pdev->dev,
> +				"Couldn't register serial port %lx,
> irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq,
> +				uart.port.iotype, brd->line[i]);
> +			break;
> +		}
> +	}
> +
> +	pci_set_drvdata(pdev, brd);
> +	return 0;
> +}
> +
> +static void moxa8250_remove(struct pci_dev *pdev)
> +{
> +	struct moxa8250_board *brd =3D pci_get_drvdata(pdev);
> +	int i;

unsigned

> +
> +	for (i =3D 0; i < brd->num_ports; i++)
> +		serial8250_unregister_port(brd->line[i]);
> +}
> +
> +static const struct pci_device_id pci_ids[] =3D {
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102E),

=2E..and PCI_VDEVICE will look even shorter!

>=20
> +	=C2=A0.driver_data =3D moxa8250_2p},

Maybe a macro which will also cast to kernel_ulong_t ?

Something like

#define MOXA_DEVICE(id,data) { PCI_VDEVICE(MOXA, id), .driver_data =3D
(kernel_ulong_t)(data) }

static const struct pci_device_id pci_ids[] =3D {
=C2=A0
MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP102E, moxa8250_2p),
=C2=A0 ...
};


> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102EL),
> +	=C2=A0.driver_data =3D moxa8250_2p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP104EL_A),
> +	=C2=A0.driver_data =3D moxa8250_4p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114EL),
> +	=C2=A0.driver_data =3D moxa8250_4p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP116E_A_A),
> +	=C2=A0.driver_data =3D moxa8250_8p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP116E_A_B),
> +	=C2=A0.driver_data =3D moxa8250_8p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP118EL_A),
> +	=C2=A0.driver_data =3D moxa8250_8p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP118E_A_I),
> +	=C2=A0.driver_data =3D moxa8250_8p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132EL),
> +	=C2=A0.driver_data =3D moxa8250_2p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP134EL_A),
> +	=C2=A0.driver_data =3D moxa8250_4p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP138E_A),
> +	=C2=A0.driver_data =3D moxa8250_8p},
> +	{PCI_DEVICE(PCI_VENDOR_ID_MOXA,
> PCI_DEVICE_ID_MOXA_CP168EL_A),
> +	=C2=A0.driver_data =3D moxa8250_8p},

I think your device provides a PCI serial class, thus you have to
blacklist them in 8250_pci.c.

> +	{0}
> +};

> +};

Redundant empty line.

> +MODULE_DEVICE_TABLE(pci, pci_ids);

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
