From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v2] serial/8250_dw: use platform_get_irq() instead of platform_get_resource()
Date: Tue,  3 Mar 2015 18:11:14 +0300
Message-ID: <1425395474-6762-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
for requesting IRQ's resources any more, as they can be not ready yet in
case of DT-booting.

platform_get_irq() instead is a recommended way for getting IRQ even if
it was not retrieved earlier.

It also makes code simpler because we're getting "int" value right away
and no conversion from resource to int is required.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

 Changes in v2:
  * Suppress error message if platform_get_irq() returns -EPROBE_DEFER

---
 drivers/tty/serial/8250/8250_dw.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e601162..cda76e8 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -384,18 +384,24 @@ static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {};
 	struct resource *regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct resource *irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	int irq = platform_get_irq(pdev, 0);
 	struct dw8250_data *data;
 	int err;
 
-	if (!regs || !irq) {
-		dev_err(&pdev->dev, "no registers/irq defined\n");
+	if (!regs) {
+		dev_err(&pdev->dev, "no registers defined\n");
 		return -EINVAL;
 	}
 
+	if (irq < 0) {
+		if (irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "cannot get irq\n");
+		return irq;
+	}
+
 	spin_lock_init(&uart.port.lock);
 	uart.port.mapbase = regs->start;
-	uart.port.irq = irq->start;
+	uart.port.irq = irq;
 	uart.port.handle_irq = dw8250_handle_irq;
 	uart.port.pm = dw8250_do_pm;
 	uart.port.type = PORT_8250;
-- 
2.1.0
