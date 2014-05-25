From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: UART_IIR_BUSY set for 16550A
Date: Sun, 25 May 2014 08:04:09 -0400
Message-ID: <20140525120409.GG6946@thunk.org>
References: <CAGXD9Ocoo_sUnFmd-pfU52yUQ5oPjWxAHXjvP8facuMiOSUn5w@mail.gmail.com>
 <20140525003642.GC6946@thunk.org>
 <CAGXD9Odvyd_go-x9-gR7Q7_etYPLHekDM3SKRN+PCvDHc__LHg@mail.gmail.com>
 <20140525024414.GF6946@thunk.org>
 <CAGXD9Of8-v9TJ-0uuQ3TDzo5QYhB3uA=B5kMGQkiABSzFrWDng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:59796 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbaEYMEM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 May 2014 08:04:12 -0400
Content-Disposition: inline
In-Reply-To: <CAGXD9Of8-v9TJ-0uuQ3TDzo5QYhB3uA=B5kMGQkiABSzFrWDng@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Prasad Koya <prasad.koya@gmail.com>
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org

On Sat, May 24, 2014 at 11:21:38PM -0700, Prasad Koya wrote:
> IIR as 0xc2 and LSR as 0x21 and it read 2 chars in that iteration and
> sent 1 byte of data.
> 
> Since the interrupt handler services all ports before it returns, in
> next iteration it sees:
> 
> [  480.972102] BUG1027: I1: 1571:0xcc 1551:0x0
> 
> and it continues to see that till iteration 349. and nothing was read
> from FIFO or transmitted from iteration 1 to 349.

If there's nothing in the receive FIFO to read, and assuming the
serial driver is correctly determining that fact (i.e., UART_LSR_DR is
zero), then something is buggy with your UART.  If IIR is 0xcc, that
means that the UART is signalling that there is a receive interrupt
pending, with the FIFO level being below the trigger level but that
the characters have been in the FIFO long enough that they should get
picked up.

When the serial driver reads all of the characters from the receive
buffer, by checking UART_LSR for the UART_LSR_DR bit, and if it is
set, reading from the receive buffer via serial_in(up, UART_RX), that
should clear the IIR register of the receive interrupt.

> At next iteration it had 0x60 in LSR and again nothing is read or sent
> out. This continues till we see that "too much work".
> 
> [  480.972526] BUG1027: I350: 1571:0xcc 1551:0x60

Yep, buggy UART.  Unfortunately there are lot of crappy
reimplementations of the 8250/16550A UART's out there.  :-(

Which is precisely why we have the "too much work" safety check.  If
we didn't, your system would be locked up forever, looping in the
serial driver.  There is, alas, a lot of crappy hardware out there,
which is why the serial driver was coded so defensively.

In any case, combination of LSR with the UART_LSR_DR bit clear and IIR
set to 0xcc is one of these "this should never happen, under any
circumstances, with a correctly implemented 8250/16550A compatible
UART".  Which is why I can't really tell you how to reset the UART,
since at least in theory, this should never happen, and if it does
happen, without having access to the hardware and doing a lot of
frustating testing to reverse engineer the exact nature of the buggy
hardware, it's hard to figure out how to work around the brain damage.
Which is one of the reasons I was happy to get out of the serial
driver maintenance business.  :-)

Cheers,

					- Ted
