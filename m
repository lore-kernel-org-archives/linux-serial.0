From: Gabriel Matni <gabriel.matni@exfo.com>
Subject: RE: [PATCH] serial: mvebu-uart: fix tx lost characters
Date: Thu, 15 Mar 2018 18:55:25 +0000
Message-ID: <3B588D51285A4A4D8D39C94212E078262787C0@SPQCMBX02.exfo.com>
References: <3B588D51285A4A4D8D39C94212E078262748ED@SPQCMBX02.exfo.com>
 <20180315165516.GA9519@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180315165516.GA9519@kroah.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, =?iso-8859-1?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-serial@vger.kernel.org

From: Gabriel Matni <gabriel.matni@exfo.com>

Fixes missing characters on kernel console at low baud rates (i.e.9600).
The driver should poll TX_RDY or TX_FIFO_EMP instead of TX_EMP to ensure
that the transmitter holding register (THR) is ready to receive a new byte.

TX_EMP tells us when it is possible to send a break sequence via
SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
empty, it does not guarantee that a new byte can be written just yet.

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700
      serial port")
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> 
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>  
Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com> 

---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index a100e98259d7..400e1bc558b2 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
 	u32 val;
 
 	readl_poll_timeout_atomic(port->membase + UART_STAT, val,
-				  (val & STAT_TX_EMP), 1, 10000);
+             (val & STAT_TX_RDY(port)), 1, 10000);
 }
 
 static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
-- 
2.7.4


> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: March 15, 2018 12:55 PM
> To: Gabriel Matni <gabriel.matni@exfo.com>
> Cc: linux-arm-kernel@lists.infradead.org; stable@vger.kernel.org; Miquel
> Raynal <miquel.raynal@bootlin.com>; Grégory Clement
> <gregory.clement@bootlin.com>; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>
> Subject: Re: [PATCH] serial: mvebu-uart: fix tx lost characters
> 
> On Tue, Mar 06, 2018 at 03:47:03PM +0000, Gabriel Matni wrote:
> > From: Gabriel Matni <gabriel.matni@exfo.com>
> >
> > Fixes missing characters on kernel console at low baud rates (i.e.9600).
> > The driver should poll TX_RDY or TX_FIFO_EMP instead of TX_EMP to
> ensure
> > that the transmitter holding register (THR) is ready to receive a new byte.
> >
> > TX_EMP tells us when it is possible to send a break sequence via
> > SND_BRK_SEQ. While this also indicates that both the THR and the TSR are
> > empty, it does not guarantee that a new byte can be written just yet.
> >
> > Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700
> serial port")
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > Signed-off-by: Gabriel Matni <gabriel.matni@exfo.com>
> > ---
> > drivers/tty/serial/mvebu-uart.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-
> uart.c
> > index a100e98259d7..f0df0640208e 100644
> > --- a/drivers/tty/serial/mvebu-uart.c
> > +++ b/drivers/tty/serial/mvebu-uart.c
> > @@ -618,7 +618,7 @@ static void wait_for_xmitr(struct uart_port *port)
> >    u32 val;
> >
> >    readl_poll_timeout_atomic(port->membase + UART_STAT, val,
> > -             (val & STAT_TX_EMP), 1, 10000);
> > +             (val & STAT_TX_RDY(port)), 1, 10000);
> > }
> >
> > static void mvebu_uart_console_putchar(struct uart_port *port, int ch)
> > --
> > 2.7.4
> 
> Patch is corrupted and can not be applied :(
> 
> Please fix up and resend.
> 
> Also be sure to cc: the linux-serial mailing list,
> scripts/get_maintainer.pl is your friend...
> 
> thanks,
> 
> greg k-h
