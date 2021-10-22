Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181AC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 22 Oct 2021 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8A56112F
	for <linux-serial@archiver.kernel.org>; Fri, 22 Oct 2021 13:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhJVNyM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Oct 2021 09:54:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:65324 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231174AbhJVNyM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Oct 2021 09:54:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="315507791"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="315507791"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 06:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="569080160"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Oct 2021 06:51:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 078C6BB; Fri, 22 Oct 2021 16:51:49 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] serial: 8250_pci: Get rid of redundant 'else' keyword
Date:   Fri, 22 Oct 2021 16:51:46 +0300
Message-Id: <20211022135147.70965-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
References: <20211022135147.70965-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 'else' keyword is not needed when previous conditional branch returns
to the upper layer. Get rid of redundant 'else' keyword in such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: avoided changes in Pericom code for now (it makes sense to split support
    to a separate driver)
 drivers/tty/serial/8250/8250_pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8a2f42507c18..463b2c71da6f 100644
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
-- 
2.33.0

