From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_pci: add MOXA Smartio MUE boards support
Date: Mon, 15 Feb 2016 15:54:14 +0200
Message-ID: <1455544454.31169.120.camel@linux.intel.com>
References: <1455301730-24333-1-git-send-email-m.othacehe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455301730-24333-1-git-send-email-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu OTHACEHE <m.othacehe@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, heikki.krogerus@linux.intel.com, hpeter@gmail.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, JBeulich@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2016-02-12 at 19:28 +0100, Mathieu OTHACEHE wrote:
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
> Signed-off-by: Mathieu OTHACEHE <m.othacehe@gmail.com>
> ---
>=20
> Hi,
>=20
> This patch add support for MOXA Smartio MUE boards to 8250 driver.
> I already submitted an independant driver based on the vendor one :
>=20
> https://lkml.org/lkml/2016/2/1/720
>=20
> But as Andy pointed out, it seems to be a better idea to add this
> support
> directly in 8250 driver.

Yes, something like this. It would be even better to have something
like 8250_moxa.c at some point. I don't know if it worth to do right
now.

See my comments below.

> I was able to test this patch on a CP-168EL-A on PC.
>=20
> Mathieu
>=20
> =C2=A0drivers/tty/serial/8250/8250_pci.c | 193
> +++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 193 insertions(+)
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c
> b/drivers/tty/serial/8250/8250_pci.c
> index 8f8d5c5..67c1028 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1862,6 +1862,25 @@ pci_wch_ch38x_setup(struct serial_private
> *priv,
> =C2=A0	return pci_default_setup(priv, board, port, idx);
> =C2=A0}
> =C2=A0
> +static int pci_mxupcie_setup(struct serial_private *priv,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct pciserial_board *board=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct uart_8250_port *port, int id=
x)
> +{
> +	unsigned int bar, offset;
> +
> +	/*
> +	=C2=A0* MOXA Smartio MUE boards with 4 ports have
> +	=C2=A0* a different offset for port #3
> +	=C2=A0*/
> +	if (idx =3D=3D 3) {
> +		bar =3D FL_GET_BASE(board->flags);
> +		offset =3D 7 * board->uart_offset;
> +		return setup_port(priv, port, bar, offset, board-
> >reg_shift);
> +	} else {
> +		return pci_default_setup(priv, board, port, idx);
> +	}
> +}

So, looks like it would be pretty simple to have it in a separate file.

> +
> =C2=A0#define PCI_VENDOR_ID_SBSMODULARIO	0x124B
> =C2=A0#define PCI_SUBVENDOR_ID_SBSMODULARIO	0x124B
> =C2=A0#define PCI_DEVICE_ID_OCTPRO		0x0001
> @@ -1927,6 +1946,19 @@ pci_wch_ch38x_setup(struct serial_private
> *priv,
> =C2=A0#define PCI_DEVICE_ID_PERICOM_PI7C9X7954	0x7954
> =C2=A0#define PCI_DEVICE_ID_PERICOM_PI7C9X7958	0x7958
> =C2=A0
> +#define	PCI_DEVICE_ID_MOXA_CP102E	0x1024
> +#define	PCI_DEVICE_ID_MOXA_CP102EL	0x1025
> +#define	PCI_DEVICE_ID_MOXA_CP132EL	0x1322
> +#define	PCI_DEVICE_ID_MOXA_CP114EL	0x1144
> +#define	PCI_DEVICE_ID_MOXA_CP104EL_A	0x1045
> +#define	PCI_DEVICE_ID_MOXA_CP168EL_A	0x1683
> +#define	PCI_DEVICE_ID_MOXA_CP118EL_A	0x1182
> +#define	PCI_DEVICE_ID_MOXA_CP118E_A_I	0x1183
> +#define	PCI_DEVICE_ID_MOXA_CP138E_A	0x1381
> +#define	PCI_DEVICE_ID_MOXA_CP134EL_A	0x1342
> +#define	PCI_DEVICE_ID_MOXA_CP116E_A_A	0x1160
> +#define	PCI_DEVICE_ID_MOXA_CP116E_A_B	0x1161

But you can keep this sorted by IDs, right?


> @@ -2938,6 +2994,19 @@ enum pci_board_num_t {
> =C2=A0	pbn_pericom_PI7C9X7952,
> =C2=A0	pbn_pericom_PI7C9X7954,
> =C2=A0	pbn_pericom_PI7C9X7958,
>=20

> +	pbn_moxa_CP102E,
> +	pbn_moxa_CP102EL,
> +	pbn_moxa_CP132EL,
> +	pbn_moxa_CP114EL,
> +	pbn_moxa_CP104EL_A,
> +	pbn_moxa_CP168EL_A,
> +	pbn_moxa_CP118EL_A,
> +	pbn_moxa_CP118E_A_I,
> +	pbn_moxa_CP138E_A,
> +	pbn_moxa_CP134EL_A,
> +	pbn_moxa_CP116E_A_A,
> +	pbn_moxa_CP116E_A_B

This part seems too verbose. You have similarities in the bunch of
boards.

+
> =C2=A0};
> =C2=A0
> =C2=A0/*
> @@ -3794,6 +3863,81 @@ static struct pciserial_board pci_boards[] =3D=
 {
> =C2=A0		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> =C2=A0		.uart_offset	=3D 0x8,
> =C2=A0	},
> +	/*
> +	=C2=A0* MOXA Smartio MUE boards
> +	=C2=A0*/
> +	[pbn_moxa_CP102E] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 2,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP102EL] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 2,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP132EL] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 2,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP114EL] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 4,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP104EL_A] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 4,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP168EL_A] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP118EL_A] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP118E_A_I] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP138E_A] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP134EL_A] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 4,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP116E_A_A] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,
> +	},
> +	[pbn_moxa_CP116E_A_B] =3D {
> +		.flags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=3D FL_BASE1,
> +		.num_ports=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8,
> +		.base_baud=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 921600,
> +		.uart_offset	=3D 0x200,

So, I see only 3. Only difference is a number of ports.

So, if you go with 8250_moxa.c you may use your private structure to
keep only what is needed.


--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
