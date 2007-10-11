From: Erik de Castro Lopo <mle+lk@mega-nerd.com>
Subject: 16550A Serial control flow
Date: Thu, 11 Oct 2007 11:41:26 +1000
Message-ID: <20071011114126.6f9edaaa.mle+lk@mega-nerd.com>
Reply-To: linux-serial@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.syd.people.net.au ([218.214.225.98]:58790 "HELO
	smtp.syd.people.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751121AbXJKBsK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 Oct 2007 21:48:10 -0400
Received: from hendrix (hendrix [192.168.200.99])
	by hendrix.mega-nerd.net (Postfix) with SMTP id 4263CAD94F
	for <linux-serial@vger.kernel.org>; Thu, 11 Oct 2007 11:41:27 +1000 (EST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all,

I'm trying to get a small serial printer working. The printer 
operates at 9600 baud (how 1980), uses hardware flow control and 
has a 20 byte recieve fifo. The hardware flow control is triggered
when the fifo has 16 characters in it.

I'm connecting this printer to linux machine running a recent 2.6
kernel with a 16550A based serial port. The driver being used is
drivers/serial/8250.c which recognises the 16550A and sets it up
using this:

	[PORT_16550A] = {
		.name		= "16550A",
		.fifo_size	= 16,
		.tx_loadsz	= 16,
		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
		.flags		= UART_CAP_FIFO,

The problem I'm having is that there is a mismatch between the
fifos on the Linux size and the printer causes wrap around of
the buffer in the printer and badly screwed up print jobs.

The manufacturer of the printer suggests hacking the driver
(drivers/serial/8250.c) and changing the .tx_loadsz value for
the 16550A from 16 to 2.

I have tried this and can confirm that it does work. However, 
this solution sucks really badly. For one, we use other 16550A 
serial ports on the machine for other purposes where we use high 
baud rates and expect high throughput. Crippling the 16550A 
behaviour like this is not a step in the right direction.

Ideally, what would be nice is an ioctl that will change the
value of .tx_loadsz on a per port basis.

It seems that there is already an ioclt that could be used for
this, the TIOCGSERIAL/TIOCSSERIAL pair. I've tried using this
ioctl for the 16550A ports and while I can change the value
of the xmit_fifo_size field of serial_struct, the change doesn't
actually have any effect.

Questions:

 0) Is the current behaviour of the 16550A as described above
    correct?
 1) Should changing the xmit_fifo_size using the TIOCGSERIAL/
    TIOCSSERIAL ioctls allow me to fix this on a per port basis?
 2) Is there another/better solution?

Cheers,
Erik
-- 
-----------------------------------------------------------------
Erik de Castro Lopo
-----------------------------------------------------------------
"Every method you use to prevent or find bugs leaves a residue of
subtler bugs against which those methods are ineffectual."
-- Bruce Beizer's Pesticide Paradox
