From: David Brown <davidb@codeaurora.org>
Subject: [RFC PATCH 34/34] msm_serial: fix clock rate on DMA-based uarts
Date: Wed,  2 Nov 2011 11:36:31 -0700
Message-ID: <1320258991-22325-35-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The driver explicitly requests a clock rate for the UART, but it is
off by a factor of four from the dividers that it programs into the
UART.  Fix this by setting the rate to 1/4 of the current value.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 29cbfd8..b7baceb 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -891,7 +891,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 			return PTR_ERR(msm_port->clk);
 
 	if (msm_port->is_uartdm)
-		clk_set_rate(msm_port->clk, 7372800);
+		clk_set_rate(msm_port->clk, 1843200);
 
 	port->uartclk = clk_get_rate(msm_port->clk);
 	printk(KERN_INFO "uartclk = %d\n", port->uartclk);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
