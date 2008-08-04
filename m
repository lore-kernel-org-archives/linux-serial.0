From: "Tosoni" <jp.tosoni@acksys.fr>
Subject: RE: [PATCH/RFC] 8250: Auto RS485 direction control
Date: Mon, 4 Aug 2008 18:47:40 +0200
Message-ID: <015301c8f651$cfea6cd0$2e01a8c0@acksys.local>
References: <200808041637.02058.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp04.msg.oleane.net ([62.161.4.4]:60989 "EHLO
	smtp04.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbYHDRPi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Aug 2008 13:15:38 -0400
In-Reply-To: <200808041637.02058.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Laurent Pinchart' <laurentp@cse-semaphore.com>
Cc: linux-serial@vger.kernel.org

> Original Message From: Laurent Pinchart
> Sent: Monday, August 04, 2008 4:37 PM
> 
> On Monday 04 August 2008, Tosoni wrote:
> > About the flags names -- CARTS, UART_FCTR_RS485
> > 
> > May I suggest CRTSTOGGLE since it is known by that kind
> > of name in other OS's :-)
> 
> I like Russell's proposal of sticking to CRTSCTS and adding 
> options to setserial:
> 
> > Should CRTSCTS be a global "enable some kind of flow 
> control" bit and
> > setserial be used to configure the actual flow control method
> > (conventional RTS/CTS, DTR/DSR, alternate RTS/CTS, RS485 on RTS,
> > RS485 on DTR) ?
> 
> Any opinion on that ?

It sounds fine, and it's much better than nothing.
Here are some drawbacks I can see:

1. We are talking about userland to kernel interface. It should
look like a "virtual" or "ideal" serial port. See this example:

The Philips SC28L202 chip can implement RS485 on RTS with its
MD2(5) register, but is is definitely NOT compatible with the 16C550.
What if I want to make a driver for it ? (and it might well happen)
Must I support setserial for it then ? Will setserial evolve when my
SC28L202 driver evolves ?

AFAIK setserial was added to handle new, specific features for 8250
compatible cards without breaking *NIX TERMIOS compatibility. If a
general feature can be added without resorting to setserial nor breaking
*NIX compatibility, let's do so ! (else let's do our best with setserial)

2. As far as I remember the CRTSCTS flag has a long history back to
XENIX and SCO Unix ports. This flag is well defined and used in
many *NIX implementations and I am reluctant to alter its meaning.

On the other hand, using CRTSCTS would garantee that is any
architecture we will find this bit available in termios, which may
not be the case with a brand new bit definition.

Last remark:
Interestingly, the RTS envelope on the Oxford chips is implemented
with... the DTR pin. On our cards we have a piece of hardware which
redirect the uart DTR pin to the external RTS in this case.


> 
> > And further, it says was RTS will do, instead of why. Maybe 
> someone could
> > use it for something other than RS485 ?
> 
> I agree with you here. The name should reflect that RTS is 
> used in 'envelope' mode (asserted during data transmission, 
> idle between frames).
> 
> Best regards,
> 
> -- 
> Laurent Pinchart
> CSE Semaphore Belgium
> 
> Chaussee de Bruxelles, 732A
> B-1410 Waterloo
> Belgium
> 
> T +32 (2) 387 42 59
> F +32 (2) 387 42 75
> 
