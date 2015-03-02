From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH v2 6/6] tty: serial: atmel: rework interrupt and wakeup handling
Date: Mon,  2 Mar 2015 10:18:18 +0100
Message-ID: <1425287898-15093-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-serial@vger.kernel.org

The IRQ line connected to the DBGU UART is often shared with a timer device
which request the IRQ with IRQF_NO_SUSPEND.
Since the UART driver is correctly disabling IRQs when entering suspend
we can safely request the IRQ with IRQF_COND_SUSPEND so that irq core
will not complain about mixing IRQF_NO_SUSPEND and !IRQF_NO_SUSPEND.

Rework the interrupt handler to wake the system up when an interrupt
happens on the DEBUG_UART while the system is suspended.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 49 +++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 846552b..4e959c4 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -47,6 +47,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/irq.h>
+#include <linux/suspend.h>
 
 #include <asm/io.h>
 #include <asm/ioctls.h>
@@ -173,6 +174,12 @@ struct atmel_uart_port {
 	bool			ms_irq_enabled;
 	bool			is_usart;	/* usart or uart */
 	struct timer_list	uart_timer;	/* uart timer */
+
+	bool			suspended;
+	unsigned int		pending;
+	unsigned int		pending_status;
+	spinlock_t		lock_suspended;
+
 	int (*prepare_rx)(struct uart_port *port);
 	int (*prepare_tx)(struct uart_port *port);
 	void (*schedule_rx)(struct uart_port *port);
@@ -1179,12 +1186,15 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
-	unsigned int status, pending, pass_counter = 0;
+	unsigned int status, pending, mask, pass_counter = 0;
 	bool gpio_handled = false;
 
+	spin_lock(&atmel_port->lock_suspended);
+
 	do {
 		status = atmel_get_lines_status(port);
-		pending = status & UART_GET_IMR(port);
+		mask = UART_GET_IMR(port);
+		pending = status & mask;
 		if (!gpio_handled) {
 			/*
 			 * Dealing with GPIO interrupt
@@ -1206,11 +1216,21 @@ static irqreturn_t atmel_interrupt(int irq, void *dev_id)
 		if (!pending)
 			break;
 
+		if (atmel_port->suspended) {
+			atmel_port->pending |= pending;
+			atmel_port->pending_status = status;
+			UART_PUT_IDR(port, mask);
+			pm_system_wakeup();
+			break;
+		}
+
 		atmel_handle_receive(port, pending);
 		atmel_handle_status(port, pending, status);
 		atmel_handle_transmit(port, pending);
 	} while (pass_counter++ < ATMEL_ISR_PASS_LIMIT);
 
+	spin_unlock(&atmel_port->lock_suspended);
+
 	return pass_counter ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -1742,7 +1762,8 @@ static int atmel_startup(struct uart_port *port)
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(port->irq, atmel_interrupt, IRQF_SHARED,
+	retval = request_irq(port->irq, atmel_interrupt,
+			IRQF_SHARED | IRQF_COND_SUSPEND,
 			tty ? tty->name : "atmel_serial", port);
 	if (retval) {
 		dev_err(port->dev, "atmel_startup - Can't get irq\n");
@@ -2513,8 +2534,14 @@ static int atmel_serial_suspend(struct platform_device *pdev,
 
 	/* we can not wake up if we're running on slow clock */
 	atmel_port->may_wakeup = device_may_wakeup(&pdev->dev);
-	if (atmel_serial_clk_will_stop())
+	if (atmel_serial_clk_will_stop()) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&atmel_port->lock_suspended, flags);
+		atmel_port->suspended = true;
+		spin_unlock_irqrestore(&atmel_port->lock_suspended, flags);
 		device_set_wakeup_enable(&pdev->dev, 0);
+	}
 
 	uart_suspend_port(&atmel_uart, port);
 
@@ -2525,6 +2552,18 @@ static int atmel_serial_resume(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&atmel_port->lock_suspended, flags);
+	if (atmel_port->pending) {
+		atmel_handle_receive(port, atmel_port->pending);
+		atmel_handle_status(port, atmel_port->pending,
+				    atmel_port->pending_status);
+		atmel_handle_transmit(port, atmel_port->pending);
+		atmel_port->pending = 0;
+	}
+	atmel_port->suspended = false;
+	spin_unlock_irqrestore(&atmel_port->lock_suspended, flags);
 
 	uart_resume_port(&atmel_uart, port);
 	device_set_wakeup_enable(&pdev->dev, atmel_port->may_wakeup);
@@ -2593,6 +2632,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
 	port->backup_imr = 0;
 	port->uart.line = ret;
 
+	spin_lock_init(&port->lock_suspended);
+
 	ret = atmel_init_gpios(port, &pdev->dev);
 	if (ret < 0)
 		dev_err(&pdev->dev, "%s",
-- 
1.9.1
