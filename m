From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH LINUX v4 06/13] tty: xuartps: Move request_irq to after
 setting up the HW
Date: Tue, 15 Dec 2015 07:41:36 -0800
Message-ID: <20151215154136.GU3358@xsjsorenbubuntu>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
 <1449376769-13369-7-git-send-email-soren.brinkmann@xilinx.com>
 <5669F172.6020503@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5669F172.6020503@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Moritz Fischer <moritz.fischer@ettus.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 2015-12-10 at 01:41PM -0800, Peter Hurley wrote:
> On 12/05/2015 08:39 PM, Soren Brinkmann wrote:
> > Request_irq() should be _after_ h/w programming, otherwise an
> > interrupt could be triggered and in-progress before the h/w has bee=
n
> > setup.
>=20
> Slight misunderstanding. My fault; I should have been more explicit.
>=20
> 1. Any setup necessary for the isr not to be confused and misdirect s=
purious
>    interrupts (or hang) should be before installing the isr with requ=
est_irq()
>    None of this code should trigger an interrupt.
> 2. Clear pending interrupts
> 3. Install the isr with request_irq()
> 4. Enable interrupts

Isn't that what the startup function is doing now - more or less. I
think 3 and 4 are swapped to release the lock and then do the
request_irq, but I believe that should be OK.
The startup function configures the HW. Clears the ISR. Enables the
intended IRQs and then does the request_irq call.

>=20
> For extra safety, first disable interrupts before starting h/w progra=
mming.

It's done within spin_lock_irqsave, which gives us at least locally
disabled IRQs. I guess we could add a disabling all IRQs in the UART
core, but it should not really be necessary.

>=20
> I would do the v5 series in the same order as the v3 series only up t=
o
> what I reviewed. Then do another series with the remainder plus new c=
hanges, ok?

Sure.

	S=C3=B6ren

>=20
> Regards,
> Peter Hurley
>=20
> > Reported-by: Peter Hurley <peter@hurleysoftware.com>
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> > v4:
> >  - this patch has been added. Thanks to Peter for pointing it out a=
nd providing
> >    commit message
> > ---
> >  drivers/tty/serial/xilinx_uartps.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/seria=
l/xilinx_uartps.c
> > index 6ffd3bbe3e18..1e9053656610 100644
> > --- a/drivers/tty/serial/xilinx_uartps.c
> > +++ b/drivers/tty/serial/xilinx_uartps.c
> > @@ -759,12 +759,7 @@ static void cdns_uart_set_termios(struct uart_=
port *port,
> >  static int cdns_uart_startup(struct uart_port *port)
> >  {
> >  	unsigned long flags;
> > -	unsigned int retval =3D 0, status =3D 0;
> > -
> > -	retval =3D request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAM=
E,
> > -								(void *)port);
> > -	if (retval)
> > -		return retval;
> > +	unsigned int status =3D 0;
> > =20
> >  	spin_lock_irqsave(&port->lock, flags);
> > =20
> > @@ -818,7 +813,7 @@ static int cdns_uart_startup(struct uart_port *=
port)
> > =20
> >  	spin_unlock_irqrestore(&port->lock, flags);
> > =20
> > -	return retval;
> > +	return request_irq(port->irq, cdns_uart_isr, 0, CDNS_UART_NAME, p=
ort);
> >  }
> > =20
> >  /**
> >=20
>=20
