Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF70C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 25 Apr 2022 14:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiDYOhw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 25 Apr 2022 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbiDYOhu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 25 Apr 2022 10:37:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DD4119EC2
        for <linux-serial@vger.kernel.org>; Mon, 25 Apr 2022 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650897286; x=1682433286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mzXjHcHrJcoVYpUJEFrN1mFRhz6nJt2peN5945Cy69Q=;
  b=aLpwqntusu3J6j4BmuLDgRzy5BBezfsyW7IicllHN6jhI8c8NzSvDFJf
   29ITlK/K8P5We7OHcIrfuKIN/jNvsaUQw9EOaw8G5WHH6sAcGHysJyT/S
   33/rPDNFGuk0KJv9GIYB69Pt1Vrv1Dj/1tDJ4Oj+Z9KFdVoBU8wERQaZ6
   Lq68hi7m+fCYfBxKWLUJc9Dw9gbx4QfxMvI/VyxS0wznOqE8iDBLSPy4e
   igODp/mhMTVyiyCKmFvfilKqcXoY7L4wpCD7KlV+6xZUvV8fQHYBmTZHT
   6MBlZWv8hL2u9IvO97S5F3WaRsMJIB+iPSrImEZNW5n02wmqIqInnFXYL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264782651"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264782651"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:34:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579315583"
Received: from lpuglia-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.217.93])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 07:34:29 -0700
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
Subject: [PATCH v4 01/13] serial: Store character timing information to uart_port
Date:   Mon, 25 Apr 2022 17:33:58 +0300
Message-Id: <20220425143410.12703-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
References: <20220425143410.12703-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Struct uart_port currently stores FIFO timeout. Having character timing
information readily available is useful. Even serial core itself
determines char_time from port->timeout using inverse calculation.

Store frame_time directly into uart_port. Character time is stored in
nanoseconds to have reasonable precision with high rates. To avoid
overflow, 64-bit math is necessary.

It might be possible to determine timeout from frame_time by
multiplying it with fifosize as needed but only part of the users seem
to be protected by a lock. Thus, this patch does not pursue storing
only frame_time in uart_port.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 14 ++++++++------
 include/linux/serial_core.h      |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 846192a7b4bf..c6ac91033e38 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -24,6 +24,7 @@
 #include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/math64.h>
 #include <linux/security.h>
 
 #include <linux/irq.h>
@@ -333,15 +334,18 @@ void
 uart_update_timeout(struct uart_port *port, unsigned int cflag,
 		    unsigned int baud)
 {
-	unsigned int size;
+	unsigned int size = tty_get_frame_size(cflag);
+	u64 frame_time;
 
-	size = tty_get_frame_size(cflag) * port->fifosize;
+	frame_time = (u64)size * NSEC_PER_SEC;
+	size *= port->fifosize;
 
 	/*
 	 * Figure the timeout to send the above number of bits.
 	 * Add .02 seconds of slop
 	 */
 	port->timeout = (HZ * size) / baud + HZ/50;
+	port->frame_time = DIV64_U64_ROUND_UP(frame_time, baud);
 }
 EXPORT_SYMBOL(uart_update_timeout);
 
@@ -1596,10 +1600,8 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 	 * Note: we have to use pretty tight timings here to satisfy
 	 * the NIST-PCTS.
 	 */
-	char_time = (port->timeout - HZ/50) / port->fifosize;
-	char_time = char_time / 5;
-	if (char_time == 0)
-		char_time = 1;
+	char_time = max(nsecs_to_jiffies(port->frame_time / 5), 1UL);
+
 	if (timeout && timeout < char_time)
 		char_time = timeout;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 31f7fe527395..504d365e2803 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -232,6 +232,7 @@ struct uart_port {
 	int			hw_stopped;		/* sw-assisted CTS flow state */
 	unsigned int		mctrl;			/* current modem ctrl settings */
 	unsigned int		timeout;		/* character-based timeout */
+	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
 	const struct uart_ops	*ops;
 	unsigned int		custom_divisor;
-- 
2.30.2

