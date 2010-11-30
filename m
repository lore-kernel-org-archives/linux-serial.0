From: folkert <folkert@vanheusden.com>
Subject: 2.6.25 upgraded to 2.6.36: serial app stops working
Date: Tue, 30 Nov 2010 17:27:55 +0100
Message-ID: <20101130162754.GI5654@belle.intranet.vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from keetweej.vanheusden.com ([83.163.219.98]:42740 "EHLO
	keetweej.vanheusden.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab0K3Qep (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 30 Nov 2010 11:34:45 -0500
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com [192.168.64.100])
	by keetweej.vanheusden.com (Postfix) with ESMTP id B7CFC8142
	for <linux-serial@vger.kernel.org>; Tue, 30 Nov 2010 17:27:55 +0100 (CET)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I upgraded my linux system to 2.6.36. Now suddenly my serial driver for
my MSF receiver stopped working. Two things I noticed: I need to open
the serial device (/dev/ttyS0, a regular uart, see below) with O_NDELAY
for open() to return at all. Then something funny happens: I read bytes
from the device (at 50bps) which runs fine for a while but then suddenly
I get a burst of '0x00' bytes - precisely at the point at which the MSF
radio device sends a timecode! So I think the device fiddles with one of
the pins of the serial port confusing the linux serial driver. This
worked fine upto and including 2.6.25 (maybe later too) but with 2.6.36
this fails.
Anyone an idea what might go wrong here? And how to fix it?
The sourcecode of my driver can be found here:
http://vanheusden.com/lpc-ntpd/lindy_precision_clock.php

[    0.826110] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    2.596509] 0000:04:06.0: ttyS0 at I/O 0xbf00 (irq = 20) is a 16550A
[    2.617685] 0000:04:06.0: ttyS1 at I/O 0xbe00 (irq = 20) is a 16550A

weerstationserver:/usr/local/src/lpc-ntpd-1.0.1.hacked# setserial -a -g /dev/ttyS0
/dev/ttyS0, Line 0, UART: 16550A, Port: 0xbf00, IRQ: 20
        Baud_base: 115200, close_delay: 50, divisor: 0
        closing_wait: 3000
        Flags: spd_normal skip_test


Folkert van Heusden

-- 
Nagios user? Check out CoffeeSaint - the versatile Nagios status
viewer! http://www.vanheusden.com/java/CoffeeSaint/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
