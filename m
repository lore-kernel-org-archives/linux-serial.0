From: Simon Arlott <simon@fire.lp0.eu>
Subject: [PATCH] bcm63xx_uart: Use the device name when registering an
 interrupt
Date: Sun, 15 Nov 2015 16:14:32 +0000
Message-ID: <5648AF68.90206@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Use the device name when registering an interrupt so that multiple
ports don't all have the same interrupt name.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 drivers/tty/serial/bcm63xx_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 681e0f3..a1c0a89 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -474,7 +474,7 @@ static int bcm_uart_startup(struct uart_port *port)
 
 	/* register irq and enable rx interrupts */
 	ret = request_irq(port->irq, bcm_uart_interrupt, 0,
-			  bcm_uart_type(port), port);
+			  dev_name(port->dev), port);
 	if (ret)
 		return ret;
 	bcm_uart_writel(port, UART_RX_INT_MASK, UART_IR_REG);
-- 
2.1.4

-- 
Simon Arlott
