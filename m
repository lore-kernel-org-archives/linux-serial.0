From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/4] serial: core: Add LED trigger support
Date: Tue, 6 Dec 2016 16:54:38 +0000
Message-ID: <20161206165438.5e37504f@lxorguk.ukuu.org.uk>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
        <20161123100106.15969-2-s.hauer@pengutronix.de>
        <e9fc12b8-d4a7-067d-ef87-03f0aae39bd7@gmail.com>
        <20161124081748.fx3xm5ww64ngn5it@pengutronix.de>
        <9225f2da-c6c4-73c8-829a-1033716b4c71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9225f2da-c6c4-73c8-829a-1033716b4c71@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

> > If we have different UART drivers, only one of them provides ttyS*, no?
> > Other drivers will have to use another namespace.  
> 
> I remember this was a problem a couple of years ago last I tried, with
> the 8250 driver being actually preventing other drivers from using
> ttyS*, but if you don't have 8250 taking over the low ttyS numbers, you
> may run into a case where several drivers successfully register their
> character devices under a ttyS* numbering scheme.
> 
> Whether this is hypothetical or not nowadays, it may be nicer to provide
> a more uniquely distinct name like what dev_name() returns, or
> ttyS*-driver-tx for instance?

It needs to be at the tty layer anyway or you will break low end
machines. On a low end system with a 16450A UART you've got something
like 160 microseconds at 57600 baud before you must have exited the
IRQ handler, re-entered it and be reading the data register again. The
current proposed patches touching the 8250 IRQ path are almost certainly
going to cause regressions on old machines.

So you need to hook receive at a point outside of the IRQ layer (eg when
the workqueue starts feeding it into the ldisc), but on the tx side you
need to hook the write method of the tty really, because tty_write sends
data to the ldisc and what happens then is up to the ldisc.

Even there though you have cases that are terribly latency dependant like
some of the dumb programming tools that don't window. If you halve
someones programming rate for microcontrollers you are going to get hate
mail 8) For RX that can mostly be avoided by queuing the data then doing
the LEDs, for TX I'm not clear you can easily hide the latency.

Alan
