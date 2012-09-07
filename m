From: David Brown <davidb@codeaurora.org>
Subject: [PATCH] msm_serial: fix clock rate on DMA-based uarts
Date: Fri,  7 Sep 2012 14:45:03 -0700
Message-ID: <1347054303-5643-1-git-send-email-davidb@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:22917 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2IGVpZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 17:45:25 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alan Cox <alan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

The driver explicitly requests a clock rate for the UART, but it is
off by a factor of four from the dividers that it programs into the
UART.  Fix this by setting the rate to 1/4 of the current value.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 8131e2c..033e0bc 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -896,7 +896,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 			return PTR_ERR(msm_port->clk);
 
 	if (msm_port->is_uartdm)
-		clk_set_rate(msm_port->clk, 7372800);
+		clk_set_rate(msm_port->clk, 1843200);
 
 	port->uartclk = clk_get_rate(msm_port->clk);
 	printk(KERN_INFO "uartclk = %d\n", port->uartclk);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation

