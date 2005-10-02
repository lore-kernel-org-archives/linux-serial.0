From: Anders Lennartsson <anders.lennartsson@foi.se>
Subject: problems with exar-17158 based 8-port card
Date: Sun, 2 Oct 2005 23:01:07 +0200
Message-ID: <20051002210107.GB13998@lie.foi.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from custos.foi.se ([150.227.16.253]:26749 "EHLO mercur-smtp.foi.se")
	by vger.kernel.org with ESMTP id S932069AbVJBVBZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Oct 2005 17:01:25 -0400
Received: from mercur.foi.se (localhost [127.0.0.1])
	by mercur-smtp.foi.se (8.12.9/8.12.9) with ESMTP id j92L18bO008662
	for <linux-serial@vger.kernel.org>; Sun, 2 Oct 2005 23:01:08 +0200 (CEST)
Received: from mercur.foi.se (localhost [127.0.0.1])
	by localhost.foi.se (Postfix) with ESMTP id D50C6B8
	for <linux-serial@vger.kernel.org>; Sun,  2 Oct 2005 23:01:08 +0200 (CEST)
Received: from mythos.foi.se (mythos [150.227.60.30])
	by mercur.foi.se (Postfix) with ESMTP id BA559B6
	for <linux-serial@vger.kernel.org>; Sun,  2 Oct 2005 23:01:08 +0200 (CEST)
Received: from lie.foi.se (lie.foi.se [150.227.178.10])
	by mythos.foi.se (8.12.9/8.12.9) with ESMTP id j92L17AZ009615
	for <linux-serial@vger.kernel.org>; Sun, 2 Oct 2005 23:01:08 +0200 (CEST)
Received: from abel by lie.foi.se with local (Exim 4.50)
	id 1EMAxH-0003eE-O5
	for linux-serial@vger.kernel.org; Sun, 02 Oct 2005 23:01:07 +0200
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I'm trying to get a 8-port serial card based on Exar XR17C158
working. It's a PC104 card [1], mounted on a Pentium based PC104
computer [2], which is running Debian Sarge from a 20GiB 1.8" HD. The
kernel is however upgraded to a kernel compiled by myself from
linux-sources-2.6.12, in order to include the drivers for the Exar
chip.  Information about the devices on the PCI-bus is found in [3].

Based on information logged in dmesg [4], the card is in fact
recognized by the kernel at boot and MMIO addresses seem to be
set. After boot completes the use of setserial to display information
about the ports displays that the MMIO addresses are incorrectly
reported [5]. In [6] is a shell script to fix that.

However, I fail to get the ports working after applying these changes
by setserial. I have tried all ports with a cable and minicom settings
that is verified to work between each of the standard serial ports
/dev/(ttyS0 | ttyS1) on this particular computer, to the serial port
on a desktop box.

Any tips?

Anders Lennartsson



[1] http://www.digitallogic.com/english/products/datasheets/pc104_peripherials_detail.asp?id=MSMX104-Plus

[2] http://www.digitallogic.com/english/products/datasheets/ms_pc104_detail.asp?id=MSMP5SEV

[3] Information from lspci:

0000:00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:0a.0 Serial controller: Exar Corp. XR17C158 Octal UART (rev 07)
0000:00:0b.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
0000:00:0b.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
0000:00:12.0 Ethernet controller: Intel Corp. 82559ER (rev 10)
0000:00:14.0 VGA compatible controller: Chips and Technologies F69000 HiQVideo (rev 64)

[4] Snip from dmesg:

Serial: 8250/16550 driver $Revision: 1.90 $ 56 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: setting IRQ 5 as level-triggered
PCI: Assigned IRQ 5 for device 0000:00:0a.0
ttyS14 at MMIO 0xfc420000 (irq = 5) is a 16550A
ttyS15 at MMIO 0xfc420200 (irq = 5) is a 16550A
ttyS44 at MMIO 0xfc420400 (irq = 5) is a 16550A
ttyS45 at MMIO 0xfc420600 (irq = 5) is a 16550A
ttyS46 at MMIO 0xfc420800 (irq = 5) is a 16550A
ttyS47 at MMIO 0xfc420a00 (irq = 5) is a 16550A
ttyS48 at MMIO 0xfc420c00 (irq = 5) is a 16550A
ttyS49 at MMIO 0xfc420e00 (irq = 5) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered

[5] output from: setserial /dev/ttyS*

/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
/dev/ttyS10, UART: unknown, Port: 0x02b0, IRQ: 5, Flags: Fourport
/dev/ttyS11, UART: unknown, Port: 0x02b8, IRQ: 5, Flags: Fourport
/dev/ttyS12, UART: unknown, Port: 0x0330, IRQ: 4
/dev/ttyS14, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS15, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS2, UART: unknown, Port: 0x03e8, IRQ: 4
/dev/ttyS3, UART: unknown, Port: 0x02e8, IRQ: 3
/dev/ttyS4, UART: unknown, Port: 0x01a0, IRQ: 2, Flags: Fourport
/dev/ttyS44, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS45, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS46, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS47, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS48, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS49, UART: 16550A, Port: 0x0000, IRQ: 5
/dev/ttyS5, UART: unknown, Port: 0x01a8, IRQ: 2, Flags: Fourport
/dev/ttyS6, UART: unknown, Port: 0x01b0, IRQ: 2, Flags: Fourport
/dev/ttyS7, UART: unknown, Port: 0x01b8, IRQ: 2, Flags: Fourport
/dev/ttyS8, UART: unknown, Port: 0x02a0, IRQ: 5, Flags: Fourport
/dev/ttyS9, UART: unknown, Port: 0x02a8, IRQ: 5, Flags: Fourport

[6] setting MMIO for applications:

#!/bin/sh
setserial /dev/ttyS14 uart 16550A port 0xfc420000 irq 5
setserial /dev/ttyS15 uart 16550A port 0xfc420200 irq 5
setserial /dev/ttyS44 uart 16550A port 0xfc420400 irq 5
setserial /dev/ttyS45 uart 16550A port 0xfc420600 irq 5
setserial /dev/ttyS46 uart 16550A port 0xfc420800 irq 5
setserial /dev/ttyS47 uart 16550A port 0xfc420a00 irq 5
setserial /dev/ttyS48 uart 16550A port 0xfc420c00 irq 5
setserial /dev/ttyS49 uart 16550A port 0xfc420e00 irq 5

