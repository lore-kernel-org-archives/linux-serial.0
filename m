From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: [PATCH] Make the Startech UART detection 'more correct'.
Date: Tue, 9 Sep 2003 15:12:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <000701c37706$513a9a10$294b82ce@stuartm>
References: <20030909171859.D4216@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030909171859.D4216@flint.arm.linux.org.uk>
To: 'Russell King' <rmk@arm.linux.org.uk>, 'Tom Rini' <trini@kernel.crashing.org>
Cc: tytso@mit.edu, 'Kernel Mailing List' <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, gallen@arlut.utexas.edu
List-Id: linux-serial@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> size_fifo() is claimed to be unreliable at detecting the FIFO size,
> so I don't feel safe about using it here.

"Claimed" being the operative word. This claim predates my involvement
with the serial driver (IIRC tytso is reporting someone's claim
second-hand), however, my company has always used this test in various
test apps, and never had it fail, and this predates my employment with
them.

So. A number of possibilities: someone thought it was unreliable, but
they were incorrect; it was unreliable, but because the software was
wrong; it was unreliable, but only on certain very old hardware that I
personally have no knowledge of its existance.

I've never seen any concrete details about what goes wrong either,
just a simple claim of unreliability.

The premise is simple enough. Put the uart into internal loopback mode
(the rx and tx pins on the chip become on-die connected to each other,
date never leaves the chip), transmit 256 characters at a known baud
rate, wait for at least the time it takes to transmit these characters
plus some to be safe, and see how many are left in the rx fifo, which
should be full.

> I'd suggest something like:
> 
> 	serial_outp(port, UART_LCR, UART_LCR_DLAB);
> 	efr = serial_in(port, UART_EFR);
> 	if ((efr & 0xfc) == 0) {
> 		serial_out(port, UART_EFR, 0xac | (efr & 3));
> 		/* if top 6 bits return zero, its motorola */
> 		if (serial_in(port, UART_EFR) == (efr & 3)) {
> 			/* motorola port */
> 		} else {
> 			/* ST16C650V1 port */
> 		}
> 		/* restore old value */
> 		serial_outb(port, UART_EFR, efr);
> 	}
> 
> If you can guarantee that the lower two bits will always be 
> zero, you can
> drop the frobbing to ignore/preseve the lower two bits.

Does the Motorola chip have an ID register at all? Certainly using the
fifo size is a weak test and should only be a last resort.

..Stu
