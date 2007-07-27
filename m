From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: serial flow control appears broken
Date: Fri, 27 Jul 2007 12:47:15 +0100
Message-ID: <20070727124715.20130b14@the-village.bc.nu>
References: <fa.Z6O0xFRT69zes0Mg+agt3Uiwux4@ifi.uio.no>
	<46A84B4A.6070902@shaw.ca>
	<46A8C6F1.4080309@howardsilvan.com>
	<20070726173121.70088a92@the-village.bc.nu>
	<46A98845.8010806@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:53469 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932412AbXG0LkN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2007 07:40:13 -0400
In-Reply-To: <46A98845.8010806@howardsilvan.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lee Howard <faxguy@howardsilvan.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-serial@vger.kernel.org

> So, does this explain why I wouldn't have a problem at 115200 bps with 
> kernel 2.2.5 but why I do with 2.6.5 and 2.6.18?  Both hardware and 

Without a scope on the board running both 2.2 and 2.6 that would be hard
to tell.

> Was there some associated application change in tty handling that needed 
> to occur between the 2.2 and 2.6 kernels to properly implement flow control?

Can we do this in a sensible, logical diagnostic order please. You are
making assumptions that seem unwise - eg that the code didn't happen to
work in 2.2.5 even though it was not correctly setting hardware flow
control, or that the defaults set by the user space apps run with the
distribution haven't changed and thus shown up such a problem.

Also was the 2.2 and 2.6 on the same exact mainboard ?

You've verified that flow control does not seem to be getting asserted
for h/w control on the wires

Next question on the software side therefore is does the serial port have
CRTSCTS set when the problem is showing up. (stty -a </dev/ttyWhatever)

