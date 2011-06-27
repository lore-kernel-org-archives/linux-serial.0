From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/7] serial/8250: I/O accessor cleanups
Date: Mon, 27 Jun 2011 23:45:13 +0200
Message-ID: <1309211120-2803-1-git-send-email-arnd@arndb.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63375 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab1F0VqP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Jun 2011 17:46:15 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-serial@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hi Greg,

This series of patches cleans up the part of the 8250 device
driver that is responsible for accessing the hardware registers.
The driver defines all sorts of methods to do that right now,
when it really should only support memory mapped and programmed
I/O by default, and the latter only on PC-compatible platforms
including those that have ISA/PCMCIA/PCI buses.

The series shrinks the 8250 driver by about 10% in both binary
and source code size, hopefully with no loss of functionality,
and it allows platforms to no longer define bogus inb/outb
functions when they don't provide CONFIG_HAS_IOPORT. I've
build-tested for x86 and ARM with and without HAS_IOPORT.

Hopefully Ralf can provide some feedback about the three
MIPS platforms that have code changed by this.

	Arnd

Arnd Bergmann (7):
  serial/8250: remove obsolete RM9000 port type
  serial/8250: move alchemy I/O handler to platform code
  serial/8250: move UPIO_TSI to powerpc
  serial/8250: move DWAP support to arch/mips
  serial/8250: remove obsolete and broken PORT_RSA support
  serial/8250: sanitize fourport handling
  serial/8250: make PIO support optional

 arch/mips/Kconfig                         |    7 -
 arch/mips/alchemy/common/platform.c       |   50 +++
 arch/mips/pmc-sierra/msp71xx/msp_serial.c |   32 ++-
 arch/powerpc/kernel/legacy_serial.c       |   24 ++
 drivers/tty/serial/8250.c                 |  472 +++--------------------------
 drivers/tty/serial/8250.h                 |    8 +
 drivers/tty/serial/8250_hub6.c            |   17 +
 drivers/tty/serial/Kconfig                |   15 -
 drivers/tty/serial/serial_core.c          |    4 -
 drivers/tty/serial/sunsu.c                |   93 ------
 include/linux/serial.h                    |    2 +-
 include/linux/serial_core.h               |   10 +-
 include/linux/serial_reg.h                |   51 ---
 13 files changed, 171 insertions(+), 614 deletions(-)

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-serial@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

-- 
1.7.5.4

