From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH] serial: imx: fix a possible NULL dereference
Date: Thu, 12 Nov 2015 08:46:21 +0100
Message-ID: <1447314381-31145-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/tty/serial/imx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 016e4be..22e91f7 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1857,8 +1857,7 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 		struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-			of_match_device(imx_uart_dt_ids, &pdev->dev);
+	const struct of_device_id *of_id;
 	int ret;
 
 	if (!np)
@@ -1878,6 +1877,9 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
+	of_id = of_match_device(imx_uart_dt_ids, &pdev->dev);
+	if (!of_id)
+		return -ENODEV;
 	sport->devdata = of_id->data;
 
 	return 0;
-- 
2.4.10
