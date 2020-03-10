Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E288BC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB405208E4
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgCJNUL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:20:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:54416 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728821AbgCJNUK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 09:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="289036350"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2020 06:20:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 86A8A193; Tue, 10 Mar 2020 15:20:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] serial: core: Use string length for SysRq magic sequence
Date:   Tue, 10 Mar 2020 15:20:01 +0200
Message-Id: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Compiler is not happy about using ARRAY_SIZE() in comparison to smaller type:

  CC      drivers/tty/serial/serial_core.o
.../serial_core.c: In function ‘uart_try_toggle_sysrq’:
.../serial_core.c:3222:24: warning: comparison is always false due to limited range of data type [-Wtype-limits]
 3222 |  if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
      |                        ^

Looking at the code it appears that there is an additional weirdness,
i.e. use ARRAY_SIZE() against simple string literal. Yes, the idea probably
was to allow '\0' in the sequence, but it's impractical: kernel configuration
won't accept it to begin with followed by a comment about '\0' before
comparison in question.

Drop all these by switching to strlen() and convert code accordingly.

Fixes: 68af43173d3f ("serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index aec98db45406..ec3b833e9f22 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3209,7 +3209,9 @@ static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
  */
 static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 {
-	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
+	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
+
+	if (!sysrq_toggle_seq_len)
 		return false;
 
 	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= U8_MAX);
@@ -3218,8 +3220,7 @@ static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
 		return false;
 	}
 
-	/* Without the last \0 */
-	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
+	if (++port->sysrq_seq < sysrq_toggle_seq_len) {
 		port->sysrq = jiffies + SYSRQ_TIMEOUT;
 		return true;
 	}
-- 
2.25.1

