From: Rob Herring <robh@kernel.org>
Subject: [PATCH 13/15] tty/serial: kill off set_irq_flags usage
Date: Tue,  9 Jun 2015 13:26:39 -0500
Message-ID: <1433874401-27161-14-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433874401-27161-1-git-send-email-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, arm@kernel.org, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Barry Song <baohua@kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/tty/serial/serial_ks8695.c | 2 +-
 drivers/tty/serial/sirfsoc_uart.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_ks8695.c b/drivers/tty/serial/serial_ks8695.c
index 5c79bda..b4decf8 100644
--- a/drivers/tty/serial/serial_ks8695.c
+++ b/drivers/tty/serial/serial_ks8695.c
@@ -328,7 +328,7 @@ static int ks8695uart_startup(struct uart_port *port)
 {
 	int retval;
 
-	set_irq_flags(KS8695_IRQ_UART_TX, IRQF_VALID | IRQF_NOAUTOEN);
+	irq_modify_status(KS8695_IRQ_UART_TX, IRQ_NOREQUEST, IRQ_NOAUTOEN);
 	tx_enable(port, 0);
 	rx_enable(port, 1);
 	ms_enable(port, 1);
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 9de3eab..bcc298d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1053,7 +1053,7 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
 	unsigned int index			= port->line;
 	int ret;
-	set_irq_flags(port->irq, IRQF_VALID | IRQF_NOAUTOEN);
+	irq_modify_status(port->irq, IRQ_NOREQUEST, IRQ_NOAUTOEN);
 	ret = request_irq(port->irq,
 				sirfsoc_uart_isr,
 				0,
@@ -1100,8 +1100,8 @@ static int sirfsoc_uart_startup(struct uart_port *port)
 	sirfport->ms_enabled = false;
 	if (sirfport->uart_reg->uart_type == SIRF_USP_UART &&
 		sirfport->hw_flow_ctrl) {
-		set_irq_flags(gpio_to_irq(sirfport->cts_gpio),
-			IRQF_VALID | IRQF_NOAUTOEN);
+		irq_modify_status(gpio_to_irq(sirfport->cts_gpio),
+			IRQ_NOREQUEST, IRQ_NOAUTOEN);
 		ret = request_irq(gpio_to_irq(sirfport->cts_gpio),
 			sirfsoc_uart_usp_cts_handler, IRQF_TRIGGER_FALLING |
 			IRQF_TRIGGER_RISING, "usp_cts_irq", sirfport);
-- 
2.1.0
