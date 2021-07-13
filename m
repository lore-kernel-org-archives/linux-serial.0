Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECF9C07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23116127C
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhGMKnD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:43:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:34847 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235669AbhGMKnB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 06:43:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="197324743"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="197324743"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="562059092"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Jul 2021 03:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A4263551; Tue, 13 Jul 2021 13:40:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] serial: 8250_pci: Replace dev_*() by pci_*() macros
Date:   Tue, 13 Jul 2021 13:40:26 +0300
Message-Id: <20210713104026.58560-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

PCI subsystem provides convenient shortcut macros for message printing.
Use those macros instead of dev_*().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 55 +++++++++++++-----------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 02825c8c5f84..0a51e44de4cd 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -63,14 +63,13 @@ static int pci_default_setup(struct serial_private*,
 
 static void moan_device(const char *str, struct pci_dev *dev)
 {
-	dev_err(&dev->dev,
-	       "%s: %s\n"
+	pci_err(dev, "%s\n"
 	       "Please send the output of lspci -vv, this\n"
 	       "message (0x%04x,0x%04x,0x%04x,0x%04x), the\n"
 	       "manufacturer and name of serial board or\n"
 	       "modem board to <linux-serial@vger.kernel.org>.\n",
-	       pci_name(dev), str, dev->vendor, dev->device,
-	       dev->subsystem_vendor, dev->subsystem_device);
+	       str,
+	       dev->vendor, dev->device, dev->subsystem_vendor, dev->subsystem_device);
 }
 
 static int
@@ -226,7 +225,7 @@ static int pci_inteli960ni_init(struct pci_dev *dev)
 	/* is firmware started? */
 	pci_read_config_dword(dev, 0x44, &oldval);
 	if (oldval == 0x00001000L) { /* RESET value */
-		dev_dbg(&dev->dev, "Local i960 firmware missing\n");
+		pci_dbg(dev, "Local i960 firmware missing\n");
 		return -ENODEV;
 	}
 	return 0;
@@ -576,9 +575,8 @@ static int pci_timedia_probe(struct pci_dev *dev)
 	 * (0,2,3,5,6: serial only -- 7,8,9: serial + parallel)
 	 */
 	if ((dev->subsystem_device & 0x00f0) >= 0x70) {
-		dev_info(&dev->dev,
-			"ignoring Timedia subdevice %04x for parport_serial\n",
-			dev->subsystem_device);
+		pci_info(dev, "ignoring Timedia subdevice %04x for parport_serial\n",
+			 dev->subsystem_device);
 		return -ENODEV;
 	}
 
@@ -815,8 +813,7 @@ static int pci_netmos_9900_numports(struct pci_dev *dev)
 		if (sub_serports > 0)
 			return sub_serports;
 
-		dev_err(&dev->dev,
-			"NetMos/Mostech serial driver ignoring port on ambiguous config.\n");
+		pci_err(dev, "NetMos/Mostech serial driver ignoring port on ambiguous config.\n");
 		return 0;
 	}
 
@@ -913,7 +910,7 @@ static int pci_ite887x_init(struct pci_dev *dev)
 	}
 
 	if (!inta_addr[i]) {
-		dev_err(&dev->dev, "ite887x: could not find iobase\n");
+		pci_err(dev, "could not find iobase\n");
 		return -ENODEV;
 	}
 
@@ -1008,9 +1005,7 @@ static int pci_endrun_init(struct pci_dev *dev)
 	/* EndRun device */
 	if (deviceID == 0x07000200) {
 		number_uarts = ioread8(p + 4);
-		dev_dbg(&dev->dev,
-			"%d ports detected on EndRun PCI Express device\n",
-			number_uarts);
+		pci_dbg(dev, "%d ports detected on EndRun PCI Express device\n", number_uarts);
 	}
 	pci_iounmap(dev, p);
 	return number_uarts;
@@ -1040,9 +1035,7 @@ static int pci_oxsemi_tornado_init(struct pci_dev *dev)
 	/* Tornado device */
 	if (deviceID == 0x07000200) {
 		number_uarts = ioread8(p + 4);
-		dev_dbg(&dev->dev,
-			"%d ports detected on Oxford PCI Express device\n",
-			number_uarts);
+		pci_dbg(dev, "%d ports detected on Oxford PCI Express device\n", number_uarts);
 	}
 	pci_iounmap(dev, p);
 	return number_uarts;
@@ -1102,15 +1095,15 @@ static struct quatech_feature quatech_cards[] = {
 	{ 0, }
 };
 
