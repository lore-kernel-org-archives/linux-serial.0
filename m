Return-Path: <SRS0=jKy5=43=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFB7C18E5A
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6348824649
	for <linux-serial@archiver.kernel.org>; Tue, 10 Mar 2020 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCJNbC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:31:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:18711 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgCJNbB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Mar 2020 09:31:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 06:31:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,537,1574150400"; 
   d="scan'208";a="441302566"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 Mar 2020 06:30:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 66D2D193; Tue, 10 Mar 2020 15:30:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Richard Genoud <richard.genoud@gmail.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] tty/serial: atmel: Use uart_console() helper
Date:   Tue, 10 Mar 2020 15:30:57 +0200
Message-Id: <20200310133057.86840-1-andriy.shevchenko@linux.intel.com>
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
 drivers/tty/serial/atmel_serial.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 187987a5b707..53b1d135f53b 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2640,18 +2640,8 @@ static struct console atmel_console = {
 
 #define ATMEL_CONSOLE_DEVICE	(&atmel_console)
 
-static inline bool atmel_is_console_port(struct uart_port *port)
-{
-	return port->cons && port->cons->index == port->line;
-}
-
 #else
 #define ATMEL_CONSOLE_DEVICE	NULL
-
-static inline bool atmel_is_console_port(struct uart_port *port)
-{
-	return false;
-}
 #endif
 
 static struct uart_driver atmel_uart = {
@@ -2680,14 +2670,14 @@ static int atmel_serial_suspend(struct platform_device *pdev,
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
-	if (atmel_is_console_port(port) && console_suspend_enabled) {
+	if (uart_console(port) && console_suspend_enabled) {
 		/* Drain the TX shifter */
 		while (!(atmel_uart_readl(port, ATMEL_US_CSR) &
 			 ATMEL_US_TXEMPTY))
 			cpu_relax();
 	}
 
-	if (atmel_is_console_port(port) && !console_suspend_enabled) {
+	if (uart_console(port) && !console_suspend_enabled) {
 		/* Cache register values as we won't get a full shutdown/startup
 		 * cycle
 		 */
@@ -2723,7 +2713,7 @@ static int atmel_serial_resume(struct platform_device *pdev)
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	unsigned long flags;
 
-	if (atmel_is_console_port(port) && !console_suspend_enabled) {
+	if (uart_console(port) && !console_suspend_enabled) {
 		atmel_uart_writel(port, ATMEL_US_MR, atmel_port->cache.mr);
 		atmel_uart_writel(port, ATMEL_US_IER, atmel_port->cache.imr);
 		atmel_uart_writel(port, ATMEL_US_BRGR, atmel_port->cache.brgr);
@@ -2877,7 +2867,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 		goto err_add_port;
 
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
-	if (atmel_is_console_port(&atmel_port->uart)
+	if (uart_console(&atmel_port->uart)
 			&& ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
 		/*
 		 * The serial core enabled the clock for us, so undo
@@ -2920,7 +2910,7 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	kfree(atmel_port->rx_ring.buf);
 	atmel_port->rx_ring.buf = NULL;
 err_alloc_ring:
-	if (!atmel_is_console_port(&atmel_port->uart)) {
+	if (!uart_console(&atmel_port->uart)) {
 		clk_put(atmel_port->clk);
 		atmel_port->clk = NULL;
 	}
-- 
2.25.1

