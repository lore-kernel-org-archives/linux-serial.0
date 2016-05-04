From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 09/11] serial: 8250_lpss: move Quark code from PCI
 driver
Date: Wed, 04 May 2016 18:40:18 +0300
Message-ID: <1462376418.17131.259.camel@linux.intel.com>
References: <1462372353-70128-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462372353-70128-10-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1462374847.27858.205.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462374847.27858.205.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-05-04 at 16:14 +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-05-04 at 17:32 +0300, Andy Shevchenko wrote:
> >=20
> > Intel Quark has DesignWare UART. Move the code from 8250_pci to
> > 8250_lpss.
> >=20
> > Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > =C2=A0drivers/tty/serial/8250/8250_lpss.c | 11 +++++++++++
> > =C2=A0drivers/tty/serial/8250/8250_pci.c=C2=A0=C2=A0| 15 +---------=
-----
> > =C2=A02 files changed, 12 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_lpss.c
> > b/drivers/tty/serial/8250/8250_lpss.c
> > index 77cf7e3..3beb3aa 100644
> > --- a/drivers/tty/serial/8250/8250_lpss.c
> > +++ b/drivers/tty/serial/8250/8250_lpss.c
> > @@ -25,6 +25,8 @@
> > =C2=A0#define PCI_DEVICE_ID_INTEL_BSW_UART1	0x228a
> > =C2=A0#define PCI_DEVICE_ID_INTEL_BSW_UART2	0x228c
> > =C2=A0
> > +#define PCI_DEVICE_ID_INTEL_QRK_UARTx	0x0936
> > +
> > =C2=A0#define PCI_DEVICE_ID_INTEL_BDW_UART1	0x9ce3
> > =C2=A0#define PCI_DEVICE_ID_INTEL_BDW_UART2	0x9ce4
> > =C2=A0
> > @@ -165,6 +167,9 @@ static int lpss8250_dma_setup(struct lpss8250
> > *lpss, struct uart_8250_port *port
> > =C2=A0	struct dw_dma_slave *rx_param, *tx_param;
> > =C2=A0	struct device *dev =3D port->port.dev;
> > =C2=A0
> > +	if (!lpss->dma_param.dma_dev)
> > +		return 0;
> > +
> > =C2=A0	rx_param =3D devm_kzalloc(dev, sizeof(*rx_param),
> > GFP_KERNEL);
> > =C2=A0	if (!rx_param)
> > =C2=A0		return -ENOMEM;
> > @@ -252,6 +257,11 @@ static const struct lpss8250_board byt_board =3D
> > {
> > =C2=A0	.setup =3D byt_serial_setup,
> > =C2=A0};
> > =C2=A0
> > +static const struct lpss8250_board qrk_board =3D {
> > +	.freq =3D 44236800,
> > +	.base_baud =3D 2764800,
> > +};
> > +
> > =C2=A0#define LPSS_DEVICE(id, board) { PCI_VDEVICE(INTEL, id),
> > (kernel_ulong_t)&board }
> > =C2=A0
> > =C2=A0static const struct pci_device_id pci_ids[] =3D {
> > @@ -259,6 +269,7 @@ static const struct pci_device_id pci_ids[] =3D=
 {
> > =C2=A0	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BYT_UART2, byt_board),
> > =C2=A0	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART1, byt_board),
> > =C2=A0	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BSW_UART2, byt_board),
> > +	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_QRK_UARTx, qrk_board),
> > =C2=A0	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART1, byt_board),
> > =C2=A0	LPSS_DEVICE(PCI_DEVICE_ID_INTEL_BDW_UART2, byt_board),
> > =C2=A0	{ },
> > diff --git a/drivers/tty/serial/8250/8250_pci.c
> > b/drivers/tty/serial/8250/8250_pci.c
> > index bb4df5d..b94b1ee 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -1765,7 +1765,6 @@ pci_wch_ch38x_setup(struct serial_private
> > *priv,
> > =C2=A0#define PCI_DEVICE_ID_COMMTECH_4222PCIE	0x0022
> > =C2=A0#define PCI_DEVICE_ID_BROADCOM_TRUMANAGE 0x160a
> > =C2=A0#define PCI_DEVICE_ID_AMCC_ADDIDATA_APCI7800 0x818e
> > -#define PCI_DEVICE_ID_INTEL_QRK_UART	0x0936
> > =C2=A0
> > =C2=A0#define PCI_VENDOR_ID_SUNIX		0x1fd4
> > =C2=A0#define PCI_DEVICE_ID_SUNIX_1999	0x1999
> > @@ -2736,7 +2735,6 @@ enum pci_board_num_t {
> > =C2=A0	pbn_ADDIDATA_PCIe_4_3906250,
> > =C2=A0	pbn_ADDIDATA_PCIe_8_3906250,
> > =C2=A0	pbn_ce4100_1_115200,
> > -	pbn_qrk,
> > =C2=A0	pbn_omegapci,
> > =C2=A0	pbn_NETMOS9900_2s_115200,
> > =C2=A0	pbn_brcm_trumanage,
> > @@ -3512,12 +3510,6 @@ static struct pciserial_board pci_boards[] =3D
> > {
> > =C2=A0		.base_baud	=3D 921600,
> > =C2=A0		.reg_shift=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 2,
> > =C2=A0	},
> > -	[pbn_qrk] =3D {
> > -		.flags		=3D FL_BASE0,
> > -		.num_ports	=3D 1,
> > -		.base_baud	=3D 2764800,
> > -		.reg_shift	=3D 2,
> > -	},
> > =C2=A0	[pbn_omegapci] =3D {
> > =C2=A0		.flags		=3D FL_BASE0,
> > =C2=A0		.num_ports	=3D 8,
> > @@ -3634,6 +3626,7 @@ static const struct pci_device_id blacklist[]
> > =3D
> > {
> > =C2=A0	{ PCI_VDEVICE(INTEL, 0x0f0c), },
> > =C2=A0	{ PCI_VDEVICE(INTEL, 0x228a), },
> > =C2=A0	{ PCI_VDEVICE(INTEL, 0x228c), },
> > +	{ PCI_VDEVICE(INTEL, 0x0936), },
> > =C2=A0	{ PCI_VDEVICE(INTEL, 0x9ce3), },
> > =C2=A0	{ PCI_VDEVICE(INTEL, 0x9ce4), },
> > =C2=A0};
> > @@ -5303,12 +5296,6 @@ static struct pci_device_id serial_pci_tbl[]
> > =3D
> > {
> > =C2=A0		pbn_ce4100_1_115200 },
> > =C2=A0
> > =C2=A0	/*
> > -	=C2=A0* Intel Quark x1000
> > -	=C2=A0*/
> > -	{	PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_QRK_UART,
> > -		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> > -		pbn_qrk },
> > -	/*
> > =C2=A0	=C2=A0* Cronyx Omega PCI
> > =C2=A0	=C2=A0*/
> > =C2=A0	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_CRONYX_OMEGA,
> Andy.
>=20
> Could you please add CONFIG_SERIAL_8250_LPSS when
> =C2=A0CONFIG_X86_INTEL_QUARK is true for my "Reviewed-by" to this pat=
ch ?
>=20
> I don't see that

Wait, what you are proposing here is a new behaviour, right?
Or can you explain how it works now (w/o this series being applied)?

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
