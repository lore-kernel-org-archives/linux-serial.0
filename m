From: Mayank Rana <mrana@codeaurora.org>
Subject: [PATCH 2/2] msm_serial_hs: Fix spinlock recursion in handling CTS
Date: Thu,  8 Dec 2011 09:06:09 +0530
Message-ID: <1323315369-19260-2-git-send-email-mrana@codeaurora.org>
References: <1323315369-19260-1-git-send-email-mrana@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:48432 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092Ab1LHDhs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 7 Dec 2011 22:37:48 -0500
In-Reply-To: <1323315369-19260-1-git-send-email-mrana@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@suse.de
Cc: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, imirkin@alum.mit.edu, npelly@google.com, Mayank Rana <mrana@codeaurora.org>

msm_hs_handle_delta_cts tries to acquire port->lock already acquired
by the callee function msm_hs_isr. Change function name to follow
"_locked" convention.

Signed-off-by: Mayank Rana <mrana@codeaurora.org>
---
 drivers/tty/serial/msm_serial_hs.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/msm_serial_hs.c b/drivers/tty/serial/msm_serial_hs.c
index f1d5695..ec16037 100644
--- a/drivers/tty/serial/msm_serial_hs.c
+++ b/drivers/tty/serial/msm_serial_hs.c
@@ -1085,12 +1085,10 @@ static void msm_hs_config_port(struct uart_port *uport, int cfg_flags)
 }
 
 /*  Handle CTS changes (Called from interrupt handler) */
-static void msm_hs_handle_delta_cts(struct uart_port *uport)
+static void msm_hs_handle_delta_cts_locked(struct uart_port *uport)
 {
-	unsigned long flags;
 	struct msm_hs_port *msm_uport = UARTDM_TO_MSM(uport);
 
-	spin_lock_irqsave(&uport->lock, flags);
 	clk_enable(msm_uport->clk);
 
 	/* clear interrupt */
@@ -1098,7 +1096,6 @@ static void msm_hs_handle_delta_cts(struct uart_port *uport)
 	uport->icount.cts++;
 
 	clk_disable(msm_uport->clk);
-	spin_unlock_irqrestore(&uport->lock, flags);
 
 	/* clear the IOCTL TIOCMIWAIT if called */
 	wake_up_interruptible(&uport->state->port.delta_msr_wait);
@@ -1246,7 +1243,7 @@ static irqreturn_t msm_hs_isr(int irq, void *dev)
 
 	/* Change in CTS interrupt */
 	if (isr_status & UARTDM_ISR_DELTA_CTS_BMSK)
-		msm_hs_handle_delta_cts(uport);
+		msm_hs_handle_delta_cts_locked(uport);
 
 	spin_unlock_irqrestore(&uport->lock, flags);
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

