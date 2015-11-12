From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v3 5/5] tty: Add software emulated RS485 support for 8250
Date: Thu, 12 Nov 2015 17:33:56 +0300
Message-ID: <1447338836-8785-6-git-send-email-matwey@sai.msu.ru>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Implementation of software emulation of RS485 direction handling is based
on omap-serial driver.
Before and after transmission RTS is set to the appropriate value.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250_port.c | 152 ++++++++++++++++++++++++++++++++++--
 include/linux/serial_8250.h         |   2 +
 2 files changed, 148 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3f6d8a2..b863a12 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/timer.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -1299,7 +1300,75 @@ static void serial8250_stop_rx(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-static inline void __stop_tx(struct uart_8250_port *p)
+static inline void serial8250_rs485_set_rts_on_send(struct uart_8250_port *p)
+{
+	if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND)
+		p->mcr |= UART_MCR_RTS;
+	else
+		p->mcr &= ~UART_MCR_RTS;
+	serial_out(p, UART_MCR, p->mcr);
+}
+
+static inline void serial8250_rs485_set_rts_after_send(struct uart_8250_port *p)
+{
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		p->mcr |= UART_MCR_RTS;
+	else
+		p->mcr &= ~UART_MCR_RTS;
+	serial_out(p, UART_MCR, p->mcr);
+}
+
+static __u32 serial8250_rs485_start_tx(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
+		return 0;
+	
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_stop_rx(&p->port);
+	
+	del_timer_sync(&p->rs485_stop_tx_timer);
+
+	if (!!(p->port.rs485.flags & SER_RS485_RTS_ON_SEND) != !!(p->mcr & UART_MCR_RTS)) {
+		serial8250_rs485_set_rts_on_send(p);
+		return p->port.rs485.delay_rts_before_send;
+	}
+
+	return 0;
+}
+
+static inline void __do_stop_tx_rs485(struct uart_8250_port *p)
+{
+	serial8250_rs485_set_rts_after_send(p);
+	/*
+	* Empty the RX FIFO, we are not interested in anything
+	* received during the half-duplex transmission.
+	*/
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_clear_fifos(p);
+}
+
+static void serial8250_handle_rs485_stop_tx_timer(unsigned long arg)
+{
+	struct uart_8250_port *p = (struct uart_8250_port*)arg;
+	__do_stop_tx_rs485(p);
+}
+
+static inline void __stop_tx_rs485(struct uart_8250_port *p)
+{
+	if (p->capabilities & UART_CAP_HW485 || !(p->port.rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	del_timer_sync(&p->rs485_start_tx_timer);
+
+	/* __do_stop_tx_rs485 is going to set RTS according to config AND flush RX FIFO if required */
+	if (p->port.rs485.delay_rts_after_send > 0) {
+		mod_timer(&p->rs485_stop_tx_timer, jiffies + p->port.rs485.delay_rts_after_send * HZ / 1000);
+	} else {
+		__do_stop_tx_rs485(p);
+	}
+}
+
+static inline void __do_stop_tx(struct uart_8250_port *p)
 {
 	if (p->ier & UART_IER_THRI) {
 		p->ier &= ~UART_IER_THRI;
@@ -1308,6 +1377,12 @@ static inline void __stop_tx(struct uart_8250_port *p)
 	}
 }
 
+static inline void __stop_tx(struct uart_8250_port *p)
+{
+	__do_stop_tx(p);
+	__stop_tx_rs485(p);
+}
+
 static void serial8250_stop_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -1325,12 +1400,10 @@ static void serial8250_stop_tx(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-static void serial8250_start_tx(struct uart_port *port)
+static inline void __start_tx(struct uart_port* port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	serial8250_rpm_get_tx(up);
-
 	if (up->dma && !up->dma->tx_dma(up))
 		return;
 
@@ -1356,6 +1429,29 @@ static void serial8250_start_tx(struct uart_port *port)
 	}
 }
 
+static void serial8250_handle_rs485_start_tx_timer(unsigned long arg)
+{
+	struct uart_port* port = (struct uart_port*)arg;
+	__start_tx(port);
+}
+
+static void serial8250_start_tx(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	__u32 delay;
+	
+	serial8250_rpm_get_tx(up);
+
+	if (timer_pending(&up->rs485_start_tx_timer))
+		return;
+
+	if ((delay = serial8250_rs485_start_tx(up))) {
+		mod_timer(&up->rs485_start_tx_timer, jiffies + delay * HZ / 1000);
+	} else {
+		__start_tx(port);
+	}
+}
+
 static void serial8250_throttle(struct uart_port *port)
 {
 	port->throttle(port);
@@ -1806,6 +1902,16 @@ static void serial8250_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
+static inline void serial8250_startup_rs485(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	
+	if (up->capabilities & UART_CAP_HW485 || !(up->port.rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	serial8250_rs485_set_rts_after_send(up);
+}
+
 int serial8250_do_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -2044,6 +2150,8 @@ dont_test_tx_en:
 		inb_p(icp);
 	}
 	retval = 0;
+
+	serial8250_startup_rs485(port);
 out:
 	serial8250_rpm_put(up);
 	return retval;
@@ -2057,12 +2165,24 @@ static int serial8250_startup(struct uart_port *port)
 	return serial8250_do_startup(port);
 }
 
+static inline void serial8250_shutdown_rs485(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	
+	if (up->capabilities & UART_CAP_HW485 || !(up->port.rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	del_timer_sync(&up->rs485_start_tx_timer);
+	del_timer_sync(&up->rs485_stop_tx_timer);
+}
+
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
 
 	serial8250_rpm_get(up);
+	serial8250_shutdown_rs485(port);
 	/*
 	 * Disable interrupts from this port
 	 */
@@ -2735,11 +2855,23 @@ serial8250_type(struct uart_port *port)
 	return uart_config[type].name;
 }
 
-static int serial8250_rs485_config(struct uart_port *port,
-				struct serial_rs485 *rs485)
+static int serial8250_rs485_config(struct uart_port *port, struct serial_rs485 *rs485)
 {
+	bool need_startup = false;
+
+	if (!(port->rs485.flags & SER_RS485_ENABLED) && (rs485->flags & SER_RS485_ENABLED)) {
+		need_startup = true;
+	}
+	if ((port->rs485.flags & SER_RS485_ENABLED) && !(rs485->flags & SER_RS485_ENABLED)) {
+		serial8250_shutdown_rs485(port);
+	}
+
 	port->rs485 = *rs485;
 	port->rs485.flags |= SER_RS485_SOFTWARE;
+
+	if (need_startup)
+		serial8250_startup_rs485(port);
+
 	return 0;
 }
 
@@ -2807,6 +2939,14 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 	}
 
 	up->port.rs485_config = serial8250_rs485_config;
+	init_timer(&up->rs485_stop_tx_timer);
+	up->rs485_stop_tx_timer.function = serial8250_handle_rs485_stop_tx_timer;
+	up->rs485_stop_tx_timer.data = (unsigned long)up;
+	up->rs485_stop_tx_timer.flags |= TIMER_IRQSAFE;
+	init_timer(&up->rs485_start_tx_timer);
+	up->rs485_start_tx_timer.function = serial8250_handle_rs485_start_tx_timer;
+	up->rs485_start_tx_timer.data = (unsigned long)up;
+	up->rs485_start_tx_timer.flags |= TIMER_IRQSAFE;
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index faa0e03..c4905e7 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -86,6 +86,8 @@ struct uart_8250_ops {
 struct uart_8250_port {
 	struct uart_port	port;
 	struct timer_list	timer;		/* "no irq" timer */
+	struct timer_list	rs485_start_tx_timer; /* "rs485 start tx" timer */
+	struct timer_list	rs485_stop_tx_timer; /* "rs485 stop tx" timer */
 	struct list_head	list;		/* ports on this IRQ */
 	unsigned short		capabilities;	/* port capabilities */
 	unsigned short		bugs;		/* port bugs */
-- 
2.6.2
