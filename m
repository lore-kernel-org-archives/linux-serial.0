From: Christian Pellegrin <chripell@fsfe.org>
Subject: [PATCH 3/3] max3100: adds console support for MAX3100
Date: Fri, 19 Mar 2010 09:39:57 +0100
Message-ID: <1268987997-22746-1-git-send-email-chripell__47536.5842263729$1268988516$gmane$org@fsfe.org>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f182.google.com ([209.85.221.182]:49447 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab0CSIr6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Mar 2010 04:47:58 -0400
Received: by qyk12 with SMTP id 12so865435qyk.5
        for <linux-serial@vger.kernel.org>; Fri, 19 Mar 2010 01:47:57 -0700 (PDT)
In-Reply-To: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, grant.likely@secretlab.ca, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.netlinu
Cc: Christian Pellegrin <chripell@fsfe.org>

This patch adds console support for the MAX3100 UART
(console=ttyMAX0,11500). The SPI subsystem and an
suitable SPI master driver have to be compiled in the kernel.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 drivers/serial/Kconfig   |   20 +++++
 drivers/serial/max3100.c |  184 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 187 insertions(+), 17 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9ff47db..bc72e84 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -547,6 +547,26 @@ config SERIAL_MAX3100
 	help
 	  MAX3100 chip support
 
+config SERIAL_MAX3100_CONSOLE
+	bool "Support console on MAX3100"
+	depends on SERIAL_MAX3100=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Console on MAX3100
+
+config SERIAL_MAX3100_CONSOLE_N
+	int "Number of MAX3100 chips to wait before registering console"
+	depends on SERIAL_MAX3100_CONSOLE=y
+	default "1"
+	help
+	  Unfortunately due to the async nature of Linux boot we must
+	  know in advance when to register the console. If we do it
+	  too early not all the MAX3100 chips are known to the system
+	  yet. And we just cannot know how many MAX3100 will be in the
+	  system so it's impossible to wait for the last one.  If you
+	  just want to have the console on the first MAX3100 chip
+	  probed (ttyMAX0) it's safe to leave this to 1.
+
 config SERIAL_DZ
 	bool "DECstation DZ serial driver"
 	depends on MACH_DECSTATION && 32BIT
diff --git a/drivers/serial/max3100.c b/drivers/serial/max3100.c
index 0c972c6..f6d250d 100644
--- a/drivers/serial/max3100.c
+++ b/drivers/serial/max3100.c
@@ -48,6 +48,7 @@
 #include <linux/kthread.h>
 #include <linux/interrupt.h>
 #include <linux/bitops.h>
+#include <linux/console.h>
 
 #include <linux/serial_max3100.h>
 
@@ -131,6 +132,10 @@ struct max3100_port {
 	int poll_time;
 	/* and its timer */
 	struct timer_list	timer;
+
+	int console_flags;
+	/* is this port a console? */
+#define MAX3100_IS_CONSOLE   (1 << 0)
 };
 
 static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
@@ -175,7 +180,8 @@ static void max3100_resume_work(struct work_struct *w)
 	struct max3100_port *s = container_of(w, struct max3100_port,
 					      resume_work);
 
-	raise_threaded_irq(s->irq);
+	if (s->irq)
+		raise_threaded_irq(s->irq);
 }
 
 static void max3100_timeout(unsigned long data)
@@ -552,14 +558,16 @@ static void max3100_shutdown(struct uart_port *port)
 	if (s->irq)
 		free_irq(s->irq, s);
 
-	/* set shutdown mode to save power */
-	if (s->max3100_hw_suspend)
-		s->max3100_hw_suspend(1);
-	else  {
-		u16 tx, rx;
+	if (!(s->console_flags & MAX3100_IS_CONSOLE)) {
+		/* set shutdown mode to save power */
+		if (s->max3100_hw_suspend)
+			s->max3100_hw_suspend(1);
+		else  {
+			u16 tx, rx;
 
-		tx = MAX3100_WC | MAX3100_SHDN;
-		max3100_sr(s, tx, &rx);
+			tx = MAX3100_WC | MAX3100_SHDN;
+			max3100_sr(s, tx, &rx);
+		}
 	}
 }
 
@@ -578,10 +586,8 @@ static int max3100_startup(struct uart_port *port)
 	s->parity = 0;
 	s->rts = 0;
 
