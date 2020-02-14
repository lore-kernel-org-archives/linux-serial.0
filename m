Return-Path: <SRS0=POds=4C=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3353C2BA83
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9644B217F4
	for <linux-serial@archiver.kernel.org>; Fri, 14 Feb 2020 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgBNLnp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:43:45 -0500
Received: from mga01.intel.com ([192.55.52.88]:54410 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbgBNLno (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 Feb 2020 06:43:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 03:43:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,440,1574150400"; 
   d="scan'208";a="227577663"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 03:43:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8931019C; Fri, 14 Feb 2020 13:43:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/8] serial: core: Introduce uart_console_enabled() helper
Date:   Fri, 14 Feb 2020 13:43:32 +0200
Message-Id: <20200214114339.53897-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
References: <20200214114339.53897-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Introduce uart_console_enabled() helper which checks port to be console
and console is registered in the list.

Note, this helper will be used in the future as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 76e506ee335c..d956da0b6d9c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1908,6 +1908,11 @@ static int uart_proc_show(struct seq_file *m, void *v)
 }
 #endif
 
+static inline bool uart_console_enabled(struct uart_port *port)
+{
+	return uart_console(port) && (port->cons->flags & CON_ENABLED);
+}
+
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 /**
  *	uart_console_write - write a console message to a serial port
@@ -2066,7 +2071,7 @@ uart_set_options(struct uart_port *port, struct console *co,
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
 	 */
-	if (!(uart_console(port) && (port->cons->flags & CON_ENABLED))) {
+	if (!uart_console_enabled(port)) {
 		spin_lock_init(&port->lock);
 		lockdep_set_class(&port->lock, &port_lock_key);
 	}
@@ -2828,7 +2833,7 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
 	 */
-	if (!(uart_console(uport) && (uport->cons->flags & CON_ENABLED))) {
+	if (!uart_console_enabled(uport)) {
 		spin_lock_init(&uport->lock);
 		lockdep_set_class(&uport->lock, &port_lock_key);
 	}
-- 
2.25.0

