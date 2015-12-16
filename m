From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 02/11] tty: serial: 8250: Fix indentation warnings
Date: Wed, 16 Dec 2015 08:49:35 -0800
Message-ID: <5671961F.2080304@hurleysoftware.com>
References: <1450280177-4460-1-git-send-email-anton.wuerfel@fau.de>
 <1450280177-4460-3-git-send-email-anton.wuerfel@fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1450280177-4460-3-git-send-email-anton.wuerfel@fau.de>
Sender: linux-parisc-owner@vger.kernel.org
To: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Qipeng Zha <qipeng.zha@intel.com>, Desmond Liu <desmondl@broadcom.com>, Wang Long <long.wanglong@huawei.com>, Matt Redfearn <matt.redfearn@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Peter Hung <hpeter@gmail.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Adam Lee <adam.lee@canonical.com>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mans Rullgard <mans@mansr.com>, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linux-kernel@i4.cs.fau.de, Phillip Raffeck <phillip.raffe>
List-Id: linux-serial@vger.kernel.org

Hi Anton,

On 12/16/2015 07:36 AM, Anton Wuerfel wrote:
> Checkpatch complains about incorrect indentation of switch/case state=
ments.
> This patch fixes the corresponding warnings. Additionally some indent=
ation
> is changed to match the correct format specified in the Linux Kernel
> Coding Style.

This patch needs split; separate the "leading spaces instead of tabs" f=
rom
the "GNU-style indent level".

Personally, I don't think it's worth changing existing code to meet the
GNU indent style unless it's being rewritten for some other reason.
But Greg's the maintainer, so it's his choice.

Regards,
Peter Hurley


