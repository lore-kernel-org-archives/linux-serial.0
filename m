Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD3C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 22 Oct 2021 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23EB161246
	for <linux-serial@archiver.kernel.org>; Fri, 22 Oct 2021 13:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhJVNyM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Oct 2021 09:54:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:65324 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhJVNyM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Oct 2021 09:54:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315507789"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="315507789"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 06:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="663197625"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2021 06:51:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F06C6136; Fri, 22 Oct 2021 16:51:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] serial: 8250_pci: Refactor the loop in pci_ite887x_init()
Date:   Fri, 22 Oct 2021 16:51:45 +0300
Message-Id: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
This reduces code base and makes it easier to read and understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed OOB access (Jiri, Dan), dropped irrelevant changes (Jiri, Joe)
 drivers/tty/serial/8250/8250_pci.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 93159557a2fb..8a2f42507c18 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -897,18 +897,16 @@ static int pci_netmos_init(struct pci_dev *dev)
 /* enable IO_Space bit */
 #define ITE_887x_POSIO_ENABLE		(1 << 31)
 
+/* inta_addr are the configuration addresses of the ITE */
+static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280 };
 static int pci_ite887x_init(struct pci_dev *dev)
 {
-	/* inta_addr are the configuration addresses of the ITE */
-	static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0,
-							0x200, 0x280, 0 };
 	int ret, i, type;
 	struct resource *iobase = NULL;
 	u32 miscr, uartbar, ioport;
 
 	/* search for the base-ioport */
-	i = 0;
-	while (inta_addr[i] && iobase == NULL) {
+	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
 		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
 								"ite887x");
 		if (iobase != NULL) {
@@ -925,12 +923,10 @@ static int pci_ite887x_init(struct pci_dev *dev)
 				break;
 			}
 			release_region(iobase->start, ITE_887x_IOSIZE);
-			iobase = NULL;
 		}
-		i++;
 	}
 
-	if (!inta_addr[i]) {
+	if (i == ARRAY_SIZE(inta_addr)) {
 		dev_err(&dev->dev, "ite887x: could not find iobase\n");
 		return -ENODEV;
 	}
-- 
2.33.0

