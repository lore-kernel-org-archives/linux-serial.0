From: Mikhail Kolesnik <mike@openbunker.org>
Subject: Oxford Semiconductor's OXCB950 in 8250_pci.c
Date: Sun, 7 May 2006 22:59:42 +0300
Message-ID: <20060507225942.0b2d7bbf@mike.staff.sky>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from silver.biz.ua ([80.68.246.128]:46306 "EHLO silver.biz.ua")
	by vger.kernel.org with ESMTP id S932221AbWEGT7C (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 May 2006 15:59:02 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk

Hi.

There was a discussion regarding support of OXCB950 in 2.4.x
http://groups.google.com/group/mlist.linux.serial/browse_frm/thread/baf6d48e25662c5/8ab3b1ea12a43420?tvc=1&q=OXCB950#8ab3b1ea12a43420
Somehow changes did not go into the kernel.

Now detailed data sheet is freely available at
http://www.oxsemi.com/oxford/documents/download/standard/dsheets/oxcb950ds.pdf

I own ST Lab RS232 serial port, model C-130. It is a CardBus Type II,
32-bit, 3.3V. After looking into that old discussion I've made the same
changes for 2.6.16 kernel:
diff -ru linux-2.6.16-orig/drivers/serial/8250_pci.c linux-2.6.16/drivers/serial/8250_pci.c
--- linux-2.6.16-orig/drivers/serial/8250_pci.c	2006-03-23 13:32:17.000000000 +0200
+++ linux-2.6.16/drivers/serial/8250_pci.c	2006-03-23 13:39:08.000000000 +0200
@@ -2045,6 +2045,9 @@
 	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_2_1130000 },
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_CB950,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_1_115200 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_4_115200 },
diff -ru linux-2.6.16-orig/include/linux/pci_ids.h linux-2.6.16/include/linux/pci_ids.h
--- linux-2.6.16-orig/include/linux/pci_ids.h	2006-03-23 13:32:24.000000000 +0200
+++ linux-2.6.16/include/linux/pci_ids.h	2006-03-23 13:40:32.000000000 +0200
@@ -1808,6 +1808,7 @@
 #define PCI_VENDOR_ID_OXSEMI		0x1415
 #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
 #define PCI_DEVICE_ID_OXSEMI_16PCI954	0x9501
+#define PCI_DEVICE_ID_OXSEMI_CB950      0x950B /* OXCB950 Cardbus 16950 UART */
 #define PCI_DEVICE_ID_OXSEMI_16PCI95N	0x9511
 #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
 #define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521

Is it enough for such card to work?
(Unfortunately, I do not have enough experience to implement complex
kernel things)

After applying the patch driver recognizes the card:
pccard: CardBus card inserted into slot 0
PCI: Enabling device 0000:07:00.0 (0000 -> 0003)
ACPI: PCI Interrupt 0000:07:00.0[A] -> Link [LNKA] -> GSI 11 (level,low) -> IRQ 11 
ttyS4: detected caps 00000700 should be 00000100
0000:07:00.0: ttyS4 at I/O 0x3010 (irq = 11) is a 16C950/954

The problem is that card only works with baud rates from 50 to 2400.
The card is connected to a common external modem, which is known to
work with any reasonable rates in other PC.

C-Kermit>set line /dev/ttyS4
C-Kermit>set carrier-watch off
C-Kermit>set speed 2400
C-Kermit>connect
works... but setting any higher rate results in non responding modem.
I've also tried connecting the card to devices with fixed serial
parameters: 9600 8N1. No response too.

Using wvdial with ANY Baud from 300 to 2400 results in:
"CONNECT 230400/V34/LAPM/V42B/TX=28800/RX=31200"
On Baud=2400 download speed easily exceeds 2400bps, but Baud=300 and
baud=1200 speed is limited as it should be. Very strange behavior.

That leads to an idea of changing divider...

'User Manual' supplied with the card says that I should use
'Automatic Crystal Detection' in WinME and '1.8432 MHz' in 2K/XP.
Baud rate divider(prescaler) value in both cases should be '8.625'.
It works in XP with suggested settings.
As far as I know setting such things with setserial for CardBus devices
is not a good idea.

Any suggestions?

Relevant lspci entry:
07:00.0 Serial controller: Oxford Semiconductor Ltd OXCB950 Cardbus 16950 UART (prog-if 06 [16950])
	Subsystem: Oxford Semiconductor Ltd Unknown device 0001
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 3010 [size=8]
	Region 1: Memory at 34000000 (32-bit, non-prefetchable) [size=4K]
	Region 2: I/O ports at 3000 [size=16]
	Region 3: Memory at 34001000 (32-bit, non-prefetchable) [size=4K]
	Region 4: Memory at 34002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
Mikhail Kolesnik
ICQ: 260259143
IRC: mike_k at freenode/#crux, rusnet/#yalta
Jabber: mike_k@jabber.lafox.net
NIC handle: MKK83-UANIC
