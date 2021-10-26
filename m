Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E0C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868C260EC0
	for <linux-serial@archiver.kernel.org>; Tue, 26 Oct 2021 13:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhJZNh0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Oct 2021 09:37:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:13406 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhJZNh0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Oct 2021 09:37:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="217074202"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="217074202"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 06:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="446743530"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2021 06:34:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3676C107; Tue, 26 Oct 2021 16:34:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 1/2] serial: 8250_pci: Replace custom pci_match_id() implementation
Date:   Tue, 26 Oct 2021 16:34:51 +0300
Message-Id: <20211026133452.61657-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Replace pci_quatech_amcc() with generic pci_match_id().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: fixed uninitialized boolean variable (lkp)
 drivers/tty/serial/8250/8250_pci.c | 72 +++++++++++++-----------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index aea12263a1ff..1c2eb44e9c33 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1063,13 +1063,6 @@ static int pci_asix_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
-/* Quatech devices have their own extra interface features */
-
-struct quatech_feature {
-	u16 devid;
-	bool amcc;
-};
-
 #define QPCR_TEST_FOR1		0x3F
 #define QPCR_TEST_GET1		0x00
 #define QPCR_TEST_FOR2		0x40
@@ -1085,42 +1078,30 @@ struct quatech_feature {
 #define QOPR_CLOCK_X8		0x0003
 #define QOPR_CLOCK_RATE_MASK	0x0003
 
-
-static struct quatech_feature quatech_cards[] = {
-	{ PCI_DEVICE_ID_QUATECH_QSC100,   1 },
-	{ PCI_DEVICE_ID_QUATECH_DSC100,   1 },
-	{ PCI_DEVICE_ID_QUATECH_DSC100E,  0 },
-	{ PCI_DEVICE_ID_QUATECH_DSC200,   1 },
-	{ PCI_DEVICE_ID_QUATECH_DSC200E,  0 },
-	{ PCI_DEVICE_ID_QUATECH_ESC100D,  1 },
-	{ PCI_DEVICE_ID_QUATECH_ESC100M,  1 },
-	{ PCI_DEVICE_ID_QUATECH_QSCP100,  1 },
-	{ PCI_DEVICE_ID_QUATECH_DSCP100,  1 },
-	{ PCI_DEVICE_ID_QUATECH_QSCP200,  1 },
-	{ PCI_DEVICE_ID_QUATECH_DSCP200,  1 },
-	{ PCI_DEVICE_ID_QUATECH_ESCLP100, 0 },
-	{ PCI_DEVICE_ID_QUATECH_QSCLP100, 0 },
-	{ PCI_DEVICE_ID_QUATECH_DSCLP100, 0 },
-	{ PCI_DEVICE_ID_QUATECH_SSCLP100, 0 },
-	{ PCI_DEVICE_ID_QUATECH_QSCLP200, 0 },
-	{ PCI_DEVICE_ID_QUATECH_DSCLP200, 0 },
-	{ PCI_DEVICE_ID_QUATECH_SSCLP200, 0 },
-	{ PCI_DEVICE_ID_QUATECH_SPPXP_100, 0 },
+/* Quatech devices have their own extra interface features */
+static struct pci_device_id quatech_cards[] = {
+	{ PCI_DEVICE_DATA(QUATECH, QSC100,   1) },
+	{ PCI_DEVICE_DATA(QUATECH, DSC100,   1) },
+	{ PCI_DEVICE_DATA(QUATECH, DSC100E,  0) },
+	{ PCI_DEVICE_DATA(QUATECH, DSC200,   1) },
+	{ PCI_DEVICE_DATA(QUATECH, DSC200E,  0) },
+	{ PCI_DEVICE_DATA(QUATECH, ESC100D,  1) },
+	{ PCI_DEVICE_DATA(QUATECH, ESC100M,  1) },
+	{ PCI_DEVICE_DATA(QUATECH, QSCP100,  1) },
+	{ PCI_DEVICE_DATA(QUATECH, DSCP100,  1) },
+	{ PCI_DEVICE_DATA(QUATECH, QSCP200,  1) },
+	{ PCI_DEVICE_DATA(QUATECH, DSCP200,  1) },
+	{ PCI_DEVICE_DATA(QUATECH, ESCLP100, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, QSCLP100, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, DSCLP100, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, SSCLP100, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, QSCLP200, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, DSCLP200, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, SSCLP200, 0) },
+	{ PCI_DEVICE_DATA(QUATECH, SPPXP_100, 0) },
 	{ 0, }
 };
 
-static int pci_quatech_amcc(struct pci_dev *dev)
-{
-	struct quatech_feature *qf = &quatech_cards[0];
-	while (qf->devid) {
-		if (qf->devid == dev->device)
-			return qf->amcc;
-		qf++;
-	}
-	pci_err(dev, "unknown port type '0x%04X'.\n", dev->device);
-	return 0;
-};
-
 static int pci_quatech_rqopr(struct uart_8250_port *port)
 {
 	unsigned long base = port->port.iobase;
@@ -1280,7 +1261,16 @@ static int pci_quatech_rs422(struct uart_8250_port *port)
 
 static int pci_quatech_init(struct pci_dev *dev)
 {
-	if (pci_quatech_amcc(dev)) {
+	const struct pci_device_id *match;
+	bool amcc = false;
+
+	match = pci_match_id(quatech_cards, dev);
+	if (match)
+		amcc = match->driver_data;
+	else
+		pci_err(dev, "unknown port type '0x%04X'.\n", dev->device);
+
+	if (amcc) {
 		unsigned long base = pci_resource_start(dev, 0);
 		if (base) {
 			u32 tmp;
-- 
2.33.0

