From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH] serial imx.c: fix CTS trigger level lower to avoid lost chars
Date: Fri, 22 Jan 2010 16:47:13 +0000
Message-ID: <20100122164713.GA21907@shareable.org>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch> <20100121220653.GA21010@pengutronix.de> <20100121221133.GA30419@n2100.arm.linux.org.uk> <4B597A82.4020906@epfl.ch> <20100122110701.GA15699@shareable.org> <20100122113130.GB10449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:46919 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0AVQrW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 22 Jan 2010 11:47:22 -0500
Content-Disposition: inline
In-Reply-To: <20100122113130.GB10449@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Russell King - ARM Linux wrote:
> On Fri, Jan 22, 2010 at 11:07:01AM +0000, Jamie Lokier wrote:
> > Valentin Longchamp wrote:
> > > First I wanted to fix the fact that the imx serial hardware only raises 
> > > the CTS pin when the oferflowing char begins to be set. I would have 
> > > solved this by setting the CTS trigger value to 31 instead of 32. But 
> > > when I talked with one colleague he told me about 16550A (that is 
> > > present nearly everywhere) that empty their TX FIFO, so I
> > > lowered it to 16.
> > 
> > That seems quite peculiar because a 16550A only has a 16 byte receive
> > buffer, doesn't it?  And therefore it would have trouble talking
> > reliably to another 16550A if it worked like that.  I wonder what I'm
> > not seeing in this picture.
> 
> What you're assuming is that flow control was there to prevent overruns
> on the hardware receiver.  That's not the way it works on these devices;
> flow control is entirely managed in software - there is no hardware
> assistance.
> 
> The flow control implemented for non-FIFO and non-hardware assisted
> UARTs is purely to do with preventing the software buffer behind the
> UART from overflowing - it can't prevent the device's receiver buffering
> from overrunning.  (Non-FIFO devices have the shift register and a
> buffer register - complete reception of a second character before the
> first is read causes an overrun condition.)

Thanks.  That is an excellent explanation.

> If you have overruns on the receiver, that's an interrupt latency
> problem and its an error that's reported to the receiver side only.

Yeah :-/ On an ARM-related note, I have a 166MHz ARM device here which
cannot receive reliably at 38400 baud.  The serial port isn't an ARM
one, but it's quite straightforward and has a 16 byte FIFO, which
translates to 240 irqs per second.  I believe the problem is an
interrupt latency problem, especially when it's busy doing other
things too like disk and network access, but surprisingly even when
it's not very active with other things.

Any tips on how to make the serial receive irq latency more reliable
on ARM, with a boringly generic serial driver?

> Yes, later devices have the ability in hardware to deassert RTS when
> the receiver FIFO gets above a certain threshold to /help/ prevent
> overruns occuring when there's high interrupt latency - but normal
> system operation should still ensure that the FIFO is emptied in a
> timely manner.
> 
> They also gained the ability to stop the transmitter once CTS is
> deasserted, mainly because the transmitter FIFOs in these devices
> is soo large (maybe 32 to 128 bytes deep.)

If only they were all like that. :-/

-- Jamie
