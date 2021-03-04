Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CD1C433E0
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BD464F09
	for <linux-serial@archiver.kernel.org>; Thu,  4 Mar 2021 08:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhCDIP0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:15:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:61253 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236415AbhCDIO7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Mar 2021 03:14:59 -0500
IronPort-SDR: 6AEvHav6Tbgxz7Qf+p62LkNJTUyFWI3YFy+O/OJK+W5zYg7Q3hTr08FcM8BO5+knqO6fiOT27O
 in/YmYU6pciA==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174482451"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="174482451"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 00:13:13 -0800
IronPort-SDR: XIGz0+zA0xj7muqT+D//5q3Gr96j2tCdfo3uEaGTBuXOBb5yi++XnJN1j1MoYyXEMXZbUVxkuO
 82Yd2Q84DUKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="507269901"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Mar 2021 00:13:11 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_exar: Constify the software nodes
Date:   Thu,  4 Mar 2021 11:13:11 +0300
Message-Id: <20210304081311.17340-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Software node is always created for additional device
properties. If the properties are constant, the software
node can also be constant.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_exar.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 2d0e7c7e408dc..2f49c580139b8 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -354,7 +354,7 @@ static void setup_gpio(struct pci_dev *pcidev, u8 __iomem *p)
 
 static void *
 __xr17v35x_register_gpio(struct pci_dev *pcidev,
-			 const struct property_entry *properties)
+			 const struct software_node *node)
 {
 	struct platform_device *pdev;
 
@@ -365,7 +365,7 @@ __xr17v35x_register_gpio(struct pci_dev *pcidev,
 	pdev->dev.parent = &pcidev->dev;
 	ACPI_COMPANION_SET(&pdev->dev, ACPI_COMPANION(&pcidev->dev));
 
-	if (platform_device_add_properties(pdev, properties) < 0 ||
+	if (device_add_software_node(&pdev->dev, node) < 0 ||
 	    platform_device_add(pdev) < 0) {
 		platform_device_put(pdev);
 		return NULL;
@@ -380,12 +380,16 @@ static const struct property_entry exar_gpio_properties[] = {
 	{ }
 };
 
+static const struct software_node exar_gpio_node = {
+	.properties = exar_gpio_properties,
+};
+
 static int xr17v35x_register_gpio(struct pci_dev *pcidev,
 				  struct uart_8250_port *port)
 {
 	if (pcidev->vendor == PCI_VENDOR_ID_EXAR)
 		port->port.private_data =
-			__xr17v35x_register_gpio(pcidev, exar_gpio_properties);
+			__xr17v35x_register_gpio(pcidev, &exar_gpio_node);
 
 	return 0;
 }
@@ -457,6 +461,10 @@ static const struct property_entry iot2040_gpio_properties[] = {
 	{ }
 };
 
+static const struct software_node iot2040_gpio_node = {
+	.properties = iot2040_gpio_properties,
+};
+
 static int iot2040_register_gpio(struct pci_dev *pcidev,
 			      struct uart_8250_port *port)
 {
@@ -468,7 +476,7 @@ static int iot2040_register_gpio(struct pci_dev *pcidev,
 	writeb(IOT2040_UARTS_GPIO_HI_MODE, p + UART_EXAR_MPIOSEL_15_8);
 
 	port->port.private_data =
-		__xr17v35x_register_gpio(pcidev, iot2040_gpio_properties);
+		__xr17v35x_register_gpio(pcidev, &iot2040_gpio_node);
 
 	return 0;
 }
@@ -547,6 +555,7 @@ static void pci_xr17v35x_exit(struct pci_dev *pcidev)
 	struct uart_8250_port *port = serial8250_get_port(priv->line[0]);
 	struct platform_device *pdev = port->port.private_data;
 
+	device_remove_software_node(&pdev->dev);
 	platform_device_unregister(pdev);
 	port->port.private_data = NULL;
 }
-- 
2.30.1

