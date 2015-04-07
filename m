From: Pramod Gurav <gpramod@codeaurora.org>
Subject: [PATCH] tty: serial: msm: Fix mask value of RFR level
Date: Tue,  7 Apr 2015 19:17:26 +0530
Message-ID: <1428414446-21282-1-git-send-email-gpramod@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz, Pramod Gurav <gpramod@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

According to documents The RFR_LEVEL1 in UART_DM_MR1 can be
programmed in bits 31:8 but the masks only bits 17:8.
Correct the same.

Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
---
 drivers/tty/serial/msm_serial.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 8f7806d..5ff9ebf 100644
--- a/drivers/tty/serial/msm_serial.h
+++ b/drivers/tty/serial/msm_serial.h
@@ -19,7 +19,7 @@
 #define UART_MR1			0x0000
 
 #define UART_MR1_AUTO_RFR_LEVEL0	0x3F
-#define UART_MR1_AUTO_RFR_LEVEL1	0x3FF00
+#define UART_MR1_AUTO_RFR_LEVEL1	0xFFFFFF00
 #define UART_MR1_RX_RDY_CTL    		(1 << 7)
 #define UART_MR1_CTS_CTL       		(1 << 6)
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
