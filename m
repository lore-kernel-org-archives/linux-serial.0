From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] serial: 8250_dw: use UPF_* constants when define flags
Date: Fri,  6 Jun 2014 15:24:10 +0300
Message-ID: <1402057450-24304-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:22030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750840AbaFFMYO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 6 Jun 2014 08:24:14 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The flags member has upf_t type and corresponding macros to define them. This
patch converts ASYNC_SKIP_TEST to UPF_SKIP_TEST in 8250_dw.c.

Otherwise we got a sparse warning:
drivers/tty/serial/8250/8250_dw.c:302:46: warning: restricted upf_t degrades to integer
drivers/tty/serial/8250/8250_dw.c:302:62: warning: restricted upf_t degrades to integer
drivers/tty/serial/8250/8250_dw.c:302:26: warning: incorrect type in assignment (different base types)
drivers/tty/serial/8250/8250_dw.c:302:26:    expected restricted upf_t [usertype] flags
drivers/tty/serial/8250/8250_dw.c:302:26:    got unsigned int

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 51b307a..cf19706 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -299,7 +299,7 @@ static int dw8250_probe_of(struct uart_port *p,
 		p->membase += 7;
 #endif
 		p->serial_out = dw8250_serial_out_rb;
-		p->flags = ASYNC_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+		p->flags = UPF_SKIP_TEST | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 		p->type = PORT_OCTEON;
 		data->usr_reg = 0x27;
 		has_ucv = false;
-- 
2.0.0

