Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E19C4332F
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbiDKIg5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiDKIg4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:36:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA327FF5
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666068; x=1681202068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s3dHyn4uqNAAp01ksOGaMh6nU3W65jOhukVGVTf+wL8=;
  b=fmG0VVw/OGUPYCEI9FVFkWVJfOMTMbceeWqGIz/4lsLo+jIrrhfIxXXu
   FipAzI9MO+1C8XIwTcheB0L4BGsH+2vT/bh/Modoy7/00XR5NtcSJHm0H
   xFzo0GyhI+v6EJhwMkiDiD5zwLjUrBK9zHeiioKIGZXIaQemZh2OePSC7
   ZI67L88gItIA6Sphc06DF+YmQLIKg3VvEP2qkSnyoU28qKYH/USl3Q49D
   glqnBs1H74T2ALpp2UZJy05r8JRZgWJjiE+/nH5GIURg5lH9fxdoF7ltG
   p6eWKbgeGJ0ZMxdBS5npq8Ir1H/OYEHuN4cGw9aE16HUTkqZU6HcFJGie
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="262246335"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="262246335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028831"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:34:25 -0700
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
Subject: [PATCH v3 10/12] serial: 8250: create lsr_save_mask
Date:   Mon, 11 Apr 2022 11:33:19 +0300
Message-Id: <20220411083321.9131-11-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
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
index 6e85ad0fade6..b3289ef117d1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1588,7 +1588,7 @@ static inline void __start_tx(struct uart_port *port)
 			unsigned int lsr;
 
 			lsr = serial_in(up, UART_LSR);
-			up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+			up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 			if (lsr & UART_LSR_THRE)
 				serial8250_tx_chars(up);
 		}
@@ -2019,7 +2019,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
@@ -2100,7 +2100,7 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
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

