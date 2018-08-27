From: jun qian <hangdianqj@163.com>
Subject: [PATCH] tty:serial:imx: use spin_lock instead of spin_lock_irqsave in isr
Date: Mon, 27 Aug 2018 07:49:04 -0700
Message-ID: <20180827144904.17226-1-hangdianqj@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Barry song <21cnbao@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>
List-Id: linux-serial@vger.kernel.org

Before the program enters the uart ISR, the local interrupt has been
disabled by the system, so it's not appropriate to use spin_lock_irqsave
interface in the ISR.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/tty/serial/imx.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 239c0fa2e981..3069ee93583e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -706,27 +706,25 @@ static irqreturn_t imx_uart_rtsint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
 	u32 usr1;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
 	uart_handle_cts_change(&sport->port, !!usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 	return IRQ_HANDLED;
 }
 
 static irqreturn_t imx_uart_txint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 	imx_uart_transmit_buffer(sport);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 	return IRQ_HANDLED;
 }
 
@@ -735,9 +733,8 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	unsigned int rx, flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	spin_lock(&sport->port.lock);
 
 	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
 		u32 usr2;
@@ -797,7 +794,7 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	}
 
 out:
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	spin_unlock(&sport->port.lock);
 	tty_flip_buffer_push(port);
 	return IRQ_HANDLED;
 }
@@ -903,13 +900,11 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 	}
 
 	if (usr1 & USR1_DTRD) {
-		unsigned long flags;
-
 		imx_uart_writel(sport, USR1_DTRD, USR1);
 
-		spin_lock_irqsave(&sport->port.lock, flags);
+		spin_lock(&sport->port.lock);
 		imx_uart_mctrl_check(sport);
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		spin_unlock(&sport->port.lock);
 
 		ret = IRQ_HANDLED;
 	}
-- 
2.17.1
