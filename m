Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA1CC433E0
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33349206CD
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 14:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGFOAm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:00:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:20782 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgGFOAl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 10:00:41 -0400
IronPort-SDR: FI9e3VnYzb5lIeMZslwU0KEktX7LroVSBWNavv86NdZ04sy5zEIiVCjzyYiWxpnhyA7Va+N+O8
 fvBg3xaj4whw==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="165481972"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="165481972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 07:00:41 -0700
IronPort-SDR: W2/OiAruJ2U4sr2mRkO6dXegEVoZUWzbBPxvDPy+FQCclW4j4YYssQy4kTGqrAwMOkXTagEzTB
 iNnnBSeZApHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="357456002"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Jul 2020 07:00:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C5B59FA; Mon,  6 Jul 2020 17:00:37 +0300 (EEST)
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
Subject: [PATCH v1] serial: core: Initialise spin lock before use in uart_configure_port()
Date:   Mon,  6 Jul 2020 17:00:36 +0300
Message-Id: <20200706140036.75524-1-andriy.shevchenko@linux.intel.com>
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
Cc: Tony Lindgren <tony@atomide.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

I hope this is now properly root caused. To the people in Reported-by list, can
you revert the corresponding change you either reported or submitted to the
certain serial driver and apply this patch and retest?

Tony, can you also test that this doesn't change anything for the PM case for
OMAP?

Geert, I tried to explain above why the change had been made in the first place.

 drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3cc183acf7ba..96d93601bfaa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1915,6 +1915,12 @@ static inline bool uart_console_enabled(struct uart_port *port)
 	return uart_console(port) && (port->cons->flags & CON_ENABLED);
 }
 
+static inline void uart_any_port_spin_lock_init(struct uart_port *port)
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
+	uart_any_port_spin_lock_init(port);
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
+			uart_any_port_spin_lock_init(uport);
+
 		/*
 		 * Ensure that the modem control lines are de-activated.
 		 * keep the DTR setting that is set in uart_set_options()
-- 
2.27.0

