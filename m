Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8172C07E95
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA38661288
	for <linux-serial@archiver.kernel.org>; Tue, 13 Jul 2021 10:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbhGMKnM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Jul 2021 06:43:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:49793 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235733AbhGMKnM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Jul 2021 06:43:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="207122151"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="207122151"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:40:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="scan'208";a="451723458"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 Jul 2021 03:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B4FEB9; Tue, 13 Jul 2021 13:40:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] serial: 8250_pci: Get rid of redundant 'else' keyword
Date:   Tue, 13 Jul 2021 13:40:24 +0300
Message-Id: <20210713104026.58560-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 'else' keyword is not needed when previous conditional branch returns
to the upper layer. Get rid of redundant 'else' keyword in such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index b9138bd08b7f..937861327aca 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -515,7 +515,7 @@ static int pci_siig_init(struct pci_dev *dev)
 
 	if (type == 0x1000)
 		return pci_siig10x_init(dev);
-	else if (type == 0x2000)
+	if (type == 0x2000)
 		return pci_siig20x_init(dev);
 
 	moan_device("Unknown SIIG card", dev);
@@ -792,9 +792,9 @@ static int pci_netmos_9900_setup(struct serial_private *priv,
 		bar = 3 * idx;
 
 		return setup_port(priv, port, bar, 0, board->reg_shift);
-	} else {
-		return pci_default_setup(priv, board, port, idx);
 	}
+
+	return pci_default_setup(priv, board, port, idx);
 }
 
 /* the 99xx series comes with a range of device IDs and a variety
@@ -1361,9 +1361,10 @@ pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 			serial_port_out(port, 2, 16 - scr);
 			serial_port_out(port, UART_LCR, lcr);
 			return;
-		} else if (baud > actual_baud) {
-			break;
 		}
+
+		if (baud > actual_baud)
+			break;
 	}
 	serial8250_do_set_divisor(port, baud, quot, quot_frac);
 }
-- 
2.30.2

