Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E533C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EA2206D7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgFRMU2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:20:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:58076 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbgFRMU2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 08:20:28 -0400
IronPort-SDR: EFJlQN16TydEtNuZSlXZU41sIVafqDdeiuqXlSTcNzb5ElDcMzAWPDA3rnaf1vFyyn9yafaBDt
 mXozJCCYAXow==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="207790111"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="207790111"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 05:20:27 -0700
IronPort-SDR: 9Hj4QFTpkdOnxX15meW8hHBVTsdAxPn3Y4ti3xAG90KVSYVzYpY8+0UPdntSKcwsLxosFcMoP2
 p0bRGFlIzg7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="309094678"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2020 05:20:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 21CCD217; Thu, 18 Jun 2020 15:20:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_omap: Switch to use platform_get_irq()
Date:   Thu, 18 Jun 2020 15:20:24 +0300
Message-Id: <20200618122024.87170-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

platform_get_irq() provides an established error code and error message.
Also, it's better to use dedicated API to retrieve Linux IRQ resource.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_omap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 144066355af4..b4cd5f1001f8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1195,17 +1195,21 @@ MODULE_DEVICE_TABLE(of, omap8250_dt_ids);
 
 static int omap8250_probe(struct platform_device *pdev)
 {
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct device_node *np = pdev->dev.of_node;
 	struct omap8250_priv *priv;
 	const struct omap8250_platdata *pdata;
 	struct uart_8250_port up;
-	int ret;
+	struct resource *regs;
 	void __iomem *membase;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	if (!regs || !irq) {
-		dev_err(&pdev->dev, "missing registers or irq\n");
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "missing registers\n");
 		return -EINVAL;
 	}
 
@@ -1222,7 +1226,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	up.port.dev = &pdev->dev;
 	up.port.mapbase = regs->start;
 	up.port.membase = membase;
-	up.port.irq = irq->start;
+	up.port.irq = irq;
 	/*
 	 * It claims to be 16C750 compatible however it is a little different.
 	 * It has EFR and has no FCR7_64byte bit. The AFE (which it claims to
-- 
2.27.0.rc2

