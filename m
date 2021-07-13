Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB7CC07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534066127C
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhGMKm7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:42:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:59772 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235304AbhGMKm7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 06:42:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="209954684"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="209954684"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="465066136"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2021 03:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C5E8FF; Tue, 13 Jul 2021 13:40:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] serial: 8250_pci: Refactor the loop in pci_ite887x_init()
Date:   Tue, 13 Jul 2021 13:40:23 +0300
Message-Id: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The loop can be refactored by using ARRAY_SIZE() instead of NULL terminator.
This reduces code base and makes it easier to read and understand.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 02985cf90ef2..b9138bd08b7f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -897,37 +897,31 @@ static int pci_netmos_init(struct pci_dev *dev)
 /* enable IO_Space bit */
 #define ITE_887x_POSIO_ENABLE		(1 << 31)
 
+/* inta_addr are the configuration addresses of the ITE */
+static const short inta_addr[] = { 0x2a0, 0x2c0, 0x220, 0x240, 0x1e0, 0x200, 0x280, };
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
-		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE,
-								"ite887x");
+	for (i = 0; i < ARRAY_SIZE(inta_addr); i++) {
+		iobase = request_region(inta_addr[i], ITE_887x_IOSIZE, "ite887x");
 		if (iobase != NULL) {
 			/* write POSIO0R - speed | size | ioport */
 			pci_write_config_dword(dev, ITE_887x_POSIO0,
 				ITE_887x_POSIO_ENABLE | ITE_887x_POSIO_SPEED |
 				ITE_887x_POSIO_IOSIZE_32 | inta_addr[i]);
 			/* write INTCBAR - ioport */
-			pci_write_config_dword(dev, ITE_887x_INTCBAR,
-								inta_addr[i]);
+			pci_write_config_dword(dev, ITE_887x_INTCBAR, inta_addr[i]);
 			ret = inb(inta_addr[i]);
 			if (ret != 0xff) {
 				/* ioport connected */
 				break;
 			}
 			release_region(iobase->start, ITE_887x_IOSIZE);
-			iobase = NULL;
 		}
-		i++;
 	}
 
 	if (!inta_addr[i]) {
-- 
2.30.2

