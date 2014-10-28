From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/2] serial: imx: add imx_poll_init()
Date: Tue, 28 Oct 2014 09:28:08 +0100
Message-ID: <1414484888-6229-2-git-send-email-dirk.behme@de.bosch.com>
References: <1414484888-6229-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:42801 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759397AbaJ1I2h (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Oct 2014 04:28:37 -0400
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id EF7FBD80223
	for <linux-serial@vger.kernel.org>; Tue, 28 Oct 2014 09:28:35 +0100 (CET)
Received: from localhost (vsgw21.fe.internet.bosch.com [10.4.98.19])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id E4ED11B80CFB
	for <linux-serial@vger.kernel.org>; Tue, 28 Oct 2014 09:28:35 +0100 (CET)
In-Reply-To: <1414484888-6229-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Huang Shijie <b32955@freescale.com>

From: Daniel Thompson <daniel.thompson@linaro.org>

For the console poll usage, .poll_init() will perform deeper hardware
initialization to ensure the serial port is always active.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Huang Shijie <b32955@freescale.com>
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/imx.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0b6f14b..6e772c7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1507,6 +1507,41 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
+
+static int imx_poll_init(struct uart_port *port)
+{
+	struct imx_port *sport = (struct imx_port *)port;
+	unsigned long flags;
+	unsigned long temp;
+	int retval;
+
+	retval = clk_prepare_enable(sport->clk_ipg);
+	if (retval)
+		return retval;
+	retval = clk_prepare_enable(sport->clk_per);
+	if (retval)
+		clk_disable_unprepare(sport->clk_ipg);
+
+	imx_setup_ufcr(sport, 0);
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+
+	temp = readl(sport->port.membase + UCR1);
+	if (is_imx1_uart(sport))
+		temp |= IMX1_UCR1_UARTCLKEN;
+	temp |= UCR1_UARTEN | UCR1_RRDYEN;
+	temp &= ~(UCR1_TXMPTYEN | UCR1_RTSDEN);
+	writel(temp, sport->port.membase + UCR1);
+
+	temp = readl(sport->port.membase + UCR2);
+	temp |= UCR2_RXEN;
+	writel(temp, sport->port.membase + UCR2);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	return 0;
+}
+
 static int imx_poll_get_char(struct uart_port *port)
 {
 	if (!(readl_relaxed(port->membase + USR2) & USR2_RDR))
@@ -1551,6 +1586,7 @@ static struct uart_ops imx_pops = {
 	.config_port	= imx_config_port,
 	.verify_port	= imx_verify_port,
 #if defined(CONFIG_CONSOLE_POLL)
+	.poll_init      = imx_poll_init,
 	.poll_get_char  = imx_poll_get_char,
 	.poll_put_char  = imx_poll_put_char,
 #endif
-- 
1.8.2

