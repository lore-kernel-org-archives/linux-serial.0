From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH v2 1/1] serial: imx: fix a possible NULL dereference
Date: Tue, 24 Nov 2015 15:36:57 +0100
Message-ID: <1448375817-16189-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1448375817-16189-1-git-send-email-clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448375817-16189-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: LABBE Corentin <clabbe.montjoie@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.
Even if the probability of this case is very low, fixing it made
static analyzers happy.
Solving this with of_device_get_match_data made also code simplier.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/tty/serial/imx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 016e4be..76818f5 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1857,11 +1857,10 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 		struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *of_id =
-			of_match_device(imx_uart_dt_ids, &pdev->dev);
 	int ret;
 
-	if (!np)
+	sport->devdata = of_device_get_match_data(&pdev->dev);
+	if (!sport->devdata)
 		/* no device tree device */
 		return 1;
 
@@ -1878,8 +1877,6 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
-	sport->devdata = of_id->data;
-
 	return 0;
 }
 #else
-- 
2.4.10
