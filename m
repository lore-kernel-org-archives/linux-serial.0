Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FC0C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA2C208C7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgFRQr6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:47:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:36707 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732035AbgFRQrz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 12:47:55 -0400
IronPort-SDR: 8xX7+iSo5V39oVeNajxHbIbBvKdu316LU1+Z6HqTlSM9tmTI1XUSVjNWpFcmYfqCroc4bAaxbh
 gA5GtHz7jsdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="131047930"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="131047930"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:47:54 -0700
IronPort-SDR: /trABZAv91giB9O7N7J/69rjWiq1ZTQdcpkvpdOcuw/Xut6pewkIWPicRSf86K5r5hrxKngLFR
 HR49lDWXgz1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="277684401"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2020 09:47:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C63781AD; Thu, 18 Jun 2020 19:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v1 3/6] serial: sunzilog: Return proper error code from console ->setup() hook
Date:   Thu, 18 Jun 2020 19:47:48 +0300
Message-Id: <20200618164751.56828-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

For unifying console ->setup() handling, which is pure documented,
return error code, rather than non-zero arbitrary number.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/tty/serial/sunzilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 103ab8c556e7..7ea06bbc6197 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1221,7 +1221,7 @@ static int __init sunzilog_console_setup(struct console *con, char *options)
 	int baud, brg;
 
 	if (up->port.type != PORT_SUNZILOG)
-		return -1;
+		return -EINVAL;
 
 	printk(KERN_INFO "Console: ttyS%d (SunZilog zs%d)\n",
 	       (sunzilog_reg.minor - 64) + con->index, con->index);
-- 
2.27.0

