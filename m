From: Frans Klaver <frans.klaver@xsens.com>
Subject: [PATCH 3/3] tty: omap-serial: support setting of hardware flow control in dts
Date: Tue, 29 Jul 2014 16:52:57 +0200
Message-ID: <1406645577-18620-4-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from filter1.ibarracuda.nl ([83.247.7.10]:33659 "EHLO
	filter1.ibarracuda.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbaG2PFZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Jul 2014 11:05:25 -0400
Received: from XSMCASSVR01.xsens-tech.local (rev-215.116.249.87.virtu.nl [87.249.116.215]) by filter1.ibarracuda.nl with ESMTP id lejY1yOzUkFj4VAz (version=TLSv1 cipher=AES128-SHA bits=128 verify=NO) for <linux-serial@vger.kernel.org>; Tue, 29 Jul 2014 16:53:32 +0200 (CEST)
In-Reply-To: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Frans Klaver <frans.klaver@xsens.com>

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

