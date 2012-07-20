From: "Tobias Arp" <tobiasarp@gmx.de>
Subject: Re: ST16C654 stoppes transmitting after a while
Date: Fri, 20 Jul 2012 12:10:56 +0200
Message-ID: <20120720101056.257640@gmx.net>
References: <20120717074355.80180@gmx.net>
	<20120717105229.17b578a5@pyramind.ukuu.org.uk>
	<20120717100521.219440@gmx.net>
	<20120717122140.075aa7ae@pyramind.ukuu.org.uk>	<20120717113603.9830@gmx.net>
 <20120717173847.1c5b4863@pyramind.ukuu.org.uk> <20120718063704.130240@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:51057 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751490Ab2GTKLA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 20 Jul 2012 06:11:00 -0400
In-Reply-To: <20120718063704.130240@gmx.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tobias Arp <tobiasarp@gmx.de>, alan@lxorguk.ukuu.org.uk
Cc: linux-serial@vger.kernel.org

I could track down the problem:

The interrupt if the MSR change (DCTS) gets lost on this point:

An interrupt is handled and CTS changes during transmit_chars() and this change is not recognized.

Is spin_lock_irqsave() too slow (on my platform and this circumstanmces? How can i avoid this ?

in 8250.c:


/*
 * This handles the interrupt from one port.
 */
static void serial8250_handle_port(struct uart_8250_port *up)
{
	unsigned int status;
	unsigned int status2;
	unsigned long flags;

	spin_lock_irqsave(&up->port.lock, flags);

	status = serial_inp(up, UART_LSR);

	DEBUG_INTR("status = %x...", status);

	if (status & (UART_LSR_DR | UART_LSR_BI))
		receive_chars(up, &status);
	check_modem_status(up);
	if (status & UART_LSR_THRE)
		transmit_chars(up);
	spin_unlock_irqrestore(&up->port.lock, flags);
}


Thanks

Tobias


-------- Original-Nachricht --------
> Datum: Wed, 18 Jul 2012 08:37:04 +0200
> Von: "Tobias Arp" <tobiasarp@gmx.de>
> An: Alan Cox <alan@lxorguk.ukuu.org.uk>
> CC: linux-serial@vger.kernel.org
> Betreff: Re: ST16C654 stoppes transmitting after a while

> The serial links are all set up to 115200 baud.
> 
> Dumping out the tty-struct when it hangs shows me this:
> 
> magic: 0x5401
> name: ttyS0
> flags: 0x00000A00
> count: 1
> stopped: 0
> hw_stopped: 1
> flow_stopped: 0
> packet: 0
> low_latency: 0
> warned: 0
> ctrl_status: 0x00
> receive_room: 4095
> ...
> 
> It is a little bit strange that always the null modem connection shows
> this behaviour. May be it's because it has the highest data transfer rate (all
> other connections are made by isdn modems / 1-channel isdn)?
> 
> 
> 
> 
> -------- Original-Nachricht --------
> > Datum: Tue, 17 Jul 2012 17:38:47 +0100
> > Von: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > An: "Tobias Arp" <tobiasarp@gmx.de>
> > CC: linux-serial@vger.kernel.org
> > Betreff: Re: ST16C654 stoppes transmitting after a while
> 
> > On Tue, 17 Jul 2012 13:36:03 +0200
> > "Tobias Arp" <tobiasarp@gmx.de> wrote:
> > 
> > > This is a single core arm processor (Cirrus EP9315), could this race
> > condition happen in this case? 
> > 
> > In theory, otoh it ought to be quite easy to test for.
> > 
> > How fast are your links - would it be fair to characterise your
> > environment as a fairly slow CPU handling a lot of fast serial links
> > 
> > (just trying to understand what the likely places to look might be)
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-serial"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


