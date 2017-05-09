From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 5/6] tty: serial: lpuart: add earlycon support for imx7ulp
Date: Tue, 9 May 2017 15:50:47 +0800
Message-ID: <1494316248-24052-6-git-send-email-aisheng.dong@nxp.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, fugang.duan@nxp.com, stefan@agner.ch, Mingkai.Hu@nxp.com, yangbo.lu@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>
List-Id: linux-serial@vger.kernel.org

earlycon is executed quite early before the device tree probe,
so we need configure the correct reg_off for imx7ulp during
early console setup.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Fugang Duan <fugang.duan@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1cdb3f9..5b485e8 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1978,8 +1978,20 @@ static int __init lpuart32_early_console_setup(struct earlycon_device *device,
 	return 0;
 }
 
+static int __init lpuart32_imx_early_console_setup(struct earlycon_device *device,
+						   const char *opt)
+{
+	if (!device->port.membase)
+		return -ENODEV;
+
+	lpuart_reg_off = IMX_REG_OFF;
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
