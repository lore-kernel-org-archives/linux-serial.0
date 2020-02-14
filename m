Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D716BC3B196
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CFC222C4
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgBNLnp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:59063 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728004AbgBNLnp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 03:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="228467752"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2020 03:43:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8E46D24A; Fri, 14 Feb 2020 13:43:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/8] serial: core: Consolidate spin lock initialization code
Date:   Fri, 14 Feb 2020 13:43:33 +0200
Message-Id: <20200214114339.53897-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have two times duplicated excerpt where we initialize spin lock
for UART port. Consolidate it under uart_port_spin_lock_init() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 34 +++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d956da0b6d9c..bb2287048108 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1913,6 +1913,19 @@ static inline bool uart_console_enabled(struct uart_port *port)
 	return uart_console(port) && (port->cons->flags & CON_ENABLED);
 }
 
+/*
+ * Ensure that the serial console lock is initialised early.
+ * If this port is a console, then the spinlock is already initialised.
+ */
+static inline void uart_port_spin_lock_init(struct uart_port *port)
+{
+	if (uart_console_enabled(port))
+		return;
+
+	spin_lock_init(&port->lock);
+	lockdep_set_class(&port->lock, &port_lock_key);
+}
+
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 /**
  *	uart_console_write - write a console message to a serial port
@@ -2065,16 +2078,7 @@ uart_set_options(struct uart_port *port, struct console *co,
 	struct ktermios termios;
 	static struct ktermios dummy;
 
-	/*
-	 * Ensure that the serial console lock is initialised
-	 * early.
-	 * If this port is a console, then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_enabled(port)) {
-		spin_lock_init(&port->lock);
-		lockdep_set_class(&port->lock, &port_lock_key);
-	}
+	uart_port_spin_lock_init(port);
 
 	memset(&termios, 0, sizeof(struct ktermios));
 
@@ -2829,14 +2833,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		goto out;
 	}
 
-	/*
-	 * If this port is a console, then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_enabled(uport)) {
-		spin_lock_init(&uport->lock);
-		lockdep_set_class(&uport->lock, &port_lock_key);
-	}
+	uart_port_spin_lock_init(uport);
+
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
-- 
2.25.0

