From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v8 1/3] tty: Move serial8250_stop_rx() in front of serial8250_start_tx()
Date: Mon,  1 Feb 2016 21:09:20 +0300
Message-ID: <1454350162-1840-2-git-send-email-matwey@sai.msu.ru>
References: <1454350162-1840-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454350162-1840-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Software RS485 emultaion is to be added in the following commit.
serial8250_start_tx() will need to refer serial8250_stop_rx().
Move serial8250_stop_rx() in front of serial8250_start_tx() in order
to avoid function forward declaration.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8d262bc..b82fcae 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1304,6 +1304,19 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	port->irq = (irq > 0) ? irq : 0;
 }
 
+static void serial8250_stop_rx(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial8250_rpm_get(up);
+
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
+	up->port.read_status_mask &= ~UART_LSR_DR;
+	serial_port_out(port, UART_IER, up->ier);
+
+	serial8250_rpm_put(up);
+}
+
 static inline void __stop_tx(struct uart_8250_port *p)
 {
 	if (p->ier & UART_IER_THRI) {
@@ -1371,19 +1384,6 @@ static void serial8250_unthrottle(struct uart_port *port)
 	port->unthrottle(port);
 }
 
-static void serial8250_stop_rx(struct uart_port *port)
-{
-	struct uart_8250_port *up = up_to_u8250p(port);
-
-	serial8250_rpm_get(up);
-
-	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
-	up->port.read_status_mask &= ~UART_LSR_DR;
-	serial_port_out(port, UART_IER, up->ier);
-
-	serial8250_rpm_put(up);
-}
-
 static void serial8250_disable_ms(struct uart_port *port)
 {
 	struct uart_8250_port *up =
-- 
2.7.0
