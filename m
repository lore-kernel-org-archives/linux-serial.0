From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] 8250_pci: Remove duplicate struct pciserial_board
Date: Sun, 25 Oct 2009 22:55:07 -0500
Message-ID: <1256529307-32177-1-git-send-email-shawn.bohrer@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754646AbZJZDzv@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shawn Bohrer <shawn.bohrer@gmail.com>
List-Id: linux-serial@vger.kernel.org

pbn_exsys_4055 is the same thing as pbn_b2_4_115200 so replace it with
the standard pattern.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 drivers/serial/8250_pci.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index e7108e7..8087d0a 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1545,7 +1545,6 @@ enum pci_board_num_t {
 	pbn_panacom,
 	pbn_panacom2,
 	pbn_panacom4,
-	pbn_exsys_4055,
 	pbn_plx_romulus,
 	pbn_oxsemi,
 	pbn_oxsemi_1_4000000,
@@ -2011,13 +2010,6 @@ static struct pciserial_board pci_boards[] __devinitdata = {
 		.reg_shift	= 7,
 	},
 
-	[pbn_exsys_4055] = {
-		.flags		= FL_BASE2,
-		.num_ports	= 4,
-		.base_baud	= 115200,
-		.uart_offset	= 8,
-	},
-
 	/* I think this entry is broken - the first_offset looks wrong --rmk */
 	[pbn_plx_romulus] = {
 		.flags		= FL_BASE2,
@@ -2736,7 +2728,7 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_EXSYS,
 		PCI_SUBDEVICE_ID_EXSYS_4055, 0, 0,
-		pbn_exsys_4055 },
+		pbn_b2_4_115200 },
 	/*
 	 * Megawolf Romulus PCI Serial Card, from Mike Hudson
 	 * (Exoray@isys.ca)
-- 
1.6.5
