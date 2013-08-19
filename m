From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3/4] msm_serial: Add support for non-GSBI UARTDM devices
Date: Mon, 19 Aug 2013 14:39:56 -0700
Message-ID: <1376948397-6882-4-git-send-email-sboyd@codeaurora.org>
References: <1376948397-6882-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376948397-6882-1-git-send-email-sboyd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, David Brown <davidb@codeaurora.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Not all UARTDM hardware is part of a GSBI complex. Add support
for these devices and fix a bug where we assumed uartdm meant the
hardware was part of a GSBI complex.

Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 7631313..f42c805 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -670,7 +670,7 @@ static void msm_config_port(struct uart_port *port, int flags)
 		if (ret)
 			return;
 	}
-	if (msm_port->is_uartdm)
+	if (msm_port->gsbi_base)
 		writel_relaxed(GSBI_PROTOCOL_UART,
 				msm_port->gsbi_base + GSBI_CONTROL);
 }
@@ -860,6 +860,11 @@ static struct uart_driver msm_uart_driver = {
 
 static atomic_t msm_uart_next_id = ATOMIC_INIT(0);
 
+static const struct of_device_id msm_uartdm_table[] = {
+	{ .compatible = "qcom,msm-uartdm" },
+	{ }
+};
+
 static int __init msm_serial_probe(struct platform_device *pdev)
 {
 	struct msm_port *msm_port;
@@ -879,7 +884,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	msm_port = UART_TO_MSM(port);
 
-	if (platform_get_resource(pdev, IORESOURCE_MEM, 1))
+	if (of_match_device(msm_uartdm_table, &pdev->dev))
 		msm_port->is_uartdm = 1;
 	else
 		msm_port->is_uartdm = 0;
@@ -926,6 +931,7 @@ static int msm_serial_remove(struct platform_device *pdev)
 
 static struct of_device_id msm_match_table[] = {
 	{ .compatible = "qcom,msm-uart" },
+	{ .compatible = "qcom,msm-uartdm" },
 	{}
 };
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
