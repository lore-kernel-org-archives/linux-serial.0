From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH] serial: fsl_lpuart: Remove the alias node dependence
Date: Wed, 14 Dec 2016 16:33:32 +0800
Message-ID: <1481704412-19208-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, yao.yuan@nxp.com
List-Id: linux-serial@vger.kernel.org

From: Yuan Yao <yao.yuan@nxp.com>

Numbering the ttyLPn space should not depend on the generic name
"serial<n>".

If don't add the alias node like:"serial0 = &lpuart0;", then lpuart
will probe failed:
[    0.773410] fsl-lpuart 2950000.serial: failed to get alias id, errno -19

So remove the alias node dependence, and add the support for allocate the
line port automatically.

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index a1c6519..c6d639f 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -231,6 +231,8 @@
 #define DEV_NAME	"ttyLP"
 #define UART_NR		6
 
+static DECLARE_BITMAP(linemap, UART_NR);
+
 struct lpuart_port {
 	struct uart_port	port;
 	struct clk		*clk;
@@ -1963,9 +1965,13 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
-		return ret;
+		ret = find_first_zero_bit(linemap, UART_NR);
+		if (ret >= UART_NR) {
+			dev_err(&pdev->dev, "port line is full, add device failed\n");
+			return ret;
+		}
 	}
+	set_bit(ret, linemap);
 	sport->port.line = ret;
 	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
 
@@ -2047,6 +2053,7 @@ static int lpuart_remove(struct platform_device *pdev)
 	struct lpuart_port *sport = platform_get_drvdata(pdev);
 
 	uart_remove_one_port(&lpuart_reg, &sport->port);
+	clear_bit(sport->port.line, linemap);
 
 	clk_disable_unprepare(sport->clk);
 
-- 
2.1.0.27.g96db324
