From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [V3] uartlite: move from byte accesses to word accesses
Date: Wed, 17 Mar 2010 10:21:27 -0600
Message-ID: <fa686aa41003170921g667edc2pcc2bf4eac592c089@mail.gmail.com>
References: <e1a95faf-6907-4262-94bf-fa6808f7f098@SG2EHSMHS007.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:41768 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab0CQQVs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 12:21:48 -0400
Received: by yxe29 with SMTP id 29so30757yxe.4
        for <linux-serial@vger.kernel.org>; Wed, 17 Mar 2010 09:21:47 -0700 (PDT)
In-Reply-To: <e1a95faf-6907-4262-94bf-fa6808f7f098@SG2EHSMHS007.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <john.linn@xilinx.com>
Cc: linux-serial@vger.kernel.org, jacmet@sunsite.dk, michal.simek@petalogix.com, john.williams@petalogix.com

On Wed, Mar 17, 2010 at 9:40 AM, John Linn <john.linn@xilinx.com> wrote=
:
> Byte accesses for I/O devices in Xilinx IP is going to be less
> desired in the future such that the driver is being changed to
> use 32 bit accesses.
>
> This change facilitates using the uartlite IP over a PCIe bus
> which only allows 32 bit accesses.
>
> Signed-off-by: John Linn <john.linn@xilinx.com>
>
> ---
>
> V2 - updated the commit message based on Peter's comments
>
> V3 - removed u8 casting based on Peter's comments, cleaned up and
> simplified the change by using raw I/O functions rather than
> using in_be32 & out_be32 functions.

The __raw_{read,write}l() functions aren't the best choice here.  User
ioread32be(), iowrite32be() instead if you want them to work
cross-architecture (see include/asm-generic/iomap.h).

g.

