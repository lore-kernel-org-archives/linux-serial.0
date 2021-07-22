Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1FC63793
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E3E61289
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 15:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhGVOVj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:21:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:3653 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232431AbhGVOVg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 10:21:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="198869950"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="198869950"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 08:02:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="633017703"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Jul 2021 08:02:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2DB9AE7; Thu, 22 Jul 2021 18:02:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dennis Giaya <dgiaya@whoi.edu>
Subject: [PATCH v1 1/1] serial: max310x: Use clock-names property matching to recognize XTAL
Date:   Thu, 22 Jul 2021 18:02:33 +0300
Message-Id: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dennis reported that on ACPI-based systems the clock frequency
isn't enough to configure device properly. We have to respect
the clock source as well. To achieve this match the clock-names
property against "xtal" to recognize crystal connection.

Reported-by: Dennis Giaya <dgiaya@whoi.edu>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max310x.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ef11860cd69e..e2ab8d4eb7ad 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1271,18 +1271,13 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
 
-	s->clk = devm_clk_get_optional(dev, "osc");
+	xtal = device_property_match_string(dev, "clock-names", "xtal") >= 0;
+	if (xtal)
+		s->clk = devm_clk_get_optional(dev, "xtal");
+	else
+		s->clk = devm_clk_get_optional(dev, "osc");
 	if (IS_ERR(s->clk))
 		return PTR_ERR(s->clk);
-	if (s->clk) {
-		xtal = false;
-	} else {
-		s->clk = devm_clk_get_optional(dev, "xtal");
-		if (IS_ERR(s->clk))
-			return PTR_ERR(s->clk);
-
-		xtal = true;
-	}
 
 	ret = clk_prepare_enable(s->clk);
 	if (ret)
-- 
2.30.2

