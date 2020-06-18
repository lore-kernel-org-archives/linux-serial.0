Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B7C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4692075E
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgFRM37 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:29:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:36206 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgFRM3z (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 08:29:55 -0400
IronPort-SDR: M87bFHhF92pUl3AjlZo1QQHfvSlmbmKldymw3cpJ8nRl4YlZLtyqH94JaibCH9j3JRJAzmQ3zy
 /JWzk5bB9IhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="141625756"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="141625756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 05:29:55 -0700
IronPort-SDR: 5V44KlbycgVIk1TomV7i2GaDJESCzMaGhxzUnfaM6imS980InIOyVjElM7xoeEf+sohDYyOFCV
 LDWRuoEPwbqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="477221285"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 05:29:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 49F94217; Thu, 18 Jun 2020 15:29:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] serial: 8250_mtk: Switch to use platform_get_irq()
Date:   Thu, 18 Jun 2020 15:29:52 +0300
Message-Id: <20200618122952.88265-1-andriy.shevchenko@linux.intel.com>
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
v2: rebase on clean tree
 drivers/tty/serial/8250/8250_mtk.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index f839380c2f4c..685ded99fa6d 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -494,13 +494,17 @@ static int mtk8250_probe_of(struct platform_device *pdev, struct uart_port *p,
 static int mtk8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {};
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct mtk8250_data *data;
-	int err;
+	struct resource *regs;
+	int irq, err;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
-	if (!regs || !irq) {
-		dev_err(&pdev->dev, "no registers/irq defined\n");
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "no registers defined\n");
 		return -EINVAL;
 	}
 
@@ -524,7 +528,7 @@ static int mtk8250_probe(struct platform_device *pdev)
 
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
-	uart.port.irq = irq->start;
+	uart.port.irq = irq;
 	uart.port.pm = mtk8250_do_pm;
 	uart.port.type = PORT_16550;
 	uart.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT;
-- 
2.27.0.rc2

