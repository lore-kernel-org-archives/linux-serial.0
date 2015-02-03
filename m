From: Sanjeev Sharma <sanjeev_sharma@mentor.com>
Subject: [PATCH] serial:imx make of_device_id array const
Date: Tue, 3 Feb 2015 16:16:06 +0530
Message-ID: <1422960366-12272-1-git-send-email-sanjeev_sharma@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
List-Id: linux-serial@vger.kernel.org

Make of_device_id array const.

Signed-off-by: Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0eb29b1..412bfbf 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -273,7 +273,7 @@ static struct platform_device_id imx_uart_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 
-static struct of_device_id imx_uart_dt_ids[] = {
+static const struct of_device_id imx_uart_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
 	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
 	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
-- 
1.7.11.7
