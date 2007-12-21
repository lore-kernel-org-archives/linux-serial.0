From: Thomas Koeller <thomas@koeller.dyndns.org>
Subject: RM9000 code broken in 8250.c
Date: Fri, 21 Dec 2007 12:50:17 +0100
Message-ID: <200712211250.18002.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx02.hansenet.de ([213.191.73.26]:54898 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbXLULuo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Dec 2007 06:50:44 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alex Williamson <alex.williamson@hp.com>
Cc: linux-serial@vger.kernel.org, Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Hi,

while investigating breakage of the RM9000 code in
drivers/serial/8250.c, I found that my problems are
caused by commit 40b36daad0ac704e6d5c1b75789f371ef5b053c1.
My device has the characteristic of not generating a
'transmitter empty' interrupt immediately if interrupts
are enabled while the transmitter is empty, it needs to
be kicked by transmitting a character first. Before
commit 40b36daad0ac704e6d5c1b75789f371ef5b053c1 this was
taken care of by code in serial8250_startup() that probed
the hardware for this bug an set the UART_BUG_TXEN flag,
which then modified the behavior of serial8250_start_tx()
to take the bug into account. This used to work well for
my device.

The commit introduced another check for the same condition
which is done earlier in serial8250_startup(), and causes
the driver to use a periodic timer instead of the hardware
interrupt. Now my device uses that timer, while it was
perfectly capable of using the serial port transmit
interrupt before.

I wonder why a new workaround has been introduced for a
problem for which there had already been a (far superior)
solution. Didn't this existing solution solve the problem
for the hardware in question? If so, wouldn't it have been
possible to modify the existing solution instead of adding
another one that conflicts with existing code that depends
on the old code?

regards,
Thomas
-- 
Thomas Koeller
thomas@koeller.dyndns.org
