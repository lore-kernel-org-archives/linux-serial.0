From: Je Yen Tam <je.yen.tam@ni.com>
Subject: RE: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Date: Thu, 4 Jul 2019 07:55:33 +0000
Message-ID: <MN2PR04MB59207BEC9DBAB5E69656DD42B7FA0@MN2PR04MB5920.namprd04.prod.outlook.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <20190703084220.GD8996@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190703084220.GD8996@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> On Wed, Jul 03, 2019 at 12:24:35AM -0700, jeyentam wrote:
> > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> >
> > Signed-off-by: jeyentam <je.yen.tam@ni.com>
>=20
> I need a "full" name here please.

Ok, will do so.

>=20
> Also, this patch breaks the build, which is not allowed, and makes me won=
der how
> you tested it :(

I've tested my changes with the steps as follows, it did not break.

1. Clone the Linux repo, check out the source and work on my project.
2. Compile the kernel source with "make j4".
3. Build the kernel modules with "make modules_install".
4. Install the kernel with "make install".
5. Reboot into the newly built kernel.
6. The kernel worked well and able to fit my needs.

Noted that my source is checked out from the latest Linux kernel 5.2.0-rc6.

Also, I checked my patch using checkpatch.pl, it did not show any errors an=
d=20
warnings too.

May I know what do you mean by breaking the build?

>=20
> Please fix up properly and resend.
>=20
> Also, some comments below:
>=20
> > ---
> >  drivers/tty/serial/8250/8250_pci.c | 293
> > ++++++++++++++++++++++++++++-
> >  1 file changed, 289 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_pci.c
> > b/drivers/tty/serial/8250/8250_pci.c
> > index df41397de478..ac8138adea9c 100644
> > --- a/drivers/tty/serial/8250/8250_pci.c
> > +++ b/drivers/tty/serial/8250/8250_pci.c
> > @@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
> > }
> >
> >  /* UART Port Control Register */
> > -#define NI8430_PORTCON	0x0f
> > -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
>=20
> Why are you renaming these #defines?

NI8430 device is using standard 16550 UART chip so I standardize all the 16=
550=20
UART related #defines to UART chip specific name rather than device specifi=
c.

>=20
> > +#define NI16550_PCR_OFFSET	0x0f
> > +#define NI16550_PCR_RS422	0x00
> > +#define NI16550_PCR_ECHO_RS485	0x01
> > +#define NI16550_PCR_DTR_RS485	0x02
> > +#define NI16550_PCR_AUTO_RS485	0x03
> > +#define NI16550_PCR_WIRE_MODE_MASK	0x03
> > +#define NI16550_PCR_TXVR_ENABLE_BIT	(1 << 3)
>=20
> BIT(3)?

Ok, will change to this style.

>=20
> > +#define NI16550_PCR_RS485_TERMINATION_BIT	(1 << 6)
>=20
> BIT(6)?

Also, will change this.

>=20
> > +#define NI16550_ACR_DTR_AUTO_DTR	(0x2 << 3)
> > +#define NI16550_ACR_DTR_MANUAL_DTR	(0x0 << 3)
> >
> >  static int
> >  pci_ni8430_setup(struct serial_private *priv, @@ -753,14 +761,127 @@
> > pci_ni8430_setup(struct serial_private *priv,
> >  		return -ENOMEM;
> >
> >  	/* enable the transceiver */
> > -	writeb(readb(p + offset + NI8430_PORTCON) |
> NI8430_PORTCON_TXVR_ENABLE,
> > -	       p + offset + NI8430_PORTCON);
> > +	writeb(readb(p + offset + NI16550_PCR_OFFSET) |
> > +			NI16550_PCR_TXVR_ENABLE_BIT,
> > +			p + offset + NI16550_PCR_OFFSET);
>=20
> Why indent like this?  Please follow the indentation that used to be ther=
e.

I moved the indentation because it complained this line exceeded 80 charact=
ers=20
when I check the patch. I will change back to original indentation.

>=20
> >
> >  	iounmap(p);
> >
> >  	return setup_port(priv, port, bar, offset, board->reg_shift);  }
> >
> > +static int pci_ni8431_config_rs485(struct uart_port *port,
> > +	struct serial_rs485 *rs485)
> > +{
> > +	u8 pcr, acr;
> > +
> > +	struct uart_8250_port *up;
> > +
> > +	up =3D container_of(port, struct uart_8250_port, port);
> > +
> > +	acr =3D up->acr;
> > +
> > +	dev_dbg(port->dev, "ni16550_config_rs485\n");
>=20
> No need for debugging lines like this, use ftrace please.

Ok, will update this.

>=20
> > +
> > +	/* "rs485" should be given to us non-NULL. */
> > +	WARN_ON(rs485 =3D=3D NULL);
>=20
> Don't crash people's machines, if this can never happen, then no need for=
 this line.  If
> it can happen, test and properly return an error.

This is more like a fail safe approach, it should never happen, will remove=
 this line.

>=20
> > +
> > +	pcr =3D port->serial_in(port, NI16550_PCR_OFFSET);
> > +	pcr &=3D ~NI16550_PCR_WIRE_MODE_MASK;
> > +
> > +	if (rs485->flags & SER_RS485_ENABLED) {
> > +		/* RS-485 */
> > +		if ((rs485->flags & SER_RS485_RX_DURING_TX) &&
> > +			(rs485->flags & SER_RS485_RTS_ON_SEND)) {
> > +			dev_dbg(port->dev, "Invalid 2-wire mode\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		if (rs485->flags & SER_RS485_RX_DURING_TX) {
> > +			/* Echo */
> > +			dev_vdbg(port->dev, "2-wire DTR with echo\n");
> > +			pcr |=3D NI16550_PCR_ECHO_RS485;
> > +			acr |=3D NI16550_ACR_DTR_MANUAL_DTR;
> > +		} else {
> > +			/* Auto or DTR */
> > +			if (rs485->flags & SER_RS485_RTS_ON_SEND) {
> > +				/* Auto */
> > +				dev_vdbg(port->dev, "2-wire Auto\n");
> > +				pcr |=3D NI16550_PCR_AUTO_RS485;
> > +				acr |=3D NI16550_ACR_DTR_AUTO_DTR;
> > +			} else {
> > +				/* DTR-controlled */
> > +				/* No Echo */
> > +				dev_vdbg(port->dev, "2-wire DTR no echo\n");
> > +				pcr |=3D NI16550_PCR_DTR_RS485;
> > +				acr |=3D NI16550_ACR_DTR_MANUAL_DTR;
> > +			}
> > +		}
> > +	} else {
> > +		/* RS-422 */
> > +		dev_vdbg(port->dev, "4-wire\n");
> > +		pcr |=3D NI16550_PCR_RS422;
> > +		acr |=3D NI16550_ACR_DTR_MANUAL_DTR;
> > +	}
> > +
> > +	dev_dbg(port->dev, "write pcr: 0x%08x\n", pcr);
> > +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> > +
> > +	up->acr =3D acr;
> > +	port->serial_out(port, UART_SCR, UART_ACR);
> > +	port->serial_out(port, UART_ICR, up->acr);
> > +
> > +	/* Update the cache. */
> > +	port->rs485 =3D *rs485;
> > +
> > +	dev_dbg(port->dev, "ni16550_config_rs485\n");
>=20
> Again, use ftrace, not dev_dbg() for stuff like this.

Will do so.

>=20
> thanks,
>=20
> greg k-h


Thank you.
Regards,
Je Yen Tam
Staff Software Engineer
National Instruments=A0
o=A0=A0 604-3776397
e=A0=A0 je.yen.tam@ni.com
