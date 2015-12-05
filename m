From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v4 2/3] tty: Add software emulated RS485 support for 8250
Date: Sat,  5 Dec 2015 13:54:50 +0300
Message-ID: <1449312891-1846-3-git-send-email-matwey@sai.msu.ru>
References: <1449312891-1846-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449312891-1846-1-git-send-email-matwey@sai.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Implementation of software emulation of RS485 direction handling is based
on omap_serial driver.
Before and after transmission RTS is set to the appropriate value.

Note that before calling serial8250_em485_init the caller has to
ensure that UART will interrupt when shift register empty. Otherwise,
emultaion cannot be used.

Both serial8250_em485_init and serial8250_em485_destroy are
idempotent functions.

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/tty/serial/8250/8250.h      |   6 ++
 drivers/tty/serial/8250/8250_port.c | 161 +++++++++++++++++++++++++++++++++++-
 include/linux/serial_8250.h         |   7 ++
 3 files changed, 170 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index d54dcd8..a3816c6 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -117,6 +117,12 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 struct uart_8250_port *serial8250_get_port(int line);
 void serial8250_rpm_get(struct uart_8250_port *p);
 void serial8250_rpm_put(struct uart_8250_port *p);
+int serial8250_em485_init(struct uart_8250_port *p);
+void serial8250_em485_destroy(struct uart_8250_port *p);
+static inline bool serial8250_em485_enabled(struct uart_8250_port *p)
+{
+	return p->rs485_emul && (p->port.rs485.flags & SER_RS485_ENABLED);
+}
 
 #if defined(__alpha__) && !defined(CONFIG_PCI)
 /*
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8ad0b2d..394d0d2 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/pm_runtime.h>
+#include <linux/timer.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -504,6 +505,31 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 	}
 }
 
+static inline void serial8250_em485_rts_on_send(struct uart_8250_port *p)
+{
+	unsigned char mcr = serial_in(p, UART_MCR);
+
+	if (p->port.rs485.flags & SER_RS485_RTS_ON_SEND)
+		mcr |= UART_MCR_RTS;
+	else
+		mcr &= ~UART_MCR_RTS;
+	serial_out(p, UART_MCR, mcr);
+}
+
+static inline void serial8250_em485_rts_after_send(struct uart_8250_port *p)
+{
+	unsigned char mcr = serial_in(p, UART_MCR);
+
+	if (p->port.rs485.flags & SER_RS485_RTS_AFTER_SEND)
+		mcr |= UART_MCR_RTS;
+	else
+		mcr &= ~UART_MCR_RTS;
+	serial_out(p, UART_MCR, mcr);
+}
+
+static void serial8250_em485_handle_start_tx(unsigned long arg);
+static void serial8250_em485_handle_stop_tx(unsigned long arg);
+
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 {
 	serial8250_clear_fifos(p);
@@ -528,6 +554,42 @@ void serial8250_rpm_put(struct uart_8250_port *p)
 }
 EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 
+int serial8250_em485_init(struct uart_8250_port *p)
+{
+	if (p->rs485_emul != NULL)
+		return 0;
+
+	p->rs485_emul = kmalloc(sizeof(struct uart_8250_rs485_emul), GFP_KERNEL);
+	if (p->rs485_emul == NULL)
+		return -ENOMEM;
+
+	init_timer(&p->rs485_emul->stop_tx_timer);
+	p->rs485_emul->stop_tx_timer.function = serial8250_em485_handle_stop_tx;
+	p->rs485_emul->stop_tx_timer.data = (unsigned long)p;
+	p->rs485_emul->stop_tx_timer.flags |= TIMER_IRQSAFE;
+	init_timer(&p->rs485_emul->start_tx_timer);
+	p->rs485_emul->start_tx_timer.function = serial8250_em485_handle_start_tx;
+	p->rs485_emul->start_tx_timer.data = (unsigned long)p;
+	p->rs485_emul->start_tx_timer.flags |= TIMER_IRQSAFE;
+
+	serial8250_em485_rts_after_send(p);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(serial8250_em485_init);
+void serial8250_em485_destroy(struct uart_8250_port *p)
+{
+	if (p->rs485_emul == NULL)
+		return;
+
+	del_timer_sync(&p->rs485_emul->start_tx_timer);
+	del_timer_sync(&p->rs485_emul->stop_tx_timer);
+
+	kfree(p->rs485_emul);
+	p->rs485_emul = NULL;
+}
+EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
+
 /*
  * These two wrappers ensure that enable_runtime_pm_tx() can be called more than
  * once and disable_runtime_pm_tx() will still disable RPM because the fifo is
@@ -1293,7 +1355,61 @@ static void serial8250_stop_rx(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-static inline void __stop_tx(struct uart_8250_port *p)
+static __u32 __start_tx_rs485(struct uart_8250_port *p)
+{
+	if (!serial8250_em485_enabled(p))
+		return 0;
+
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_stop_rx(&p->port);
+
+	del_timer_sync(&p->rs485_emul->stop_tx_timer);
+
+	if (!!(p->port.rs485.flags & SER_RS485_RTS_ON_SEND) != !!(serial_in(p, UART_MCR) & UART_MCR_RTS)) {
+		serial8250_em485_rts_on_send(p);
+		return p->port.rs485.delay_rts_before_send;
+	}
+
+	return 0;
+}
+
+static inline void __do_stop_tx_rs485(struct uart_8250_port *p)
+{
+	if (!serial8250_em485_enabled(p))
+		return;
+
+	serial8250_em485_rts_after_send(p);
+	/*
+	* Empty the RX FIFO, we are not interested in anything
+	* received during the half-duplex transmission.
+	*/
+	if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		serial8250_clear_fifos(p);
+}
+
+static void serial8250_em485_handle_stop_tx(unsigned long arg)
+{
+	struct uart_8250_port *p = (struct uart_8250_port *)arg;
+
+	__do_stop_tx_rs485(p);
+}
+
+static inline void __stop_tx_rs485(struct uart_8250_port *p)
+{
+	if (!serial8250_em485_enabled(p))
+		return;
+
+	del_timer_sync(&p->rs485_emul->start_tx_timer);
+
+	/* __do_stop_tx_rs485 is going to set RTS according to config AND flush RX FIFO if required */
+	if (p->port.rs485.delay_rts_after_send > 0) {
+		mod_timer(&p->rs485_emul->stop_tx_timer, jiffies + p->port.rs485.delay_rts_after_send * HZ / 1000);
+	} else {
+		__do_stop_tx_rs485(p);
+	}
+}
+
+static inline void __do_stop_tx(struct uart_8250_port *p)
 {
 	if (p->ier & UART_IER_THRI) {
 		p->ier &= ~UART_IER_THRI;
@@ -1302,6 +1418,21 @@ static inline void __stop_tx(struct uart_8250_port *p)
 	}
 }
 
