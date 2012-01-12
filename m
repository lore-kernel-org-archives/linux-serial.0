From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty/serial: Need clarification on Support for 4+M Baudrate
Date: Thu, 12 Jan 2012 14:39:00 +0000
Message-ID: <20120112143900.27b92668@pyramind.ukuu.org.uk>
References: <20120111121901.GA4034@bnru05>
	<20120111123025.244a9cf5@pyramind.ukuu.org.uk>
	<2B1D156D95AE9B4EAD379CB9E465FE7324AF2A605A@EXDCVYMBSTM005.EQ1STM.local>
	<20120112114913.21809bed@pyramind.ukuu.org.uk>
	<2B1D156D95AE9B4EAD379CB9E465FE7324AF2A630D@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:59580 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab2ALOi0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 09:38:26 -0500
In-Reply-To: <2B1D156D95AE9B4EAD379CB9E465FE7324AF2A630D@EXDCVYMBSTM005.EQ1STM.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rajanikanth H V <rajanikanth.hv@stericsson.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@sude.de" <gregkh@sude.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, 12 Jan 2012 15:20:46 +0100
Rajanikanth H V <rajanikanth.hv@stericsson.com> wrote:

> Alan,
> 
> FYI: I am not using application, rather I have a Bluetooth driver invoking
> encode_baud_rate(...), please find log below.
> 
> I made sure that c_ispeed = c_ospeed = 4.05M Baud, however I see 
> tty_termios_encode_baud_rate(...) is normalizing to 4.0
> 
> 
> manual trace log below:
> ======================================================================================
> 
> 4.05M Arbitrary Baud Setting Sequence:
> [    9.664703] alloc_set_baud_rate_cmd Setting arbitrary baudrate using BOTHER baudrate:89 c_cflag:020000016262
> [    9.774658] XXXXXX_hci_uart_set_baudrate c_cflag:020000016262 baud:4050000

4050000 seems a bit odd - you want cflag&CBAUD == BOTHER so I'd expect
the low bits to end rather different things to 6262 ?

So something like

	struct ktermios new = *tty->termios;
	new.c_cflag &= ~(CBAUD|CIBAUD);
	new.c_cflag |= BOTHER;
	new.c_ispeed = 4050000;
	new.c_ospeed = 4050000;
	tty_set_termios(tty, &new);	/* Can sleep */

	/* Returned new will now hold actual values selected */

should do the trick providing the low level driver supports the rate.

Alan