-static int pci_quatech_amcc(u16 devid)
+static int pci_quatech_amcc(struct pci_dev *dev)
 {
 	struct quatech_feature *qf = &quatech_cards[0];
 	while (qf->devid) {
-		if (qf->devid == devid)
+		if (qf->devid == dev->device)
 			return qf->amcc;
 		qf++;
 	}
-	pr_err("quatech: unknown port type '0x%04X'.\n", devid);
+	pci_err(dev, "unknown port type '0x%04X'.\n", dev->device);
 	return 0;
 };
 
@@ -1273,7 +1266,7 @@ static int pci_quatech_rs422(struct uart_8250_port *port)
 
 static int pci_quatech_init(struct pci_dev *dev)
 {
-	if (pci_quatech_amcc(dev->device)) {
+	if (pci_quatech_amcc(dev)) {
 		unsigned long base = pci_resource_start(dev, 0);
 		if (base) {
 			u32 tmp;
@@ -1297,7 +1290,7 @@ static int pci_quatech_setup(struct serial_private *priv,
 	port->port.uartclk = pci_quatech_clock(port);
 	/* For now just warn about RS422 */
 	if (pci_quatech_rs422(port))
-		pr_warn("quatech: software control of RS422 features not currently supported.\n");
+		pci_warn(priv->dev, "software control of RS422 features not currently supported.\n");
 	return pci_default_setup(priv, board, port, idx);
 }
 
@@ -1508,7 +1501,7 @@ static int pci_fintek_setup(struct serial_private *priv,
 	/* Get the io address from configuration space */
 	pci_read_config_word(pdev, config_base + 4, &iobase);
 
-	dev_dbg(&pdev->dev, "%s: idx=%d iobase=0x%x", __func__, idx, iobase);
+	pci_dbg(pdev, "idx=%d iobase=0x%x", idx, iobase);
 
 	port->port.iotype = UPIO_PORT;
 	port->port.iobase = iobase;
@@ -1672,7 +1665,7 @@ static int skip_tx_en_setup(struct serial_private *priv,
 			struct uart_8250_port *port, int idx)
 {
 	port->port.quirks |= UPQ_NO_TXEN_TEST;
-	dev_dbg(&priv->dev->dev,
+	pci_dbg(priv->dev,
 		"serial8250: skipping TxEn test for device [%04x:%04x] subsystem [%04x:%04x]\n",
 		priv->dev->vendor, priv->dev->device,
 		priv->dev->subsystem_vendor, priv->dev->subsystem_device);
@@ -3994,9 +3987,9 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 		uart.port.irq = pci_irq_vector(dev, 0);
 
 		if (pci_dev_msi_enabled(dev))
-			dev_dbg(&dev->dev, "Using MSI(-X) interrupts\n");
+			pci_dbg(dev, "Using MSI(-X) interrupts\n");
 		else
-			dev_dbg(&dev->dev, "Using legacy interrupts\n");
+			pci_dbg(dev, "Using legacy interrupts\n");
 	}
 
 	uart.port.dev = &dev->dev;
@@ -4005,12 +3998,12 @@ pciserial_init_ports(struct pci_dev *dev, const struct pciserial_board *board)
 		if (quirk->setup(priv, board, &uart, i))
 			break;
 
-		dev_dbg(&dev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
+		pci_dbg(dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			uart.port.iobase, uart.port.irq, uart.port.iotype);
 
 		priv->line[i] = serial8250_register_8250_port(&uart);
 		if (priv->line[i] < 0) {
-			dev_err(&dev->dev,
+			pci_err(dev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				uart.port.iobase, uart.port.irq,
 				uart.port.iotype, priv->line[i]);
@@ -4106,8 +4099,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 	}
 
 	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
-		dev_err(&dev->dev, "invalid driver_data: %ld\n",
-			ent->driver_data);
+		pci_err(dev, "invalid driver_data: %ld\n", ent->driver_data);
 		return -EINVAL;
 	}
 
@@ -4147,8 +4139,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
 		       sizeof(struct pciserial_board));
 		rc = serial_pci_guess_board(dev, &tmp);
 		if (rc == 0 && serial_pci_matches(board, &tmp))
-			moan_device("Redundant entry in serial pci_table.",
-				    dev);
+			moan_device("Redundant entry in serial pci_table.", dev);
 	}
 
 	priv = pciserial_init_ports(dev, board);
-- 
2.30.2

