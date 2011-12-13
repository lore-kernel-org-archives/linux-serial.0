From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v5] tty: serial: imx: Allow UART to be a source for wakeup
Date: Tue, 13 Dec 2011 01:23:48 -0200
Message-ID: <1323746628-25163-1-git-send-email-festevam@gmail.com>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40924 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab1LMDYA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Dec 2011 22:24:00 -0500
Received: by yhr47 with SMTP id 47so64793yhr.19
        for <linux-serial@vger.kernel.org>; Mon, 12 Dec 2011 19:23:59 -0800 (PST)
In-Reply-To: <1323434541-27689-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, shawn.guo@freescale.com, alan@linux.intel.com, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Allow UART to be a source for wakeup from low power mode.

Tested on a MX27PDK by doing:

echo enabled > /sys/devices/platform/imx21-uart.0/tty/ttymxc0/power/wakeup

echo mem > /sys/power/state

and then pressing a key in the console will wakeup the sytem.

Suggested-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v4:
- Let serial core handle device_init_wakeup/device_set_wakeup_enable.
Changes since v3:
- Remove IMXUART_CANWAKE flag. Let userspace write in /sys/ file
in order to enable UART wakeup source.
Changes since v2:
- Remove incorrect enable_irq_wake from serial_imx_resume
Changes since v1:
- Pass the can-wake property via DT correctly
 drivers/tty/serial/imx.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..0022bbd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -566,6 +566,9 @@ static irqreturn_t imx_int(int irq, void *dev_id)
 	if (sts & USR1_RTSD)
 		imx_rtsint(irq, dev_id);
 
+	if (sts & USR1_AWAKE)
+		writel(USR1_AWAKE, sport->port.membase + USR1);
+
 	return IRQ_HANDLED;
 }
 
@@ -1269,6 +1272,12 @@ static struct uart_driver imx_reg = {
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 {
 	struct imx_port *sport = platform_get_drvdata(dev);
+	unsigned int val;
+
+	/* enable wakeup from i.MX UART */
+	val = readl(sport->port.membase + UCR3);
+	val |= UCR3_AWAKEN;
+	writel(val, sport->port.membase + UCR3);
 
 	if (sport)
 		uart_suspend_port(&imx_reg, &sport->port);
@@ -1279,7 +1288,13 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 static int serial_imx_resume(struct platform_device *dev)
 {
 	struct imx_port *sport = platform_get_drvdata(dev);
+	unsigned int val;
 
+	/* disable wakeup from i.MX UART */
+	val = readl(sport->port.membase + UCR3);
+	val &= ~UCR3_AWAKEN;
+	writel(val, sport->port.membase + UCR3);
+
 	if (sport)
 		uart_resume_port(&imx_reg, &sport->port);
 
-- 
1.7.1