> Signed-off-by: Anton W=C3=BCrfel <anton.wuerfel@fau.de>
> Signed-off-by: Phillip Raffeck <phillip.raffeck@fau.de>
> CC: linux-kernel@i4.cs.fau.de
> ---
>  drivers/tty/serial/8250/8250_pci.c  | 31 +++++++++++++++------------=
----
>  drivers/tty/serial/8250/8250_pnp.c  |  4 ++--
>  drivers/tty/serial/8250/8250_port.c | 14 +++++++-------
>  3 files changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/=
8250/8250_pci.c
> index ed99fdf..41508a5 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -722,7 +722,7 @@ static int pci_ni8430_init(struct pci_dev *dev)
>  	 */
>  	pcibios_resource_to_bus(dev->bus, &region, &dev->resource[bar]);
>  	device_window =3D ((region.start + MITE_IOWBSR1_WIN_OFFSET) & 0xfff=
fff00)
> -	                | MITE_IOWBSR1_WENAB | MITE_IOWBSR1_WSIZE;
> +			| MITE_IOWBSR1_WENAB | MITE_IOWBSR1_WSIZE;
>  	writel(device_window, p + MITE_IOWBSR1);
> =20
>  	/* Set window access to go to RAMSEL IO address space */
> @@ -843,17 +843,16 @@ static int pci_netmos_init(struct pci_dev *dev)
>  		return 0;
> =20
>  	switch (dev->device) { /* FALLTHROUGH on all */
> -		case PCI_DEVICE_ID_NETMOS_9904:
> -		case PCI_DEVICE_ID_NETMOS_9912:
> -		case PCI_DEVICE_ID_NETMOS_9922:
> -		case PCI_DEVICE_ID_NETMOS_9900:
> -			num_serial =3D pci_netmos_9900_numports(dev);
> -			break;
> +	case PCI_DEVICE_ID_NETMOS_9904:
> +	case PCI_DEVICE_ID_NETMOS_9912:
> +	case PCI_DEVICE_ID_NETMOS_9922:
> +	case PCI_DEVICE_ID_NETMOS_9900:
> +		num_serial =3D pci_netmos_9900_numports(dev);
> +		break;
> =20
> -		default:
> -			if (num_serial =3D=3D 0 ) {
> -				moan_device("unknown NetMos/Mostech device", dev);
> -			}
> +	default:
> +		if (num_serial =3D=3D 0)
> +			moan_device("unknown NetMos/Mostech device", dev);
>  	}
> =20
>  	if (num_serial =3D=3D 0)
> @@ -1766,7 +1765,7 @@ xr17v35x_has_slave(struct serial_private *priv)
>  	const int dev_id =3D priv->dev->device;
> =20
>  	return ((dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V4358) ||
> -	        (dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V8358));
> +		(dev_id =3D=3D PCI_DEVICE_ID_EXAR_XR17V8358));
>  }
> =20
>  static int
> @@ -1866,8 +1865,8 @@ pci_fastcom335_setup(struct serial_private *pri=
v,
> =20
>  static int
>  pci_wch_ch353_setup(struct serial_private *priv,
> -                    const struct pciserial_board *board,
> -                    struct uart_8250_port *port, int idx)
> +		    const struct pciserial_board *board,
> +		    struct uart_8250_port *port, int idx)
>  {
>  	port->port.flags |=3D UPF_FIXED_TYPE;
>  	port->port.type =3D PORT_16550A;
> @@ -1876,8 +1875,8 @@ pci_wch_ch353_setup(struct serial_private *priv=
,
> =20
>  static int
>  pci_wch_ch38x_setup(struct serial_private *priv,
> -                    const struct pciserial_board *board,
> -                    struct uart_8250_port *port, int idx)
> +		    const struct pciserial_board *board,
> +		    struct uart_8250_port *port, int idx)
>  {
>  	port->port.flags |=3D UPF_FIXED_TYPE;
>  	port->port.type =3D PORT_16850;
> diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/=
8250/8250_pnp.c
> index 658b392..1f18065 100644
> --- a/drivers/tty/serial/8250/8250_pnp.c
> +++ b/drivers/tty/serial/8250/8250_pnp.c
> @@ -425,8 +425,8 @@ static int check_resources(struct pnp_dev *dev)
>  static int serial_pnp_guess_board(struct pnp_dev *dev)
>  {
>  	if (!(check_name(pnp_dev_name(dev)) ||
> -		(dev->card && check_name(dev->card->name))))
> -			return -ENODEV;
> +	    (dev->card && check_name(dev->card->name))))
> +		return -ENODEV;
> =20
>  	if (check_resources(dev))
>  		return 0;
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial=
/8250/8250_port.c
> index ae8f993..57ad0f2 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -52,7 +52,7 @@
>  #define DEBUG_AUTOCONF(fmt...)	do { } while (0)
>  #endif
> =20
> -#define BOTH_EMPTY 	(UART_LSR_TEMT | UART_LSR_THRE)
> +#define BOTH_EMPTY	(UART_LSR_TEMT | UART_LSR_THRE)
> =20
>  /*
>   * Here we define the default xmit fifo size used for each type of U=
ART.
> @@ -2236,9 +2236,9 @@ static void serial8250_set_divisor(struct uart_=
port *port, unsigned int baud,
>  		serial_port_out(port, 0x2, quot_frac);
>  }
> =20
> -static unsigned int
> -serial8250_get_baud_rate(struct uart_port *port, struct ktermios *te=
rmios,
> -			 struct ktermios *old)
> +static unsigned int serial8250_get_baud_rate(struct uart_port *port,
> +					     struct ktermios *termios,
> +					     struct ktermios *old)
>  {
>  	unsigned int tolerance =3D port->uartclk / 100;
> =20
> @@ -2253,9 +2253,9 @@ serial8250_get_baud_rate(struct uart_port *port=
, struct ktermios *termios,
>  				  (port->uartclk + tolerance) / 16);
>  }
> =20
> -void
> -serial8250_do_set_termios(struct uart_port *port, struct ktermios *t=
ermios,
> -		          struct ktermios *old)
> +void serial8250_do_set_termios(struct uart_port *port,
> +			       struct ktermios *termios,
> +			       struct ktermios *old)
>  {
>  	struct uart_8250_port *up =3D up_to_u8250p(port);
>  	unsigned char cval;
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-parisc"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
