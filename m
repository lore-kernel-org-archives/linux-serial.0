From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm] Make it possible to disable serial console suspend
Date: Tue, 29 Aug 2006 21:52:43 +0200
Message-ID: <200608292152.43915.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:31930 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751273AbWH2TtH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Aug 2006 15:49:07 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>

Hack uart_suspend_port() and uart_resume_port() so that serial console ports
are not suspended if CONFIG_DISABLE_CONSOLE_SUSPEND is set.

This makes it possible to debug the suspend and resume routines of all device
drivers as well as the lowest-level swsusp code with the help of the serial
console.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/serial/serial_core.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

Index: linux-2.6.18-rc4-mm3/drivers/serial/serial_core.c
===================================================================
--- linux-2.6.18-rc4-mm3.orig/drivers/serial/serial_core.c
+++ linux-2.6.18-rc4-mm3/drivers/serial/serial_core.c
@@ -1930,6 +1930,13 @@ int uart_suspend_port(struct uart_driver
 
 	mutex_lock(&state->mutex);
 
+#ifdef CONFIG_DISABLE_CONSOLE_SUSPEND
+	if (uart_console(port)) {
+		mutex_unlock(&state->mutex);
+		return 0;
+	}
+#endif
+
 	if (state->info && state->info->flags & UIF_INITIALIZED) {
 		const struct uart_ops *ops = port->ops;
 
@@ -1968,6 +1975,13 @@ int uart_resume_port(struct uart_driver 
 
 	mutex_lock(&state->mutex);
 
+#ifdef CONFIG_DISABLE_CONSOLE_SUSPEND
+	if (uart_console(port)) {
+		mutex_unlock(&state->mutex);
+		return 0;
+	}
+#endif
+
 	uart_change_pm(state, 0);
 
 	/*
