From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] serial: add support for various Titan PCI cards
Date: Wed, 02 Jun 2010 17:16:30 +0200
Message-ID: <4C0675CE.4090305@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:38980 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959Ab0FBPn5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jun 2010 11:43:57 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de

serial: add support for various Titan PCI cards

Models: 200I, 400I, 800I, 400EH, 800EH, 800EHB,
        100E, 200E, 400E, 800E, 200EI, 200EISI

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/drivers/serial/8250_pci.c
===================================================================
--- a/drivers/serial/8250_pci.c	2010-05-17 17:24:17.000000000 +0200
+++ b/drivers/serial/8250_pci.c	2010-06-02 11:30:45.000000000 +0200
@@ -1541,6 +1541,10 @@
 	pbn_b3_4_115200,
 	pbn_b3_8_115200,
 
+	pbn_b4_bt_2_921600,
+	pbn_b4_bt_4_921600,
+	pbn_b4_bt_8_921600,
+
 	/*
 	 * Board-specific versions.
 	 */
@@ -1995,6 +1999,25 @@
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
@@ -3043,6 +3066,42 @@
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
Index: b/include/linux/pci_ids.h
===================================================================
--- a/include/linux/pci_ids.h	2010-05-27 09:38:42.000000000 +0200
+++ b/include/linux/pci_ids.h	2010-06-02 11:30:45.000000000 +0200
@@ -2021,6 +2021,18 @@
 #define PCI_DEVICE_ID_TITAN_200		0xA005
 #define PCI_DEVICE_ID_TITAN_400		0xA003
 #define PCI_DEVICE_ID_TITAN_800B	0xA004
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
 
 #define PCI_VENDOR_ID_PANACOM		0x14d4
 #define PCI_DEVICE_ID_PANACOM_QUADMODEM	0x0400

