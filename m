From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/6] tty: serial: lpuart: introduce lpuart_soc_data to
 represent SoC property
Date: Tue, 9 May 2017 15:50:43 +0800
Message-ID: <1494316248-24052-2-git-send-email-aisheng.dong@nxp.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, fugang.duan@nxp.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This is used to dynamically check the SoC specific lpuart properies.
Currently only the checking of 32 bit register width is added which
functions the same as before. More will be added later for supporting
new chips.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 15df1ba7..cd4e905 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -258,13 +258,21 @@ struct lpuart_port {
 	wait_queue_head_t	dma_wait;
 };
 
+struct lpuart_soc_data {
+	bool	is_32;
+};
+
+static struct lpuart_soc_data vf_data = {
+	.is_32 = false,
+};
+
+static struct lpuart_soc_data ls_data = {
+	.is_32 = true,
+};
+
 static const struct of_device_id lpuart_dt_ids[] = {
-	{
-		.compatible = "fsl,vf610-lpuart",
-	},
-	{
-		.compatible = "fsl,ls1021a-lpuart",
-	},
+	{ .compatible = "fsl,vf610-lpuart", .data = &vf_data, },
+	{ .compatible = "fsl,ls1021a-lpuart", .data = &ls_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -1971,6 +1979,9 @@ static struct uart_driver lpuart_reg = {
 
 static int lpuart_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id = of_match_device(lpuart_dt_ids,
+							   &pdev->dev);
+	const struct lpuart_soc_data *sdata = of_id->data;
 	struct device_node *np = pdev->dev.of_node;
 	struct lpuart_port *sport;
 	struct resource *res;
@@ -1988,7 +1999,7 @@ static int lpuart_probe(struct platform_device *pdev)
 		return ret;
 	}
 	sport->port.line = ret;
-	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
+	sport->lpuart32 = sdata->is_32;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4
