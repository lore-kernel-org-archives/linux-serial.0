Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E1C433F5
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 18:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A524061284
	for <linux-serial@archiver.kernel.org>; Sat,  2 Oct 2021 18:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhJBSxa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 2 Oct 2021 14:53:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:20254 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233936AbhJBSx3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 2 Oct 2021 14:53:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10125"; a="205878478"
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="205878478"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2021 11:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,342,1624345200"; 
   d="scan'208";a="481760054"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2021 11:51:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2AAC9B8; Sat,  2 Oct 2021 21:51:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/2] serial: 8250_lpss: Extract dw8250_do_set_termios() for common use
Date:   Sat,  2 Oct 2021 21:51:40 +0300
Message-Id: <20211002185141.31652-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some of the code currently used in dw8250_set_termios(), byt_set_termios()
may be reused by other methods in the future. Extract it to a common helper
function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c    |  8 ++------
 drivers/tty/serial/8250/8250_dwlib.c | 10 ++++++++++
 drivers/tty/serial/8250/8250_dwlib.h |  1 +
 drivers/tty/serial/8250/8250_lpss.c  |  6 +-----
 4 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a3a0154da567..e3c90c9e2448 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -338,7 +338,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	rate = clk_round_rate(d->clk, newrate);
 	if (rate > 0) {
 		/*
-		 * Premilinary set the uartclk to the new clock rate so the
+		 * Preliminary set the uartclk to the new clock rate so the
 		 * clock update event handler caused by the clk_set_rate()
 		 * calling wouldn't actually update the UART divisor since
 		 * we about to do this anyway.
@@ -350,11 +350,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 	}
 	clk_prepare_enable(d->clk);
 
-	p->status &= ~UPSTAT_AUTOCTS;
-	if (termios->c_cflag & CRTSCTS)
-		p->status |= UPSTAT_AUTOCTS;
-
-	serial8250_do_set_termios(p, termios, old);
+	dw8250_do_set_termios(p, termios, old);
 }
 
 static void dw8250_set_ldisc(struct uart_port *p, struct ktermios *termios)
diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
index 6d6a78eead3e..622d3b0d89e7 100644
--- a/drivers/tty/serial/8250/8250_dwlib.c
+++ b/drivers/tty/serial/8250/8250_dwlib.c
@@ -77,6 +77,16 @@ static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
 	serial8250_do_set_divisor(p, baud, quot, quot_frac);
 }
 
+void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old)
+{
+	p->status &= ~UPSTAT_AUTOCTS;
+	if (termios->c_cflag & CRTSCTS)
+		p->status |= UPSTAT_AUTOCTS;
+
+	serial8250_do_set_termios(p, termios, old);
+}
+EXPORT_SYMBOL_GPL(dw8250_do_set_termios);
+
 void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
diff --git a/drivers/tty/serial/8250/8250_dwlib.h b/drivers/tty/serial/8250/8250_dwlib.h
index 9a12953832d3..83d528e5cc21 100644
--- a/drivers/tty/serial/8250/8250_dwlib.h
+++ b/drivers/tty/serial/8250/8250_dwlib.h
@@ -16,4 +16,5 @@ struct dw8250_port_data {
 	u8			dlf_size;
 };
 
+void dw8250_do_set_termios(struct uart_port *p, struct ktermios *termios, struct ktermios *old);
 void dw8250_setup_port(struct uart_port *p);
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 848d81e3838c..398d2c4a40e3 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -100,11 +100,7 @@ static void byt_set_termios(struct uart_port *p, struct ktermios *termios,
 	reg |= BYT_PRV_CLK_EN | BYT_PRV_CLK_UPDATE;
 	writel(reg, p->membase + BYT_PRV_CLK);
 
-	p->status &= ~UPSTAT_AUTOCTS;
-	if (termios->c_cflag & CRTSCTS)
-		p->status |= UPSTAT_AUTOCTS;
-
-	serial8250_do_set_termios(p, termios, old);
+	dw8250_do_set_termios(p, termios, old);
 }
 
 static unsigned int byt_get_mctrl(struct uart_port *port)
-- 
2.33.0

