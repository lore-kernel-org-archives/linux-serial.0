From: Pramod Gurav <gpramod@codeaurora.org>
Subject: [PATCH v3 2/3] tty: serial: msm: Remove duplicate operations on clocks in startup/shutdown
Date: Fri, 10 Apr 2015 17:49:55 +0530
Message-ID: <1428668396-6955-2-git-send-email-gpramod@codeaurora.org>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz, Pramod Gurav <gpramod@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

clk_prepare_enable/clk_disable_unprepare is already done in .pm
function of uart_ops hence get rid of them from msm_startup and
msm_shutdown.

Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
---
Changes since last version:
 - Decided to drop calls to clk operations

 drivers/tty/serial/msm_serial.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 99aba04..c32b088 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -494,8 +494,6 @@ static int msm_startup(struct uart_port *port)
 	if (unlikely(ret))
 		return ret;
 
-	msm_init_clock(port);
-
 	if (likely(port->fifosize > 12))
 		rfr_level = port->fifosize - 12;
 	else
@@ -525,8 +523,6 @@ static void msm_shutdown(struct uart_port *port)
 	msm_port->imr = 0;
 	msm_write(port, 0, UART_IMR); /* disable interrupts */
 
-	clk_disable_unprepare(msm_port->clk);
-
 	free_irq(port->irq, port);
 }
 
@@ -683,8 +679,7 @@ static void msm_power(struct uart_port *port, unsigned int state,
 
 	switch (state) {
 	case 0:
-		clk_prepare_enable(msm_port->clk);
-		clk_prepare_enable(msm_port->pclk);
+		msm_init_clock(port);
 		break;
 	case 3:
 		clk_disable_unprepare(msm_port->clk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
