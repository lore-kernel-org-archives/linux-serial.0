From: Greg KH <greg@kroah.com>
Subject: Re: How to disable the transmit FIFO?
Date: Thu, 18 Nov 2010 12:11:25 -0800
Message-ID: <20101118201125.GA26323@kroah.com>
References: <E1PJ0al-0000hs-Kb@palantir.moria.de>
 <20101118164122.GB2855@kroah.com>
 <E1PJAfx-0000gW-8e@palantir.moria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:39042 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757037Ab0KRUL2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Nov 2010 15:11:28 -0500
Content-Disposition: inline
In-Reply-To: <E1PJAfx-0000gW-8e@palantir.moria.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Haardt <michael@moria.de>
Cc: linux-serial@vger.kernel.org

On Thu, Nov 18, 2010 at 09:01:45PM +0100, Michael Haardt wrote:
> > > I miss a way to disable the transmit FIFO.
> >
> > From userspace or from within a kernel driver?
> 
> >From userspace.
> 
> > > UARTs that don't do hardware handshaking in hardware, but use a transmit
> > > FIFO, can only be used if the peer can deal with the delayed handshaking
> > > response.
> > > 
> > > If slow peers can not receive at line rate, hardware handshaking will
> > > still cause overruns with Linux as sender, because Linux fills the
> > > transmit FIFO and transmission continues at worst for 16 characters with
> > > a 16550 after CTS was asserted.
> > > 
> > > So, how can I fix hardware flow control response to the non-delayed
> > > behaviour as it worked with a 8250 or 16450 by disabling the transmit
> > > FIFO?
> >
> > So you are saying this used to work and now it doesn't?
> 
> It used to work with old non-FIFO UARTs (8250, 16450) and does not work
> with the slightly newer FIFO-UARTs (16550 and up, probably excluding
> those that can do RTS/CTS flow control in hardware).

It also breaks down massively with usb to serial devices where the delay
is a lot bigger :)

> A transmitter FIFO on a UART that can not do RTS/CTS flow control in
> hardware delays the flow control response by the size of the FIFO.
> By the time Linux notices CTS being set, the FIFO is already filled and
> the transmitter keeps sending, despite the peer asking to pause.
> 
> It is desirable that flow control has minimal delays from seeing CTS
> to pausing the flow.  Given a 16550 UART, you have to disable the
> transmitter FIFO for that.  One could argue whether the default should
> be high throughput (use the FIFO and delay handshaking) or correct flow
> control (no FIFO and near instant handshaking).  Most systems default
> to the first.
> 
> The admin has to know if the peer allows delayed flow control and
> configure it for the affected UART ports.  Windows allows exactly that
> and the MS knowledge base correctly describes that the FIFO size may
> cause data overruns, suggesting to reduce it until the problem goes away.
> A binary switch, as offered by BSD, probably suffices, though.

What is the BSD user/kernel api that they have to provide this?

thanks,

greg k-h
