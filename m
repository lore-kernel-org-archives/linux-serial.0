From: mreed@linux.vnet.ibm.com
Subject: [PATCH] 8250_pci Add EEH support to the 8250 driver for IBM/Digi PCIe 2-port Adapter
Date: Wed, 25 May 2011 12:07:50 -0500
Message-ID: <1306343270-5138-1-git-send-email-mreed@linux.vnet.ibm.com>
References: <1305831823-25400-2-git-send-email-mreed@linux.vnet.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:44791 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab1EYRIZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 May 2011 13:08:25 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4PGtmJZ011681
	for <linux-serial@vger.kernel.org>; Wed, 25 May 2011 10:55:48 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p4PH9iX8175026
	for <linux-serial@vger.kernel.org>; Wed, 25 May 2011 11:09:44 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p4PB8Jl5007795
	for <linux-serial@vger.kernel.org>; Wed, 25 May 2011 05:08:20 -0600
In-Reply-To: <1305831823-25400-2-git-send-email-mreed@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Michael Reed <mreed@linux.vnet.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>, Breno Leitao <leitao@linux.vnet.ibm.com>, Scott Kilau <scottk@digi.com>

From: Michael Reed <mreed@linux.vnet.ibm.com>

The purpose of the patch is to add EEH support to the 8250_PCI driver
for the IBM/Digi PCIE 2port Async EIA-232 Adapter that uses a PLX
chipset on the PPC platforrm.  Basic support for this adapter was
recently added https://lkml.org/lkml/2011/5/11/341

This patch was created against the linux-next kernel

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Breno Leitao <leitao@linux.vnet.ibm.com>
Cc: Scott Kilau <scottk@digi.com>
Signed-off-by: Michael Reed <mreed@linux.vnet.ibm.com>
---
 drivers/tty/serial/8250_pci.c |   47 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 4b4968a..5b328e4 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -2595,6 +2595,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 	board = &pci_boards[ent->driver_data];
 
 	rc = pci_enable_device(dev);
+	pci_save_state(dev);
 	if (rc)
 		return rc;
 
@@ -3868,6 +3869,51 @@ static struct pci_device_id serial_pci_tbl[] = {
 	{ 0, }
 };
 
+static pci_ers_result_t serial8250_io_error_detected(struct pci_dev *dev,
+						pci_channel_state_t state)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (priv)
+		pciserial_suspend_ports(priv);
+
+	pci_disable_device(dev);
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t serial8250_io_slot_reset(struct pci_dev *dev)
+{
+	int rc;
+
+	rc = pci_enable_device(dev);
+
+	if (rc)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	pci_restore_state(dev);
+	pci_save_state(dev);
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void serial8250_io_resume(struct pci_dev *dev)
+{
+	struct serial_private *priv = pci_get_drvdata(dev);
+
+	if (priv)
+		pciserial_resume_ports(priv);
+}
+
+static struct pci_error_handlers serial8250_err_handler = {
+	.error_detected = serial8250_io_error_detected,
+	.slot_reset = serial8250_io_slot_reset,
+	.resume = serial8250_io_resume,
+};
+
 static struct pci_driver serial_pci_driver = {
 	.name		= "serial",
 	.probe		= pciserial_init_one,
@@ -3877,6 +3923,7 @@ static struct pci_driver serial_pci_driver = {
 	.resume		= pciserial_resume_one,
 #endif
 	.id_table	= serial_pci_tbl,
+	.err_handler	= &serial8250_err_handler,
 };
 
 static int __init serial8250_pci_init(void)
-- 
1.7.1

