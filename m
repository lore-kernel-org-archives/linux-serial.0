From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 1/4] serial: imx: Constify platform_device_id
Date: Sat,  2 May 2015 00:40:02 +0900
Message-ID: <1430494805-30906-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-serial@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index c8cfa0637128..fca20d595037 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -239,7 +239,7 @@ static struct imx_uart_data imx_uart_devdata[] = {
 	},
 };
 
-static struct platform_device_id imx_uart_devtype[] = {
+static const struct platform_device_id imx_uart_devtype[] = {
 	{
 		.name = "imx1-uart",
 		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX1_UART],
-- 
2.1.4
