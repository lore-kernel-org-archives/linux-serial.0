From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: sccnxp: Reset break and overrun bits in RX handler
Date: Mon, 21 Jan 2013 19:38:56 +0400
Message-ID: <1358782737-3386-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:47025 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635Ab3AUPjF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2013 10:39:05 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This patch adds a hardware reset the break and overflow bits for
these events. Without resetting the bits they will be reported to
the core every time, when once occur.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 3fd83e3..79d6aeb 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -309,14 +309,19 @@ static void sccnxp_handle_rx(struct uart_port *port)
 		if (unlikely(sr)) {
 			if (sr & SR_BRK) {
 				port->icount.brk++;
+				sccnxp_port_write(port, SCCNXP_CR_REG,
+						  CR_CMD_BREAK_RESET);
 				if (uart_handle_break(port))
 					continue;
 			} else if (sr & SR_PE)
 				port->icount.parity++;
 			else if (sr & SR_FE)
 				port->icount.frame++;
-			else if (sr & SR_OVR)
+			else if (sr & SR_OVR) {
 				port->icount.overrun++;
+				sccnxp_port_write(port, SCCNXP_CR_REG,
+						  CR_CMD_STATUS_RESET);
+			}
 
 			sr &= port->read_status_mask;
 			if (sr & SR_BRK)
-- 
1.7.12.4

