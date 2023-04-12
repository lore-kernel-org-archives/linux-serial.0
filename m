Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4A4C7619A
	for <linux-serial@archiver.kernel.org>; Wed, 12 Apr 2023 06:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLGDA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Apr 2023 02:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjDLGC5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Apr 2023 02:02:57 -0400
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 23:02:54 PDT
Received: from mail.iszf.irk.ru (mx.iszf.irk.ru [84.237.20.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DEF955A6
        for <linux-serial@vger.kernel.org>; Tue, 11 Apr 2023 23:02:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.0.6.6])
        by mail.iszf.irk.ru (Postfix) with ESMTP id 8FC4D65DEC;
        Wed, 12 Apr 2023 13:56:31 +0800 (IRKT)
From:   tomin@iszf.irk.ru
To:     linux-serial@vger.kernel.org
Cc:     Vitaliy Tomin <tomin@iszf.irk.ru>
Subject: [PATCH] serial: Add support for Advantech PCI-1611U card
Date:   Wed, 12 Apr 2023 13:56:22 +0800
Message-Id: <20230412055622.3787514-1-tomin@iszf.irk.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vitaliy Tomin <tomin@iszf.irk.ru>

Add support for Advantech PCI-1611U card

Advantech provides opensource drivers for this and many others card
based on legacy copy of 8250_pci driver called adv950

https://www.advantech.com/emt/support/details/driver?id=1-TDOIMJ

It is hard to maintain to run as out of tree module on newer kernels.
Just adding PCI ID to kernel 8250_pci works perfect.
---
 drivers/tty/serial/8250/8250_pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index c55be6fda0ca..e80c4f6551a1 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1920,6 +1920,8 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCI_SUBDEVICE_ID_SIIG_DUAL_30	0x2530
 #define PCI_VENDOR_ID_ADVANTECH		0x13fe
 #define PCI_DEVICE_ID_INTEL_CE4100_UART 0x2e66
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600	0x1600
+#define PCI_DEVICE_ID_ADVANTECH_PCI1600_1611	0x1611
 #define PCI_DEVICE_ID_ADVANTECH_PCI3620	0x3620
 #define PCI_DEVICE_ID_ADVANTECH_PCI3618	0x3618
 #define PCI_DEVICE_ID_ADVANTECH_PCIf618	0xf618
@@ -4085,6 +4087,9 @@ static SIMPLE_DEV_PM_OPS(pciserial_pm_ops, pciserial_suspend_one,
 			 pciserial_resume_one);
 
 static const struct pci_device_id serial_pci_tbl[] = {
+	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI1600,
+		PCI_DEVICE_ID_ADVANTECH_PCI1600_1611, PCI_ANY_ID, 0, 0,
+		pbn_b0_4_921600 },
 	/* Advantech use PCI_DEVICE_ID_ADVANTECH_PCI3620 (0x3620) as 'PCI_SUBVENDOR_ID' */
 	{	PCI_VENDOR_ID_ADVANTECH, PCI_DEVICE_ID_ADVANTECH_PCI3620,
 		PCI_DEVICE_ID_ADVANTECH_PCI3620, 0x0001, 0, 0,
-- 
2.34.1

