Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CFC433DF
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 21:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3E4206B6
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgGFVtI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:49:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:54380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFVtI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 17:49:08 -0400
IronPort-SDR: 3RYTpgtvfQWASR4hN+m1W387m8WBpchod9IB47Pk/Ut1fCF9N+E1fdt+irPGy7+/6j0ST8zVwX
 2gaqJVUTWLXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="134969110"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="134969110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 14:49:08 -0700
IronPort-SDR: i90DzRRIvtTvYq5Mxhs3M2ukmU86s9/Yc5hXoosFSHOmsmmYysnhSfVgVq02SFXsMXMVfbzvr4
 gPaUVaGcfpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="315303929"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2020 14:49:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E2722195; Tue,  7 Jul 2020 00:49:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3] serial: core: Initialise spin lock before use in uart_configure_port()
Date:   Tue,  7 Jul 2020 00:49:03 +0300
Message-Id: <20200706214903.56148-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The comment near to uart_port_spin_lock_init() says:

  Ensure that the serial console lock is initialised early.
  If this port is a console, then the spinlock is already initialised.

and there is nothing about enabled or disabled consoles. The commit
a3cb39d258ef ("serial: core: Allow detach and attach serial device
for console") made a change, which follows the comment, and also to
prevent reinitialisation of the lock in use, when user detaches and
attaches back the same console device. But this change discovers
another issue, that uart_add_one_port() tries to access a spin lock
that now may be uninitialised. This happens when a driver expects
the serial core to register a console on its behalf. In this case
we must initialise a spin lock before use.

Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
Reported-by: Marc Zyngier <maz@kernel.org>
Reported-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: renamed lock init primitive and dropped inline (Marc), added tags (Marc, Tony)
 drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3cc183acf7ba..309fa42b0861 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1915,6 +1915,12 @@ static inline bool uart_console_enabled(struct uart_port *port)
 	return uart_console(port) && (port->cons->flags & CON_ENABLED);
 }
 
+static void __uart_port_spin_lock_init(struct uart_port *port)
+{
+	spin_lock_init(&port->lock);
+	lockdep_set_class(&port->lock, &port_lock_key);
+}
+
 /*
  * Ensure that the serial console lock is initialised early.
  * If this port is a console, then the spinlock is already initialised.
@@ -1924,8 +1930,7 @@ static inline void uart_port_spin_lock_init(struct uart_port *port)
 	if (uart_console(port))
 		return;
 
-	spin_lock_init(&port->lock);
-	lockdep_set_class(&port->lock, &port_lock_key);
+	__uart_port_spin_lock_init(port);
 }
 
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
@@ -2371,6 +2376,13 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		/* Power up port for set_mctrl() */
 		uart_change_pm(state, UART_PM_STATE_ON);
 
+		/*
+		 * If this driver supports console, and it hasn't been
+		 * successfully registered yet, initialise spin lock for it.
+		 */
+		if (port->cons && !(port->cons->flags & CON_ENABLED))
+			__uart_port_spin_lock_init(port);
+
 		/*
 		 * Ensure that the modem control lines are de-activated.
 		 * keep the DTR setting that is set in uart_set_options()
-- 
2.27.0

