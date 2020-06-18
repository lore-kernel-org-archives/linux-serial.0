Return-Path: <SRS0=rTT/=77=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E52C433DF
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B27208C7
	for <linux-serial@archiver.kernel.org>; Thu, 18 Jun 2020 16:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgFRQrz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:47:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:20430 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbgFRQrz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Jun 2020 12:47:55 -0400
IronPort-SDR: qmfa/nKnlduU9itOP68fs0qquvNVkvARZxZ2jD1My+K9sZvBib93O80F2KIgOJBGAOqXc6nT/s
 r8mxmhKpcKjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="207886167"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="207886167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 09:47:54 -0700
IronPort-SDR: 8oswUOEDkOkLh7BDI3SHoBHc35hsaN7g3ykAsrKXx58oKyZcHcw5gppjXAXwPoJhE8PipcwaXK
 qDqDHUxOgpjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="477309441"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 09:47:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AFC03130; Thu, 18 Jun 2020 19:47:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH v1 1/6] mips: Return proper error code from console ->setup() hook
Date:   Thu, 18 Jun 2020 19:47:46 +0300
Message-Id: <20200618164751.56828-2-andriy.shevchenko@linux.intel.com>
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/fw/arc/arc_con.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/fw/arc/arc_con.c b/arch/mips/fw/arc/arc_con.c
index 365e3913231e..7fdce236b298 100644
--- a/arch/mips/fw/arc/arc_con.c
+++ b/arch/mips/fw/arc/arc_con.c
@@ -28,7 +28,9 @@ static void prom_console_write(struct console *co, const char *s,
 
 static int prom_console_setup(struct console *co, char *options)
 {
-	return !(prom_flags & PROM_FLAG_USE_AS_CONSOLE);
+	if (prom_flags & PROM_FLAG_USE_AS_CONSOLE)
+		return 0;
+	return -ENODEV;
 }
 
 static struct console arc_cons = {
-- 
2.27.0

