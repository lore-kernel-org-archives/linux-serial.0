From: Pramod Gurav <gpramod@codeaurora.org>
Subject: [PATCH v2 2/2] tty: serial: msm: Disable pclk when port is closed
Date: Wed,  8 Apr 2015 18:58:53 +0530
Message-ID: <1428499733-21963-2-git-send-email-gpramod@codeaurora.org>
References: <1428499733-21963-1-git-send-email-gpramod@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428499733-21963-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz, Pramod Gurav <gpramod@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Disable the pclk when tty port is closed by user space.

Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 4c1e9ea..f38565c 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -523,6 +523,7 @@ static void msm_shutdown(struct uart_port *port)
 	msm_write(port, 0, UART_IMR); /* disable interrupts */
 
 	clk_disable_unprepare(msm_port->clk);
+	clk_disable_unprepare(msm_port->pclk);
 
 	free_irq(port->irq, port);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
