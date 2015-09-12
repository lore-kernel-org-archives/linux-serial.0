From: "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/7] tty: serial: msm: replaces (1 << x) with BIT(x) macro
Date: Sat, 12 Sep 2015 16:02:09 +0300
Message-ID: <1442062934-13449-3-git-send-email-ivan.ivanov@linaro.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442062934-13449-1-git-send-email-ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Pramod Gurav <gpramod-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Frank Rowand <frank.rowand-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Pramod Gurav <gpramod-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Replaces (1 << x) with BIT(x) macro

Signed-off-by: Pramod Gurav <gpramod-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Reviewed-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Ivan T. Ivanov <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/msm_serial.h | 44 ++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 5b7722c3938b..60917d30c6b5 100644
--- a/drivers/tty/serial/msm_serial.h
+++ b/drivers/tty/serial/msm_serial.h
@@ -21,11 +21,11 @@
 #define UART_MR1_AUTO_RFR_LEVEL0	0x3F
 #define UART_MR1_AUTO_RFR_LEVEL1	0x3FF00
 #define UART_DM_MR1_AUTO_RFR_LEVEL1	0xFFFFFF00
-#define UART_MR1_RX_RDY_CTL    		(1 << 7)
-#define UART_MR1_CTS_CTL       		(1 << 6)
+#define UART_MR1_RX_RDY_CTL		BIT(7)
+#define UART_MR1_CTS_CTL		BIT(6)

 #define UART_MR2			0x0004
-#define UART_MR2_ERROR_MODE		(1 << 6)
+#define UART_MR2_ERROR_MODE		BIT(6)
 #define UART_MR2_BITS_PER_CHAR		0x30
 #define UART_MR2_BITS_PER_CHAR_5	(0x0 << 4)
 #define UART_MR2_BITS_PER_CHAR_6	(0x1 << 4)
@@ -62,19 +62,19 @@
 #define UART_CR_CMD_STALE_EVENT_ENABLE	(80 << 4)
 #define UART_CR_CMD_FORCE_STALE		(4 << 8)
 #define UART_CR_CMD_RESET_TX_READY	(3 << 8)
-#define UART_CR_TX_DISABLE		(1 << 3)
-#define UART_CR_TX_ENABLE		(1 << 2)
-#define UART_CR_RX_DISABLE		(1 << 1)
-#define UART_CR_RX_ENABLE		(1 << 0)
+#define UART_CR_TX_DISABLE		BIT(3)
+#define UART_CR_TX_ENABLE		BIT(2)
+#define UART_CR_RX_DISABLE		BIT(1)
+#define UART_CR_RX_ENABLE		BIT(0)
 #define UART_CR_CMD_RESET_RXBREAK_START	((1 << 11) | (2 << 4))

 #define UART_IMR		0x0014
-#define UART_IMR_TXLEV		(1 << 0)
-#define UART_IMR_RXSTALE	(1 << 3)
-#define UART_IMR_RXLEV		(1 << 4)
-#define UART_IMR_DELTA_CTS	(1 << 5)
-#define UART_IMR_CURRENT_CTS	(1 << 6)
-#define UART_IMR_RXBREAK_START	(1 << 10)
+#define UART_IMR_TXLEV			BIT(0)
+#define UART_IMR_RXSTALE		BIT(3)
+#define UART_IMR_RXLEV			BIT(4)
+#define UART_IMR_DELTA_CTS		BIT(5)
+#define UART_IMR_CURRENT_CTS		BIT(6)
+#define UART_IMR_RXBREAK_START		BIT(10)

 #define UART_IPR_RXSTALE_LAST		0x20
 #define UART_IPR_STALE_LSB		0x1F
@@ -98,20 +98,20 @@
 #define UART_TEST_CTRL		0x0050

 #define UART_SR			0x0008
-#define UART_SR_HUNT_CHAR	(1 << 7)
-#define UART_SR_RX_BREAK	(1 << 6)
-#define UART_SR_PAR_FRAME_ERR	(1 << 5)
-#define UART_SR_OVERRUN		(1 << 4)
-#define UART_SR_TX_EMPTY	(1 << 3)
-#define UART_SR_TX_READY	(1 << 2)
-#define UART_SR_RX_FULL		(1 << 1)
-#define UART_SR_RX_READY	(1 << 0)
+#define UART_SR_HUNT_CHAR	BIT(7)
+#define UART_SR_RX_BREAK	BIT(6)
+#define UART_SR_PAR_FRAME_ERR	BIT(5)
+#define UART_SR_OVERRUN		BIT(4)
+#define UART_SR_TX_EMPTY	BIT(3)
+#define UART_SR_TX_READY	BIT(2)
+#define UART_SR_RX_FULL		BIT(1)
+#define UART_SR_RX_READY	BIT(0)

 #define UART_RF			0x000C
 #define UARTDM_RF		0x0070
 #define UART_MISR		0x0010
 #define UART_ISR		0x0014
-#define UART_ISR_TX_READY	(1 << 7)
+#define UART_ISR_TX_READY	BIT(7)

 #define UARTDM_RXFS		0x50
 #define UARTDM_RXFS_BUF_SHIFT	0x7
--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
