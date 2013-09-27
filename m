From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] serial: 8250_dw: fix broken function call
Date: Fri, 27 Sep 2013 10:21:07 +0300
Message-ID: <1380266467-8360-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41557 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab3I0HVL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Sep 2013 03:21:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org

The stub for dw8250_probe_acpi() is missing an argument.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 8edf769..d04a037 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -278,7 +278,8 @@ static int dw8250_probe_acpi(struct uart_8250_port *up,
 	return 0;
 }
 #else
-static inline int dw8250_probe_acpi(struct uart_8250_port *up)
+static inline int dw8250_probe_acpi(struct uart_8250_port *up,
+				    struct dw8250_data *data)
 {
 	return -ENODEV;
 }
-- 
1.8.4.rc3

