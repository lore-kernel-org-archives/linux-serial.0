From: Jim Treadway <jim@stardot-tech.com>
Subject: [PATCH 2.4] Add support for Lava Octopus serial card
Date: Thu, 17 Oct 2002 14:47:26 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0210171443360.10886-100000@cerberus.stardot-tech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ed Vance <serial24@macrolink.com>, linux-serial@vger.kernel.org


The following patch (against BK-2.4) adds support for the Lava Octopus-550
PCI multiport serial card.  The necessary PCI device IDs have already been
added to pci_ids.h.

 char/serial.c |    8 ++++++++
 pci/pci.ids   |    2 ++
 2 files changed, 10 insertions

		Jim
--
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.794   -> 1.795  
#	 drivers/pci/pci.ids	1.30    -> 1.31   
#	drivers/char/serial.c	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/17	jim@stardot-tech.com	1.795
# Add support for Lava Octopus-550 PCI multiport serial card
# --------------------------------------------
#
diff -Nru a/drivers/char/serial.c b/drivers/char/serial.c
--- a/drivers/char/serial.c	Thu Oct 17 14:47:40 2002
+++ b/drivers/char/serial.c	Thu Oct 17 14:47:40 2002
@@ -4308,6 +4308,7 @@
 	pbn_b0_bt_2_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_4_460800,
 	pbn_b0_bt_2_921600,
 
 	pbn_b1_1_115200,
@@ -4389,6 +4390,7 @@
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 460800 }, /* pbn_b0_bt_4_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b0_bt_2_921600 */
 
 	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
@@ -4854,6 +4856,12 @@
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_1_115200 },
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Thu Oct 17 14:47:40 2002
+++ b/drivers/pci/pci.ids	Thu Oct 17 14:47:40 2002
@@ -4725,6 +4725,8 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
+	0180  Lava Octo A
+	0181  Lava Octo B
 	0200  Lava Port Plus
 	0201  Lava Quad A
 	0202  Lava Quad B

