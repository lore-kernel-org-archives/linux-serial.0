From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_dw: remove ACPI ifdef
Date: Tue, 26 Nov 2013 10:30:06 +0200
Message-ID: <1385454606-23255-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12509 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab3KZIaO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Nov 2013 03:30:14 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

ACPI now provides stubs for the functions the driver uses.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 4658e3e..816ec88 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -272,7 +272,6 @@ static int dw8250_probe_of(struct uart_port *p,
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
 static int dw8250_probe_acpi(struct uart_8250_port *up,
 			     struct dw8250_data *data)
 {
@@ -300,13 +299,6 @@ static int dw8250_probe_acpi(struct uart_8250_port *up,
 
 	return 0;
 }
-#else
-static inline int dw8250_probe_acpi(struct uart_8250_port *up,
-				    struct dw8250_data *data)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_ACPI */
 
 static int dw8250_probe(struct platform_device *pdev)
 {
-- 
1.8.4.3

