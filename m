From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] tty: serial: qcom_geni_serial: Don't slow all ports just for kgdb
Date: Mon, 15 Oct 2018 13:44:24 -0700
Message-ID: <20181015204425.84537-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: msavaliy@codeaurora.org, linux-arm-msm@vger.kernel.org, alokc@codeaurora.org, mka@chromium.org, evgreen@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

If you turn on CONFIG_KGDB then you'll get CONFIG_CONSOLE_POLL
selected.

If you have CONFIG_CONSOLE_POLL selected then the GENI serial driver
was setting RX_BYTES_PW to 1 for _all_ UART ports.

This doesn't seem like such a good idea.  Let's only set RX_BYTES_PW
to 1 for the console port.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d3b5261ee80a..9ee6ce725e43 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -89,9 +89,9 @@
 #define MAX_LOOPBACK_CFG	3
 
 #ifdef CONFIG_CONSOLE_POLL
-#define RX_BYTES_PW 1
+#define CONSOLE_RX_BYTES_PW 1
 #else
-#define RX_BYTES_PW 4
+#define CONSOLE_RX_BYTES_PW 4
 #endif
 
 struct qcom_geni_serial_port {
@@ -853,11 +853,13 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	unsigned int rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
 	u32 proto;
 
-	if (uart_console(uport))
+	if (uart_console(uport)) {
 		port->tx_bytes_pw = 1;
-	else
+		port->rx_bytes_pw = CONSOLE_RX_BYTES_PW;
+	} else {
 		port->tx_bytes_pw = 4;
-	port->rx_bytes_pw = RX_BYTES_PW;
+		port->rx_bytes_pw = 4;
+	}
 
 	proto = geni_se_read_proto(&port->se);
 	if (proto != GENI_SE_UART) {
-- 
2.19.1.331.ge82ca0e54c-goog
