Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F94C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80074208C7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgFRQsP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:18732 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732055AbgFRQr6 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 12:47:58 -0400
IronPort-SDR: g1z67WL4rXumrC31JvueiR9NCqfTLZ51XXn9F8z6Crr+KujB+CVL9gSUvn+akmIA/XPjcVbzRi
 xQ0J24GJgHkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="142595289"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="142595289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:47:57 -0700
IronPort-SDR: 3a8y2+tuF1G777QHoLpoaEYLIt1skH8wZYy2EWSA6PprgElHUtXbQ6WjFlSm+SmwOWJTppes3h
 9H/fHhR0VjfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="477257278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2020 09:47:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DE47430F; Thu, 18 Jun 2020 19:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v1 5/6] console: Propagate error code from console ->setup()
Date:   Thu, 18 Jun 2020 19:47:50 +0300
Message-Id: <20200618164751.56828-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since console ->setup() hook returns meaningful error codes,
propagate it to the caller of try_enable_new_console().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 kernel/printk/printk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8c14835be46c..aaea3ad182e1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2668,7 +2668,7 @@ early_param("keep_bootcon", keep_bootcon_setup);
 static int try_enable_new_console(struct console *newcon, bool user_specified)
 {
 	struct console_cmdline *c;
-	int i;
+	int i, err;
 
 	for (i = 0, c = console_cmdline;
 	     i < MAX_CMDLINECONSOLES && c->name[0];
@@ -2691,8 +2691,8 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 				return 0;
 
 			if (newcon->setup &&
-			    newcon->setup(newcon, c->options) != 0)
-				return -EIO;
+			    (err = newcon->setup(newcon, c->options)) != 0)
+				return err;
 		}
 		newcon->flags |= CON_ENABLED;
 		if (i == preferred_console) {
-- 
2.27.0

