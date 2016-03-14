From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Subject: Re: [PATCH v3] tty: serial: 8250: add MOXA Smartio MUE boards support
Date: Mon, 14 Mar 2016 12:36:54 +0300
Message-ID: <56E68636.8000002@gmail.com>
References: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456341022-8897-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, JBeulich@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

24.02.2016 22:10, Mathieu OTHACEHE =EF=E8=F8=E5=F2:
> Add support for :
>
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
>
> This patch is based on information extracted from
> vendor mxupcie driver available on MOXA website.
>
> I was able to test it on a CP-168EL-A on PC.

Hi,

Are you currently planning to add RS485 support to this module?
I mean TIOCGRS485/TIOCSRS485.

I have old MOXA CP-132U PCI-based board in may labs.
What do you think, should 8250_moxa also support PCI-based boards?

>
> Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
> ---
>
> Hi,
>
> Here is v3 of the patch, it fixes problems pointed out by
> last Andy review.
>
> Thanks,
> Mathieu
>
> Changelog:
> V3:
> * Add supported boards to 8250_pci blacklist
> * Use MOXA_DEVICE macro to simplify pci_device_id declaration
> V2:
> * Move everything to 8250_moxa.c
> * Use PCI_DEVICE macro
> * Group driver_data by port number as this is the only singularity be=
tween boards.
>
>   drivers/tty/serial/8250/8250_moxa.c | 157 +++++++++++++++++++++++++=
+++++++++++
>   drivers/tty/serial/8250/8250_pci.c  |  14 ++++
>   drivers/tty/serial/8250/Kconfig     |  10 +++
>   drivers/tty/serial/8250/Makefile    |   1 +
>   4 files changed, 182 insertions(+)
>   create mode 100644 drivers/tty/serial/8250/8250_moxa.c
>
> diff --git a/drivers/tty/serial/8250/8250_moxa.c b/drivers/tty/serial=
/8250/8250_moxa.c
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
> + * This program is free software; you can redistribute it and/or mod=
ify
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
> +static int moxa8250_probe(struct pci_dev *pdev, const struct pci_dev=
ice_id *id)
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
> +	brd =3D devm_kzalloc(&pdev->dev, sizeof(struct moxa8250_board) +
> +			   sizeof(unsigned int) * nr_ports, GFP_KERNEL);
> +	if (!brd)
> +		return -ENOMEM;
> +
> +	memset(&uart, 0, sizeof(struct uart_8250_port));
> +
> +	uart.port.dev =3D &pdev->dev;
> +	uart.port.irq =3D pdev->irq;
> +	uart.port.uartclk =3D MOXA_BASE_BAUD * 16;
> +	uart.port.flags =3D UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_I=
RQ;
> +
> +	baseaddr =3D pci_resource_start(pdev, MOXA_BASE_BAR);
> +	ioaddr =3D pcim_iomap(pdev, MOXA_BASE_BAR, 0);
> +	if (!ioaddr)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nr_ports; i++) {
> +
> +		/*
> +		 * MOXA Smartio MUE boards with 4 ports have
> +		 * a different offset for port #3
> +		 */
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
> +		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
> +			uart.port.iobase, uart.port.irq, uart.port.iotype);
> +
> +		brd->line[i] =3D serial8250_register_8250_port(&uart);
> +		if (brd->line[i] < 0) {
> +			dev_err(&pdev->dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n"=
,
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
> +#define MOXA_DEVICE(id, data) { PCI_VDEVICE(MOXA, id), (kernel_ulong=
_t)data }
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
> +	.name           =3D "8250_moxa",
> +	.id_table       =3D pci_ids,
> +	.probe          =3D moxa8250_probe,
> +	.remove         =3D moxa8250_remove,
> +};
> +
> +module_pci_driver(moxa8250_pci_driver);
> +
> +MODULE_AUTHOR("Mathieu OTHACEHE");
> +MODULE_DESCRIPTION("MOXA SmartIO MUE driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> index 0fc6ab5..855d16d 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -3952,6 +3952,20 @@ static const struct pci_device_id blacklist[] =
=3D {
>   	{ PCI_DEVICE(0x1c00, 0x3250), }, /* WCH CH382 2S1P */
>   	{ PCI_DEVICE(0x1c00, 0x3470), }, /* WCH CH384 4S */
>
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
>   	/* Intel platforms with MID UART */
>   	{ PCI_VDEVICE(INTEL, 0x081b), },
>   	{ PCI_VDEVICE(INTEL, 0x081c), },
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/825=
0/Kconfig
> index 67ad6b0..349f571 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -402,6 +402,16 @@ config SERIAL_8250_MID
>   	  present on the UART found on Intel Medfield SOC and various othe=
r
>   	  Intel platforms.
>
> +config SERIAL_8250_MOXA
> +	tristate "MOXA SmartIO MUE support"
> +	depends on SERIAL_8250 && PCI
> +	help
> +	  Say Y here if you have a Moxa SmartIO MUE multiport serial card.
> +	  If unsure, say N.
> +
> +	  This driver can also be built as a module. The module will be cal=
led
> +	  8250_moxa. If you want to do that, say M here.
> +
>   config SERIAL_OF_PLATFORM
>   	tristate "Devicetree based probing for 8250 ports"
>   	depends on SERIAL_8250 && OF
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/82=
50/Makefile
> index 5c1869f..c9a2d6e 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_SERIAL_8250_MT6577)	+=3D 8250_mtk.o
>   obj-$(CONFIG_SERIAL_8250_UNIPHIER)	+=3D 8250_uniphier.o
>   obj-$(CONFIG_SERIAL_8250_INGENIC)	+=3D 8250_ingenic.o
>   obj-$(CONFIG_SERIAL_8250_MID)		+=3D 8250_mid.o
> +obj-$(CONFIG_SERIAL_8250_MOXA)		+=3D 8250_moxa.o
>   obj-$(CONFIG_SERIAL_OF_PLATFORM)	+=3D 8250_of.o
>
>   CFLAGS_8250_ingenic.o +=3D -I$(srctree)/scripts/dtc/libfdt
>
