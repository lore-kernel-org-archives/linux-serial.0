From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 3/4] serial: 8250_dw: Use ifdef with ACPI
Date: Wed, 16 Jan 2013 14:08:15 +0200
Message-ID: <1358338096-32081-4-git-send-email-heikki.krogerus@linux.intel.com>
References: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29833 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859Ab3APMHU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 07:07:20 -0500
In-Reply-To: <1358338096-32081-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

There are no stubs for ACPI functions so the driver needs to
have this ifdef or it will not compile without ACPI.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ceacf5e..bfdaf8b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -145,6 +145,7 @@ static int dw8250_probe_of(struct uart_port *p)
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
 static bool dw8250_acpi_dma_filter(struct dma_chan *chan, void *parm)
 {
 	return chan->chan_id == *(int *)parm;
@@ -231,6 +232,12 @@ static int dw8250_probe_acpi(struct uart_port *p)
 
 	return 0;
 }
+#else
+static inline int dw8250_probe_acpi(struct uart_port *p)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_ACPI */
 
 static void dw8250_setup_port(struct uart_8250_port *up)
 {
-- 
1.7.10.4

