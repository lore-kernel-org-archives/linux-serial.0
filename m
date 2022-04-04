Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A210DC433EF
	for <linux-serial@archiver.kernel.org>; Mon,  4 Apr 2022 08:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiDDIbg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 4 Apr 2022 04:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiDDIbf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 4 Apr 2022 04:31:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76964220C5
        for <linux-serial@vger.kernel.org>; Mon,  4 Apr 2022 01:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649060979; x=1680596979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aEQDCTG965JKg0vtyx56wV9VxW6CjI19u0rSutPHh/8=;
  b=E4k0Fw2XwHQ7gSEVsya2ga+jiyhbTWcN0zspOIlQ/1yIbSr0au/F5eXF
   qPe3smBRF/CgJe7Xf4NfE0ooiNdNmbJhnLFNbz2qu2zbgO9WS4lDPURLe
   zxTWPhY+J+wi1oBSkubZAZt/M3VQQ7VrRwaF+3QzV+BJ1NauQMXJZc+yF
   x3W0bTa70oC/ze/4IX65K2YgrfkFjyVKcKLNiLNDXGzaF7oCzVy4OVyCZ
   3eF6xtNQAF4vK6HQx+5kyHPM3X4bCmw7Vox/J1JA5mW+uVpqPNCMvnxzd
   dOu/knAP3IJMQQd78514lIfSBrM/HXTwmvRtniTv0x0kfpBZpr7vGXc6/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="241052768"
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="241052768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:29:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,233,1643702400"; 
   d="scan'208";a="569293325"
Received: from rhamza-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.126])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 01:29:35 -0700
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
Subject: [PATCH v2 01/12] serial: Store character timing information to uart_port
Date:   Mon,  4 Apr 2022 11:29:01 +0300
Message-Id: <20220404082912.6885-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
References: <20220404082912.6885-1-ilpo.jarvinen@linux.intel.com>
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

