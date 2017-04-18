From: Alexey Ignatov <lexszero@gmail.com>
Subject: [PATCH 2/2] serial: imx: allow enabling RX during TX operation with DT option
Date: Tue, 18 Apr 2017 19:54:34 +0300
Message-ID: <20170418165434.21252-2-lexszero@gmail.com>
References: <20170418165434.21252-1-lexszero@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170418165434.21252-1-lexszero@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Alexey Ignatov <lexszero@gmail.com>
List-Id: linux-serial@vger.kernel.org

This commit changes the driver behaviour: new default is no RX during
TX when RS485 is also enabled, so boards requiring this should explicitly
enable rs485-rx-during-tx in their device trees.

Signed-off-by: Alexey Ignatov <lexszero@gmail.com>
---
 drivers/tty/serial/imx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 38c55c309953..a1d4ed71312f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2050,6 +2050,10 @@ static int serial_imx_probe_dt(struct imx_port *sport,
 
 	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
 		sport->port.rs485.flags |= SER_RS485_ENABLED;
+	
+	if (of_get_property(np, "rs485-rx-during-tx", NULL))
+		sport->port.rs485.flags |= SER_RS485_RX_DURING_TX;
+
 	return 0;
 }
 #else
@@ -2112,7 +2116,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.ops = &imx_pops;
 	sport->port.rs485_config = imx_rs485_config;
 	sport->port.rs485.flags |=
-		SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX;
+		SER_RS485_RTS_ON_SEND;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
-- 
2.12.2
