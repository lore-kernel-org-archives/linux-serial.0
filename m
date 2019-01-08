From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
Date: Mon,  7 Jan 2019 17:58:38 -0800
Message-ID: <20190108015838.166271-5-ryandcase@chromium.org>
References: <20190108015838.166271-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108015838.166271-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Use u32 rather than unsigned long for register variables for clarity and
consistency.

Signed-off-by: Ryan Case <ryandcase@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---

Changes in v2:
- Updated commit message
- Updated missed rxstale variable

 drivers/tty/serial/qcom_geni_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 626bf7d399aa..6d8a44c12596 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -760,12 +760,12 @@ static void qcom_geni_serial_handle_tx(struct uart_port *uport, bool done,
 
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
@@ -844,7 +844,7 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 static int qcom_geni_serial_port_setup(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
-	unsigned int rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
+	u32 rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 
 	if (uart_console(uport)) {
@@ -943,14 +943,14 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
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
2.20.1.97.g81188d93c3-goog
