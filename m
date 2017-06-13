From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 5/7] tty: serial: lpuart: add imx7ulp support
Date: Tue, 13 Jun 2017 10:55:52 +0800
Message-ID: <1497322554-24463-6-git-send-email-aisheng.dong@nxp.com>
References: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, nikita.yoush@cogentembedded.com, andy.shevchenko@gmail.com, dongas86@gmail.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

The lpuart of imx7ulp is basically the same as ls1021a. It's also
32 bit width register, but unlike ls1021a, it's little endian.
Besides that, imx7ulp lpuart has a minor different register layout
from ls1021a that it has four extra registers (verid, param, global,
pincfg) located at the beginning of register map, which are currently
not used by the driver and less to be used later.

To ease the register difference handling, we add a reg_off member
in lpuart_soc_data structure to represent if the normal
lpuart32_{read|write} requires plus a offset to hide the issue.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Cc: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * No changes
v2->v3:
 * use standard port->iotype to represent the endians.
v1->v2:
 * remove lpuart_reg_off according to Stefan's suggestion
---
 drivers/tty/serial/fsl_lpuart.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ed0bf18..9486333 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -231,6 +231,9 @@
 #define DEV_NAME	"ttyLP"
 #define UART_NR		6
 
+/* IMX lpuart has four extra unused regs located at the beginning */
+#define IMX_REG_OFF	0x10
+
 struct lpuart_port {
 	struct uart_port	port;
 	struct clk		*clk;
@@ -259,6 +262,7 @@ struct lpuart_port {
 
 struct lpuart_soc_data {
 	char	iotype;
+	u8	reg_off;
 };
 
 static const struct lpuart_soc_data vf_data = {
@@ -269,9 +273,15 @@ static const struct lpuart_soc_data ls_data = {
 	.iotype = UPIO_MEM32BE,
 };
 
+static struct lpuart_soc_data imx_data = {
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
+};
+
 static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,vf610-lpuart",	.data = &vf_data, },
 	{ .compatible = "fsl,ls1021a-lpuart",	.data = &ls_data, },
+	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -2019,6 +2029,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (IS_ERR(sport->port.membase))
 		return PTR_ERR(sport->port.membase);
 
+	sport->port.membase += sdata->reg_off;
 	sport->port.mapbase = res->start;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
-- 
2.7.4
