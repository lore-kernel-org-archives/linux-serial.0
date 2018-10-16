From: "Mukesh, Savaliya" <msavaliy@codeaurora.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Rectify UART suspend mechanism
Date: Tue, 16 Oct 2018 19:41:00 +0530
Message-ID: <1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alokc@codeaurora.org, dianders@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>

UART driver checks for the PM state and denies suspend if state is ACTIVE.
This makes UART to deny suspend when client keeps port open which is not
correct. Instead follow framework and obey suspend-resume callbacks.

Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 36 ++++++-----------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 29ec343..93598d7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1327,49 +1327,25 @@ static int qcom_geni_serial_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int __maybe_unused qcom_geni_serial_sys_suspend_noirq(struct device *dev)
+static int __maybe_unused qcom_geni_serial_sys_suspend(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
-	if (uart_console(uport)) {
-		uart_suspend_port(uport->private_data, uport);
-	} else {
-		struct uart_state *state = uport->state;
-		/*
-		 * If the port is open, deny system suspend.
-		 */
-		if (state->pm_state == UART_PM_STATE_ON)
-			return -EBUSY;
-	}
-
-	return 0;
+	return uart_suspend_port(uport->private_data, uport);
 }
 
-static int __maybe_unused qcom_geni_serial_sys_resume_noirq(struct device *dev)
+static int __maybe_unused qcom_geni_serial_sys_resume(struct device *dev)
 {
 	struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
 	struct uart_port *uport = &port->uport;
 
-	if (uart_console(uport) &&
-			console_suspend_enabled && uport->suspended) {
-		uart_resume_port(uport->private_data, uport);
-		/*
-		 * uart_suspend_port() invokes port shutdown which in turn
-		 * frees the irq. uart_resume_port invokes port startup which
-		 * performs request_irq. The request_irq auto-enables the IRQ.
-		 * In addition, resume_noirq implicitly enables the IRQ and
-		 * leads to an unbalanced IRQ enable warning. Disable the IRQ
-		 * before returning so that the warning is suppressed.
-		 */
-		disable_irq(uport->irq);
-	}
-	return 0;
+	return uart_resume_port(uport->private_data, uport);
 }
 
 static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend_noirq,
-					qcom_geni_serial_sys_resume_noirq)
+	SET_SYSTEM_SLEEP_PM_OPS(qcom_geni_serial_sys_suspend,
+					qcom_geni_serial_sys_resume)
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
