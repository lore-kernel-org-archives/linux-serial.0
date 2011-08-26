From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 07/12] 8250_pci: add support for Rosewill RC-305 4x serial port card
Date: Fri, 26 Aug 2011 13:58:16 -0700
Message-ID: <1314392301-25140-7-git-send-email-gregkh@suse.de>
References: <20110826191143.GC5557@kroah.com>
 <1314392301-25140-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37784 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149Ab1HZU66 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 16:58:58 -0400
In-Reply-To: <1314392301-25140-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Eric Smith <eric@brouhaha.com>, stable <stable@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Eric Smith <eric@brouhaha.com>

This patch adds support for the Rosewill RC-305 four-port PCI serial
card, and probably any other four-port serial cards based on the
Moschip MCS9865 chip, assuming that the EEPROM on the card was
programmed in accordance with Table 6 of the MCS9865 EEPROM
Application Note version 0.3 dated 16-May-2008, available from the
Moschip web site (registration required).

This patch is based on an earlier patch [1] for the SYBA 6x serial
port card by Ira W. Snyder.

[1]: http://www.gossamer-threads.com/lists/linux/kernel/1162435

Signed-off-by: Eric Smith <eric@brouhaha.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250_pci.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 6b887d9..f652a7b 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -4021,7 +4021,7 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0, 0, pbn_NETMOS9900_2s_115200 },
 
 	/*
-	 * Best Connectivity PCI Multi I/O cards
+	 * Best Connectivity and Rosewill PCI Multi I/O cards
 	 */
 
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
@@ -4029,6 +4029,10 @@ static struct pci_device_id serial_pci_tbl[] = {
 		0, 0, pbn_b0_1_115200 },
 
 	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
+		0xA000, 0x3002,
+		0, 0, pbn_b0_bt_2_115200 },
+
+	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
 		0xA000, 0x3004,
 		0, 0, pbn_b0_bt_4_115200 },
 	/* Intel CE4100 */
-- 
1.7.6.1

