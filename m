Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C1C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 26 Apr 2022 12:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244762AbiDZMbB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242388AbiDZMav (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 Apr 2022 08:30:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289AC692A0
        for <linux-serial@vger.kernel.org>; Tue, 26 Apr 2022 05:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650976064; x=1682512064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h18PAbr9WsKuOKbF+2nmNOVAbqb6Cix9lNv8WtYXij8=;
  b=LnCRcmMIX61UbbFLhXI6s9CAWx25r+XxfEFQZycC4X+0iBd23Z9Gyphf
   I+3QISwuyy+btGzV0IIp+wYxjjAivpxqSpM81L95JHQOsFQ+GNoCZF5Ev
   123U3O1SKD/tVmn6Ifv1jWG5xcWHRHa7NZy50VTbVse+UDrXcPtD1wTjS
   HmYdAEbQ9ZzbJb4bDC/OqzG/zv3LAkck1xXZlTOX57qXusjybIjmON/Qt
   8t/hxn/Qp9nl9tMre1ikJMjWf88rtOA5N53eZzbJGI0xbNkO0G6X8di3J
   R19zJ2j1yWk4fbBeQn9l+dbv6JlwEDpISzIpy6LOHMOBXrhLVzJ/lANms
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265365589"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265365589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579865016"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 05:27:40 -0700
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
Subject: [PATCH v5 08/10] serial: 8250: create lsr_save_mask
Date:   Tue, 26 Apr 2022 15:24:46 +0300
Message-Id: <20220426122448.38997-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
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
index aa76027b8acc..9505d9d5b45c 100644
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
@@ -2027,7 +2027,7 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	spin_lock_irqsave(&port->lock, flags);
 	lsr = serial_port_in(port, UART_LSR);
-	up->lsr_saved_flags |= lsr & LSR_SAVE_FLAGS;
+	up->lsr_saved_flags |= lsr & up->lsr_save_mask;
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	serial8250_rpm_put(up);
@@ -2105,7 +2105,7 @@ static void wait_for_lsr(struct uart_8250_port *up, int bits)
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

