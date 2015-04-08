From: Pramod Gurav <gpramod@codeaurora.org>
Subject: [PATCH 1/2] tty: serial: msm: Add mask value for UART_DM registers
Date: Wed,  8 Apr 2015 18:43:13 +0530
Message-ID: <1428498794-20833-1-git-send-email-gpramod@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz, Pramod Gurav <gpramod@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

The bit masks for RFR_LEVEL1 and STALE_TIMEOUT_MSB values in MR1 and
IPR registers respectively are different for UART and UART_DM hardware
cores. We have been using UART core mask values for these. Add the same
for UART_DM core.

There is no bit setting as UART_IPR_RXSTALE_LAST for UART_DM core so do
it only for UART core.

Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
--

Changes since last version:
 - Added new macro fo UART_DM_MR1_AUTO_RFR_LEVEL1 instead of modifying existing.
 - Added a new macro for IPR register as it is also different in UART_DM
 - Changed subject line

---
 drivers/tty/serial/msm_serial.c | 19 +++++++++++++++----
 drivers/tty/serial/msm_serial.h |  2 ++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b73889c..4c1e9ea 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -432,8 +432,13 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud)
 	/* RX stale watermark */
 	rxstale = entry->rxstale;
 	watermark = UART_IPR_STALE_LSB & rxstale;
-	watermark |= UART_IPR_RXSTALE_LAST;
-	watermark |= UART_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
+	if (msm_port->is_uartdm)
+		watermark |= UART_DM_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
+	else {
+		watermark |= UART_IPR_RXSTALE_LAST;
+		watermark |= UART_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
+	}
+
 	msm_write(port, watermark, UART_IPR);
 
 	/* set RX watermark */
@@ -496,9 +501,15 @@ static int msm_startup(struct uart_port *port)
 
 	/* set automatic RFR level */
 	data = msm_read(port, UART_MR1);
-	data &= ~UART_MR1_AUTO_RFR_LEVEL1;
+	if (msm_port->is_uartdm) {
+		data &= ~UART_DM_MR1_AUTO_RFR_LEVEL1;
+		data |= UART_DM_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
+	} else {
+		data &= ~UART_MR1_AUTO_RFR_LEVEL1;
+		data |= UART_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
+	}
+
 	data &= ~UART_MR1_AUTO_RFR_LEVEL0;
-	data |= UART_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
 	data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
 	msm_write(port, data, UART_MR1);
 	return 0;
diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 3e1c713..caf5363 100644
--- a/drivers/tty/serial/msm_serial.h
+++ b/drivers/tty/serial/msm_serial.h
@@ -20,6 +20,7 @@
 
 #define UART_MR1_AUTO_RFR_LEVEL0	0x3F
 #define UART_MR1_AUTO_RFR_LEVEL1	0x3FF00
+#define UART_DM_MR1_AUTO_RFR_LEVEL1	0xFFFFFF00
 #define UART_MR1_RX_RDY_CTL    		(1 << 7)
 #define UART_MR1_CTS_CTL       		(1 << 6)
 
@@ -78,6 +79,7 @@
 #define UART_IPR_RXSTALE_LAST		0x20
 #define UART_IPR_STALE_LSB		0x1F
 #define UART_IPR_STALE_TIMEOUT_MSB	0x3FF80
+#define UART_DM_IPR_STALE_TIMEOUT_MSB	0xFFFFFF80
 
 #define UART_IPR	0x0018
 #define UART_TFWR	0x001C
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
