From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 4/6] tty: serial: lpuart: add imx7ulp support
Date: Mon, 15 May 2017 15:48:57 +0800
Message-ID: <1494834539-17523-5-git-send-email-aisheng.dong@nxp.com>
References: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494834539-17523-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, dongas86@gmail.com, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
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
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v1->v2:
 * remove lpuart_reg_off according to Stefan's suggestion
---
 drivers/tty/serial/fsl_lpuart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index e72b397..a3ee825 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -231,6 +231,9 @@
 #define DEV_NAME	"ttyLP"
 #define UART_NR		6
 
+/* IMX lpuart has four extra unused regs located at the beginning */
+#define IMX_REG_OFF	0x10
+
 static bool lpuart_is_be;
 
 struct lpuart_port {
@@ -263,6 +266,7 @@ struct lpuart_port {
 struct lpuart_soc_data {
 	bool	is_32;
 	bool	is_be;
+	u8	reg_off;
 };
 
 static const struct lpuart_soc_data vf_data = {
@@ -272,11 +276,19 @@ static const struct lpuart_soc_data vf_data = {
 static const struct lpuart_soc_data ls_data = {
 	.is_32 = true,
 	.is_be = true,
+	.reg_off = 0x0,
+};
+
+static struct lpuart_soc_data imx_data = {
+	.is_32 = true,
+	.is_be = false,
+	.reg_off = IMX_REG_OFF,
 };
 
 static const struct of_device_id lpuart_dt_ids[] = {
 	{ .compatible = "fsl,vf610-lpuart", .data = &vf_data, },
 	{ .compatible = "fsl,ls1021a-lpuart", .data = &ls_data, },
+	{ .compatible = "fsl,imx7ulp-lpuart", .data = &imx_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lpuart_dt_ids);
@@ -2014,6 +2026,7 @@ static int lpuart_probe(struct platform_device *pdev)
 	if (IS_ERR(sport->port.membase))
 		return PTR_ERR(sport->port.membase);
 
+	sport->port.membase += sdata->reg_off;
 	sport->port.mapbase = res->start;
 	sport->port.dev = &pdev->dev;
 	sport->port.type = PORT_LPUART;
-- 
2.7.4
