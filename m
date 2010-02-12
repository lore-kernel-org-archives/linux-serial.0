From: sfabel <sfabel@hawaii.edu>
Subject: Intel 82801 DB LPC / 6 serial ports, only 1 works
Date: Fri, 12 Feb 2010 15:21:46 -0800 (PST)
Message-ID: <27570741.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kuber.nabble.com ([216.139.236.158]:54567 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab0BLXVr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Feb 2010 18:21:47 -0500
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1Ng4pW-0006G9-Bq
	for linux-serial@vger.kernel.org; Fri, 12 Feb 2010 15:21:46 -0800
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hello,

I've been banging my head on this issue for a couple of days now and would
appreciate any help or pointers in the right direction. I've got an
Intel-based motherboard with the above mentioned LPC bus integrated. There
is one regular serial port included (DB 9), the rest is on the bus. I've got
several motor controllers hanging on that bus. Under Windows, they are
attached to COM4, 5 and 6.

Under Linux (2.6.31/Ubuntu stock kernel), I only get /dev/ttyS{0,1,2,3}
initially. Ports 0-2 are dead, under ttyS3 I can access one motor. So I used
the boot parameter 8250.nr_uarts=6 to try and see if that changes anything,
and it does: I've got /dev/ttyS{4,5} now. However, the I/O ports are messed
up.

A quick look in the BIOS revealed that serial port 5 lives at I/O 0x4e8 and
port 6 at 0x4f8. 

However, dmesg shows these ports in reverse:
-----snip-----
[    1.015356] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.015479] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.015619] serial8250: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
[    1.015729] serial8250: ttyS3 at I/O 0x2e8 (irq = 3) is a 16550A
[    1.016355] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    1.016584] 00:10: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.016763] 00:11: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
[    1.016937] 00:12: ttyS3 at I/O 0x2e8 (irq = 4) is a 16550A
[    1.017113] 00:13: ttyS4 at I/O 0x4f8 (irq = 5) is a 16550A 
[    1.017289] 00:14: ttyS5 at I/O 0x4e8 (irq = 9) is a 16550A
-----snip-----

So I made sure I did not oversee anything; but I did not. Every time I
change this in the BIOS, it shows up in reverse in dmesg; I cannot use
setserial to change it, either. I should mention that the IRQs are set
correctly and I've tried changing them (with one eye on the Serial-HOWTO),
and these changes get accepted.

Now the above only shows the first four as output from serial8250, and then
lists them again, this time all 6 of them.

What can I do? Is there a way to move /dev/ttyS{0-2} to wherever my motor
controllers are? Do I recompile the kernel with some option enabled or
changed? To I have to rewire the LPC port? Is support for the Intel 82801 DB
LPC broken?

Thanks for any help on this.

Stephan
-- 
View this message in context: http://old.nabble.com/Intel-82801-DB-LPC---6-serial-ports%2C-only-1-works-tp27570741p27570741.html
Sent from the linux-serial mailing list archive at Nabble.com.

