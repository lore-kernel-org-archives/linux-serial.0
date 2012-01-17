From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH] serial: amba-pl011: lock console writes against interrupts
Date: Tue, 17 Jan 2012 11:52:28 +0100
Message-ID: <1326797548-3353-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:38888 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752960Ab2AQKxF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 Jan 2012 05:53:05 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rabin Vincent <rabin.vincent@stericsson.com>, stable@kernel.org, Linus Walleij <linus.walleij@linaro.org>

From: Rabin Vincent <rabin.vincent@stericsson.com>

Protect against pl011_console_write() and the interrupt for
the console UART running concurrently on different CPUs.

Otherwise the console_write could spin for a long time
waiting for the UART to become not busy, while the other
CPU continuously services UART interrupts and keeps the
UART busy.

The checks for sysrq and oops_in_progress are taken
from 8250.c.

Cc: stable@kernel.org
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Reviewed-by: Bibek Basu <bibek.basu@stericsson.com>
Reviewed-by: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6958594..89178b4 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1740,9 +1740,19 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 	unsigned int status, old_cr, new_cr;
+	unsigned long flags;
+	int locked = 1;
 
 	clk_enable(uap->clk);
 
+	local_irq_save(flags);
+	if (uap->port.sysrq)
+		locked = 0;
+	else if (oops_in_progress)
+		locked = spin_trylock(&uap->port.lock);
+	else
+		spin_lock(&uap->port.lock);
+
 	/*
 	 *	First save the CR then disable the interrupts
 	 */
@@ -1762,6 +1772,10 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	} while (status & UART01x_FR_BUSY);
 	writew(old_cr, uap->port.membase + UART011_CR);
 
+	if (locked)
+		spin_unlock(&uap->port.lock);
+	local_irq_restore(flags);
+
 	clk_disable(uap->clk);
 }
 
-- 
1.7.8

