From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 07/10] drivers: PL011: move cts_event workaround into separate function
Date: Fri, 19 Sep 2014 13:21:20 +0100
Message-ID: <1411129283-17219-8-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36063 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751829AbaISMWG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:06 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

To avoid lines with more than 80 characters and to make the
pl011_int() function more readable, move the workaround out into a
separate function.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e7566ed..65a0411 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1293,6 +1293,25 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 	wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
 }
 
+static void check_apply_cts_event_workaround(struct uart_amba_port *uap)
+{
+	unsigned int dummy_read;
+
+	if (!uap->vendor->cts_event_workaround)
+		return;
+
+	/* workaround to make sure that all bits are unlocked.. */
+	writew(0x00, uap->port.membase + UART011_ICR);
+
+	/*
+	 * WA: introduce 26ns(1 uart clk) delay before W1C;
+	 * single apb access will incur 2 pclk(133.12Mhz) delay,
+	 * so add 2 dummy reads
+	 */
+	dummy_read = readw(uap->port.membase + UART011_ICR);
+	dummy_read = readw(uap->port.membase + UART011_ICR);
+}
+
 static irqreturn_t pl011_int(int irq, void *dev_id)
 {
 	struct uart_amba_port *uap = dev_id;
@@ -1300,25 +1319,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	u16 imsc;
 	int handled = 0;
-	unsigned int dummy_read;
 
 	spin_lock_irqsave(&uap->port.lock, flags);
 	imsc = readw(uap->port.membase + UART011_IMSC);
 	status = readw(uap->port.membase + UART011_RIS) & imsc;
 	if (status) {
 		do {
-			if (uap->vendor->cts_event_workaround) {
-				/* workaround to make sure that all bits are unlocked.. */
-				writew(0x00, uap->port.membase + UART011_ICR);
-
-				/*
-				 * WA: introduce 26ns(1 uart clk) delay before W1C;
-				 * single apb access will incur 2 pclk(133.12Mhz) delay,
-				 * so add 2 dummy reads
-				 */
-				dummy_read = readw(uap->port.membase + UART011_ICR);
-				dummy_read = readw(uap->port.membase + UART011_ICR);
-			}
+			check_apply_cts_event_workaround(uap);
 
 			writew(status & ~(UART011_TXIS|UART011_RTIS|
 					  UART011_RXIS),
-- 
1.7.9.5

