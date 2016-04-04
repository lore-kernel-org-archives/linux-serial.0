From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/5] serial: 8250_mid: recognize interrupt source in handler
Date: Mon,  4 Apr 2016 17:35:10 +0300
Message-ID: <1459780513-140200-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1459780513-140200-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1459780513-140200-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

There is a special register that shows interrupt status by source. In
particular case the source can be a combination of DMA Tx, DMA Rx, and UART.

Read the register and call the handlers only for sources that request an
interrupt.

Fixes: 6ede6dcd87aa ("serial: 8250_mid: add support for DMA engine handling from UART MMIO")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_mid.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 7aa6ef8..ed48988 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -25,6 +25,7 @@
 #define PCI_DEVICE_ID_INTEL_DNV_UART	0x19d8
 
 /* Intel MID Specific registers */
+#define INTEL_MID_UART_DNV_FISR		0x08
 #define INTEL_MID_UART_PS		0x30
 #define INTEL_MID_UART_MUL		0x34
 #define INTEL_MID_UART_DIV		0x38
@@ -90,16 +91,16 @@ static int tng_setup(struct mid8250 *mid, struct uart_port *p)
 static int dnv_handle_irq(struct uart_port *p)
 {
 	struct mid8250 *mid = p->private_data;
-	int ret;
-
-	ret = hsu_dma_irq(&mid->dma_chip, 0);
-	ret |= hsu_dma_irq(&mid->dma_chip, 1);
-
-	/* For now, letting the HW generate separate interrupt for the UART */
-	if (ret)
-		return ret;
-
-	return serial8250_handle_irq(p, serial_port_in(p, UART_IIR));
+	unsigned int fisr = serial_port_in(p, INTEL_MID_UART_DNV_FISR);
+	int ret = IRQ_NONE;
+
+	if (fisr & BIT(2))
+		ret |= hsu_dma_irq(&mid->dma_chip, 1);
+	if (fisr & BIT(1))
+		ret |= hsu_dma_irq(&mid->dma_chip, 0);
+	if (fisr & BIT(0))
+		ret |= serial8250_handle_irq(p, serial_port_in(p, UART_IIR));
+	return ret;
 }
 
 #define DNV_DMA_CHAN_OFFSET 0x80
-- 
2.8.0.rc3
