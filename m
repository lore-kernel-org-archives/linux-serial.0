Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE972C433E0
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846652075F
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgGKNxu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:53:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:36441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgGKNxt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 09:53:49 -0400
IronPort-SDR: 9i0OXrOK5VtSwP2MPOnWVohw23tEJ+G2fcGhfaDf7WaqBAH86oAtW33Tn6wgnjjHA4zth19OBW
 lSpAaXGuKj/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="166464615"
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="166464615"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 06:53:49 -0700
IronPort-SDR: 3QCfEU3cuSiKc948o95gtbhQMrzbYcONsOTXTAyukj96HDh5OMrH71WJVGjUREx8uW4BSBGCp0
 sOQP89RcTHqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="428855436"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2020 06:53:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 89B99130; Sat, 11 Jul 2020 16:53:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/5] Revert "serial: sunhv: Initialize lock for non-registered console"
Date:   Sat, 11 Jul 2020 16:53:42 +0300
Message-Id: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 0f87aa66e8c314f95c00eeff978c8a0b41e05d50.

There has been a quick fix against uninitialised lock revealed by
the commit f743061a85f5 ("serial: core: Initialise spin lock before use
in uart_configure_port()"). Since we have now better fix in serial core,
this may be safely reverted.

Fixes: 0f87aa66e8c3 ("serial: sunhv: Initialize lock for non-registered console")
Depends-on: f743061a85f5 ("serial: core: Initialise spin lock before use in uart_configure_port()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sunhv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index e35073e93a5b..eafada8fb6fa 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -567,9 +567,6 @@ static int hv_probe(struct platform_device *op)
 	sunserial_console_match(&sunhv_console, op->dev.of_node,
 				&sunhv_reg, port->line, false);
 
-	/* We need to initialize lock even for non-registered console */
-	spin_lock_init(&port->lock);
-
 	err = uart_add_one_port(&sunhv_reg, port);
 	if (err)
 		goto out_unregister_driver;
-- 
2.27.0

