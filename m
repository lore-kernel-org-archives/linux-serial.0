From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH] serial: sprd: Add loopback function support
Date: Wed, 21 Aug 2019 20:39:09 +0800
Message-ID: <1275cd9968f1ceb5ac049cc23f1e508025cd552f.1566375260.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, cixi.geng@unisoc.com, lanqing.liu@unisoc.com, baolin.wang@linaro.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Add loopback function support for Spreadtrum serial controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4..85fc57c 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -79,6 +79,7 @@
 /* control register 1 */
 #define SPRD_CTL1		0x001C
 #define SPRD_DMA_EN		BIT(15)
+#define SPRD_LOOPBACK_EN	BIT(14)
 #define RX_HW_FLOW_CTL_THLD	BIT(6)
 #define RX_HW_FLOW_CTL_EN	BIT(7)
 #define TX_HW_FLOW_CTL_EN	BIT(8)
@@ -164,7 +165,14 @@ static unsigned int sprd_get_mctrl(struct uart_port *port)
 
 static void sprd_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	/* nothing to do */
+	u32 val = serial_in(port, SPRD_CTL1);
+
+	if (mctrl & TIOCM_LOOP)
+		val |= SPRD_LOOPBACK_EN;
+	else
+		val &= ~SPRD_LOOPBACK_EN;
+
+	serial_out(port, SPRD_CTL1, val);
 }
 
 static void sprd_stop_rx(struct uart_port *port)
-- 
1.7.9.5
