From: Jingchang Lu <jingchang.lu@freescale.com>
Subject: [PATCH] serial: fsl-lpuart: add lpuart32 power management support
Date: Fri, 24 Oct 2014 17:20:49 +0800
Message-ID: <1414142449-22907-1-git-send-email-jingchang.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-by2on0123.outbound.protection.outlook.com ([207.46.100.123]:62842
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755955AbaJXKJK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Oct 2014 06:09:10 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jingchang Lu <jingchang.lu@freescale.com>

This adds 32-bit register lpuart32 power management support,
this also updates the 8-bit register lpuart resume function.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6dd53af..4e25772 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1862,6 +1862,20 @@ static int lpuart_suspend(struct device *dev)
 static int lpuart_resume(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
+	unsigned long temp;
+
+	if (sport->lpuart32) {
+		lpuart32_setup_watermark(sport);
+		temp = lpuart32_read(sport->port.membase + UARTCTRL);
+		temp |= (UARTCTRL_RIE | UARTCTRL_TIE | UARTCTRL_RE |
+			 UARTCTRL_TE | UARTCTRL_ILIE);
+		lpuart32_write(temp, sport->port.membase + UARTCTRL);
+	} else {
+		lpuart_setup_watermark(sport);
+		temp = readb(sport->port.membase + UARTCR2);
+		temp |= (UARTCR2_RIE | UARTCR2_TIE | UARTCR2_RE | UARTCR2_TE);
+		writeb(temp, sport->port.membase + UARTCR2);
+	}
 
 	uart_resume_port(&lpuart_reg, &sport->port);
 
-- 
1.8.0

