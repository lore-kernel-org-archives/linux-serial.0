From: Pramod Gurav <gpramod@codeaurora.org>
Subject: [PATCH v3 3/3] tty: serial: msm: replaces (1 << x) with BIT(x) macro
Date: Fri, 10 Apr 2015 17:49:56 +0530
Message-ID: <1428668396-6955-3-git-send-email-gpramod@codeaurora.org>
References: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428668396-6955-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz, Pramod Gurav <gpramod@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

Replaces (1 << x) with BIT(x) macro

Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
---
This is a new patch added in this series.

 drivers/tty/serial/msm_serial.h | 58 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index caf5363..f663822 100644
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
@@ -41,8 +41,8 @@
 
 #define UART_CSR			0x0008
 
-#define UART_TF		0x000C
-#define UARTDM_TF	0x0070
+#define UART_TF				0x000C
+#define UARTDM_TF			0x0070
 
 #define UART_CR				0x0010
 #define UART_CR_CMD_NULL		(0 << 4)
@@ -62,29 +62,29 @@
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
 
-#define UART_IMR		0x0014
-#define UART_IMR_TXLEV		(1 << 0)
-#define UART_IMR_RXSTALE	(1 << 3)
-#define UART_IMR_RXLEV		(1 << 4)
-#define UART_IMR_DELTA_CTS	(1 << 5)
-#define UART_IMR_CURRENT_CTS	(1 << 6)
-#define UART_IMR_RXBREAK_START	(1 << 10)
+#define UART_IMR			0x0014
+#define UART_IMR_TXLEV			BIT(0)
+#define UART_IMR_RXSTALE		BIT(3)
+#define UART_IMR_RXLEV			BIT(4)
+#define UART_IMR_DELTA_CTS		BIT(5)
+#define UART_IMR_CURRENT_CTS		BIT(6)
+#define UART_IMR_RXBREAK_START		BIT(10)
 
 #define UART_IPR_RXSTALE_LAST		0x20
 #define UART_IPR_STALE_LSB		0x1F
 #define UART_IPR_STALE_TIMEOUT_MSB	0x3FF80
 #define UART_DM_IPR_STALE_TIMEOUT_MSB	0xFFFFFF80
 
-#define UART_IPR	0x0018
-#define UART_TFWR	0x001C
-#define UART_RFWR	0x0020
-#define UART_HCR	0x0024
+#define UART_IPR		0x0018
+#define UART_TFWR		0x001C
+#define UART_RFWR		0x0020
+#define UART_HCR		0x0024
 
 #define UART_MREG		0x0028
 #define UART_NREG		0x002C
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
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