+static inline void __stop_tx(struct uart_8250_port *p)
+{
+	if (serial8250_em485_enabled(p)) {
+		unsigned char lsr = serial_in(p, UART_LSR);
+	/* To provide required timeing and allow FIFO transfer,
+	 * __stop_tx_rs485 must be called only when both FIFO and shift register
+	 * are empty. It is for device driver to enable interrupt on TEMT.
+	 */
+		if (!((lsr & UART_LSR_TEMT) && (lsr & UART_LSR_THRE)))
+			return;
+	}
+	__do_stop_tx(p);
+	__stop_tx_rs485(p);
+}
+
 static void serial8250_stop_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -1319,12 +1450,10 @@ static void serial8250_stop_tx(struct uart_port *port)
 	serial8250_rpm_put(up);
 }
 
-static void serial8250_start_tx(struct uart_port *port)
+static inline void __start_tx(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	serial8250_rpm_get_tx(up);
-
 	if (up->dma && !up->dma->tx_dma(up))
 		return;
 
@@ -1350,6 +1479,30 @@ static void serial8250_start_tx(struct uart_port *port)
 	}
 }
 
+static void serial8250_em485_handle_start_tx(unsigned long arg)
+{
+	struct uart_8250_port *p = (struct uart_8250_port *)arg;
+
+	__start_tx(&p->port);
+}
+
+static void serial8250_start_tx(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	__u32 delay;
+
+	serial8250_rpm_get_tx(up);
+
+	if (up->rs485_emul && timer_pending(&up->rs485_emul->start_tx_timer))
+		return;
+
+	if (up->rs485_emul && (delay = __start_tx_rs485(up))) {
+		mod_timer(&up->rs485_emul->start_tx_timer, jiffies + delay * HZ / 1000);
+	} else {
+		__start_tx(port);
+	}
+}
+
 static void serial8250_throttle(struct uart_port *port)
 {
 	port->throttle(port);
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index faa0e03..99e59fc 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -76,6 +76,11 @@ struct uart_8250_ops {
 	void		(*release_irq)(struct uart_8250_port *);
 };
 
+struct uart_8250_rs485_emul {
+	struct timer_list	start_tx_timer; /* "rs485 start tx" timer */
+	struct timer_list	stop_tx_timer; /* "rs485 stop tx" timer */
+};
+
 /*
  * This should be used by drivers which want to register
  * their own 8250 ports without registering their own
@@ -122,6 +127,8 @@ struct uart_8250_port {
 	/* 8250 specific callbacks */
 	int			(*dl_read)(struct uart_8250_port *);
 	void			(*dl_write)(struct uart_8250_port *, int);
+
+	struct uart_8250_rs485_emul *rs485_emul;
 };
 
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)
-- 
2.6.3
