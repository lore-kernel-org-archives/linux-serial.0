Return-Path: <SRS0=puAX=AW=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E0DC433E3
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E469207DD
	for <linux-serial@archiver.kernel.org>; Sat, 11 Jul 2020 13:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgGKNxu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 11 Jul 2020 09:53:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:1862 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgGKNxu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 11 Jul 2020 09:53:50 -0400
IronPort-SDR: sxaEXoQreIOGMGM2vuDmhoFBXY271xMVSXOdg8FAiSgSfVO9rIyNi2MmM3cf5Xmc69lf68aM/i
 ulxY+afHGIAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="136570887"
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="136570887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 06:53:49 -0700
IronPort-SDR: VLjDMyjp4Y5r+ucJVNiJ3mwp5bwcwr1coI4yq2ts2nR/LWuo5SN9VZGOOxcvchrCQAmmln8HuA
 62IAnYbrv8mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,339,1589266800"; 
   d="scan'208";a="359584323"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 11 Jul 2020 06:53:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A816446D; Sat, 11 Jul 2020 16:53:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] Revert "serial: imx: Initialize lock for non-registered console"
Date:   Sat, 11 Jul 2020 16:53:45 +0300
Message-Id: <20200711135346.71171-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
References: <20200711135346.71171-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 8f065acec7573672dd15916e31d1e9b2e785566c.

There has been a quick fix against uninitialised lock revealed by
the commit f743061a85f5 ("serial: core: Initialise spin lock before use
in uart_configure_port()"). Since we have now better fix in serial core,
this may be safely reverted.

Fixes: 8f065acec757 ("serial: imx: Initialize lock for non-registered console")
Depends-on: f743061a85f5 ("serial: core: Initialise spin lock before use in uart_configure_port()")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1265e8d86d8a..6175f8398130 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2406,9 +2406,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* We need to initialize lock even for non-registered console */
-	spin_lock_init(&sport->port.lock);
-
 	imx_uart_ports[sport->port.line] = sport;
 
 	platform_set_drvdata(pdev, sport);
-- 
2.27.0

