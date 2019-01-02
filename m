From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
Date: Wed,  2 Jan 2019 13:36:36 -0800
Message-ID: <20190102213636.40866-5-ryandcase@chromium.org>
References: <20190102213636.40866-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102213636.40866-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Ryan Case <ryandcase@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3103aa0adc86..fa67a2ced420 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -765,12 +765,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
 static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 {
-	unsigned int m_irq_status;
-	unsigned int s_irq_status;
-	unsigned int geni_status;
+	u32 m_irq_en;
+	u32 m_irq_status;
+	u32 s_irq_status;
+	u32 geni_status;
 	struct uart_port *uport = dev;
 	unsigned long flags;
-	unsigned int m_irq_en;
 	bool drop_rx = false;
 	struct tty_port *tport = &uport->state->port;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
@@ -948,14 +948,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 				struct ktermios *termios, struct ktermios *old)
 {
 	unsigned int baud;
-	unsigned int bits_per_char;
-	unsigned int tx_trans_cfg;
-	unsigned int tx_parity_cfg;
-	unsigned int rx_trans_cfg;
-	unsigned int rx_parity_cfg;
-	unsigned int stop_bit_len;
+	u32 bits_per_char;
+	u32 tx_trans_cfg;
+	u32 tx_parity_cfg;
+	u32 rx_trans_cfg;
+	u32 rx_parity_cfg;
+	u32 stop_bit_len;
 	unsigned int clk_div;
-	unsigned long ser_clk_cfg;
+	u32 ser_clk_cfg;
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
 	unsigned long clk_rate;
 
-- 
2.20.1.415.g653613c723-goog
