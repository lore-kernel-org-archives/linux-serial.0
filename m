Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B23AC18E5B
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC42208E4
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgCJNUL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:20:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:17887 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbgCJNUJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 09:20:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:20:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="265615381"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2020 06:20:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3735436; Tue, 10 Mar 2020 15:20:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] serial: core: Refactor uart_unlock_and_check_sysrq()
Date:   Tue, 10 Mar 2020 15:20:04 +0200
Message-Id: <20200310132004.86367-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
References: <20200310132004.86367-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Refactor uart_unlock_and_check_sysrq() to:

  - explicitly show that we release a port lock which makes
    static analyzers happy:

CHECK   drivers/tty/serial/serial_core.c
.../serial_core.c:3290:17: warning: context imbalance in 'uart_unlock_and_check_sysrq' - unexpected unlock

  - use flags instead of irqflags to avoid confusion with IRQ flags

  - provide one return point

  - be more compact

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 22 ++++++++++------------
 include/linux/serial_core.h      |  3 +--
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e3f8e641e3a7..ee51cf87e409 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3286,22 +3286,20 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 }
 EXPORT_SYMBOL_GPL(uart_prepare_sysrq_char);
 
-void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags)
+__releases(&port->lock)
 {
 	int sysrq_ch;
 
-	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, irqflags);
-		return;
+	if (port->has_sysrq) {
+		sysrq_ch = port->sysrq_ch;
+		port->sysrq_ch = 0;
+		spin_unlock_irqrestore(&port->lock, flags);
+		if (sysrq_ch)
+			handle_sysrq(sysrq_ch);
+	} else {
+		spin_unlock_irqrestore(&port->lock, flags);
 	}
-
-	sysrq_ch = port->sysrq_ch;
-	port->sysrq_ch = 0;
-
-	spin_unlock_irqrestore(&port->lock, irqflags);
-
-	if (sysrq_ch)
-		handle_sysrq(sysrq_ch);
 }
 EXPORT_SYMBOL_GPL(uart_unlock_and_check_sysrq);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 7a025042e0bb..cab896c60e35 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -447,8 +447,7 @@ extern void uart_insert_char(struct uart_port *port, unsigned int status,
 
 extern int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch);
 extern int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch);
-extern void uart_unlock_and_check_sysrq(struct uart_port *port,
-					unsigned long irqflags);
+extern void uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long flags);
 extern int uart_handle_break(struct uart_port *port);
 
 /*
-- 
2.25.1

