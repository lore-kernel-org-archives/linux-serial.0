From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: [PATCH v3 1/6] tty: serial: msm: Add mask value for UART_DM registers
Date: Wed, 30 Sep 2015 15:26:58 +0300
Message-ID: <1443616023-28625-2-git-send-email-ivan.ivanov@linaro.org>
References: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1443616023-28625-1-git-send-email-ivan.ivanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Andy Gross <agross@codeaurora.org>
Cc: Pramod Gurav <gpramod@codeaurora.org>, David Brown <davidb@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Pramod Gurav <gpramod@codeaurora.org>

The bit masks for RFR_LEVEL1 and STALE_TIMEOUT_MSB values in MR1 and
IPR registers respectively are different for UART and UART_DM hardware
cores. We have been using UART core mask values for these. Add the same
for UART_DM core.

There is no bit setting as UART_IPR_RXSTALE_LAST for UART_DM core so do
it only for UART core.

Signed-off-by: Pramod Gurav <gpramod@codeaurora.org>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 drivers/tty/serial/msm_serial.c | 26 ++++++++++++++++++++------
 drivers/tty/serial/msm_serial.h |  2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index b73889c8ed4b..d08cfd3e1c3a 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -421,7 +421,7 @@ msm_find_best_baud(struct uart_port *port, unsigned int baud)

 static int msm_set_baud_rate(struct uart_port *port, unsigned int baud)
 {
-	unsigned int rxstale, watermark;
+	unsigned int rxstale, watermark, mask;
 	struct msm_port *msm_port = UART_TO_MSM(port);
 	const struct msm_baud_map *entry;

@@ -432,8 +432,15 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud)
 	/* RX stale watermark */
 	rxstale = entry->rxstale;
 	watermark = UART_IPR_STALE_LSB & rxstale;
-	watermark |= UART_IPR_RXSTALE_LAST;
-	watermark |= UART_IPR_STALE_TIMEOUT_MSB & (rxstale << 2);
+	if (msm_port->is_uartdm) {
+		mask = UART_DM_IPR_STALE_TIMEOUT_MSB;
+	} else {
+		watermark |= UART_IPR_RXSTALE_LAST;
+		mask = UART_IPR_STALE_TIMEOUT_MSB;
+	}
+
+	watermark |= mask & (rxstale << 2);
+
 	msm_write(port, watermark, UART_IPR);

 	/* set RX watermark */
@@ -476,7 +483,7 @@ static void msm_init_clock(struct uart_port *port)
 static int msm_startup(struct uart_port *port)
 {
 	struct msm_port *msm_port = UART_TO_MSM(port);
-	unsigned int data, rfr_level;
+	unsigned int data, rfr_level, mask;
 	int ret;

 	snprintf(msm_port->name, sizeof(msm_port->name),
@@ -496,11 +503,18 @@ static int msm_startup(struct uart_port *port)

 	/* set automatic RFR level */
 	data = msm_read(port, UART_MR1);
-	data &= ~UART_MR1_AUTO_RFR_LEVEL1;
+
+	if (msm_port->is_uartdm)
+		mask = UART_DM_MR1_AUTO_RFR_LEVEL1;
+	else
+		mask = UART_MR1_AUTO_RFR_LEVEL1;
+
+	data &= ~mask;
 	data &= ~UART_MR1_AUTO_RFR_LEVEL0;
-	data |= UART_MR1_AUTO_RFR_LEVEL1 & (rfr_level << 2);
+	data |= mask & (rfr_level << 2);
 	data |= UART_MR1_AUTO_RFR_LEVEL0 & rfr_level;
 	msm_write(port, data, UART_MR1);
+
 	return 0;
 }

diff --git a/drivers/tty/serial/msm_serial.h b/drivers/tty/serial/msm_serial.h
index 737f69fe7113..5b7722c3938b 100644
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
1.9.1
