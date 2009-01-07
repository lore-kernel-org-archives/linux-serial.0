From: Matthias Fuchs <mfuchs@ma-fu.de>
Subject: Re: [PATCH V2] serial: Add ioctl to enable auto rs485 mode with some Exar UARTs
Date: Wed, 7 Jan 2009 22:56:03 +0100
Message-ID: <200901072256.03667.mfuchs@ma-fu.de>
References: <200901021726.09767.mfuchs@ma-fu.de> <1231336690.29906.48.camel@thetriton.toftronix.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:59276 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751856AbZAGV4I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Jan 2009 16:56:08 -0500
In-Reply-To: <1231336690.29906.48.camel@thetriton.toftronix.com.au>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christopher Gibson <chris@toftronix.com.au>
Cc: linux-serial@vger.kernel.org, Laurent Pinchart <laurentp@cse-semaphore.com>

> On Fri, 2009-01-02 at 17:26 +0100, Matthias Fuchs wrote:
> > Some Exar UARTs support a auto rs485 mode. In this mode
> > the UART's RTS# pin is activated during transmitting and
> > can be used to enable a rs485 line driver.
>  --->8----
> 
> > +
> > +	case TIOCGRS485:
> > +	{
> > +		struct serial_rs485 rs485ctrl;
> 
> Should the TIOCGRS485 call set delay_rts_before_send structure element
> to 0 to demonstrate that there is no delay ability?  memset(&rs485ctrl,
> 0, sizeof(struct serial_rs485)); missing?
Yes, that makes sense. I will add the memset and also add the saving of the LCR 
as Laurent requested.

Matthias
