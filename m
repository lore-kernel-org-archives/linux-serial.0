From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 3/3] tty: omap-serial: support setting of hardware flow control in dts
Date: Tue, 29 Jul 2014 17:02:32 +0200
Message-ID: <1406646152-24698-4-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1406646152-24698-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406646152-24698-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Frans Klaver <frans.klaver@xsens.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This makes hardware flow control availability configurable from the
device tree.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 drivers/tty/serial/omap-serial.c                         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 342eedd..1b629e9 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -8,3 +8,4 @@ Required properties:
 
 Optional properties:
 - clock-frequency : frequency of the clock input to the UART
+- has-hw-flow-control : the hardware has flow control capability
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ff2d931..87df0ee 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1660,6 +1660,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 			return -EPROBE_DEFER;
 		wakeirq = irq_of_parse_and_map(pdev->dev.of_node, 1);
 		omap_up_info = of_get_uart_port_info(&pdev->dev);
+		if (of_property_read_bool(pdev->dev.of_node,
+					"has-hw-flow-control"))
+			omap_up_info->flags |= UPF_HARD_FLOW;
 		pdev->dev.platform_data = omap_up_info;
 	} else {
 		uartirq = platform_get_irq(pdev, 0);
-- 
1.9.3
