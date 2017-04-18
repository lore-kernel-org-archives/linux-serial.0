From: Alexey Ignatov <lexszero@gmail.com>
Subject: [PATCH 1/2] serial: imx: support enabling rs485 at boot time with DT option
Date: Tue, 18 Apr 2017 19:54:33 +0300
Message-ID: <20170418165434.21252-1-lexszero@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexey Ignatov <lexszero@gmail.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Alexey Ignatov <lexszero@gmail.com>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a70356dad1b7..38c55c309953 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2048,6 +2048,8 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 	if (of_get_property(np, "fsl,dte-mode", NULL))
 		sport->dte_mode = 1;
 
+	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
+		sport->port.rs485.flags |= SER_RS485_ENABLED;
 	return 0;
 }
 #else
@@ -2109,7 +2111,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.fifosize = 32;
 	sport->port.ops = &imx_pops;
 	sport->port.rs485_config = imx_rs485_config;
-	sport->port.rs485.flags =
+	sport->port.rs485.flags |=
 		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	init_timer(&sport->timer);
-- 
2.12.2
