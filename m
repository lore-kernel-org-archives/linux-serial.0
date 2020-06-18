Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBDFC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A6020707
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgFRMdZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:33:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:58489 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgFRMdY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 08:33:24 -0400
IronPort-SDR: 0EQtmHjChDwQ5EjnDBJ/q/kzVTmIejLF86KK6FHD40hAdeMetWaZczFcP/A43Edf48djf7PLkT
 wK+hjfRwL3dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="142499406"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="142499406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 05:33:23 -0700
IronPort-SDR: m9/0Z/o5OVW7ZdET7pVm7OmrH13w2RyBG8lr86SfM/sqpvLPp/bEii4OSB2ju8YmZYsMPSU6cy
 /DYbtgI0MTEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="477222681"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 05:33:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AE76D217; Thu, 18 Jun 2020 15:33:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_ingenic: Switch to use platform_get_irq()
Date:   Thu, 18 Jun 2020 15:33:20 +0300
Message-Id: <20200618123320.88612-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_ingenic.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 424c07c5f629..dde766fa465f 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -207,12 +207,11 @@ static unsigned int ingenic_uart_serial_in(struct uart_port *p, int offset)
 static int ingenic_uart_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {};
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct ingenic_uart_data *data;
 	const struct ingenic_uart_config *cdata;
 	const struct of_device_id *match;
-	int err, line;
+	struct resource *regs;
+	int irq, err, line;
 
 	match = of_match_device(of_match, &pdev->dev);
 	if (!match) {
@@ -221,8 +220,13 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	}
 	cdata = match->data;
 
-	if (!regs || !irq) {
-		dev_err(&pdev->dev, "no registers/irq defined\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "no registers defined\n");
 		return -EINVAL;
 	}
 
@@ -238,7 +242,7 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	uart.port.regshift = 2;
 	uart.port.serial_out = ingenic_uart_serial_out;
 	uart.port.serial_in = ingenic_uart_serial_in;
-	uart.port.irq = irq->start;
+	uart.port.irq = irq;
 	uart.port.dev = &pdev->dev;
 	uart.port.fifosize = cdata->fifosize;
 	uart.tx_loadsz = cdata->tx_loadsz;
-- 
2.27.0.rc2

