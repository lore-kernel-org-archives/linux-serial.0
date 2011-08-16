From: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v2 2/4] msm_serial: Add devicetree support
Date: Tue, 16 Aug 2011 10:52:14 -0700
Message-ID: <1313517136-27414-3-git-send-email-davidb@codeaurora.org>
References: <1313517136-27414-1-git-send-email-davidb@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1313517136-27414-1-git-send-email-davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Add devicetree support to the msm_serial driver.  Clocks are still
queried by direct name from the driver until device tree clock support
is implemented.

Signed-off-by: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 .../devicetree/bindings/tty/serial/msm_serial.txt  |   22 ++++++++++++++++++++
 drivers/tty/serial/msm_serial.c                    |   14 ++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/msm_serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/msm_serial.txt b/Documentation/devicetree/bindings/tty/serial/msm_serial.txt
new file mode 100644
index 0000000..1b72e79
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/msm_serial.txt
@@ -0,0 +1,22 @@
+* Qualcomm MSM UART
+
+Required properties:
+- compatible :
+	- "qcom,msm-uart"
+- reg : offset and length of the register set for the device
+	for the hsuart operating in compatible mode, there should be a
+	second pair describing the gsbi registers.
+- interrupts : should contain the uart interrupt.
+
+There are two different UART blocks in MSM devices, "qcom,msm-uart"
+and "qcom,msm-hsuart".  The msm-serial driver is able to handle both
+of these devices.
+
+Example:
+
+	uart@19c400000 {
+		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
+		reg = <0x19c40000 0x1000>,
+		      <0x19c00000 0x1000>;
+		interrupts = <195>;
+	};
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index d9863b2..7767902 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -19,6 +19,7 @@
 # define SUPPORT_SYSRQ
 #endif
 
+#include <linux/atomic.h>
 #include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <linux/io.h>
@@ -33,6 +34,8 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include "msm_serial.h"
 
@@ -856,6 +859,8 @@ static struct uart_driver msm_uart_driver = {
 	.cons = MSM_CONSOLE,
 };
 
+static atomic_t msm_uart_next_id = ATOMIC_INIT(0);
+
 static int __init msm_serial_probe(struct platform_device *pdev)
 {
 	struct msm_port *msm_port;
@@ -863,6 +868,9 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 	struct uart_port *port;
 	int irq;
 
+	if (pdev->id == -1)
+		pdev->id = atomic_inc_return(&msm_uart_next_id) - 1;
+
 	if (unlikely(pdev->id < 0 || pdev->id >= UART_NR))
 		return -ENXIO;
 
@@ -920,11 +928,17 @@ static int __devexit msm_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct of_device_id msm_match_table[] = {
+	{ .compatible = "qcom,msm-uart" },
+	{}
+};
+
 static struct platform_driver msm_platform_driver = {
 	.remove = msm_serial_remove,
 	.driver = {
 		.name = "msm_serial",
 		.owner = THIS_MODULE,
+		.of_match_table = msm_match_table,
 	},
 };
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
