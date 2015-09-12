From: "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/7] tty: serial: msm: Add msm prefix to all driver functions
Date: Sat, 12 Sep 2015 16:02:11 +0300
Message-ID: <1442062934-13449-5-git-send-email-ivan.ivanov@linaro.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442062934-13449-1-git-send-email-ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Frank Rowand <frank.rowand-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Make function naming consistent across this driver.
No functional changes.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/tty/serial/msm_serial.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index d08cfd3e1c3a..1c2a02634853 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -57,7 +57,7 @@ struct msm_port {
 	bool			break_detected;
 };

-static inline void wait_for_xmitr(struct uart_port *port)
+static inline void msm_wait_for_xmitr(struct uart_port *port)
 {
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_EMPTY)) {
 		if (msm_read(port, UART_ISR) & UART_ISR_TX_READY)
@@ -99,7 +99,7 @@ static void msm_enable_ms(struct uart_port *port)
 	msm_write(port, msm_port->imr, UART_IMR);
 }

-static void handle_rx_dm(struct uart_port *port, unsigned int misr)
+static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
@@ -171,7 +171,7 @@ static void handle_rx_dm(struct uart_port *port, unsigned int misr)
 	msm_write(port, UART_CR_CMD_STALE_EVENT_ENABLE, UART_CR);
 }

-static void handle_rx(struct uart_port *port)
+static void msm_handle_rx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
 	unsigned int sr;
@@ -224,14 +224,14 @@ static void handle_rx(struct uart_port *port)
 	spin_lock(&port->lock);
 }

-static void reset_dm_count(struct uart_port *port, int count)
+static void msm_reset_dm_count(struct uart_port *port, int count)
 {
-	wait_for_xmitr(port);
+	msm_wait_for_xmitr(port);
 	msm_write(port, count, UARTDM_NCF_TX);
 	msm_read(port, UARTDM_NCF_TX);
 }

-static void handle_tx(struct uart_port *port)
+static void msm_handle_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
 	struct msm_port *msm_port = UART_TO_MSM(port);
@@ -250,13 +250,13 @@ static void handle_tx(struct uart_port *port)

 	if (port->x_char) {
 		if (msm_port->is_uartdm)
-			reset_dm_count(port, tx_count + 1);
+			msm_reset_dm_count(port, tx_count + 1);

 		iowrite8_rep(tf, &port->x_char, 1);
 		port->icount.tx++;
 		port->x_char = 0;
 	} else if (tx_count && msm_port->is_uartdm) {
-		reset_dm_count(port, tx_count);
+		msm_reset_dm_count(port, tx_count);
 	}

 	while (tf_pointer < tx_count) {
@@ -290,7 +290,7 @@ static void handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }

-static void handle_delta_cts(struct uart_port *port)
+static void msm_handle_delta_cts(struct uart_port *port)
 {
 	msm_write(port, UART_CR_CMD_RESET_CTS, UART_CR);
 	port->icount.cts++;
@@ -314,14 +314,14 @@ static irqreturn_t msm_irq(int irq, void *dev_id)

 	if (misr & (UART_IMR_RXLEV | UART_IMR_RXSTALE)) {
 		if (msm_port->is_uartdm)
-			handle_rx_dm(port, misr);
+			msm_handle_rx_dm(port, misr);
 		else
-			handle_rx(port);
+			msm_handle_rx(port);
 	}
 	if (misr & UART_IMR_TXLEV)
-		handle_tx(port);
+		msm_handle_tx(port);
 	if (misr & UART_IMR_DELTA_CTS)
-		handle_delta_cts(port);
+		msm_handle_delta_cts(port);

 	msm_write(port, msm_port->imr, UART_IMR); /* restore interrupt */
 	spin_unlock(&port->lock);
@@ -779,7 +779,7 @@ static void msm_poll_put_char(struct uart_port *port, unsigned char c)
 	msm_write(port, 0, UART_IMR);

 	if (msm_port->is_uartdm)
-		reset_dm_count(port, 1);
+		msm_reset_dm_count(port, 1);

 	/* Wait until FIFO is empty */
 	while (!(msm_read(port, UART_SR) & UART_SR_TX_READY))
@@ -853,7 +853,7 @@ static struct msm_port msm_uart_ports[] = {

 #define UART_NR	ARRAY_SIZE(msm_uart_ports)

-static inline struct uart_port *get_port_from_line(unsigned int line)
+static inline struct uart_port *msm_get_port_from_line(unsigned int line)
 {
 	return &msm_uart_ports[line].uart;
 }
@@ -880,7 +880,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,

 	spin_lock(&port->lock);
 	if (is_uartdm)
-		reset_dm_count(port, count);
+		msm_reset_dm_count(port, count);

 	i = 0;
 	while (i < count) {
@@ -925,7 +925,7 @@ static void msm_console_write(struct console *co, const char *s,

 	BUG_ON(co->index < 0 || co->index >= UART_NR);

-	port = get_port_from_line(co->index);
+	port = msm_get_port_from_line(co->index);
 	msm_port = UART_TO_MSM(port);

 	__msm_console_write(port, s, count, msm_port->is_uartdm);
@@ -942,7 +942,7 @@ static int __init msm_console_setup(struct console *co, char *options)
 	if (unlikely(co->index >= UART_NR || co->index < 0))
 		return -ENXIO;

-	port = get_port_from_line(co->index);
+	port = msm_get_port_from_line(co->index);

 	if (unlikely(!port->membase))
 		return -ENXIO;
@@ -1057,7 +1057,7 @@ static int msm_serial_probe(struct platform_device *pdev)

 	dev_info(&pdev->dev, "msm_serial: detected port #%d\n", line);

-	port = get_port_from_line(line);
+	port = msm_get_port_from_line(line);
 	port->dev = &pdev->dev;
 	msm_port = UART_TO_MSM(port);

--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
