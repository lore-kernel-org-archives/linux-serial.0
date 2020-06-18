Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA2C433E1
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB872080D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgFRM2d (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:28:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:8335 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgFRM1v (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 08:27:51 -0400
IronPort-SDR: bqkklPtroSkSt9MT2L3AUY7nqcAhI6lNJYKGr4nmMNWoGnVOJEgYo5FNPhxJOXUdnOcisq0sxt
 nM8Zm+ujLgYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="122771781"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="122771781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 05:27:46 -0700
IronPort-SDR: Qqoj42aHAk8UKkgXhbe5wacIJe13ffYt8aAq5Mwg/dmp7+DhmL/6wSToJOhSnBVI5nt9EBi7cn
 nBu3D0TIx9XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="421482099"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2020 05:27:45 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A3EE5217; Thu, 18 Jun 2020 15:27:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_pxa: Switch to use platform_get_irq()
Date:   Thu, 18 Jun 2020 15:27:44 +0300
Message-Id: <20200618122744.88204-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_pxa.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pxa.c b/drivers/tty/serial/8250/8250_pxa.c
index 11612d174716..33ca98bfa5b3 100644
--- a/drivers/tty/serial/8250/8250_pxa.c
+++ b/drivers/tty/serial/8250/8250_pxa.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/serial_reg.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -93,12 +92,15 @@ static int serial_pxa_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {};
 	struct pxa8250_data *data;
-	struct resource *mmres, *irqres;
-	int ret;
+	struct resource *mmres;
+	int irq, ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!mmres || !irqres)
+	if (!mmres)
 		return -ENODEV;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -121,7 +123,7 @@ static int serial_pxa_probe(struct platform_device *pdev)
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.mapbase = mmres->start;
 	uart.port.regshift = 2;
-	uart.port.irq = irqres->start;
+	uart.port.irq = irq;
 	uart.port.fifosize = 64;
 	uart.port.flags = UPF_IOREMAP | UPF_SKIP_TEST | UPF_FIXED_TYPE;
 	uart.port.dev = &pdev->dev;
-- 
2.27.0.rc2

