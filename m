From: Scott Ashcroft <scott.ashcroft@talk21.com>
Subject: [PATCH] Fix 4 port and add support for 8 port 'Unknown' PCI serial
 port cards
Date: Sun, 03 Mar 2013 21:35:06 +0000
Message-ID: <1362346506.8802.16.camel@bart.intra.qzxyz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nm1-vm1.bt.bullet.mail.ir2.yahoo.com ([212.82.99.116]:31037
	"EHLO nm1-vm1.bt.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753563Ab3CCVky (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 3 Mar 2013 16:40:54 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

I've managed to find an 8 port version of the card 4 port card which was discussed here:

http://marc.info/?l=linux-serial&m=120760744205314&w=2

Looking back at that thread there were two issues in the original patch.

1) The I/O ports for the UARTs are within BAR2 not BAR0. This can been seen in the original post.
2) A serial quirk isn't needed as these cards have no memory in BAR0 which makes pci_plx9050_init just return.

This patch fixes the 4 port support to use BAR2, removes the bogus quirk and adds support for the 8 port card.

$ lspci -vvv -n -s 00:08.0
00:08.0 0780: 10b5:9050 (rev 01)
	Subsystem: 10b5:1588
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 17
	Region 1: I/O ports at ff00 [size=128]
	Region 2: I/O ports at fe00 [size=64]
	Region 3: I/O ports at fd00 [size=8]
	Capabilities: <access denied>
	Kernel driver in use: serial

$ dmesg | grep 0000:00:08.0:
[    0.083320] pci 0000:00:08.0: [10b5:9050] type 0 class 0x000780
[    0.083355] pci 0000:00:08.0: reg 14: [io  0xff00-0xff7f]
[    0.083369] pci 0000:00:08.0: reg 18: [io  0xfe00-0xfe3f]
[    0.083382] pci 0000:00:08.0: reg 1c: [io  0xfd00-0xfd07]
[    0.083460] pci 0000:00:08.0: PME# supported from D0 D3hot
[    1.212867] 0000:00:08.0: ttyS4 at I/O 0xfe00 (irq = 17) is a 16550A
[    1.233073] 0000:00:08.0: ttyS5 at I/O 0xfe08 (irq = 17) is a 16550A
[    1.253270] 0000:00:08.0: ttyS6 at I/O 0xfe10 (irq = 17) is a 16550A
[    1.273468] 0000:00:08.0: ttyS7 at I/O 0xfe18 (irq = 17) is a 16550A
[    1.293666] 0000:00:08.0: ttyS8 at I/O 0xfe20 (irq = 17) is a 16550A
[    1.313863] 0000:00:08.0: ttyS9 at I/O 0xfe28 (irq = 17) is a 16550A
[    1.334061] 0000:00:08.0: ttyS10 at I/O 0xfe30 (irq = 17) is a 16550A
[    1.354258] 0000:00:08.0: ttyS11 at I/O 0xfe38 (irq = 17) is a 16550A

Signed-off-by: Scott Ashcroft <scott.ashcroft@talk21.com>

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 791c5a7..85c6bf9 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1571,6 +1571,7 @@ pci_wch_ch353_setup(struct serial_private *priv,
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
+#define PCI_SUBDEVICE_ID_UNKNOWN_0x1588	0x1588
 
 /*
  * Master list of serial port init/setup/exit quirks.
@@ -1852,15 +1853,6 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_PLX,
-		.device		= PCI_DEVICE_ID_PLX_9050,
-		.subvendor	= PCI_VENDOR_ID_PLX,
-		.subdevice	= PCI_SUBDEVICE_ID_UNKNOWN_0x1584,
-		.init		= pci_plx9050_init,
-		.setup		= pci_default_setup,
-		.exit		= pci_plx9050_exit,
-	},
-	{
-		.vendor		= PCI_VENDOR_ID_PLX,
 		.device		= PCI_DEVICE_ID_PLX_ROMULUS,
 		.subvendor	= PCI_VENDOR_ID_PLX,
 		.subdevice	= PCI_DEVICE_ID_PLX_ROMULUS,
@@ -3733,7 +3725,12 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_VENDOR_ID_PLX,
 		PCI_SUBDEVICE_ID_UNKNOWN_0x1584, 0, 0,
-		pbn_b0_4_115200 },
+		pbn_b2_4_115200 },
+	/* Unknown card - subdevice 0x1588 */
+	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+		PCI_VENDOR_ID_PLX,
+		PCI_SUBDEVICE_ID_UNKNOWN_0x1588, 0, 0,
+		pbn_b2_8_115200 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_KEYSPAN,
 		PCI_SUBDEVICE_ID_KEYSPAN_SX2, 0, 0,




