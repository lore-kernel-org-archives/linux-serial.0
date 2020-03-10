Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB4EC10F27
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5067920675
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgCJNeS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:34:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:19004 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgCJNeS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 09:34:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:34:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="443164096"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Mar 2020 06:34:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 39148193; Tue, 10 Mar 2020 15:33:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] serial: pic32_uart: Use uart_console() helper
Date:   Tue, 10 Mar 2020 15:33:58 +0200
Message-Id: <20200310133358.87062-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use uart_console() helper in instead of open coded variant.

Note, SERIAL_CORE_CONSOLE is selected by SERIAL_ATMEL_CONSOLE,
thus no functional changes expected.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/pic32_uart.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index 484b7e8d5381..0a12fb11e698 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -768,11 +768,6 @@ static int __init pic32_console_init(void)
 }
 console_initcall(pic32_console_init);
 
-static inline bool is_pic32_console_port(struct uart_port *port)
-{
-	return port->cons && port->cons->index == port->line;
-}
-
 /*
  * Late console initialization.
  */
@@ -873,8 +868,7 @@ static int pic32_uart_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_SERIAL_PIC32_CONSOLE
-	if (is_pic32_console_port(port) &&
-	    (pic32_console.flags & CON_ENABLED)) {
+	if (uart_console(port) && (pic32_console.flags & CON_ENABLED)) {
 		/* The peripheral clock has been enabled by console_setup,
 		 * so disable it till the port is used.
 		 */
-- 
2.25.1

