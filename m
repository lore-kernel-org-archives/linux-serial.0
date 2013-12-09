From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH] serial: pl011: use port lock to guard control register
 access
Date: Mon, 09 Dec 2013 17:34:01 +0000
Message-ID: <1386610441.3380.58.camel@linaro1.home>
References: <1386149930.3417.22.camel@linaro1.home>
 <alpine.LFD.2.10.1312041105470.31246@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.LFD.2.10.1312041105470.31246@knanqh.ubzr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2013-12-04 at 11:17 -0500, Nicolas Pitre wrote:
> On Wed, 4 Dec 2013, Jon Medhurst (Tixy) wrote:
> 
> > I can't help but think I've missed something fundamental here as it
> > seems wrong to be in the situation at all where were initialising
> > hardware if it is already being used?
> > 
> > Also, even with this fix I still see spurious/corrupt output on the
> > serial port at the point the port is initialised, so there is obviously
> > some other issues in this area.
> 
> I don't know if this is still the case nowdays, but that might be due to 
> the fact that the tty layer initializes the port speed to 9600 bauds 
> when opened.  So there might be a period when the port goes from 115200 
> bauds (from the serial console setup) to 9600 bauds, to finally go back 
> to 115200 bauds configured by the getty process.  If the serial console 
> is in the middle of outputting something when user space opens the port 
> then you might see garbled output for a brief period.

I've just got back to looking at this and the baud rate and data format
don't get gratuitously changed by the serial framework, just by
pl011_startup which sets the port to max baud rate and shortest bit size
in order to send one character via loopback mode (relevant code copied
below). These values get restored fairly quickly afterwards by a call to
pl011_set_termios, but there is a window where they are wrong, leading
to corruption if console outputs text during this window.

If I save and restore register values in this startup code then that
seems to fix things.

I guess an alternative would be to leave the registers unchanged in this
initialisation code if the port is being used for a console. But I'm
unsure how to reliably detect that is the case or if using the fact that
the port has already been setup once means that it's safe to assume it
stays set up, e.g. state isn't lost though power management actions.

	/*
	 * Provoke TX FIFO interrupt into asserting.
	 */
	cr = UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_LBE;
	writew(cr, uap->port.membase + UART011_CR);
	writew(0, uap->port.membase + UART011_FBRD);
	writew(1, uap->port.membase + UART011_IBRD);
	writew(0, uap->port.membase + uap->lcrh_rx);
	if (uap->lcrh_tx != uap->lcrh_rx) {
		int i;
		/*
		 * Wait 10 PCLKs before writing LCRH_TX register,
		 * to get this delay write read only register 10 times
		 */
		for (i = 0; i < 10; ++i)
			writew(0xff, uap->port.membase + UART011_MIS);
		writew(0, uap->port.membase + uap->lcrh_tx);
	}
	writew(0, uap->port.membase + UART01x_DR);
	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
		barrier();

-- 
Tixy
