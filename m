From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New serial card development
Date: Thu, 1 Nov 2012 22:26:19 +0000
Message-ID: <20121101222619.12bb9c50@pyramind.ukuu.org.uk>
References: <5074703E.408@commtech-fastcom.com>
	<20121014093704.GA6207@thunk.org>
	<CAJp1Oe6F+KiXoWdhb7JjbYmNBY4gxbtBzwNu0gWC7XzA_ZJxMg@mail.gmail.com>
	<20121016002608.64b33de5@pyramind.ukuu.org.uk>
	<20121016023226.GA17446@thunk.org>
	<CAJp1Oe4n-TtxDM8D82bFQxjBtx8rSAX8mWrFk0bSM6uGL9X=Eg@mail.gmail.com>
	<20121019212158.GB4721@thunk.org>
	<CAJp1Oe6ekkaZ29iwJ91VXwM_CSL6Z0_KEaqVQTa1XMzTB5niEQ@mail.gmail.com>
	<CAJp1Oe67Jd+FaaDPosexrVrrUFS=c-0FUZx_JHTbpTN5RCCcUw@mail.gmail.com>
	<20121023183859.GA3317@kroah.com>
	<CAJp1Oe7MMuk8TNBom2EDXx6UBdMV6qAE5fDdKTZ0o-329QSdaA@mail.gmail.com>
	<CAJp1Oe7Lk2q6v+5jrj2wD4cW=M9LX6kkia=AQnJKOiUEod5uRQ@mail.gmail.com>
	<CAJp1Oe4cnWot=wgou91dea81hHNxo8RWOPwXJj3o+JL4zOwQpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35355 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760291Ab2KAWVP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Nov 2012 18:21:15 -0400
In-Reply-To: <CAJp1Oe4cnWot=wgou91dea81hHNxo8RWOPwXJj3o+JL4zOwQpg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: Greg KH <greg@kroah.com>, Theodore Ts'o <tytso@mit.edu>, linux-serial@vger.kernel.org

> Hello, the next question that I have is how to handle the interrupts
> on this UART.  It has a more complex interrupt scheme than a
> traditional 8250 UART.  There is a global ISR register that tells you
> which port had the interrupt and then there is another set of
> registers that hold the actual interrupts.

port->handle_irq is half of what you need, but you probably need to be
able to hook serial8250_interruot and provide your own alternative. Given
you don't need the irq chain handling either probably the bit that wants
to be hookable is the calls to serial_link_irq_chain and
serial_unlink_irq_chain in the startup/shutdown methods.

In yor case all that and all the irq scanning the chain becomes a simple
read of the port and call of the handlers (serial8250_handlee_irq(port,
iir)



Alan
