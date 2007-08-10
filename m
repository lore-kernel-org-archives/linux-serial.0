From: Michael Mauch <michael.mauch@gmx.de>
Subject: Serial ports rearranged in 2.6.22?
Date: Fri, 10 Aug 2007 23:39:25 +0200
Message-ID: <20070810213925.GB10855@elmicha>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46122 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752842AbXHJVj2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2007 17:39:28 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org

Hi,

until 2.6.21, I had the normal assignments for ttyS0 and ttyS1:

00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

With 2.6.22 I get the names <-> ports/irqs the other way around:

00:08: ttyS0 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS1 at I/O 0x3f8 (irq = 4) is a 16550A

Is this supposed to be that way? Should we reassign these names with
udev? udev-114 doesn't seem to have built-in rules to assign the
traditional names.

Or could it be related to some brokeness in my BIOS (ACPI/PNP)? 

I'm using the 8250_pnp module (and it's the same with builtin serial
modules). I made sure that I did not accidentally change the BIOS
settings for the serial ports.

I'm using Gentoo, but on the lirc list was a Fedora user with the same
symptoms.

Regards...
		Michael
