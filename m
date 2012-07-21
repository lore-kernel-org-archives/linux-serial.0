From: Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH 2/2] ARM: vt8500: Minor update to vt8500-uart for devicetree support
Date: Sat, 21 Jul 2012 23:20:22 +1200
Message-ID: <1342869622-11171-2-git-send-email-linux@prisktech.co.nz>
References: <1342869622-11171-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342869622-11171-1-git-send-email-linux@prisktech.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zumoo <a.zummo@towertech.it>, Alan Cox <alan@linux.intel.com>
Cc: Tony Prisk <linux@prisktech.co.nz>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, VT8500 mailing list <vt8500-wm8505-linux-kernel@googlegroups.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
Split single patch into seperate patches.
 .../devicetree/bindings/tty/serial/vt8500-uart.txt |   14 ++++++++++++++
 drivers/tty/serial/vt8500_serial.c                 |    8 ++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt b/Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt
new file mode 100644
index 0000000..745070a
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/vt8500-uart.txt
@@ -0,0 +1,14 @@
+* VIA/Wondermedia Universal Asynchronous Receiver/Transmitter (UART)
+
+Required properties:
+- compatible: Should be "via,vt8500-uart"
+- reg: Should contain registers location and length
+- interrupts: Should contain interrupt
+
+Example:
+	uart0: serial@d8200000 {
+		compatible = "via,vt8500-uart";
+		reg = <0xd8200000 0x1040>;
+		interrupts = <32>;
+	};
+
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 2be006f..b9ea0b9 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * UART Register offsets
@@ -603,12 +604,18 @@ static int __devexit vt8500_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id vt8500_uart_ids[] = {
+	{ .compatible = "via,vt8500-uart", },
+	{}
+};
+
 static struct platform_driver vt8500_platform_driver = {
 	.probe  = vt8500_serial_probe,
 	.remove = __devexit_p(vt8500_serial_remove),
 	.driver = {
 		.name = "vt8500_serial",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(vt8500_uart_ids),
 	},
 };
 
@@ -643,3 +650,4 @@ module_exit(vt8500_serial_exit);
 MODULE_AUTHOR("Alexey Charkov <alchark@gmail.com>");
 MODULE_DESCRIPTION("Driver for vt8500 serial device");
 MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(of, vt8500_uart_ids);
-- 
1.7.2.5
