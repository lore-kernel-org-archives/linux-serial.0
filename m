From: Valentin Rothberg <valentinrothberg@gmail.com>
Subject: [PATCH] serial: bfin: ctsrts: enfore Kconfig naming convention
Date: Sun, 12 Apr 2015 17:54:35 +0200
Message-ID: <1428854075-6241-1-git-send-email-valentinrothberg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, realmz6@gmail.com, sonic.zhang@analog.com
Cc: Valentin Rothberg <valentinrothberg@gmail.com>
List-Id: linux-serial@vger.kernel.org

The CONFIG_ prefix is reserved for Kconfig options in Make and CPP
syntax; static analysis tools rely on this convention.  This patch
enforces this behavior for SERIAL_BFIN_{HARD_}CTSRTS.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
---
I found this issue with ./scripts/checkkconfigsymbols.py
---
 arch/blackfin/include/asm/bfin_serial.h |  8 ++++----
 drivers/tty/serial/bfin_uart.c          | 24 ++++++++++++------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/blackfin/include/asm/bfin_serial.h b/arch/blackfin/include/asm/bfin_serial.h
index d00d732784b1..b550ada7321b 100644
--- a/arch/blackfin/include/asm/bfin_serial.h
+++ b/arch/blackfin/include/asm/bfin_serial.h
@@ -22,9 +22,9 @@
     defined(CONFIG_BFIN_UART2_CTSRTS) || \
     defined(CONFIG_BFIN_UART3_CTSRTS)
 # if defined(BFIN_UART_BF54X_STYLE) || defined(BFIN_UART_BF60X_STYLE)
-#  define CONFIG_SERIAL_BFIN_HARD_CTSRTS
+#  define SERIAL_BFIN_HARD_CTSRTS
 # else
-#  define CONFIG_SERIAL_BFIN_CTSRTS
+#  define SERIAL_BFIN_CTSRTS
 # endif
 #endif
 
@@ -50,8 +50,8 @@ struct bfin_serial_port {
 #elif ANOMALY_05000363
 	unsigned int anomaly_threshold;
 #endif
-#if defined(CONFIG_SERIAL_BFIN_CTSRTS) || \
-	defined(CONFIG_SERIAL_BFIN_HARD_CTSRTS)
+#if defined(SERIAL_BFIN_CTSRTS) || \
+	defined(SERIAL_BFIN_HARD_CTSRTS)
 	int cts_pin;
 	int rts_pin;
 #endif
diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 155781ece050..ae3cf94b146b 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -74,8 +74,8 @@ static void bfin_serial_tx_chars(struct bfin_serial_port *uart);
 
 static void bfin_serial_reset_irda(struct uart_port *port);
 
-#if defined(CONFIG_SERIAL_BFIN_CTSRTS) || \
-	defined(CONFIG_SERIAL_BFIN_HARD_CTSRTS)
+#if defined(SERIAL_BFIN_CTSRTS) || \
+	defined(SERIAL_BFIN_HARD_CTSRTS)
 static unsigned int bfin_serial_get_mctrl(struct uart_port *port)
 {
 	struct bfin_serial_port *uart = (struct bfin_serial_port *)port;
@@ -110,7 +110,7 @@ static irqreturn_t bfin_serial_mctrl_cts_int(int irq, void *dev_id)
 	struct bfin_serial_port *uart = dev_id;
 	struct uart_port *uport = &uart->port;
 	unsigned int status = bfin_serial_get_mctrl(uport);
-#ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
+#ifdef SERIAL_BFIN_HARD_CTSRTS
 
 	UART_CLEAR_SCTS(uart);
 	if (uport->hw_stopped) {
@@ -700,7 +700,7 @@ static int bfin_serial_startup(struct uart_port *port)
 # endif
 #endif
 
-#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+#ifdef SERIAL_BFIN_CTSRTS
 	if (uart->cts_pin >= 0) {
 		if (request_irq(gpio_to_irq(uart->cts_pin),
 			bfin_serial_mctrl_cts_int,
@@ -718,7 +718,7 @@ static int bfin_serial_startup(struct uart_port *port)
 			gpio_direction_output(uart->rts_pin, 0);
 	}
 #endif
-#ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
+#ifdef SERIAL_BFIN_HARD_CTSRTS
 	if (uart->cts_pin >= 0) {
 		if (request_irq(uart->status_irq, bfin_serial_mctrl_cts_int,
 			0, "BFIN_UART_MODEM_STATUS", uart)) {
@@ -766,13 +766,13 @@ static void bfin_serial_shutdown(struct uart_port *port)
 	free_irq(uart->tx_irq, uart);
 #endif
 
-#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+#ifdef SERIAL_BFIN_CTSRTS
 	if (uart->cts_pin >= 0)
 		free_irq(gpio_to_irq(uart->cts_pin), uart);
 	if (uart->rts_pin >= 0)
 		gpio_free(uart->rts_pin);
 #endif
-#ifdef CONFIG_SERIAL_BFIN_HARD_CTSRTS
+#ifdef SERIAL_BFIN_HARD_CTSRTS
 	if (uart->cts_pin >= 0)
 		free_irq(uart->status_irq, uart);
 #endif
@@ -788,7 +788,7 @@ bfin_serial_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int ier, lcr = 0;
 	unsigned long timeout;
 
-#ifdef CONFIG_SERIAL_BFIN_CTSRTS
+#ifdef SERIAL_BFIN_CTSRTS
 	if (old == NULL && uart->cts_pin != -1)
 		termios->c_cflag |= CRTSCTS;
 	else if (uart->cts_pin == -1)
@@ -1110,8 +1110,8 @@ bfin_serial_console_setup(struct console *co, char *options)
 	int baud = 57600;
 	int bits = 8;
 	int parity = 'n';
-# if defined(CONFIG_SERIAL_BFIN_CTSRTS) || \
-	defined(CONFIG_SERIAL_BFIN_HARD_CTSRTS)
+# if defined(SERIAL_BFIN_CTSRTS) || \
+	defined(SERIAL_BFIN_HARD_CTSRTS)
 	int flow = 'r';
 # else
 	int flow = 'n';
@@ -1322,8 +1322,8 @@ static int bfin_serial_probe(struct platform_device *pdev)
 		init_timer(&(uart->rx_dma_timer));
 #endif
 
-#if defined(CONFIG_SERIAL_BFIN_CTSRTS) || \
-	defined(CONFIG_SERIAL_BFIN_HARD_CTSRTS)
+#if defined(SERIAL_BFIN_CTSRTS) || \
+	defined(SERIAL_BFIN_HARD_CTSRTS)
 		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
 		if (res == NULL)
 			uart->cts_pin = -1;
-- 
2.1.0
