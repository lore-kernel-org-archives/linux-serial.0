From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH V2 1/2] tty: serial: imx: add lock for registers save/restore
Date: Wed,  5 Sep 2018 09:24:26 +0800
Message-ID: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de
Cc: Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

In noirq suspend/resume stage with no_console_suspend enabled,
imx_uart_console_write() may be called to print out log_buf
message by printk(), so there will be race condition between
imx_uart_console_write() and imx_uart_save/restore_context(),
need to add lock to protect the registers save/restore operations.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/tty/serial/imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa..c15332d 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2376,8 +2376,13 @@ static int imx_uart_remove(struct platform_device *pdev)
 
 static void imx_uart_restore_context(struct imx_port *sport)
 {
-	if (!sport->context_saved)
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
+	if (!sport->context_saved) {
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 		return;
+	}
 
 	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
 	imx_uart_writel(sport, sport->saved_reg[5], UESC);
@@ -2390,11 +2395,15 @@ static void imx_uart_restore_context(struct imx_port *sport)
 	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
 	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
 	sport->context_saved = false;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_uart_save_context(struct imx_port *sport)
 {
+	unsigned long flags;
+
 	/* Save necessary regs */
+	spin_lock_irqsave(&sport->port.lock, flags);
 	sport->saved_reg[0] = imx_uart_readl(sport, UCR1);
 	sport->saved_reg[1] = imx_uart_readl(sport, UCR2);
 	sport->saved_reg[2] = imx_uart_readl(sport, UCR3);
@@ -2406,6 +2415,7 @@ static void imx_uart_save_context(struct imx_port *sport)
 	sport->saved_reg[8] = imx_uart_readl(sport, UBMR);
 	sport->saved_reg[9] = imx_uart_readl(sport, IMX21_UTS);
 	sport->context_saved = true;
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
-- 
2.7.4
