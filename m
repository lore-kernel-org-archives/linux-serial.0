From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] [V3] uartlite: move from byte accesses to word accesses
Date: Wed, 17 Mar 2010 12:04:18 -0600
Message-ID: <873097b0-5388-45b1-8483-3ef01bf8351f@SG2EHSMHS005.ehs.local>
References: <e1a95faf-6907-4262-94bf-fa6808f7f098@SG2EHSMHS007.ehs.local> <fa686aa41003170921g667edc2pcc2bf4eac592c089@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sg2ehsobe001.messaging.microsoft.com ([207.46.51.75]:45594 "EHLO
	SG2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755286Ab0CQSE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 14:04:28 -0400
Content-Class: urn:content-classes:message
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <linnj@xilinx.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-serial@vger.kernel.org, jacmet@sunsite.dk, michal.simek@petalogix.com, john.williams@petalogix.com



> -----Original Message-----
> From: John Linn
> Sent: Wednesday, March 17, 2010 10:27 AM
> To: 'Grant Likely'
> Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk; michal.simek@pet=
alogix.com;
> john.williams@petalogix.com
> Subject: RE: [PATCH] [V3] uartlite: move from byte accesses to word a=
ccesses
>=20
> > -----Original Message-----
> > From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf =
Of Grant Likely
> > Sent: Wednesday, March 17, 2010 10:21 AM
> > To: John Linn
> > Cc: linux-serial@vger.kernel.org; jacmet@sunsite.dk; michal.simek@p=
etalogix.com;
> > john.williams@petalogix.com
> > Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to word=
 accesses
> >
> > On Wed, Mar 17, 2010 at 9:40 AM, John Linn <john.linn@xilinx.com> w=
rote:
> > > Byte accesses for I/O devices in Xilinx IP is going to be less
> > > desired in the future such that the driver is being changed to
> > > use 32 bit accesses.
> > >
> > > This change facilitates using the uartlite IP over a PCIe bus
> > > which only allows 32 bit accesses.
> > >
> > > Signed-off-by: John Linn <john.linn@xilinx.com>
> > >
> > > ---
> > >
> > > V2 - updated the commit message based on Peter's comments
> > >
> > > V3 - removed u8 casting based on Peter's comments, cleaned up and
> > > simplified the change by using raw I/O functions rather than
> > > using in_be32 & out_be32 functions.
> >
> > The __raw_{read,write}l() functions aren't the best choice here.  U=
ser
> > ioread32be(), iowrite32be() instead if you want them to work
> > cross-architecture (see include/asm-generic/iomap.h).
>=20
> Maybe the ioread functions will work better than the in/out_be32 as t=
hey
> were not working like I wanted.
>=20
> I'm still trying to get my head wrapped around the right I/O function=
s to use since there are so many
> options.
>=20
> I'll look at your suggestions.

That works ok on Powerpc, but not microblaze yet as there are still pat=
ches in the process of going into the kernel for that.

Do we need to wait til those patches are in?

Thanks,
John
>=20
> Thanks,
> John
>=20
> >
> > g.
> >
> > > ---
> > > =A0drivers/serial/uartlite.c | =A0 32 ++++++++++++++++-----------=
-----
> > > =A01 files changed, 16 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.=
c
> > > index ab2ab3c..bdf08c7 100644
> > > --- a/drivers/serial/uartlite.c
> > > +++ b/drivers/serial/uartlite.c
> > > @@ -86,7 +86,7 @@ static int ulite_receive(struct uart_port *port=
, int stat)
> > > =A0 =A0 =A0 =A0/* stats */
> > > =A0 =A0 =A0 =A0if (stat & ULITE_STATUS_RXVALID) {
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->icount.rx++;
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D readb(port->membase + ULITE_=
RX);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D __raw_readl(port->membase + =
ULITE_RX);
> > >
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (stat & ULITE_STATUS_PARITY)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->icount.parit=
y++;
> > > @@ -131,7 +131,7 @@ static int ulite_transmit(struct uart_port *p=
ort, int stat)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> > >
> > > =A0 =A0 =A0 =A0if (port->x_char) {
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(port->x_char, port->membase =
+ ULITE_TX);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(port->x_char, port->me=
mbase + ULITE_TX);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->x_char =3D 0;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->icount.tx++;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> > > @@ -140,7 +140,7 @@ static int ulite_transmit(struct uart_port *p=
ort, int stat)
> > > =A0 =A0 =A0 =A0if (uart_circ_empty(xmit) || uart_tx_stopped(port)=
)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> > >
> > > - =A0 =A0 =A0 writeb(xmit->buf[xmit->tail], port->membase + ULITE=
_TX);
> > > + =A0 =A0 =A0 __raw_writel(xmit->buf[xmit->tail], port->membase +=
 ULITE_TX);
> > > =A0 =A0 =A0 =A0xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE-=
1);
> > > =A0 =A0 =A0 =A0port->icount.tx++;
> > >
> > > @@ -157,7 +157,7 @@ static irqreturn_t ulite_isr(int irq, void *d=
ev_id)
> > > =A0 =A0 =A0 =A0int busy, n =3D 0;
> > >
> > > =A0 =A0 =A0 =A0do {
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int stat =3D readb(port->membase + =
ULITE_STATUS);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int stat =3D __raw_readl(port->memb=
ase + ULITE_STATUS);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0busy =A0=3D ulite_receive(port, st=
at);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0busy |=3D ulite_transmit(port, sta=
t);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n++;
> > > @@ -178,7 +178,7 @@ static unsigned int ulite_tx_empty(struct uar=
t_port *port)
> > > =A0 =A0 =A0 =A0unsigned int ret;
> > >
> > > =A0 =A0 =A0 =A0spin_lock_irqsave(&port->lock, flags);
> > > - =A0 =A0 =A0 ret =3D readb(port->membase + ULITE_STATUS);
> > > + =A0 =A0 =A0 ret =3D __raw_readl(port->membase + ULITE_STATUS);
> > > =A0 =A0 =A0 =A0spin_unlock_irqrestore(&port->lock, flags);
> > >
> > > =A0 =A0 =A0 =A0return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT :=
 0;
> > > @@ -201,7 +201,7 @@ static void ulite_stop_tx(struct uart_port *p=
ort)
> > >
> > > =A0static void ulite_start_tx(struct uart_port *port)
> > > =A0{
> > > - =A0 =A0 =A0 ulite_transmit(port, readb(port->membase + ULITE_ST=
ATUS));
> > > + =A0 =A0 =A0 ulite_transmit(port, __raw_readl(port->membase + UL=
ITE_STATUS));
> > > =A0}
> > >
> > > =A0static void ulite_stop_rx(struct uart_port *port)
> > > @@ -230,17 +230,17 @@ static int ulite_startup(struct uart_port *=
port)
> > > =A0 =A0 =A0 =A0if (ret)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> > >
> > > - =A0 =A0 =A0 writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
> > > + =A0 =A0 =A0 __raw_writel(ULITE_CONTROL_RST_RX | ULITE_CONTROL_R=
ST_TX,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->membase + ULITE_CONTROL);
> > > - =A0 =A0 =A0 writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONT=
ROL);
> > > + =A0 =A0 =A0 __raw_writel(ULITE_CONTROL_IE, port->membase + ULIT=
E_CONTROL);
> > >
> > > =A0 =A0 =A0 =A0return 0;
> > > =A0}
> > >
> > > =A0static void ulite_shutdown(struct uart_port *port)
> > > =A0{
> > > - =A0 =A0 =A0 writeb(0, port->membase + ULITE_CONTROL);
> > > - =A0 =A0 =A0 readb(port->membase + ULITE_CONTROL); /* dummy */
> > > + =A0 =A0 =A0 __raw_writel(0, port->membase + ULITE_CONTROL);
> > > + =A0 =A0 =A0 __raw_readl(port->membase + ULITE_CONTROL); /* dumm=
y */
> > > =A0 =A0 =A0 =A0free_irq(port->irq, port);
> > > =A0}
> > >
> > > @@ -352,7 +352,7 @@ static void ulite_console_wait_tx(struct uart=
_port *port)
> > >
> > > =A0 =A0 =A0 =A0/* Spin waiting for TX fifo to have space availabl=
e */
> > > =A0 =A0 =A0 =A0for (i =3D 0; i < 100000; i++) {
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D readb(port->membase + ULITE=
_STATUS);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D __raw_readl(port->membase +=
 ULITE_STATUS);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((val & ULITE_STATUS_TXFULL) =3D=
=3D 0)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> > > @@ -362,7 +362,7 @@ static void ulite_console_wait_tx(struct uart=
_port *port)
> > > =A0static void ulite_console_putchar(struct uart_port *port, int =
ch)
> > > =A0{
> > > =A0 =A0 =A0 =A0ulite_console_wait_tx(port);
> > > - =A0 =A0 =A0 writeb(ch, port->membase + ULITE_TX);
> > > + =A0 =A0 =A0 __raw_writel(ch, port->membase + ULITE_TX);
> > > =A0}
> > >
> > > =A0static void ulite_console_write(struct console *co, const char=
 *s,
> > > @@ -379,8 +379,8 @@ static void ulite_console_write(struct consol=
e *co, const char *s,
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&port->lock, fla=
gs);
> > >
> > > =A0 =A0 =A0 =A0/* save and disable interrupt */
> > > - =A0 =A0 =A0 ier =3D readb(port->membase + ULITE_STATUS) & ULITE=
_STATUS_IE;
> > > - =A0 =A0 =A0 writeb(0, port->membase + ULITE_CONTROL);
> > > + =A0 =A0 =A0 ier =3D __raw_readl(port->membase + ULITE_STATUS) &=
 ULITE_STATUS_IE;
> > > + =A0 =A0 =A0 __raw_writel(0, port->membase + ULITE_CONTROL);
> > >
> > > =A0 =A0 =A0 =A0uart_console_write(port, s, count, ulite_console_p=
utchar);
> > >
> > > @@ -388,7 +388,7 @@ static void ulite_console_write(struct consol=
e *co, const char *s,
> > >
> > > =A0 =A0 =A0 =A0/* restore interrupt state */
> > > =A0 =A0 =A0 =A0if (ier)
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(ULITE_CONTROL_IE, port->memb=
ase + ULITE_CONTROL);
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ULITE_CONTROL_IE, port=
->membase + ULITE_CONTROL);
> > >
> > > =A0 =A0 =A0 =A0if (locked)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&port->lock=
, flags);
> > > @@ -601,7 +601,7 @@ ulite_of_probe(struct of_device *op, const st=
ruct of_device_id *match)
> > >
> > > =A0 =A0 =A0 =A0id =3D of_get_property(op->node, "port-number", NU=
LL);
> > >
> > > - =A0 =A0 =A0 return ulite_assign(&op->dev, id ? *id : -1, res.st=
art+3, irq);
> > > + =A0 =A0 =A0 return ulite_assign(&op->dev, id ? *id : -1, res.st=
art, irq);
> > > =A0}
> > >
> > > =A0static int __devexit ulite_of_remove(struct of_device *op)
> > > --
> > > 1.6.2.1
> > >
> > >
> > >
> > > This email and any attachments are intended for the sole use of t=
he named recipient(s) and
> > contain(s) confidential information that may be proprietary, privil=
eged or copyrighted under
> > applicable law. If you are not the intended recipient, do not read,=
 copy, or forward this email
> > message or any attachments. Delete this email message and any attac=
hments immediately.
> > >
> > >
> > >
> >
> >
> >
> > --
> > Grant Likely, B.Sc., P.Eng.
> > Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the nam=
ed recipient(s) and contain(s) confidential information that may be pro=
prietary, privileged or copyrighted under applicable law. If you are no=
t the intended recipient, do not read, copy, or forward this email mess=
age or any attachments. Delete this email message and any attachments i=
mmediately.


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
