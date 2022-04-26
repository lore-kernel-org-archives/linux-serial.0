Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07CC4167E
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 12:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242388AbiDZMbC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349940AbiDZMaq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 08:30:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F356971E
        for <linux-serial@vger.kernel.org>; Tue, 26 Apr 2022 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650976059; x=1682512059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xcCMF02gefyJKqaa1HlrLVLu7QGDlwDQD1pxLCrYwpc=;
  b=bFhCoVKTIGrnQZWl6bjvADohmIdl7wp7q0IgGY+WWHCHa9VxeG4uIuyC
   Kc1soeBB3P/N9kK0KQ4BhTXbo/5Z3ge9BeO5u4iTteoBflEBxIR8U8QEL
   /nVl/FnmX/d4glh95JZCkYN2CTQ+QxWBz0Y0EDun4FO85hWRXA1gTNMX/
   ZBsnGvjWUhCPrNIIVtMeu+gAgkFs8mG87oJNRB54PXsuwkFljQwUzwdNl
   1mq249745qQo5TlEbJT6sR80XR9fwEShceuuJhZuGLXhk6Fr+xCD7jmaP
   zkLS1x6ScbK/4dtrlzZFeoM1TfQ2GC6zIeLUPwPbm4hPSBAB3ksvDJI1X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265365570"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265365570"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579864978"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:36 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 07/10] serial: 8250: make saved LSR larger
Date:   Tue, 26 Apr 2022 15:24:45 +0300
Message-Id: <20220426122448.38997-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
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
index b8d05a7dfcf9..aa76027b8acc 100644
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
@@ -1935,7 +1935,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
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

