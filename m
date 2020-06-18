Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30CC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 09:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8225217A0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 09:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgFRJvt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:51:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:27678 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgFRJvs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 05:51:48 -0400
IronPort-SDR: 6EagYkaK6Q77GnxwAj5Bd3qkzMHttABy20JjYUgmsZs5dsX0lcmgRAz5mrau+wloa/BHuRGorz
 OEnuiI/lNHrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="140862124"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="140862124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 02:51:47 -0700
IronPort-SDR: LQsq9bkbEavIpDi4nPfUv/WJOYaroATLrYdAQ1peYLmBzDneYtVUGl5BSn5ILbup1USgOL0c75
 LLrdSOZGzflA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="450582962"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2020 02:51:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3EFD3217; Thu, 18 Jun 2020 12:51:44 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: 8250_em: Switch to use platform_get_irq()
Date:   Thu, 18 Jun 2020 12:51:44 +0300
Message-Id: <20200618095144.73852-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/8250/8250_em.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_em.c b/drivers/tty/serial/8250/8250_em.c
index 2a76e22d2ec0..db88dee3a399 100644
--- a/drivers/tty/serial/8250/8250_em.c
+++ b/drivers/tty/serial/8250/8250_em.c
@@ -78,14 +78,18 @@ static void serial8250_em_serial_dl_write(struct uart_8250_port *up, int value)
 
 static int serial8250_em_probe(struct platform_device *pdev)
 {
-	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	struct serial8250_em_priv *priv;
 	struct uart_8250_port up;
-	int ret;
+	struct resource *regs;
+	int irq, ret;
 
-	if (!regs || !irq) {
-		dev_err(&pdev->dev, "missing registers or irq\n");
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs) {
+		dev_err(&pdev->dev, "missing registers\n");
 		return -EINVAL;
 	}
 
@@ -101,7 +105,7 @@ static int serial8250_em_probe(struct platform_device *pdev)
 
 	memset(&up, 0, sizeof(up));
 	up.port.mapbase = regs->start;
-	up.port.irq = irq->start;
+	up.port.irq = irq;
 	up.port.type = PORT_UNKNOWN;
 	up.port.flags = UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_IOREMAP;
 	up.port.dev = &pdev->dev;
-- 
2.27.0.rc2

