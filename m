From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty/serial: add support for Xilinx PS UART
Date: Wed, 20 Apr 2011 10:25:01 +0100
Message-ID: <20110420102501.1e395f14@lxorguk.ukuu.org.uk>
References: <e35578a9-909d-4594-bbe4-41d89b5f9b3e@VA3EHSMHS014.ehs.local>
	<20110419221530.7370d013@lxorguk.ukuu.org.uk>
	<551928f1-72b8-432e-879e-8721b5c87414@VA3EHSMHS017.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37041 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752507Ab1DTJYA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 20 Apr 2011 05:24:00 -0400
In-Reply-To: <551928f1-72b8-432e-879e-8721b5c87414@VA3EHSMHS017.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Linn <John.Linn@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

> > > +	/* Min baud rate = 6bps and Max Baud Rate is 10Mbps for 100Mhz
> > clk */
> > > +	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
> > > +	xuartps_set_baud_rate(port, baud);
> > 
> > So why pass 460800 ?
> 
> Seems like 115200 is better number.

Well if it can do 10Mbit why not pass 10Mbit as the upper limit ?

> > And set the baud rate (see 8250.c for an example). Note that the
> helper
> > functions know about mapping slight errors so if you are asked for
> 9600
> > and the hardware does 9575 it will report B9600 as you'd expect not do
> > something crazy.
> > 
> 
> Sorry I didn't follow what you meant above. The h/w is a bit different
> with it's
> baud rate settings due to 2 different dividers.

After you've worked out what baud rate you actually set do

	       /* Don't rewrite B0 */
        if (tty_termios_baud_rate(termios))
                tty_termios_encode_baud_rate(termios, baud, baud);


which will ensure that the termios reflects the actual rate.

Alan
