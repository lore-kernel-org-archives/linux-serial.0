From: Chris Gibson <chris@toftronix.com.au>
Subject: Re: [PATCH/RFC] serial: Add ioctl to enable auto rs485 mode with
	some Exar UARTs
Date: Sun, 21 Dec 2008 20:50:04 +1100
Message-ID: <1229853004.3216.14.camel@thewinkle.toftronix.com.au>
References: <200812190048.35249.mfuchs@ma-fu.de>
	 <200812191613.29657.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from toftronix.com.au ([60.241.205.236]:39394 "EHLO
	thetriton.toftronix.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751343AbYLUJq0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 21 Dec 2008 04:46:26 -0500
In-Reply-To: <200812191613.29657.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: Matthias Fuchs <mfuchs@ma-fu.de>, linux-serial@vger.kernel.org

Two and a half weeks ago I submitted a patch to implement RS485 auto
direction control on either (or both) the RTS and the DTR lines with
varying pre and post delay settings that would work for _all_ uarts that
support mctrl.

This patch had a variation on the ioctl suggested by Alan Cox, that was
a variation on an ioctl that was already in existence in the kernel.   

The ioctl was devised to allow considerable flexibility, and I hoped
that it would be considered for future auto direction control.

Sorry for sounding grumpy but is any one interested?

On Fri, 2008-12-19 at 16:13 +0100, Laurent Pinchart wrote:
> Hi Matthias,
> 
> On Friday 19 December 2008 00:48:34 Matthias Fuchs wrote:
> > Hi,
> >
> > please see my patch for enabling the RS485 half-duplex control below.
> > Please note that I am using this on a PowerPC platform. So I needed to
> > add the ioctl to the PowerPC header. As Wolfgang stated, it is
> > already in the x86 header. I am not sure if I have to post the modification
> > on the powerpc header to the PowerPC list or if it will be accepted here
> > as well.  .... But first I will have to see what you think of this patch
> > :-)
> >
> > Matthias
> >
> >
> > Some Exar UARTs support a auto rs485 mode. In this mode
> > the UART's RTS# pin is activated during transmitting and
> > can be used to enable a rs485 line driver. This has nothing
> > to do with attempts to do this by manually by asserting/
> > deasserting handshake lines.
> 
> [snip]
> > +		serial_outp(up, UART_LCR, 0xbf);
> > +		fctr = serial_inp(up, UART_FCTR);
> > +		if (rs485ctrl.flags & SER_RS485_ENABLED)
> > +			fctr |= 0x08;
> > +		else
> > +			fctr &= ~0x08;
> > +		serial_outp(up, UART_FCTR, fctr);
> > +		serial_outp(up, UART_LCR, 0);
> 
> You might also want to add a
> 
> #define UART_FCTR_RS485	0x08
> 
> to include/linux/serial_reg.h instead of using a hardcoded 0x08 constant.
> 

