From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/6] tty: serial: lpuart: add little endian 32 bit register support
Date: Tue, 9 May 2017 15:50:44 +0800
Message-ID: <1494316248-24052-3-git-send-email-aisheng.dong@nxp.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

It's based on the exist lpuart32 read/write implementation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com> (supporter:TTY LAYER)
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index cd4e905..bddd041 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -231,6 +231,8 @@
 #define DEV_NAME	"ttyLP"
 #define UART_NR		6
 
+static bool lpuart_is_be;
+
 struct lpuart_port {
 	struct uart_port	port;
 	struct clk		*clk;
@@ -260,6 +262,7 @@ struct lpuart_port {
 
 struct lpuart_soc_data {
 	bool	is_32;
+	bool	is_be;
 };
 
 static struct lpuart_soc_data vf_data = {
@@ -268,6 +271,7 @@ static struct lpuart_soc_data vf_data = {
 
 static struct lpuart_soc_data ls_data = {
 	.is_32 = true,
+	.is_be = true,
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
@@ -282,12 +286,15 @@ static void lpuart_dma_tx_complete(void *arg);
 
 static u32 lpuart32_read(void __iomem *addr)
 {
-	return ioread32be(addr);
+	return lpuart_is_be ? ioread32be(addr) : readl(addr);
 }
 
 static void lpuart32_write(u32 val, void __iomem *addr)
 {
-	iowrite32be(val, addr);
+	if (lpuart_is_be)
+		iowrite32be(val, addr);
+	else
+		writel(val, addr);
 }
 
 static void lpuart_stop_tx(struct uart_port *port)
@@ -2000,6 +2007,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	}
 	sport->port.line = ret;
 	sport->lpuart32 = sdata->is_32;
+	lpuart_is_be = sdata->is_be;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4
