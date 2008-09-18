From: "Niels de Vos" <niels.devos@wincor-nixdorf.com>
Subject: [PATCH] serial: set correct baud_base for Oxford Semiconductor Ltd EXSYS EX-41092 Dual 16950 Serial adapter
Date: Thu, 18 Sep 2008 14:31:14 +0200
Message-ID: <1b51b6f80809180531nd8c699lb38dc73d2d7edc7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:50432 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbYIRMbS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Sep 2008 08:31:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3695471rvb.1
        for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2008 05:31:14 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This card is only useable with other devices (not the same card) after doing
a setserial /dev/ttyS<n> baud_base 115200. This baud_base should
be default for this card.

This card was the last/only user of pbn_b0_2_1130000, therefore removed.

Signed-off-by: Niels de Vos <niels.devos@wincor-nixdorf.com>

diff --git a/drivers/serial/8250_pci.c b/drivers/serial/8250_pci.c
index c2f2393..f092cf9 100644
--- a/drivers/serial/8250_pci.c
+++ b/drivers/serial/8250_pci.c
@@ -1089,8 +1089,6 @@ enum pci_board_num_t {
 	pbn_b0_2_921600,
 	pbn_b0_4_921600,

-	pbn_b0_2_1130000,
-
 	pbn_b0_4_1152000,

 	pbn_b0_2_1843200,
@@ -1245,13 +1243,6 @@ static struct pciserial_board pci_boards[]
__devinitdata = {
 		.uart_offset	= 8,
 	},

-	[pbn_b0_2_1130000] = {
-		.flags          = FL_BASE0,
-		.num_ports      = 2,
-		.base_baud      = 1130000,
-		.uart_offset    = 8,
-	},
-
 	[pbn_b0_4_1152000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
@@ -2292,7 +2283,7 @@ static struct pci_device_id serial_pci_tbl[] = {
 		 */
 	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_2_1130000 },
+		pbn_b0_2_115200 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_4_115200 },
