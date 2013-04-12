From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/1] serial: 8250_dw: Fix the stub for dw8250_probe_acpi()
Date: Fri, 12 Apr 2013 12:44:27 +0300
Message-ID: <1365759867-29657-2-git-send-email-heikki.krogerus@linux.intel.com>
References: <1365759867-29657-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35471 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753657Ab3DLJoa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 12 Apr 2013 05:44:30 -0400
In-Reply-To: <1365759867-29657-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

This fixes the stub for dw8250_probe_acpi() that is used
when compiling without ACPI enabled. The argument type was
wrong.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 39b7ae4..beaa283 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -190,7 +190,7 @@ static int dw8250_probe_acpi(struct uart_8250_port *up)
 	return 0;
 }
 #else
-static inline int dw8250_probe_acpi(struct uart_port *p)
+static inline int dw8250_probe_acpi(struct uart_8250_port *up)
 {
 	return -ENODEV;
 }
-- 
1.7.10.4

