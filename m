Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CD4C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280B961945
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 15:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFYPjh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 11:39:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:54176 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhFYPjh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 11:39:37 -0400
IronPort-SDR: sguQRcZ3za32KBeOkgeL4O+cmM/p4sC5fulzkwLNFvGidseAoJcZAkApNhfFjaLNm85szGbKLi
 0iis43k9Otuw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="194984670"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="194984670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:37:16 -0700
IronPort-SDR: 3CE0n7XYa/SK7Pz/2cGeHC+YjdO8V8FqiwDsZTgV0uuQzmjjJ/WT3usOZoDvMmfUxozWHYhaE+
 8b8kp0b4jFbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="491597121"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2021 08:37:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 452F1103; Fri, 25 Jun 2021 18:37:39 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v1 1/1] serial: max310x: Unprepare and disable clock in error path
Date:   Fri, 25 Jun 2021 18:37:33 +0300
Message-Id: <20210625153733.12911-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In one error case the clock may be left prepared and enabled.
Unprepare and disable clock in that case to balance state of
the hardware.

Fixes: d4d6f03c4fb3 ("serial: max310x: Try to get crystal clock rate from property")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/max310x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0c1e4df52215..ef11860cd69e 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1293,7 +1293,8 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		freq = uartclk;
 	if (freq == 0) {
 		dev_err(dev, "Cannot get clock rate\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_clk;
 	}
 
 	if (xtal) {
-- 
2.30.2

