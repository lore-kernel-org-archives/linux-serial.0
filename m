Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622E5C433E2
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F722075F
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgGKNxu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:53:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:49198 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgGKNxt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 09:53:49 -0400
IronPort-SDR: PrETq6okCUg147veQAZR1iD946rVaTilTkZEHm6ohW+ZapyyEQx51bymemzHVVk6o7l5Mh0CFx
 fqocwOUSse5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="147513732"
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="147513732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 06:53:49 -0700
IronPort-SDR: cFn7rEp4tPipHEQ3fY3c7JzMlYSOwrg7T1TWrkEvjXnzhSvCcll6iP9OLBKwwgN8koM1NZrYNX
 5SzBA7Ez7EWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="267972789"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2020 06:53:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ADCAB1A1; Sat, 11 Jul 2020 16:53:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] Revert "serial: sh-sci: Initialize spinlock for uart console"
Date:   Sat, 11 Jul 2020 16:53:46 +0300
Message-Id: <20200711135346.71171-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
References: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit f38278e9b810b06aff2981d505267be984423ba3.

There has been a quick fix against uninitialised lock revealed by
the commit f743061a85f5 ("serial: core: Initialise spin lock before use
in uart_configure_port()"). Since we have now better fix in serial core,
this may be safely reverted.

Fixes: f38278e9b810 ("serial: sh-sci: Initialize spinlock for uart console")
Depends-on: f743061a85f5 ("serial: core: Initialise spin lock before use in uart_configure_port()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 83b81b6c3dbf..fc3515b92554 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3282,9 +3282,6 @@ static int sci_probe_single(struct platform_device *dev,
 		sciport->port.flags |= UPF_HARD_FLOW;
 	}
 
-	if (sci_uart_driver.cons->index == sciport->port.line)
-		spin_lock_init(&sciport->port.lock);
-
 	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 	if (ret) {
 		sci_cleanup_single(sciport);
-- 
2.27.0

