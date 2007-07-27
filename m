From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 18:28:28 -0500
Message-ID: <1185578908.2989.15.camel@x2>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	 <46A84B4A.6070902@shaw.ca>	<46A8C6F1.4080309@howardsilvan.com>
	 <20070726173121.70088a92@the-village.bc.nu>
	 <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc>
	 <46D33636.7070200@microgate.com>  <46AA5A0E.1050600@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:57459
	"EHLO gw.microgate.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964923AbXG0Xcg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 19:32:36 -0400
In-Reply-To: <46AA5A0E.1050600@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Tilman Schmidt <tilman@imap.cc>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org

On Fri, 2007-07-27 at 13:48 -0700, Lee Howard wrote:
> Here's the output:
> 
>             type: 4
>             line: 1
>             line: 760
>              irq: 3
>            flags: 1358954688
>   xmit_fifo_size: 16
>   custom_divisor: 0
>        baud_base: 115200

OK, the FIFO should be enabled.

What is known:

* The error is a hardware FIFO overrun.
  - observed message is in n_tty due to driver setting TTY_OVERRUN

* The RTS/CTS flow control is not involved
  - this is done only by the ldisc in response to buffer levels
  - you verified crtscts is set
  - you did not observed RTS change when 'overflow error' logged
  - you did observe RTS change when application stopped reading

So this seems to be a latency issue reading the receive
FIFO in the ISR. The current rx FIFO trigger level
should be 8 bytes (UART_FCR_R_TRIG_10) which gives the
ISR 694usec to get the data at 115200bps.

IIRC, in 2.2.X kernels this defaulted to 4 bytes
(TRIG_01) which gave a little more time to service the interrupt.

How does the data rate affect the frequency of the overrun errors?
Does 57600bps make them go away?

--
Paul




