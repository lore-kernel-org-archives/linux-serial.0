From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] TTY: serial 8250: Support MCR CLK_SEL bit.
Date: Tue, 20 Nov 2012 16:23:32 +0000
Message-ID: <20121120162332.4eaa14f2@pyramind.ukuu.org.uk>
References: <20121119085421.315.47347.stgit@localhost>
	<20121119120043.39f59baf@pyramind.ukuu.org.uk>
	<50AB538F.6030904@parkeon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60907 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab2KTQS1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 11:18:27 -0500
In-Reply-To: <50AB538F.6030904@parkeon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: mfuzzey@parkeon.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

> This chip is a DUART but the clksel bit, although present for
> both channels, (in MCR bit 7) is actually shared (as is the external
> CLKSEL pin). Hence if the kernel determines whether to enable
> /4 or /1 based on the requested baud rate for one channel it
> may break the baud rate for the other channel.

Gak.

> As a general question how should this type of dependency between
> ports due to them being part of the same chip be handled?

It sounds to me an even bigger reason for having the kernel 8250 termios
code have a ->clock_select() method but you'd need some way to find the
pair of the device. Ok thats uglier. Can you at least define the DT as
setting the *initial* divisor. That way we can later fix the kernel to be
smart about clocks without breaking any assumption about what the DT
entry means.

> So I've just refactored the existing code to share setting this bit -
> this shouldn't change the existing behaviour.
> 
> Maybe I should have done this as a seperate patch to make it clearer.

Got it - and yes please make that a separate patch.
 
> If UART_CAP_EFR is not set but UART_CAP_SLEEP or UART_CAP_CLKSEL is
> set is assumed that it is not necessary to enable access via the EFR 
> (whether
> that is a valid combination for any existing UART is another question).

Probably not.

Alan
