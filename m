Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011D0C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbiDYOjj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242504AbiDYOj0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:39:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6227D1E8
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897382; x=1682433382;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l+Z6f4juhDC6bACwEALp+g2T17NIHj/1kpLAgk+YLLk=;
  b=gR6koAg+/zAjiFtkeL3sRsR+RT7t+y7uiPrexcxjs2X66zjH0AN9TIV4
   CrPEOvZfKk7ac/oN+fucktTTv36Q3FVEqDTTPu+NukPtFRfQfZAPcjYRi
   vtmA+Ho5jamFSaNGe2NyWDrWTw+m4PaFicJftQHL2jy9cq08yZxVvGVu3
   NMjl+RhR6dx2Uop49Iszn7LtqBNd0qgPC5PUUnH/JJr42FiCAdPq8HZxe
   cb5t9+d/0NJSugExSVfUx+W+iygINg1lq7GNqXmY49gHNwCp7G74OaDjQ
   AIY+tt4Id58iXwYOb6lXv5iEDJMlFgOpoLk8osjZKfHISSDm2hFPCqGnA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245189822"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="245189822"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:36:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579316252"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:36:17 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vicente Bergas <vicencb@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 10/13] serial: 8250: make saved LSR larger
Date:   Mon, 25 Apr 2022 17:34:07 +0300
Message-Id: <20220425143410.12703-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DW flags address received as BIT(8) in LSR. In order to not lose that
on read, enlarge lsr_saved_flags and adjust related call chains which
passed chars previously.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++----
 include/linux/serial_8250.h         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index da78a7fa763f..c2492b91b0cd 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1592,7 +1592,7 @@ static inline void __start_tx(struct uart_port *port)
 
 	if (serial8250_set_THRI(up)) {
 		if (up->bugs & UART_BUG_TXEN) {
-			unsigned char lsr;
+			unsigned int lsr;
 
 			lsr = serial_in(up, UART_LSR);
 			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
@@ -1748,7 +1748,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
+void serial8250_read_char(struct uart_8250_port *up, unsigned int lsr)
 {
 	struct uart_port *port = &up->port;
 	unsigned char ch;
@@ -1815,7 +1815,7 @@ EXPORT_SYMBOL_GPL(serial8250_read_char);
  * value, and returns the remaining LSR bits not handled
  * by this Rx routine.
  */
-unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
+unsigned int serial8250_rx_chars(struct uart_8250_port *up, unsigned int lsr)
 {
 	struct uart_port *port = &up->port;
 	int max_count = 256;
@@ -1937,7 +1937,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
  */
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 {
-	unsigned char status;
+	unsigned int status;
 	struct uart_8250_port *up = up_to_u8250p(port);
 	bool skip_rx = false;
 	unsigned long flags;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index ff84a3ed10ea..921df4c60062 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -119,7 +119,7 @@ struct uart_8250_port {
 	 * be immediately processed.
 	 */
 #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
-	unsigned char		lsr_saved_flags;
+	u16			lsr_saved_flags;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
@@ -170,8 +170,8 @@ extern void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 				      unsigned int quot_frac);
 extern int fsl8250_handle_irq(struct uart_port *port);
 int serial8250_handle_irq(struct uart_port *port, unsigned int iir);
-unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr);
-void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr);
+unsigned int serial8250_rx_chars(struct uart_8250_port *up, unsigned int lsr);
+void serial8250_read_char(struct uart_8250_port *up, unsigned int lsr);
 void serial8250_tx_chars(struct uart_8250_port *up);
 unsigned int serial8250_modem_status(struct uart_8250_port *up);
 void serial8250_init_port(struct uart_8250_port *up);
-- 
2.30.2

