From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 2/4] serial: mxs: Constify platform_device_id
Date: Sat,  2 May 2015 00:40:03 +0900
Message-ID: <1430494805-30906-2-git-send-email-k.kozlowski.k@gmail.com>
References: <1430494805-30906-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430494805-30906-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-serial@vger.kernel.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index f7e5825b55ab..13cf7738fbdc 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -169,7 +169,7 @@ struct mxs_auart_port {
 	bool			ms_irq_enabled;
 };
 
-static struct platform_device_id mxs_auart_devtype[] = {
+static const struct platform_device_id mxs_auart_devtype[] = {
 	{ .name = "mxs-auart-imx23", .driver_data = IMX23_AUART },
 	{ .name = "mxs-auart-imx28", .driver_data = IMX28_AUART },
 	{ /* sentinel */ }
-- 
2.1.4
