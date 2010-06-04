From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH v2] serial: add support for various Titan PCI cards
Date: Fri, 04 Jun 2010 09:58:18 +0200
Message-ID: <4C08B21A.4030002@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:35725 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0FDH60 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Jun 2010 03:58:26 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: greg@kroah.com

serial: add support for various Titan PCI cards

Models: 200I, 400I, 800I, 400EH, 800EH, 800EHB,
        100E, 200E, 400E, 800E, 200EI, 200EISI

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/drivers/serial/8250_pci.c
===================================================================
--- a/drivers/serial/8250_pci.c	2010-06-03 16:04:45.000000000 +0200
+++ b/drivers/serial/8250_pci.c	2010-06-04 09:03:28.000000000 +0200
@@ -982,6 +982,18 @@
 #define PCI_SUBDEVICE_ID_POCTAL422	0x0408
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
+#define PCI_DEVICE_ID_TITAN_200I	0x8028
+#define PCI_DEVICE_ID_TITAN_400I	0x8048
+#define PCI_DEVICE_ID_TITAN_800I	0x8088
+#define PCI_DEVICE_ID_TITAN_800EH	0xA007
+#define PCI_DEVICE_ID_TITAN_800EHB	0xA008
+#define PCI_DEVICE_ID_TITAN_400EH	0xA009
+#define PCI_DEVICE_ID_TITAN_100E	0xA010
+#define PCI_DEVICE_ID_TITAN_200E	0xA012
+#define PCI_DEVICE_ID_TITAN_400E	0xA013
+#define PCI_DEVICE_ID_TITAN_800E	0xA014
+#define PCI_DEVICE_ID_TITAN_200EI	0xA016
+#define PCI_DEVICE_ID_TITAN_200EISI	0xA017
 
 /* Unknown vendors/cards - this should not be in linux/pci_ids.h */
 #define PCI_SUBDEVICE_ID_UNKNOWN_0x1584	0x1584
@@ -1541,6 +1553,10 @@
 	pbn_b3_4_115200,
 	pbn_b3_8_115200,
 
+	pbn_b4_bt_2_921600,
+	pbn_b4_bt_4_921600,
+	pbn_b4_bt_8_921600,
+
 	/*
 	 * Board-specific versions.
 	 */
@@ -1995,6 +2011,25 @@
 		.uart_offset	= 8,
 	},
 
+	[pbn_b4_bt_2_921600] = {
+		.flags		= FL_BASE4,
+		.num_ports	= 2,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b4_bt_4_921600] = {
+		.flags		= FL_BASE4,
+		.num_ports	= 4,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+	[pbn_b4_bt_8_921600] = {
+		.flags		= FL_BASE4,
+		.num_ports	= 8,
+		.base_baud	= 921600,
+		.uart_offset	= 8,
+	},
+
 	/*
 	 * Entries following this are board-specific.
 	 */
@@ -3043,6 +3078,42 @@
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800L,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_8_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200I,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b4_bt_2_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400I,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b4_bt_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800I,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b4_bt_8_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400EH,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800EH,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800EHB,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_1_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_4_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800E,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_8_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EI,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_4000000 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EISI,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_oxsemi_2_4000000 },
 
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,

