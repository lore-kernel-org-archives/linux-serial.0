From: Paul Fulghum <paulkf@microgate.com>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 19:34:23 +0000 (UTC)
Message-ID: <46D33636.7070200__46621.8012887568$1185564863$gmane$org@microgate.com>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>	<46A84B4A.6070902@shaw.ca>	<46A8C6F1.4080309@howardsilvan.com> <20070726173121.70088a92@the-village.bc.nu> <46A98845.8010806@howardsilvan.com> <46A9F712.70706@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932485AbXG0TeF@vger.kernel.org>
Date: Mon, 27 Aug 2007 14:38:14 -0600
In-Reply-To: <46A9F712.70706@imap.cc>
Sender: linux-kernel-owner@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Lee Howard <faxguy@howardsilvan.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org, tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Tilman Schmidt wrote:
> Could this be related?
> 
> http://lkml.org/lkml/2007/7/18/245
> 
> Quote:
> "I've recently found (using 2.6.21.4) that configuring a serial ports
> (ST16654) which use the 8250 driver using setserial results in the
> UART's FIFOs being disabled (unless you specify autoconfig)."

That would make sense.

Lee's error is a hardware FIFO overrun which could occur
if the FIFO is being disabled as described in your
link (by trying to set the uart type with setserial).

Since the tty flow control is only triggered
by the line discipline in response to ldisc
buffer levels and not hardware FIFO overruns,
you would never see any flow control action
as reported by Lee.


-- 
Paul Fulghum
Microgate Systems, Ltd.
