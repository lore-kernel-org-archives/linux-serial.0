From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 3/4] serial: 8250: Handle case port doesn't have TEMT interrupt using em485.
Date: Wed,  6 Jun 2018 11:51:52 +0200
Message-ID: <20180606095156.72628-2-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Ed Blake <ed.blake@sondrel.com>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Phil Elwell <phil@raspberrypi.org>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Some 8250 ports only have TEMT interrupt, so current implementation
can't work for ports without it. The only chance to make it work is to
loop-read on LSR register.

With NO TEMT interrupt check if both TEMT and THRE are set looping on
LSR register.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/8250/8250.h      |  2 +-
 drivers/tty/serial/8250/8250_dw.c   |  2 +-
 drivers/tty/serial/8250/8250_omap.c |  2 +-
 drivers/tty/serial/8250/8250_port.c | 26 ++++++++++++++++++--------
 include/linux/serial_8250.h         |  1 +
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index ebfb0bd5bef5..5c6ae5f69432 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -136,7 +136,7 @@ void serial8250_rpm_put(struct uart_8250_port *p);
 void serial8250_rpm_get_tx(struct uart_8250_port *p);
 void serial8250_rpm_put_tx(struct uart_8250_port *p);
 
-int serial8250_em485_init(struct uart_8250_port *p);
+int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr);
 void serial8250_em485_destroy(struct uart_8250_port *p);
 
 static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0f8b4da03d4e..888280ff5451 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -330,7 +330,7 @@ static int dw8250_rs485_config(struct uart_port *p,
 	 * are idempotent
 	 */
 	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
+		int ret = serial8250_em485_init(up, false);
 
 		if (ret) {
 			rs485->flags &= ~SER_RS485_ENABLED;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 624b501fd253..ab483c8b30c8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -725,7 +725,7 @@ static int omap_8250_rs485_config(struct uart_port *port,
 	 * are idempotent
 	 */
 	if (rs485->flags & SER_RS485_ENABLED) {
-		int ret = serial8250_em485_init(up);
+		int ret = serial8250_em485_init(up, true);
 
 		if (ret) {
 			rs485->flags &= ~SER_RS485_ENABLED;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c8c10b5ec6d6..8432445c80e5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -602,15 +602,16 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
 /**
  *	serial8250_em485_init() - put uart_8250_port into rs485 emulating
  *	@p:	uart_8250_port port instance
+ *	@p:	bool specify if 8250 port has TEMT interrupt or not
  *
  *	The function is used to start rs485 software emulating on the
  *	&struct uart_8250_port* @p. Namely, RTS is switched before/after
  *	transmission. The function is idempotent, so it is safe to call it
  *	multiple times.
  *
- *	The caller MUST enable interrupt on empty shift register before
- *	calling serial8250_em485_init(). This interrupt is not a part of
- *	8250 standard, but implementation defined.
+ *	If has_temt_isr is passed as true, the caller MUST enable interrupt
+ *	on empty shift register before calling serial8250_em485_init().
+ *	This interrupt is not a part of	8250 standard, but implementation defined.
  *
  *	The function is supposed to be called from .rs485_config callback
  *	or from any other callback protected with p->port.lock spinlock.
@@ -619,7 +620,7 @@ EXPORT_SYMBOL_GPL(serial8250_rpm_put);
  *
  *	Return 0 - success, -errno - otherwise
  */
-int serial8250_em485_init(struct uart_8250_port *p)
+int serial8250_em485_init(struct uart_8250_port *p, bool has_temt_isr)
 {
 	if (p->em485)
 		return 0;
@@ -636,6 +637,7 @@ int serial8250_em485_init(struct uart_8250_port *p)
 	p->em485->start_tx_timer.function = &serial8250_em485_handle_start_tx;
 	p->em485->port = p;
 	p->em485->active_timer = NULL;
+	p->em485->has_temt_isr = has_temt_isr;
 	serial8250_em485_rts_after_send(p);
 
 	return 0;
@@ -1520,11 +1522,19 @@ static inline void __stop_tx(struct uart_8250_port *p)
 		/*
 		 * To provide required timeing and allow FIFO transfer,
 		 * __stop_tx_rs485() must be called only when both FIFO and
-		 * shift register are empty. It is for device driver to enable
-		 * interrupt on TEMT.
+		 * shift register are empty. If 8250 port supports it,
+		 * it is for device driver to enable interrupt on TEMT.
+		 * Otherwise must loop-read until TEMT and THRE flags are set.
 		 */
-		if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
-			return;
+		if (em485->has_temt_isr) {
+			if ((lsr & BOTH_EMPTY) != BOTH_EMPTY)
+				return;
+		} else {
+			while ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
+				lsr = serial_in(p, UART_LSR);
+				cpu_relax();
+			}
+		}
 
 		em485->active_timer = NULL;
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index a27ef5f56431..9b13cf59726b 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -83,6 +83,7 @@ struct uart_8250_em485 {
 	struct hrtimer		start_tx_timer; /* "rs485 start tx" timer */
 	struct hrtimer		stop_tx_timer;  /* "rs485 stop tx" timer */
 	struct hrtimer		*active_timer;  /* pointer to active timer */
+	bool			has_temt_isr;	/* say if 8250 has TEMT interrupt or no */
 	struct uart_8250_port	*port;          /* for hrtimer callbacks */
 };
 
-- 
2.17.1
