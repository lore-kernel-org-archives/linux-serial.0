Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5479BC35278
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343866AbiDKIhA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343873AbiDKIgg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0251CB00
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666062; x=1681202062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bLfpST78W5acINQtiR37FmtdEkwFx1MA1jfZ9QhhVZk=;
  b=VrD5g1fMXN2XOU7R1na3YMinS20gGsSg3BImFimpJDyElkdzM6DHQUHl
   OiLbZlS9jC1sCRZ9KMIoSJDmwqfFbdiK3sJueFTts+PMd/2Yl2yUJJMSi
   9+pL3MYwgizLBEhPvkbgZxQRlkk0xtXDTm072wGtihjmp0EYfKK8kGdKG
   GAWpv44hUbe23mD/YxGPPb1KLwkM8+IUMrQKsN53Uf1ZLxdG65ozMar/V
   /znnawOQCULIzLp/+pY/sVJineT2g5qLLVoTkt8IFWCT7cM8U9xwXVyXW
   6hFduUdMxXUqw2MDzEambwmuyYz4utcIRo13L5QpwWXbyEWf4LrfjP4kG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="262246325"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="262246325"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028797"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:19 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 09/12] serial: 8250: make saved LSR larger
Date:   Mon, 11 Apr 2022 11:33:18 +0300
Message-Id: <20220411083321.9131-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DW flags address received as BIT(8) in LSR. In order to not
lose that on read, enlarge lsr_saved_flags and adjust related
call chains which passed chars previously.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_port.c | 8 ++++----
 include/linux/serial_8250.h         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 276c5281aaa0..6e85ad0fade6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1585,7 +1585,7 @@ static inline void __start_tx(struct uart_port *port)
 
 	if (serial8250_set_THRI(up)) {
 		if (up->bugs & UART_BUG_TXEN) {
-			unsigned char lsr;
+			unsigned int lsr;
 
 			lsr = serial_in(up, UART_LSR);
 			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
@@ -1741,7 +1741,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-void serial8250_read_char(struct uart_8250_port *up, unsigned char lsr)
+void serial8250_read_char(struct uart_8250_port *up, unsigned int lsr)
 {
 	struct uart_port *port = &up->port;
 	unsigned char ch;
@@ -1808,7 +1808,7 @@ EXPORT_SYMBOL_GPL(serial8250_read_char);
  * value, and returns the remaining LSR bits not handled
  * by this Rx routine.
  */
-unsigned char serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
+unsigned int serial8250_rx_chars(struct uart_8250_port *up, unsigned int lsr)
 {
 	struct uart_port *port = &up->port;
 	int max_count = 256;
@@ -1930,7 +1930,7 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
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

