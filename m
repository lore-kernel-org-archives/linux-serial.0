From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/12] tty: amba-pl011: add register accessor functions
Date: Thu, 24 Dec 2015 15:14:24 +0000
Message-ID: <20151224151424.GG8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNl7-0003jH-85@rmk-PC.arm.linux.org.uk>
 <566333AF.8020507@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <566333AF.8020507@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 05, 2015 at 01:57:51PM -0500, Peter Hurley wrote:
> On 11/16/2015 12:40 PM, Russell King wrote:
> > Add register accessor functions to amba-pl011.  Much of this
> > transformation was done using the sed expression below, with any
> > left-overs fixed up manually afterwards, and code formatted to remain
> > within coding style.
> 
> A couple local temporaries are u16; I noted which below.
> Can be fixed with follow-up patch if desired.
> 
> > s/readw(\(uap->port.membase\|regs\|port->membase\) +/pl011_read(\1,/g
> > s/writew(\(.*\) +/pl011_write(\1,/g
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/tty/serial/amba-pl011.c | 210 +++++++++++++++++++++-------------------
> >  1 file changed, 112 insertions(+), 98 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> > index 899a77187bde..bd01e75128dc 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -184,6 +184,16 @@ struct uart_amba_port {
> >  #endif
> >  };
> >  
> > +static unsigned int pl011_read(void __iomem *base, unsigned int reg)
> > +{
> > +	return readw(base + reg);
> > +}
> > +
> > +static void pl011_write(unsigned int val, void __iomem *base, unsigned int reg)
> > +{
> > +	writew(val, base + reg);
> > +}
> > +
> >  /*
> >   * Reads up to 256 characters from the FIFO or until it's empty and
> >   * inserts them into the TTY layer. Returns the number of characters
> > @@ -196,12 +206,12 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
> >  	int fifotaken = 0;
> >  
> >  	while (max_count--) {
> > -		status = readw(uap->port.membase + UART01x_FR);
> > +		status = pl011_read(uap->port.membase, UART01x_FR);
> 
> status is u16.

Not a problem, the register itself is only 16-bit wide.

> >  		if (status & UART01x_FR_RXFE)
> >  			break;
> >  
> >  		/* Take chars from the FIFO and update status */
> > -		ch = readw(uap->port.membase + UART01x_DR) |
> > +		ch = pl011_read(uap->port.membase, UART01x_DR) |
> >  			UART_DUMMY_DR_RX;
> >  		flag = TTY_NORMAL;
> >  		uap->port.icount.rx++;
> > @@ -438,7 +448,7 @@ static void pl011_dma_tx_callback(void *data)
> >  
> >  	dmacr = uap->dmacr;
> 
> dmacr is u16.
> 
> >  	uap->dmacr = dmacr & ~UART011_TXDMAE;
> > -	writew(uap->dmacr, uap->port.membase + UART011_DMACR);
> > +	pl011_write(uap->dmacr, uap->port.membase, UART011_DMACR);

Also not a problem.

> > @@ -658,9 +668,9 @@ static inline bool pl011_dma_tx_start(struct uart_amba_port *uap)
> >  	 */
> >  	dmacr = uap->dmacr;
> 
> dmacr is u16.

Not a problem.

> > @@ -1361,15 +1372,15 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
> >  	int handled = 0;
> >  
> >  	spin_lock_irqsave(&uap->port.lock, flags);
> > -	imsc = readw(uap->port.membase + UART011_IMSC);
> > -	status = readw(uap->port.membase + UART011_RIS) & imsc;
> > +	imsc = pl011_read(uap->port.membase, UART011_IMSC);
> 
> imsc is u16.

Not a problem, IMSC is only 16-bit wide.

None of these are a problem:
* The registers are defined on 32-bit boundaries.
* The registers in question all have less than 16 bits.
* GCC will automatically promote/demote these integers as necessary.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
