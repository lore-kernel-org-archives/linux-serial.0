Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B411AC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 17:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B21A6128A
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 17:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhEQRfm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 13:35:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:24147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243983AbhEQRfS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 13:35:18 -0400
IronPort-SDR: jJLRIIDDrhZXSY5Ois3LFuzBx3E3Qt4S/LMfQfMlHcKOZg97W/TTqGGJMEg7IEZ1TgHdT9czTp
 UYfhisqPRFSA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="221564852"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="221564852"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 10:34:01 -0700
IronPort-SDR: HGG3u8GFhtp4two7G9PkCwl/ciBhVNQGKFlIK9n9V2OpVQLmzON/dYvN5RdJplzqGCyp07FCC3
 34wN/xBcEbMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="432735820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2021 10:33:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A742C12F; Mon, 17 May 2021 20:34:20 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: sc16is7xx: Use devm_clk_get_optional()
Date:   Mon, 17 May 2021 20:34:15 +0300
Message-Id: <20210517173415.7483-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Replace open coded variants of devm_clk_get_optional().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sc16is7xx.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index c5433f9f15f4..2548b4c466ac 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1201,8 +1201,16 @@ static int sc16is7xx_probe(struct device *dev,
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
 
-	s->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(s->clk)) {
+	s->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(s->clk))
+		return PTR_ERR(s->clk);
+
+	ret = clk_prepare_enable(s->clk);
+	if (ret)
+		return ret;
+
+	freq = clk_get_rate(s->clk);
+	if (freq == 0) {
 		if (uartclk)
 			freq = uartclk;
 		if (pfreq)
@@ -1210,13 +1218,7 @@ static int sc16is7xx_probe(struct device *dev,
 		if (freq)
 			dev_dbg(dev, "Clock frequency: %luHz\n", freq);
 		else
-			return PTR_ERR(s->clk);
-	} else {
-		ret = clk_prepare_enable(s->clk);
-		if (ret)
-			return ret;
-
-		freq = clk_get_rate(s->clk);
+			return -EINVAL;
 	}
 
 	s->regmap = regmap;
@@ -1351,8 +1353,7 @@ static int sc16is7xx_probe(struct device *dev,
 	kthread_stop(s->kworker_task);
 
 out_clk:
-	if (!IS_ERR(s->clk))
-		clk_disable_unprepare(s->clk);
+	clk_disable_unprepare(s->clk);
 
 	return ret;
 }
@@ -1376,8 +1377,7 @@ static int sc16is7xx_remove(struct device *dev)
 	kthread_flush_worker(&s->kworker);
 	kthread_stop(s->kworker_task);
 
-	if (!IS_ERR(s->clk))
-		clk_disable_unprepare(s->clk);
+	clk_disable_unprepare(s->clk);
 
 	return 0;
 }
-- 
2.30.2

