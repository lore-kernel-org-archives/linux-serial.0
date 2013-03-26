From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH] tty: serial: samsung: Disable interrupts in a suspend-friendly
 way
Date: Tue, 26 Mar 2013 15:57:35 +0100
Message-ID: <1364309855-10391-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, kyungmin.park@samsung.com, kgene.kim@samsung.com, m.szyprowski@samsung.com, thomas.abraham@linaro.org, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-serial@vger.kernel.org

Since the interrupt mask register is not preserved across system suspend
and it defaults to all interrupts enabled, it is not enough to disable
UART interrupt.

This patch adds free_irq to port shutdown and mask setting to port
startup to handle IRQ disabling in a suspend-friendly way. In addition,
a bug caused by multiple request_irq calls in port startup callback is
fixed.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 2769a38..b386fc8 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -446,6 +446,8 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 
 	/* Clear pending interrupts and mask all interrupts */
 	if (s3c24xx_serial_has_interrupt_mask(port)) {
+		free_irq(port->irq, ourport);
+
 		wr_regl(port, S3C64XX_UINTP, 0xf);
 		wr_regl(port, S3C64XX_UINTM, 0xf);
 	}
@@ -505,6 +507,8 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 	dbg("s3c64xx_serial_startup: port=%p (%08lx,%p)\n",
 	    port->mapbase, port->membase);
 
+	wr_regl(port, S3C64XX_UINTM, 0xf);
+
 	ret = request_irq(port->irq, s3c64xx_serial_handle_irq, IRQF_SHARED,
 			  s3c24xx_serial_portname(port), ourport);
 	if (ret) {
-- 
1.8.1.5
