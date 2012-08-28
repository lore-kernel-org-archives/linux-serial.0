From: gianluca <gianluca@sottospazio.it>
Subject: unrecognized multi io pci card
Date: Tue, 28 Aug 2012 14:24:58 +0200
Message-ID: <20120828122458.GB1258@server>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:34249 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab2H1Mal (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Aug 2012 08:30:41 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I recently bought a pci card with two serial ports and one parallel port
since my machine didn't have any, but the card isn't autodetected by linux.

Here follows a lspci -vvvxxx of the device

5:01.0 Serial controller: Device 4348:7053 (rev 10) (prog-if 02 [16550])
       Subsystem: Device 4348:3253
       Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
       Stepping- SERR- FastB2B- DisINTx-
       Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
       <TAbort- <MAbort- >SERR- <PERR- INTx-
       Interrupt: pin A routed to IRQ 17
       Region 0: I/O ports at ec00 [size=8]
       Region 1: I/O ports at e880 [size=8]
       Region 2: I/O ports at e800 [size=8]
       Region 3: I/O ports at e480 [size=16]
       Kernel driver in use: parport_serial
00: 48 43 53 70 01 00 00 02 10 02 00 07 00 00 00 00
10: 01 ec 00 00 81 e8 00 00 01 e8 00 00 81 e4 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 48 43 53 32
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

I tried to patch parport_serial.c which, as I understand, is suited to provide
all the parallel and serial ports to userspace. That driver is unmantained
unfortunately but since the card is also a serial card I'm writing to you and
this list to get feedback on what I've done.

After adding the IDs and descriptions I found unfortunately that the module
8250_pci reclaims the pci device as a serial card only and this prevents the
successful registration of the parport_serial driver (which also depends on
8250_pci).

So I blacklisted the card in 8250_pci.c using the sofmodem blacklist mechanism
already in place. I know this isn't really the right place to do it but it
works and I didn't find another way.

Eventually the parallel and the serial ports are detected but only the parallel
port works because the serial ports are wrongly recognized as XScale when they
are actually 16550 clones: if I set the port type by hand with setserial they work.

So I changed the autoconfig function in 8250.c this way: checks also the RTOIE
bit in IER to detect the port as XSCALE. I don't think this is really correct
but I've no knowledge on XSCALE or my serial card hardware to do it better.

After this last change the ports are detected and work flawlessly.

In attachment you'll find all the patches.

Thank you.

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="parport-serial.patch"

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e9c3227..a8d65a2 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -62,6 +62,7 @@ enum parport_pc_pci_cards {
 	timedia_9079a,
 	timedia_9079b,
 	timedia_9079c,
+	wch_ch353_2s1p,
 };
 
 /* each element directly indexed from enum list, above */
@@ -145,6 +146,7 @@ static struct parport_pc_pci cards[] __devinitdata = {
 	/* timedia_9079a */             { 1, { { 2, 3 }, } },
 	/* timedia_9079b */             { 1, { { 2, 3 }, } },
 	/* timedia_9079c */             { 1, { { 2, 3 }, } },
+	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -243,7 +245,7 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x1409, 0x7168, 0x1409, 0xb079, 0, 0, timedia_9079a },
 	{ 0x1409, 0x7168, 0x1409, 0xc079, 0, 0, timedia_9079b },
 	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
-
+	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -460,6 +462,12 @@ static struct pciserial_board pci_parport_serial_boards[] __devinitdata = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
+	[wch_ch353_2s1p] = {
+		.flags          = FL_BASE0|FL_BASE_BARS,
+		.num_ports      = 2,
+		.base_baud      = 115200,
+		.uart_offset    = 8,
+	},
 };
 
 struct parport_serial_private {
diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e9c3227..a8d65a2 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -62,6 +62,7 @@ enum parport_pc_pci_cards {
 	timedia_9079a,
 	timedia_9079b,
 	timedia_9079c,
+	wch_ch353_2s1p,
 };
 
 /* each element directly indexed from enum list, above */
@@ -145,6 +146,7 @@ static struct parport_pc_pci cards[] __devinitdata = {
 	/* timedia_9079a */             { 1, { { 2, 3 }, } },
 	/* timedia_9079b */             { 1, { { 2, 3 }, } },
 	/* timedia_9079c */             { 1, { { 2, 3 }, } },
+	/* wch_ch353_2s1p*/             { 1, { { 2, -1}, } },
 };
 
 static struct pci_device_id parport_serial_pci_tbl[] = {
@@ -243,7 +245,7 @@ static struct pci_device_id parport_serial_pci_tbl[] = {
 	{ 0x1409, 0x7168, 0x1409, 0xb079, 0, 0, timedia_9079a },
 	{ 0x1409, 0x7168, 0x1409, 0xc079, 0, 0, timedia_9079b },
 	{ 0x1409, 0x7168, 0x1409, 0xd079, 0, 0, timedia_9079c },
-
+	{ 0x4348, 0x7053, 0x4348, 0x3253, 0, 0, wch_ch353_2s1p},
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
@@ -460,6 +462,12 @@ static struct pciserial_board pci_parport_serial_boards[] __devinitdata = {
 		.base_baud	= 921600,
 		.uart_offset	= 8,
 	},
+	[wch_ch353_2s1p] = {
+		.flags          = FL_BASE0|FL_BASE_BARS,
+		.num_ports      = 2,
+		.base_baud      = 115200,
+		.uart_offset    = 8,
+	},
 };
 
 struct parport_serial_private {

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8250-pci.patch"

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 28e7c7c..61aadfc 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2628,6 +2628,7 @@ static const struct pci_device_id softmodem_blacklist[] = {
 	{ PCI_VDEVICE(AL, 0x5457), }, /* ALi Corporation M5457 AC'97 Modem */
 	{ PCI_VDEVICE(MOTOROLA, 0x3052), }, /* Motorola Si3052-based modem */
 	{ PCI_DEVICE(0x1543, 0x3052), }, /* Si3052-based modem, default IDs */
+	{ PCI_DEVICE(0x4348, 0x7053), }, /* wch ch353 2S1P */
 };
 
 /*

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="8250.patch"

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 6e1958a..9693d5a 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -980,14 +980,17 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		 */
 		serial_out(up, UART_IER, iersave | UART_IER_UUE);
 		if (serial_in(up, UART_IER) & UART_IER_UUE) {
-			/*
-			 * It's an Xscale.
-			 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
-			 */
-			DEBUG_AUTOCONF("Xscale ");
-			up->port.type = PORT_XSCALE;
-			up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
-			return;
+			serial_out(up, UART_IER, iersave | UART_IER_RTOIE);
+			if (serial_in(up, UART_IER) & UART_IER_RTOIE) {
+				/*
+				 * It's an Xscale.
+				 * We'll leave the UART_IER_UUE bit set to 1 (enabled).
+				 */
+				DEBUG_AUTOCONF("Xscale ");
+				up->port.type = PORT_XSCALE;
+				up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
+				return;
+			}
 		}
 	} else {
 		/*

--ikeVEW9yuYc//A+q--
