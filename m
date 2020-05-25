Return-Path: <SRS0=EYjC=7H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24E8C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 10:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA61F207CB
	for <linux-serial@archiver.kernel.org>; Mon, 25 May 2020 10:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbgEYK74 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 May 2020 06:59:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:21781 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389484AbgEYK74 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 May 2020 06:59:56 -0400
IronPort-SDR: 3aQa8oQuOXeUNzoqBVjFn+qLfQgglQ1s/bpUBflsi/9ugUnBr+Bk29xeCgNvciWI5irVsjQaBW
 X8x0kFzCdf3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 03:59:55 -0700
IronPort-SDR: W+gA/V2vDl0wZzW/duB2x9Ddc+cC1ItpXQMB16WSo7oBe/v3vcIS4Zbf9bu62IIsqD8afHREIq
 PhqgvMtnHTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,433,1583222400"; 
   d="scan'208";a="301393326"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 May 2020 03:59:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67703101; Mon, 25 May 2020 13:59:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1] serial: imx: Initialize lock for non-registered console
Date:   Mon, 25 May 2020 13:59:52 +0300
Message-Id: <20200525105952.13744-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The commit a3cb39d258ef
("serial: core: Allow detach and attach serial device for console")
changed a bit logic behind lock initialization since for most of the console
driver it's supposed to have lock already initialized even if console is not
enabled. However, it's not the case for Freescale IMX console.

Initialize lock explicitly in the ->probe().

Note, there is still an open question should or shouldn't not this driver
register console properly.

Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 986d902fb7fe..6b078e395931 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2404,6 +2404,9 @@ static int imx_uart_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* We need to initialize lock even for non-registered console */
+	spin_lock_init(&sport->port.lock);
+
 	imx_uart_ports[sport->port.line] = sport;
 
 	platform_set_drvdata(pdev, sport);
-- 
2.26.2

