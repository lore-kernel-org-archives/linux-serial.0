Return-Path: <SRS0=A6+4=YQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FBDCA9EB6
	for <linux-serial@archiver.kernel.org>; Wed, 23 Oct 2019 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B172064A
	for <linux-serial@archiver.kernel.org>; Wed, 23 Oct 2019 10:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbfJWKgC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:36:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:50760 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404481AbfJWKgC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Oct 2019 06:36:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 03:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="281581732"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Oct 2019 03:36:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4011A1CB; Wed, 23 Oct 2019 13:35:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_dw: Avoid double error messaging when IRQ absent
Date:   Wed, 23 Oct 2019 13:35:58 +0300
Message-Id: <20191023103558.51862-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since the commit 7723f4c5ecdb ("driver core: platform: Add an error message
to platform_get_irq*()") platform_get_irq() started issuing an error message.
Thus, there is no need to have the same in the driver

Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index acbf23b3e300..aab3cccc6789 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -385,10 +385,10 @@ static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	int irq = platform_get_irq(pdev, 0);
 	struct uart_port *p = &up->port;
 	struct device *dev = &pdev->dev;
 	struct dw8250_data *data;
+	int irq;
 	int err;
 	u32 val;
 
@@ -397,11 +397,9 @@ static int dw8250_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "cannot get irq\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
 		return irq;
-	}
 
 	spin_lock_init(&p->lock);
 	p->mapbase	= regs->start;
-- 
2.23.0

