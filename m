Return-Path: <SRS0=r/Py=AR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A9C433E5
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 14:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FF7A206CB
	for <linux-serial@archiver.kernel.org>; Mon,  6 Jul 2020 14:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgGFOfz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:35:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:3972 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgGFOfy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Jul 2020 10:35:54 -0400
IronPort-SDR: GwdY4KZJdbGWtFYs0CH4RuZxfM0DKa+kwk+vExiQRqlaqiOFQQW4ke8WczIA/1+/3WHJd3daE4
 ZE+oZc9jt97A==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127497267"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="127497267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 07:35:51 -0700
IronPort-SDR: 1H4Wnd1VmuRki391kRaJiLt6Odg+Mcz/yjJWEIotsfGzFnb7P5vbDLFIGR37YAhyrqRhqmrBeA
 bGU8esIWikGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="323224542"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2020 07:35:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0F947FA; Mon,  6 Jul 2020 17:35:48 +0300 (EEST)
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
Subject: [PATCH v2] serial: core: Initialise spin lock before use in uart_configure_port()
Date:   Mon,  6 Jul 2020 17:35:48 +0300
Message-Id: <20200706143548.63985-1-andriy.shevchenko@linux.intel.com>
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
v2: my bad to send the version with one typo, now squashed and resent

I hope this is now properly root caused. To the people in Reported-by list, can
you revert the corresponding change you either reported or submitted to the
certain serial driver and apply this patch and retest?

Tony, can you also test that this doesn't change anything for the PM case for
OMAP?

Geert, I tried to explain above why the change had been made in the first place.

 drivers/tty/serial/serial_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3cc183acf7ba..55f9615f0b50 100644
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
+			uart_any_port_spin_lock_init(port);
+
 		/*
 		 * Ensure that the modem control lines are de-activated.
 		 * keep the DTR setting that is set in uart_set_options()
-- 
2.27.0

