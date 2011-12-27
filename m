From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: serial: add support for 400 and 800 v3 series Titan cards
Date: Tue, 27 Dec 2011 15:47:37 +0100
Message-ID: <4EF9DA89.5030700@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ns.visionsystems.de ([62.145.30.242]:51174 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab1L0PGS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Dec 2011 10:06:18 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de

add support for 400Hv3, 410Hv3 and 800Hv3
 
Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/tty/serial/8250_pci.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: b/drivers/tty/serial/8250_pci.c
===================================================================
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -1152,6 +1152,10 @@
 #define PCI_DEVICE_ID_TITAN_800E	0xA014
 #define PCI_DEVICE_ID_TITAN_200EI	0xA016
 #define PCI_DEVICE_ID_TITAN_200EISI	0xA017
+#define PCI_DEVICE_ID_TITAN_400V3	0xA310
+#define PCI_DEVICE_ID_TITAN_410V3	0xA312
+#define PCI_DEVICE_ID_TITAN_800V3	0xA314
+#define PCI_DEVICE_ID_TITAN_800V3B	0xA315
 #define PCI_DEVICE_ID_OXSEMI_16PCI958	0x9538
 #define PCIE_DEVICE_ID_NEO_2_OX_IBM	0x00F6
 #define PCI_DEVICE_ID_PLX_CRONYX_OMEGA	0xc001
@@ -3443,6 +3447,18 @@
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EISI,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_oxsemi_2_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400V3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_410V3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800V3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800V3B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
 
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,

