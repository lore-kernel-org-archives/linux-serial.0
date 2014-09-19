From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 06/10] drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
Date: Fri, 19 Sep 2014 13:21:19 +0100
Message-ID: <1411129283-17219-7-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36079 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755548AbaISMWJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:09 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

The PL011 register UART_MIS is actually a bitwise AND of the
UART_RIS and the UART_MISC register.
Since the SBSA UART does not include the _MIS register, use the
two separate registers to get the same behaviour. Since we are
inside the spinlock and we read the _IMSC register only once, there
should be no race issue.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 457a8d90..e7566ed 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1298,11 +1298,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	struct uart_amba_port *uap = dev_id;
 	unsigned long flags;
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
+	u16 imsc;
 	int handled = 0;
 	unsigned int dummy_read;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
-	status = readw(uap->port.membase + UART011_MIS);
+	imsc = readw(uap->port.membase + UART011_IMSC);
+	status = readw(uap->port.membase + UART011_RIS) & imsc;
 	if (status) {
 		do {
 			if (uap->vendor->cts_event_workaround) {
@@ -1337,7 +1339,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 			if (pass_counter-- == 0)
 				break;
 
-			status = readw(uap->port.membase + UART011_MIS);
+			status = readw(uap->port.membase + UART011_RIS) & imsc;
 		} while (status != 0);
 		handled = 1;
 	}
-- 
1.7.9.5

