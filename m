From: Jim Treadway <jim@stardot-tech.com>
Subject: [PATCH] 2.5.40 - Add support for Lava Octopus serial card
Date: Wed, 2 Oct 2002 16:17:42 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0210021616180.30370-100000@cerberus.stardot-tech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: torvalds@transmeta.com
Cc: linux-serial@vger.kernel.org


The following patch adds support for the Lava Octopus-550 PCI multiport
serial card.  The necessary PCI device IDs have already been added to
pci_ids.h.

 drivers/pci/pci.ids       |    2 ++
 drivers/serial/8250_pci.c |    8 ++++++++
 2 files changed, 10 insertions

--
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.674   -> 1.675  
#	 drivers/pci/pci.ids	1.34    -> 1.35   
#	drivers/serial/8250_pci.c	1.8     -> 1.9    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/02	jim@stardot-tech.com	1.675
# Add support for Lava Octopus-550 PCI multiport serial card
# --------------------------------------------
#
diff -Nru a/drivers/pci/pci.ids b/drivers/pci/pci.ids
--- a/drivers/pci/pci.ids	Wed Oct  2 15:32:32 2002
+++ b/drivers/pci/pci.ids	Wed Oct  2 15:32:32 2002
@@ -4719,6 +4719,8 @@
 	0100  Lava Dual Serial
 	0101  Lava Quatro A
 	0102  Lava Quatro B
+	0180  Lava Octo A
+	0181  Lava Octo B
 	0200  Lava Port Plus
 	0201  Lava Quad A
 	0202  Lava Quad B
diff -Nru a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
--- a/drivers/serial/8250_pci.c	Wed Oct  2 15:32:32 2002
+++ b/drivers/serial/8250_pci.c	Wed Oct  2 15:32:32 2002
@@ -467,6 +467,7 @@
 	pbn_b0_bt_8_115200,
 	pbn_b0_bt_1_460800,
 	pbn_b0_bt_2_460800,
+	pbn_b0_bt_4_460800,
 
 	pbn_b1_1_115200,
 	pbn_b1_2_115200,
@@ -547,6 +548,7 @@
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 8, 115200 }, /* pbn_b0_bt_8_115200 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
 	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 460800 }, /* pbn_b0_bt_4_460800 */
 
 	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
 	{ SPCI_FL_BASE1, 2, 115200 },		/* pbn_b1_2_115200 */
@@ -1096,6 +1098,12 @@
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_115200 },
+	{       PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
+	{       PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_OCTO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_4_460800 },
 	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_460800 },

