Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD31C18E5C
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C914F208E4
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgCJNUJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:20:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:29020 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgCJNUI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 09:20:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="415188335"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2020 06:20:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9ABF916D; Tue, 10 Mar 2020 15:20:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] serial: core: Print escaped SysRq Magic sequence if enabled
Date:   Tue, 10 Mar 2020 15:20:02 +0200
Message-Id: <20200310132004.86367-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is useful to see on the serial console the magic sequence itself
to enable SysRq without rummaging source code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ec3b833e9f22..e3f2afc15ad4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3191,8 +3191,11 @@ static const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
 
 static void uart_sysrq_on(struct work_struct *w)
 {
+	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
+
 	sysrq_toggle_support(1);
-	pr_info("SysRq is enabled by magic sequence on serial\n");
+	pr_info("SysRq is enabled by magic sequence '%*pE' on serial\n",
+		sysrq_toggle_seq_len, sysrq_toggle_seq);
 }
 static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
 
-- 
2.25.1