> ---
> =A0drivers/serial/uartlite.c | =A0 32 ++++++++++++++++---------------=
-
> =A01 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> index ab2ab3c..bdf08c7 100644
> --- a/drivers/serial/uartlite.c
> +++ b/drivers/serial/uartlite.c
> @@ -86,7 +86,7 @@ static int ulite_receive(struct uart_port *port, in=
t stat)
> =A0 =A0 =A0 =A0/* stats */
> =A0 =A0 =A0 =A0if (stat & ULITE_STATUS_RXVALID) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->icount.rx++;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D readb(port->membase + ULITE_RX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ch =3D __raw_readl(port->membase + ULIT=
E_RX);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (stat & ULITE_STATUS_PARITY)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->icount.parity++;
> @@ -131,7 +131,7 @@ static int ulite_transmit(struct uart_port *port,=
 int stat)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0if (port->x_char) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(port->x_char, port->membase + UL=
ITE_TX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(port->x_char, port->membas=
e + ULITE_TX);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->x_char =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->icount.tx++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> @@ -140,7 +140,7 @@ static int ulite_transmit(struct uart_port *port,=
 int stat)
> =A0 =A0 =A0 =A0if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> - =A0 =A0 =A0 writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX)=
;
> + =A0 =A0 =A0 __raw_writel(xmit->buf[xmit->tail], port->membase + ULI=
TE_TX);
> =A0 =A0 =A0 =A0xmit->tail =3D (xmit->tail + 1) & (UART_XMIT_SIZE-1);
> =A0 =A0 =A0 =A0port->icount.tx++;
>
> @@ -157,7 +157,7 @@ static irqreturn_t ulite_isr(int irq, void *dev_i=
d)
> =A0 =A0 =A0 =A0int busy, n =3D 0;
>
> =A0 =A0 =A0 =A0do {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int stat =3D readb(port->membase + ULIT=
E_STATUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int stat =3D __raw_readl(port->membase =
+ ULITE_STATUS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0busy =A0=3D ulite_receive(port, stat);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0busy |=3D ulite_transmit(port, stat);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n++;
> @@ -178,7 +178,7 @@ static unsigned int ulite_tx_empty(struct uart_po=
rt *port)
> =A0 =A0 =A0 =A0unsigned int ret;
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&port->lock, flags);
> - =A0 =A0 =A0 ret =3D readb(port->membase + ULITE_STATUS);
> + =A0 =A0 =A0 ret =3D __raw_readl(port->membase + ULITE_STATUS);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&port->lock, flags);
>
> =A0 =A0 =A0 =A0return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
> @@ -201,7 +201,7 @@ static void ulite_stop_tx(struct uart_port *port)
>
> =A0static void ulite_start_tx(struct uart_port *port)
> =A0{
> - =A0 =A0 =A0 ulite_transmit(port, readb(port->membase + ULITE_STATUS=
));
> + =A0 =A0 =A0 ulite_transmit(port, __raw_readl(port->membase + ULITE_=
STATUS));
> =A0}
>
> =A0static void ulite_stop_rx(struct uart_port *port)
> @@ -230,17 +230,17 @@ static int ulite_startup(struct uart_port *port=
)
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> - =A0 =A0 =A0 writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
> + =A0 =A0 =A0 __raw_writel(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_T=
X,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->membase + ULITE_CONTROL);
> - =A0 =A0 =A0 writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL)=
;
> + =A0 =A0 =A0 __raw_writel(ULITE_CONTROL_IE, port->membase + ULITE_CO=
NTROL);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0static void ulite_shutdown(struct uart_port *port)
> =A0{
> - =A0 =A0 =A0 writeb(0, port->membase + ULITE_CONTROL);
> - =A0 =A0 =A0 readb(port->membase + ULITE_CONTROL); /* dummy */
> + =A0 =A0 =A0 __raw_writel(0, port->membase + ULITE_CONTROL);
> + =A0 =A0 =A0 __raw_readl(port->membase + ULITE_CONTROL); /* dummy */
> =A0 =A0 =A0 =A0free_irq(port->irq, port);
> =A0}
>
> @@ -352,7 +352,7 @@ static void ulite_console_wait_tx(struct uart_por=
t *port)
>
> =A0 =A0 =A0 =A0/* Spin waiting for TX fifo to have space available */
> =A0 =A0 =A0 =A0for (i =3D 0; i < 100000; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D readb(port->membase + ULITE_STA=
TUS);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D __raw_readl(port->membase + ULI=
TE_STATUS);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((val & ULITE_STATUS_TXFULL) =3D=3D=
 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_relax();
> @@ -362,7 +362,7 @@ static void ulite_console_wait_tx(struct uart_por=
t *port)
> =A0static void ulite_console_putchar(struct uart_port *port, int ch)
> =A0{
> =A0 =A0 =A0 =A0ulite_console_wait_tx(port);
> - =A0 =A0 =A0 writeb(ch, port->membase + ULITE_TX);
> + =A0 =A0 =A0 __raw_writel(ch, port->membase + ULITE_TX);
> =A0}
>
> =A0static void ulite_console_write(struct console *co, const char *s,
> @@ -379,8 +379,8 @@ static void ulite_console_write(struct console *c=
o, const char *s,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&port->lock, flags);
>
> =A0 =A0 =A0 =A0/* save and disable interrupt */
> - =A0 =A0 =A0 ier =3D readb(port->membase + ULITE_STATUS) & ULITE_STA=
TUS_IE;
> - =A0 =A0 =A0 writeb(0, port->membase + ULITE_CONTROL);
> + =A0 =A0 =A0 ier =3D __raw_readl(port->membase + ULITE_STATUS) & ULI=
TE_STATUS_IE;
> + =A0 =A0 =A0 __raw_writel(0, port->membase + ULITE_CONTROL);
>
> =A0 =A0 =A0 =A0uart_console_write(port, s, count, ulite_console_putch=
ar);
>
> @@ -388,7 +388,7 @@ static void ulite_console_write(struct console *c=
o, const char *s,
>
> =A0 =A0 =A0 =A0/* restore interrupt state */
> =A0 =A0 =A0 =A0if (ier)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 writeb(ULITE_CONTROL_IE, port->membase =
+ ULITE_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ULITE_CONTROL_IE, port->me=
mbase + ULITE_CONTROL);
>
> =A0 =A0 =A0 =A0if (locked)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&port->lock, fl=
ags);
> @@ -601,7 +601,7 @@ ulite_of_probe(struct of_device *op, const struct=
 of_device_id *match)
>
> =A0 =A0 =A0 =A0id =3D of_get_property(op->node, "port-number", NULL);
>
> - =A0 =A0 =A0 return ulite_assign(&op->dev, id ? *id : -1, res.start+=
3, irq);
> + =A0 =A0 =A0 return ulite_assign(&op->dev, id ? *id : -1, res.start,=
 irq);
> =A0}
>
> =A0static int __devexit ulite_of_remove(struct of_device *op)
> --
> 1.6.2.1
>
>
>
> This email and any attachments are intended for the sole use of the n=
amed recipient(s) and contain(s) confidential information that may be p=
roprietary, privileged or copyrighted under applicable law. If you are =
not the intended recipient, do not read, copy, or forward this email me=
ssage or any attachments. Delete this email message and any attachments=
 immediately.
>
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
