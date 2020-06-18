Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2630C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0772208C7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgFRQsK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:48:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:59105 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731996AbgFRQsC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:02 -0400
IronPort-SDR: 3s+UaHpl4piUFzX5IOL06b3epk5DU4D+qfDPStAX+X+KQm5R2q5GxQpc+FZ2SdEKXZHD+W6/qL
 L7NbZfW5hibA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="160752480"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="160752480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:48:00 -0700
IronPort-SDR: xO1z+b2nf6ftbpfvmDkdlvN86z/cX6IfMkPIFOTchTM+XUDjnubturTYf2D63ebZHg2f7UL3fm
 /anv7pdZD5XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="421562121"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2020 09:47:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E50E624D; Thu, 18 Jun 2020 19:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v1 6/6] console: Fix trivia typo 'change' -> 'chance'
Date:   Thu, 18 Jun 2020 19:47:51 +0300
Message-Id: <20200618164751.56828-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I bet the word 'chance' has to be used in 'had a chance to be called',
but, alas, I'm not native speaker...

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 kernel/printk/printk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index aaea3ad182e1..6623e975675a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2705,7 +2705,7 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
-	 * and setup() had a change to be called.
+	 * and setup() had a chance to be called.
 	 */
 	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
 		return 0;
-- 
2.27.0

