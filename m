Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AADC433ED
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC886139C
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 10:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhDGKHV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:07:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:57902 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240556AbhDGKHR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 06:07:17 -0400
IronPort-SDR: WlzQ6nO32B+9Et+SyexHwGppiTCSjJA1BecxmqyW2/M6h3VzQ/ncEX9K6Dae4UVZZdTbByhvaX
 fKXQnQ4o2lig==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="191111930"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="191111930"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 03:05:45 -0700
IronPort-SDR: 4kGujm+dPCk6sxHxyCreArxtLCAphdx66ybpi7rgQwv6DS9EK5B3Xa8VYDrbUhfSubrYY9oUvu
 n+NkvqdA/hvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="381261096"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Apr 2021 03:05:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5CA5D197; Wed,  7 Apr 2021 13:05:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] serial: sh-sci: Respect deferred probe when getting IRQ
Date:   Wed,  7 Apr 2021 13:05:56 +0300
Message-Id: <20210407100556.12321-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

With platform_get_irq() and its optional variant it's possible to get
a deferred probe error code. Since the commit ed7027fdf4ec ("driver core:
platform: Make platform_get_irq_optional() optional") the error code
can be distinguished from no IRQ case. With this, rewrite IRQ resource
handling in sh-sci driver to follow above and allow to respect deferred
probe.

Fixes: ed7027fdf4ec ("driver core: platform: Make platform_get_irq_optional() optional")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ad2c189e8fc8..539c1c2d50b1 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2899,13 +2899,6 @@ static int sci_init_single(struct platform_device *dev,
 	port->mapbase = res->start;
 	sci_port->reg_size = resource_size(res);
 
-	for (i = 0; i < ARRAY_SIZE(sci_port->irqs); ++i) {
-		if (i)
-			sci_port->irqs[i] = platform_get_irq_optional(dev, i);
-		else
-			sci_port->irqs[i] = platform_get_irq(dev, i);
-	}
-
 	/* The SCI generates several interrupts. They can be muxed together or
 	 * connected to different interrupt lines. In the muxed case only one
 	 * interrupt resource is specified as there is only one interrupt ID.
@@ -2913,12 +2906,17 @@ static int sci_init_single(struct platform_device *dev,
 	 * from the SCI, however those signals might have their own individual
 	 * interrupt ID numbers, or muxed together with another interrupt.
 	 */
+	sci_port->irqs[0] = platform_get_irq(dev, i);
 	if (sci_port->irqs[0] < 0)
-		return -ENXIO;
+		return sci_port->irqs[0];
 
-	if (sci_port->irqs[1] < 0)
-		for (i = 1; i < ARRAY_SIZE(sci_port->irqs); i++)
+	for (i = 1; i < ARRAY_SIZE(sci_port->irqs); ++i) {
+		sci_port->irqs[i] = platform_get_irq_optional(dev, i);
+		if (sci_port->irqs[i] < 0)
+			return sci_port->irqs[i];
+		if (sci_port->irqs[i] == 0)
 			sci_port->irqs[i] = sci_port->irqs[0];
+	}
 
 	sci_port->params = sci_probe_regmap(p);
 	if (unlikely(sci_port->params == NULL))
-- 
2.30.2

