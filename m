From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V3 5/7] tty: serial: lpuart: add imx7ulp support
Date: Mon, 12 Jun 2017 23:37:26 +0800
Message-ID: <1497281848-12995-6-git-send-email-aisheng.dong@nxp.com>
References: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497281848-12995-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: nikita.yoush@cogentembedded.com, Dong Aisheng <aisheng.dong@nxp.com>, fugang.duan@nxp.com, dongas86@gmail.com, gregkh@linuxfoundation.org, yangbo.lu@nxp.com, linux-kernel@vger.kernel.org, stefan@agner.ch, andy.shevchenko@gmail.com, Mingkai.Hu@nxp.com, jslaby@suse.com, linux-arm-kernel@lists.infradead.org
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
v2->v3:
 * use standard port->iotype to represent the endians.
v1->v2:
 * remove lpuart_reg_off according to Stefan's suggestion
---
 drivers/tty/serial/fsl_lpuart.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index bbf47a0..9d05e53 100644
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
@@ -267,12 +271,17 @@ static const struct lpuart_soc_data vf_data = {
 
 static const struct lpuart_soc_data ls_data = {
 	.iotype = UPIO_MEM32BE,
+};
 
+static struct lpuart_soc_data imx_data = {
+	.iotype = UPIO_MEM32,
+	.reg_off = IMX_REG_OFF,
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,vf610-lpuart",	.data = &vf_data, },
 	{ .compatible = "fsl,ls1021a-lpuart",	.data = &ls_data, },
+	{ .compatible = "fsl,imx7ulp-lpuart",	.data = &imx_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -2020,6 +2029,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (IS_ERR(sport->port.membase))
 		return PTR_ERR(sport->port.membase);
 
+	sport->port.membase += sdata->reg_off;
 	sport->port.mapbase = res->start;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
-- 
2.7.4
