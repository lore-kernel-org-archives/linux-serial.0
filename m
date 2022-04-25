Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24818C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiDYOjr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiDYOjq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:39:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAABBF6B
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897403; x=1682433403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RIP+HzW6zgvdmDzKjfv3XpeZ9y85V/peQTNSRMVO3Kg=;
  b=L7sRdlRnxVHrTCvsZNKzuI/c3dxA5OCUpvckeqmcuyzVfMt+3hIzzcOF
   puwAZgobCYvvhjoJopbi85p5VZ2ahSz4YP7cXB4YEIZOEzAKbtnBwntNH
   WfJsHQ9rMM5ho+F+MS98z+PDQVg66j7p5VQb1gSIVMZDDsIGR5KCnRQDL
   ugmFQ5lHwoCTYIlqdZBYiW3O1LHttj3Bb1BoO9TLdxB+zzOCYpI4F4NVL
   jswC3ggqO8Er+MEsdqyWBs6iQHNX9bRl/uU4qO8ff5OYDvEPazrg66xw2
   Y6GtvV/vWHMl48ilWFi9Ku82JUWT4UR+12bMYGqhlbeAWFvowlMVodyQz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264783234"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264783234"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:36:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579316331"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:36:32 -0700
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
Subject: [PATCH v4 11/13] serial: 8250: create lsr_save_mask
Date:   Mon, 25 Apr 2022 17:34:08 +0300
Message-Id: <20220425143410.12703-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Allow drivers to alter LSR save mask.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 4 +++-
 drivers/tty/serial/8250/8250_port.c | 6 +++---
 include/linux/serial_8250.h         | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f67bc3b76f65..7cb1267559d4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -278,7 +278,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	 * ia64 and parisc boxes.
 	 */
 	lsr = serial_in(up, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 	if ((iir & UART_IIR_NO_INT) && (up->ier & UART_IER_THRI) &&
 	    (!uart_circ_empty(&up->port.state->xmit) || up->port.x_char) &&
 	    (lsr & UART_LSR_THRE)) {
@@ -1097,6 +1097,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			ret = 0;
 		}
 
+		uart->lsr_save_mask = up->lsr_save_mask ?: LSR_SAVE_FLAGS;
+
 		/* Initialise interrupt backoff work if required */
 		if (up->overrun_backoff_time_ms > 0) {
 			uart->overrun_backoff_time_ms =
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c2492b91b0cd..3be95e861f21 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1595,7 +1595,7 @@ static inline void __start_tx(struct uart_port *port)
 			unsigned int lsr;
 
 			lsr = serial_in(up, UART_LSR);
-			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+			up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 			if (lsr & UART_LSR_THRE)
 				serial8250_tx_chars(up);
 		}
@@ -2029,7 +2029,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
@@ -2110,7 +2110,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 	for (;;) {
 		status = serial_in(up, UART_LSR);
 
-		up->lsr_saved_flags |= status & LSR_SAVE_FLAGS;
+		up->lsr_saved_flags |= status & up->lsr_save_mask;
 
 		if ((status & bits) == bits)
 			break;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 921df4c60062..aff76ea22287 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -120,6 +120,7 @@ struct uart_8250_port {
 	 */
 #define LSR_SAVE_FLAGS UART_LSR_BRK_ERROR_BITS
 	u16			lsr_saved_flags;
+	u16			lsr_save_mask;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
-- 
2.30.2

