From: Robert Baldyga <r.baldyga@samsung.com>
Subject: [PATCH 2/4] serial: samsung: fix style problems
Date: Mon, 24 Nov 2014 07:56:22 +0100
Message-ID: <1416812184-4496-3-git-send-email-r.baldyga@samsung.com>
References: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1416812184-4496-1-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, Robert Baldyga <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Split lines longer than 80 chars and remove unnecessary whitespaces.

Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
---
 drivers/tty/serial/samsung.c | 46 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 587d63b..d05c32c 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -199,12 +199,14 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 	}
 }
 
-static inline struct s3c24xx_uart_info *s3c24xx_port_to_info(struct uart_port *port)
+static inline struct s3c24xx_uart_info
+	*s3c24xx_port_to_info(struct uart_port *port)
 {
 	return to_ourport(port)->info;
 }
 
-static inline struct s3c2410_uartcfg *s3c24xx_port_to_cfg(struct uart_port *port)
+static inline struct s3c2410_uartcfg
+	*s3c24xx_port_to_cfg(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport;
 
@@ -311,14 +313,14 @@ s3c24xx_serial_rx_chars(int irq, void *dev_id)
 		uart_insert_char(port, uerstat, S3C2410_UERSTAT_OVERRUN,
 				 ch, flag);
 
- ignore_char:
+ignore_char:
 		continue;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
 	tty_flip_buffer_push(&port->state->port);
 
- out:
+out:
 	return IRQ_HANDLED;
 }
 
@@ -368,7 +370,7 @@ static irqreturn_t s3c24xx_serial_tx_chars(int irq, void *id)
 	if (uart_circ_empty(xmit))
 		s3c24xx_serial_stop_tx(port);
 
- out:
+out:
 	spin_unlock_irqrestore(&port->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -519,7 +521,7 @@ static int s3c24xx_serial_startup(struct uart_port *port)
 
 	return ret;
 
- err:
+err:
 	s3c24xx_serial_shutdown(port);
 	return ret;
 }
@@ -845,8 +847,8 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	 */
 	port->read_status_mask = S3C2410_UERSTAT_OVERRUN;
 	if (termios->c_iflag & INPCK)
-		port->read_status_mask |= S3C2410_UERSTAT_FRAME | S3C2410_UERSTAT_PARITY;
-
+		port->read_status_mask |= S3C2410_UERSTAT_FRAME |
+			S3C2410_UERSTAT_PARITY;
 	/*
 	 * Which character status flags should we ignore?
 	 */
@@ -973,10 +975,13 @@ static struct uart_driver s3c24xx_uart_drv = {
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
 
-static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
+#define __PORT_LOCK_UNLOCKED(i) \
+	__SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[i].port.lock)
+static struct s3c24xx_uart_port
+s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
 	[0] = {
 		.port = {
-			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[0].port.lock),
+			.lock		= __PORT_LOCK_UNLOCKED(0),
 			.iotype		= UPIO_MEM,
 			.uartclk	= 0,
 			.fifosize	= 16,
@@ -987,7 +992,7 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 	},
 	[1] = {
 		.port = {
-			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[1].port.lock),
+			.lock		= __PORT_LOCK_UNLOCKED(1),
 			.iotype		= UPIO_MEM,
 			.uartclk	= 0,
 			.fifosize	= 16,
@@ -1000,7 +1005,7 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 
 	[2] = {
 		.port = {
-			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[2].port.lock),
+			.lock		= __PORT_LOCK_UNLOCKED(2),
 			.iotype		= UPIO_MEM,
 			.uartclk	= 0,
 			.fifosize	= 16,
@@ -1013,7 +1018,7 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 #if CONFIG_SERIAL_SAMSUNG_UARTS > 3
 	[3] = {
 		.port = {
-			.lock		= __SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[3].port.lock),
+			.lock		= __PORT_LOCK_UNLOCKED(3),
 			.iotype		= UPIO_MEM,
 			.uartclk	= 0,
 			.fifosize	= 16,
@@ -1024,6 +1029,7 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 	}
 #endif
 };
+#undef __PORT_LOCK_UNLOCKED
 
 /* s3c24xx_serial_resetport
  *
@@ -1106,11 +1112,12 @@ static int s3c24xx_serial_cpufreq_transition(struct notifier_block *nb,
 		s3c24xx_serial_set_termios(uport, termios, NULL);
 	}
 
- exit:
+exit:
 	return 0;
 }
 
-static inline int s3c24xx_serial_cpufreq_register(struct s3c24xx_uart_port *port)
+static inline int
+s3c24xx_serial_cpufreq_register(struct s3c24xx_uart_port *port)
 {
 	port->freq_transition.notifier_call = s3c24xx_serial_cpufreq_transition;
 
@@ -1118,19 +1125,22 @@ static inline int s3c24xx_serial_cpufreq_register(struct s3c24xx_uart_port *port
 					 CPUFREQ_TRANSITION_NOTIFIER);
 }
 
-static inline void s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
+static inline void
+s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
 {
 	cpufreq_unregister_notifier(&port->freq_transition,
 				    CPUFREQ_TRANSITION_NOTIFIER);
 }
 
 #else
-static inline int s3c24xx_serial_cpufreq_register(struct s3c24xx_uart_port *port)
+static inline int
+s3c24xx_serial_cpufreq_register(struct s3c24xx_uart_port *port)
 {
 	return 0;
 }
 
-static inline void s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
+static inline void
+s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
 {
 }
 #endif
-- 
1.9.1
