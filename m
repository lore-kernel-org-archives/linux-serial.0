Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3274C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A82C60FDB
	for <linux-serial@archiver.kernel.org>; Mon, 17 May 2021 17:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhEQRag (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 17 May 2021 13:30:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:12541 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236191AbhEQRaf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 17 May 2021 13:30:35 -0400
IronPort-SDR: rjudpaq9ABws+8/xzlGUC49acoICqLIwF5NmDORSzCstjOEprw1dSsP7buMP4oG63/ZptZePM3
 mjIK6Z7oMD8w==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180799000"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180799000"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 10:29:16 -0700
IronPort-SDR: 6C2BywTUWdad1JYgVQKP4Fz8hgYbln4EQmLybDYNQcCjdPEuQ2NKonmWhM0ujZly3sMr2GD2JF
 kZJqRHgElt9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="630076698"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 May 2021 10:29:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 73E1112F; Mon, 17 May 2021 20:29:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] serial: max310x: Try to get crystal clock rate from property
Date:   Mon, 17 May 2021 20:29:30 +0300
Message-Id: <20210517172930.83353-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In some configurations, mainly ACPI-based, the clock frequency of the device
is supplied by very well established 'clock-frequency' property. Hence, try
to get it from the property at last if no other providers are available.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 3cbc757d7be7..0c1e4df52215 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -552,7 +552,7 @@ static int max310x_update_best_err(unsigned long f, long *besterr)
 	return 1;
 }
 
-static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
+static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 			       unsigned long freq, bool xtal)
 {
 	unsigned int div, clksrc, pllcfg = 0;
@@ -618,7 +618,7 @@ static int max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 		}
 	}
 
-	return (int)bestfreq;
+	return bestfreq;
 }
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
@@ -1253,9 +1253,10 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
-	int i, ret, fmin, fmax, freq, uartclk;
+	int i, ret, fmin, fmax, freq;
 	struct max310x_port *s;
-	bool xtal = false;
+	u32 uartclk = 0;
+	bool xtal;
 
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
@@ -1267,24 +1268,20 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		return -ENOMEM;
 	}
 
+	/* Always ask for fixed clock rate from a property. */
+	device_property_read_u32(dev, "clock-frequency", &uartclk);
+
 	s->clk = devm_clk_get_optional(dev, "osc");
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
 	if (s->clk) {
-		fmin = 500000;
-		fmax = 35000000;
+		xtal = false;
 	} else {
 		s->clk = devm_clk_get_optional(dev, "xtal");
 		if (IS_ERR(s->clk))
 			return PTR_ERR(s->clk);
-		if (s->clk) {
-			fmin = 1000000;
-			fmax = 4000000;
-			xtal = true;
-		} else {
-			dev_err(dev, "Cannot get clock\n");
-			return -EINVAL;
-		}
+
+		xtal = true;
 	}
 
 	ret = clk_prepare_enable(s->clk);
@@ -1292,6 +1289,21 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		return ret;
 
 	freq = clk_get_rate(s->clk);
+	if (freq == 0)
+		freq = uartclk;
+	if (freq == 0) {
+		dev_err(dev, "Cannot get clock rate\n");
+		return -EINVAL;
+	}
+
+	if (xtal) {
+		fmin = 1000000;
+		fmax = 4000000;
+	} else {
+		fmin = 500000;
+		fmax = 35000000;
+	}
+
 	/* Check frequency limits */
 	if (freq < fmin || freq > fmax) {
 		ret = -ERANGE;
-- 
2.30.2

