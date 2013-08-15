From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: [PATCH] OMAP: serial: Remove incorrect disabling of IER interrupt
Date: Thu, 15 Aug 2013 08:53:44 +0100
Message-ID: <520C8908.4050006@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The recent patch to add RS485 contained a bug whereby the IER
interrupt was cleared down incorrectly.

This patch fixes the problem.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 drivers/tty/serial/omap-serial.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 2706c11..2fa7b5c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1327,9 +1327,6 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	pm_runtime_get_sync(up->dev);
 	spin_lock_irqsave(&up->port.lock, flags);
 
-	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	serial_out(up, UART_IER, up->ier);
-
 	/* Disable interrupts from this port */
 	mode = up->ier;
 	up->ier = 0;
-- 
1.7.9.5