-	INIT_WORK(&s->resume_work, max3100_resume_work);
-
 	if (request_threaded_irq(s->irq, NULL, max3100_ist,
-			IRQF_TRIGGER_FALLING, "max3100", s) < 0) {
+				 IRQF_TRIGGER_FALLING, "max3100", s) < 0) {
 		dev_err(&s->spi->dev, "cannot allocate irq %d\n", s->irq);
 		s->irq = 0;
 		return -EBUSY;
@@ -699,6 +705,136 @@ static struct uart_ops max3100_ops = {
 	.verify_port	= max3100_verify_port,
 };
 
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+
+static void max3100_console_putchar(struct uart_port *port, int ch)
+{
+	struct max3100_port *s = container_of(port, struct max3100_port, port);
+	unsigned long tout = 10 * HZ / 1000; /* 10ms */
+	unsigned long start;
+	u16 tx, rx;
+
+	if (tout == 0)
+		tout = 1;
+	start = jiffies;
+	do {
+		tx = MAX3100_RC;
+		max3100_sr(s, tx, &rx);
+	} while ((rx & MAX3100_T) == 0 &&
+		 !time_after(jiffies, start + tout));
+	tx = ch;
+	max3100_calc_parity(s, &tx);
+	tx |= MAX3100_WD | MAX3100_RTS;
+	max3100_sr(s, tx, &rx);
+}
+
+static void max3100_console_write(struct console *co,
+				  const char *str, unsigned int count)
+{
+	struct max3100_port *s = max3100s[co->index];;
+
+	uart_console_write(&s->port, str, count, max3100_console_putchar);
+}
+
+static int max3100_console_setup(struct console *co, char *options)
+{
+	struct max3100_port *s;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	int ret;
+	u16 tx, rx;
+
+	if (co->index == -1 || co->index >= MAX_MAX3100)
+		co->index = 0;
+	s = max3100s[co->index];
+	if (!s)
+		return -ENOENT;
+	s->console_flags |= MAX3100_IS_CONSOLE;
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+	ret = uart_set_options(&s->port, co, baud, parity, bits, flow);
+
+	tx = 0;
+	switch (baud) {
+	case 300:
+		tx = 15;
+		break;
+	case 600:
+		tx = 14 + s->crystal;
+		break;
+	case 1200:
+		tx = 13 + s->crystal;
+		break;
+	case 2400:
+		tx = 12 + s->crystal;
+		break;
+	case 4800:
+		tx = 11 + s->crystal;
+		break;
+	case 9600:
+		tx = 10 + s->crystal;
+		break;
+	case 19200:
+		tx = 9 + s->crystal;
+		break;
+	case 38400:
+		tx = 8 + s->crystal;
+		break;
+	case 57600:
+		tx = 1 + s->crystal;
+		break;
+	case 115200:
+		tx = 0 + s->crystal;
+		break;
+	case 230400:
+		tx = 0;
+		break;
+	}
+
+	if (bits == 8) {
+		tx &= ~MAX3100_L;
+		s->parity &= ~MAX3100_7BIT;
+	} else {
+		tx |= MAX3100_L;
+		s->parity |= MAX3100_7BIT;
+	}
+
+	if (parity == 'o' || parity == 'e') {
+		tx |= MAX3100_PE;
+		parity |= MAX3100_PARITY_ON;
+	} else {
+		tx &= ~MAX3100_PE;
+		parity &= ~MAX3100_PARITY_ON;
+	}
+
+	if (parity == 'o')
+		parity |= MAX3100_PARITY_ODD;
+	else
+		parity &= ~MAX3100_PARITY_ODD;
+
+
+	tx |= MAX3100_WC;
+	max3100_sr(s, tx, &rx);
+
+	msleep(50);
+	return ret;
+}
+
+static struct uart_driver max3100_uart_driver;
+static struct console max3100_console = {
+	.name		= "ttyMAX",
+	.write		= max3100_console_write,
+	.device		= uart_console_device,
+	.setup		= max3100_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
+	.data		= &max3100_uart_driver,
+};
+#endif
+
 static struct uart_driver max3100_uart_driver = {
 	.owner          = THIS_MODULE,
 	.driver_name    = "ttyMAX",
@@ -706,6 +842,9 @@ static struct uart_driver max3100_uart_driver = {
 	.major          = MAX3100_MAJOR,
 	.minor          = MAX3100_MINOR,
 	.nr             = MAX_MAX3100,
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+	.cons           = &max3100_console,
+#endif
 };
 static int uart_driver_registered;
 
@@ -768,18 +907,26 @@ static int __devinit max3100_probe(struct spi_device *spi)
 	max3100s[i]->port.line = i;
 	max3100s[i]->port.type = PORT_MAX3100;
 	max3100s[i]->port.dev = &spi->dev;
+	INIT_WORK(&max3100s[i]->resume_work, max3100_resume_work);
 	retval = uart_add_one_port(&max3100_uart_driver, &max3100s[i]->port);
 	if (retval < 0)
 		dev_warn(&spi->dev,
 			 "uart_add_one_port failed for line %d with error %d\n",
 			 i, retval);
 
-	/* set shutdown mode to save power. Will be woken-up on open */
-	if (max3100s[i]->max3100_hw_suspend)
-		max3100s[i]->max3100_hw_suspend(1);
-	else {
-		tx = MAX3100_WC | MAX3100_SHDN;
-		max3100_sr(max3100s[i], tx, &rx);
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+	if (i == (CONFIG_SERIAL_MAX3100_CONSOLE_N - 1))
+		register_console(&max3100_console);
+#endif
+
+	if (!(max3100s[i]->console_flags & MAX3100_IS_CONSOLE)) {
+		/* set shutdown mode to save power. Will be woken-up on open */
+		if (max3100s[i]->max3100_hw_suspend)
+			max3100s[i]->max3100_hw_suspend(1);
+		else {
+			tx = MAX3100_WC | MAX3100_SHDN;
+			max3100_sr(max3100s[i], tx, &rx);
+		}
 	}
 	mutex_unlock(&max3100s_lock);
 	return 0;
@@ -810,6 +957,9 @@ static int __devexit max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+#ifdef CONFIG_SERIAL_MAX3100_CONSOLE
+	unregister_console(&max3100_console);
+#endif
 
 	mutex_unlock(&max3100s_lock);
 	return 0;
-- 
1.5.6.5

