Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95224C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 11 Apr 2022 08:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiDKIgC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343859AbiDKIfx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 11 Apr 2022 04:35:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED403E5F6
        for <linux-serial@vger.kernel.org>; Mon, 11 Apr 2022 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649666020; x=1681202020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aEQDCTG965JKg0vtyx56wV9VxW6CjI19u0rSutPHh/8=;
  b=dZcVOv+tkp10rzqJQmURcs4oXbgQjqYA5IuIX8O1kPqmo9QLsjkvmMN4
   Kyzvy24ymTl25FuQaaP8jsBMqXxjQ5BoXPG0s5tcf1b9HXFZCuiP9aMmv
   1Hm8Xy7rp8WpV9jpEJ57eDainTKBc0fnobT1aVEbbLN7ebh7aGRjG457G
   BMUCKxMp/Na9+hiznzktG3OYOn0zuR1E0iLPemyNMyDjmjjkRJJOieaUz
   DsR5DmeHXp5RIWNrS2HNoMOA65iFYjlruazwEZieqUJoqxioXKlP8mH3L
   cV25GXs1N8Kmf5wW4wdq1tc+7RoFVGS2ue0rzvJVRZTIvfKW9uTv8lean
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="322511536"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="322511536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572028563"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 01:33:36 -0700
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
Subject: [PATCH v3 01/12] serial: Store character timing information to uart_port
Date:   Mon, 11 Apr 2022 11:33:10 +0300
Message-Id: <20220411083321.9131-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Struct uart_port currently stores FIFO timeout. Having character
timing information readily available is useful. Even serial core
itself determines char_time from port->timeout using inverse
calculation.

Store frame_time directly into uart_port. Character time is stored
in nanoseconds to have reasonable precision with high rates.
To avoid overflow, 64-bit math is necessary.

It might be possible to determine timeout from frame_time by
multiplying it with fifosize as needed but only part of the
users seem to be protected by a lock. Thus, this patch does
not pursue storing only frame_time in uart_port.

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

