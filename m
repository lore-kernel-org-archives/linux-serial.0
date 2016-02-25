From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] tty: serial: 8250: add MOXA Smartio MUE boards
 support
Date: Thu, 25 Feb 2016 15:25:28 +0200
Message-ID: <1456406728.13244.75.camel@linux.intel.com>
References: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, JBeulich@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-02-24 at 20:10 +0100, Mathieu OTHACEHE wrote:
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
>=20
> Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>=20
> Hi,
>=20
> Here is v3 of the patch, it fixes problems pointed out by
> last Andy review.
>=20
> Thanks,
> Mathieu
>=20
> Changelog:
> V3:
> * Add supported boards to 8250_pci blacklist
> * Use MOXA_DEVICE macro to simplify pci_device_id declaration
> V2:
> * Move everything to 8250_moxa.c
> * Use PCI_DEVICE macro
> * Group driver_data by port number as this is the only singularity
> between boards.
>=20
> =C2=A0drivers/tty/serial/8250/8250_moxa.c | 157
> ++++++++++++++++++++++++++++++++++++
> =C2=A0drivers/tty/serial/8250/8250_pci.c=C2=A0=C2=A0|=C2=A0=C2=A014 +=
+++
> =C2=A0drivers/tty/serial/8250/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A010 +++
> =C2=A0drivers/tty/serial/8250/Makefile=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A0=C2=A01 +
> =C2=A04 files changed, 182 insertions(+)
> =C2=A0create mode 100644 drivers/tty/serial/8250/8250_moxa.c
>=20
> diff --git a/drivers/tty/serial/8250/8250_moxa.c
> b/drivers/tty/serial/8250/8250_moxa.c
> new file mode 100644
> index 0000000..26eb539
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_moxa.c
> @@ -0,0 +1,157 @@
> +/*
> + * 8250_moxa.c - MOXA Smartio/Industio MUE multiport serial driver.
> + *
> + * Author: Mathieu OTHACEHE <m.othacehe@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "8250.h"
> +
> +#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
> +#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
> +#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
> +#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
> +#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
> +#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161
> +#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
> +#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
> +#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
> +#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
> +#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
> +#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
> +
> +#define MOXA_BASE_BAUD 921600
> +#define MOXA_UART_OFFSET 0x200
> +#define MOXA_BASE_BAR 1
> +
> +struct moxa8250_board {
> +	unsigned int num_ports;
> +	int line[0];
> +};
> +
> +enum {
> +	moxa8250_2p =3D 0,
> +	moxa8250_4p,
> +	moxa8250_8p
> +};
> +
> +static struct moxa8250_board moxa8250_boards[] =3D {
> +	[moxa8250_2p] =3D { .num_ports =3D 2},
> +	[moxa8250_4p] =3D { .num_ports =3D 4},
> +	[moxa8250_8p] =3D { .num_ports =3D 8},
> +};
> +
> +static int moxa8250_probe(struct pci_dev *pdev, const struct
> pci_device_id *id)
> +{
> +	struct uart_8250_port uart;
> +	struct moxa8250_board *brd;
> +	void __iomem *ioaddr;
> +	resource_size_t baseaddr;
> +	unsigned int i, nr_ports;
> +	unsigned int offset;
> +	int ret;
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
> +	uart.port.uartclk =3D MOXA_BASE_BAUD * 16;
> +	uart.port.flags =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF |
> UPF_SHARE_IRQ;
> +
> +	baseaddr =3D pci_resource_start(pdev, MOXA_BASE_BAR);
> +	ioaddr =3D pcim_iomap(pdev, MOXA_BASE_BAR, 0);
> +	if (!ioaddr)
> +		return -ENOMEM;
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
> +		uart.port.mapbase =3D baseaddr + offset;
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
> +	unsigned int i;
> +
> +	for (i =3D 0; i < brd->num_ports; i++)
> +		serial8250_unregister_port(brd->line[i]);
> +}
> +
> +#define MOXA_DEVICE(id, data) { PCI_VDEVICE(MOXA, id),
> (kernel_ulong_t)data }
> +
> +static const struct pci_device_id pci_ids[] =3D {
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP102E, moxa8250_2p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP102EL, moxa8250_2p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP104EL_A, moxa8250_4p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP114EL, moxa8250_4p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP116E_A_A, moxa8250_8p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP116E_A_B, moxa8250_8p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP118EL_A, moxa8250_8p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP118E_A_I, moxa8250_8p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP132EL, moxa8250_2p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP134EL_A, moxa8250_4p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP138E_A, moxa8250_8p),
> +	MOXA_DEVICE(PCI_DEVICE_ID_MOXA_CP168EL_A, moxa8250_8p),
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, pci_ids);
> +
> +static struct pci_driver moxa8250_pci_driver =3D {
> +	.name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=3D "8250_moxa",
> +	.id_table=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D pci_ids,
> +	.probe=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D=
 moxa8250_probe,
> +	.remove=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D mo=
xa8250_remove,
> +};
> +
> +module_pci_driver(moxa8250_pci_driver);
> +
> +MODULE_AUTHOR("Mathieu OTHACEHE");
> +MODULE_DESCRIPTION("MOXA SmartIO MUE driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/tty/serial/8250/8250_pci.c
> b/drivers/tty/serial/8250/8250_pci.c
> index 0fc6ab5..855d16d 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3952,6 +3952,20 @@ static const struct pci_device_id blacklist[]
> =3D {
> =C2=A0	{ PCI_DEVICE(0x1c00, 0x3250), }, /* WCH CH382 2S1P */
> =C2=A0	{ PCI_DEVICE(0x1c00, 0x3470), }, /* WCH CH384 4S */
> =C2=A0
> +	/* Moxa Smartio MUE boards handled by 8250_moxa */
> +	{ PCI_VDEVICE(MOXA, 0x1024), },
> +	{ PCI_VDEVICE(MOXA, 0x1025), },
> +	{ PCI_VDEVICE(MOXA, 0x1045), },
> +	{ PCI_VDEVICE(MOXA, 0x1144), },
> +	{ PCI_VDEVICE(MOXA, 0x1160), },
> +	{ PCI_VDEVICE(MOXA, 0x1161), },
> +	{ PCI_VDEVICE(MOXA, 0x1182), },
> +	{ PCI_VDEVICE(MOXA, 0x1183), },
> +	{ PCI_VDEVICE(MOXA, 0x1322), },
> +	{ PCI_VDEVICE(MOXA, 0x1342), },
> +	{ PCI_VDEVICE(MOXA, 0x1381), },
> +	{ PCI_VDEVICE(MOXA, 0x1683), },
> +
> =C2=A0	/* Intel platforms with MID UART */
> =C2=A0	{ PCI_VDEVICE(INTEL, 0x081b), },
> =C2=A0	{ PCI_VDEVICE(INTEL, 0x081c), },
> diff --git a/drivers/tty/serial/8250/Kconfig
> b/drivers/tty/serial/8250/Kconfig
> index 67ad6b0..349f571 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -402,6 +402,16 @@ config SERIAL_8250_MID
> =C2=A0	=C2=A0=C2=A0present on the UART found on Intel Medfield SOC an=
d
> various other
> =C2=A0	=C2=A0=C2=A0Intel platforms.
> =C2=A0
> +config SERIAL_8250_MOXA
> +	tristate "MOXA SmartIO MUE support"
> +	depends on SERIAL_8250 && PCI
> +	help
> +	=C2=A0=C2=A0Say Y here if you have a Moxa SmartIO MUE multiport ser=
ial
> card.
> +	=C2=A0=C2=A0If unsure, say N.
> +
> +	=C2=A0=C2=A0This driver can also be built as a module. The module w=
ill
> be called
> +	=C2=A0=C2=A08250_moxa. If you want to do that, say M here.
> +
> =C2=A0config SERIAL_OF_PLATFORM
> =C2=A0	tristate "Devicetree based probing for 8250 ports"
> =C2=A0	depends on SERIAL_8250 && OF
> diff --git a/drivers/tty/serial/8250/Makefile
> b/drivers/tty/serial/8250/Makefile
> index 5c1869f..c9a2d6e 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+=3D
> 8250_mtk.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+=3D 8250_uniphier.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_INGENIC)	+=3D 8250_ingenic.o
> =C2=A0obj-$(CONFIG_SERIAL_8250_MID)		+=3D 8250_mid.o
> +obj-$(CONFIG_SERIAL_8250_MOXA)		+=3D 8250_moxa.o
> =C2=A0obj-$(CONFIG_SERIAL_OF_PLATFORM)	+=3D 8250_of.o
> =C2=A0
> =C2=A0CFLAGS_8250_ingenic.o +=3D -I$(srctree)/scripts/dtc/libfdt

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
