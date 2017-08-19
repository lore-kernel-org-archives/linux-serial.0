From: <sean.wang@mediatek.com>
Subject: [PATCH v2 2/2] serial: 8250: of: Add new port type for MediaTek BTIF controller on MT7622/23 SoC
Date: Sun, 20 Aug 2017 02:03:30 +0800
Message-ID: <c2696f6a17ca5914098ad1da394834f8b4b30141.1503165144.git.sean.wang@mediatek.com>
References: <cover.1503165144.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1503165144.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, robert.jarzmik@free.fr, arnd@arndb.de, p.zabel@pengutronix.de, joel@jms.id.au, david@lechnology.com, jan.kiszka@siemens.com, heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com, matthias.bgg@gmail.com, tthayer@opensource.altera.com
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-serial@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

MediaTek BTIF controller is the serial interface similar to UART but it
works only as the digital device which is mainly used to communicate with
the connectivity module called CONNSYS inside the SoC which could be mostly
found on those MediaTek SoCs with Bluetooth feature such as MT7622 and
MT7623 SoCs.

And the controller is made as being compatible with the 8250 register
layout with extra registers such as DMA enablement so it tends to be
integrated with reusing 8250 OF driver. However, DMA mode is not being
supported yet in the current driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_of.c   | 2 ++
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 include/uapi/linux/serial_core.h    | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 6c5a8ca..47d4772 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -300,6 +300,8 @@ static const struct of_device_id of_platform_serial_table[] = {
 		.data = (void *)PORT_ALTR_16550_F64, },
 	{ .compatible = "altr,16550-FIFO128",
 		.data = (void *)PORT_ALTR_16550_F128, },
+	{ .compatible = "mediatek,mt7623-btif",
+		.data = (void *)PORT_MTK_BTIF, },
 	{ .compatible = "mrvl,mmp-uart",
 		.data = (void *)PORT_XSCALE, },
 	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 25aae66..053bb38 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -289,6 +289,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 4, 8, 14},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_MTK_BTIF] = {
+		.name		= "MediaTek BTIF",
+		.fifo_size	= 16,
+		.tx_loadsz	= 16,
+		.fcr		= UART_FCR_ENABLE_FIFO |
+				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 38bea32..cfc07a5 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -272,4 +272,7 @@
 /* MPS2 UART */
 #define PORT_MPS2UART	116
 
+/* MediaTek BTIF */
+#define PORT_MTK_BTIF	117
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.7.4
