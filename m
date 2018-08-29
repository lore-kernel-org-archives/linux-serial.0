From: John Garry <john.garry@huawei.com>
Subject: [PATCH] serial: 8250_of: Fix for lack of interrupt support
Date: Wed, 29 Aug 2018 23:07:57 +0800
Message-ID: <1535555277-102256-1-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alexander.sverdlin@nokia.com, jslaby@suse.com, robh@kernel.org, joel@jms.id.au, kurt@linutronix.de, yamada.masahiro@socionext.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, John Garry <john.garry@huawei.com>
List-Id: linux-serial@vger.kernel.org

In commit c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ"), a
check was added for the UART driver being probed prior to the parent IRQ
controller.

Unfortunately this breaks certain boards which have no interrupt support,
like Huawei D03.

Indeed, the 8250 DT bindings state that interrupts should be supported -
not must.

To fix, switch from irq_of_parse_and_map() to of_irq_get(), which
does relay whether the IRQ host controller domain is not ready, i.e.
defer probe, instead of assuming it.

Fixes: c58caaab3bf8 ("serial: 8250: of: Defer probe on missing IRQ")
Signed-off-by: John Garry <john.garry@huawei.com>
---
Note: I think that it would better if we could try to get the interrupt
	  before clk+pm enabling, so we don't need to disable later when
	  deferring, but this is not a fix.

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index af8beef..c370e776 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -58,7 +58,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	struct resource resource;
 	struct device_node *np = ofdev->dev.of_node;
 	u32 clk, spd, prop;
-	int ret;
+	int ret, irq;
 
 	memset(port, 0, sizeof *port);
 
@@ -143,21 +143,27 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (ret >= 0)
 		port->line = ret;
 
-	port->irq = irq_of_parse_and_map(np, 0);
-	if (!port->irq) {
-		ret = -EPROBE_DEFER;
-		goto err_unprepare;
+	irq = of_irq_get(np, 0);
+	if (irq < 0) {
+		if (port->irq == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_unprepare;
+		}
+		/* IRQ support not mandatory */
+		irq = 0;
 	}
 
+	port->irq = irq;
+
 	info->rst = devm_reset_control_get_optional_shared(&ofdev->dev, NULL);
 	if (IS_ERR(info->rst)) {
 		ret = PTR_ERR(info->rst);
-		goto err_dispose;
+		goto err_unprepare;
 	}
 
 	ret = reset_control_deassert(info->rst);
 	if (ret)
-		goto err_dispose;
+		goto err_unprepare;
 
 	port->type = type;
 	port->uartclk = clk;
@@ -184,8 +190,6 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 		port->handle_irq = fsl8250_handle_irq;
 
 	return 0;
-err_dispose:
-	irq_dispose_mapping(port->irq);
 err_unprepare:
 	clk_disable_unprepare(info->clk);
 err_pmruntime:
-- 
1.9.1
