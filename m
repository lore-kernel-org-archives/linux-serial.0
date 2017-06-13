From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 6/7] tty: serial: lpuart: add earlycon support for imx7ulp
Date: Tue, 13 Jun 2017 10:55:53 +0800
Message-ID: <1497322554-24463-7-git-send-email-aisheng.dong@nxp.com>
References: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497322554-24463-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, nikita.yoush@cogentembedded.com, andy.shevchenko@gmail.com, dongas86@gmail.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

earlycon is executed quite early before the device tree probe,
so we need correctly initialize the port membase and iotype for
imx7ulp during early console setup before using.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
Change Log:
v3->v4:
 * No changes
v2->v3:
 * use standard port->iotype to represent endians
v1->v2:
 * updated due to lpuart_reg_off removed
---
 drivers/tty/serial/fsl_lpuart.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 9486333..a0f2666 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1982,8 +1982,21 @@ static int __init lpuart32_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 
+static int __init lpuart32_imx_early_console_setup(struct earlycon_device *device,
+						   const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	device->port.iotype = UPIO_MEM32;
+	device->port.membase += IMX_REG_OFF;
+	device->con->write = lpuart32_early_write;
+
+	return 0;
+}
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);
 
-- 
2.7.4
