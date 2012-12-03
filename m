From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] serial: sccnxp: Implement polling mode
Date: Mon,  3 Dec 2012 22:23:31 +0400
Message-ID: <1354559012-21882-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp22.mail.ru ([94.100.176.175]:49631 "EHLO smtp22.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab2LCSXk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Dec 2012 13:23:40 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>

This patch adds support for polling work mode, i.e. system is perform
periodical check chip status when IRQ-line is not connected to CPU.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c          |  148 +++++++++++++++++++++++----------
 include/linux/platform_data/sccnxp.h |    2 +
 2 files changed, 105 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 418b495..ae68e8c 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -23,6 +23,7 @@
 #include <linux/io.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/spinlock.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/sccnxp.h>
 
@@ -106,6 +107,7 @@ enum {
 struct sccnxp_port {
 	struct uart_driver	uart;
 	struct uart_port	port[SCCNXP_MAX_UARTS];
+	bool			opened[SCCNXP_MAX_UARTS];
 
 	const char		*name;
 	int			irq;
@@ -122,7 +124,10 @@ struct sccnxp_port {
 	struct console		console;
 #endif
 
-	struct mutex		sccnxp_mutex;
+	spinlock_t		lock;
+
+	bool			poll;
+	struct timer_list	timer;
 
 	struct sccnxp_pdata	pdata;
 };
@@ -377,31 +382,48 @@ static void sccnxp_handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
-static irqreturn_t sccnxp_ist(int irq, void *dev_id)
+static void sccnxp_handle_events(struct sccnxp_port *s)
 {
 	int i;
 	u8 isr;
-	struct sccnxp_port *s = (struct sccnxp_port *)dev_id;
-
-	mutex_lock(&s->sccnxp_mutex);
 
-	for (;;) {
+	do {
 		isr = sccnxp_read(&s->port[0], SCCNXP_ISR_REG);
 		isr &= s->imr;
 		if (!isr)
 			break;
 
-		dev_dbg(s->port[0].dev, "IRQ status: 0x%02x\n", isr);
-
 		for (i = 0; i < s->uart.nr; i++) {
-			if (isr & ISR_RXRDY(i))
+			if (s->opened[i] && (isr & ISR_RXRDY(i)))
 				sccnxp_handle_rx(&s->port[i]);
-			if (isr & ISR_TXRDY(i))
+			if (s->opened[i] && (isr & ISR_TXRDY(i)))
 				sccnxp_handle_tx(&s->port[i]);
 		}
-	}
+	} while (1);
+}
+
+static void sccnxp_timer(unsigned long data)
+{
+	struct sccnxp_port *s = (struct sccnxp_port *)data;
+	unsigned long flags;
 
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
+	sccnxp_handle_events(s);
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	if (!timer_pending(&s->timer))
+		mod_timer(&s->timer, jiffies +
+			  usecs_to_jiffies(s->pdata.poll_time_us));
+}
+
+static irqreturn_t sccnxp_ist(int irq, void *dev_id)
+{
+	struct sccnxp_port *s = (struct sccnxp_port *)dev_id;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+	sccnxp_handle_events(s);
+	spin_unlock_irqrestore(&s->lock, flags);
 
 	return IRQ_HANDLED;
 }
@@ -409,8 +431,9 @@ static irqreturn_t sccnxp_ist(int irq, void *dev_id)
 static void sccnxp_start_tx(struct uart_port *port)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 
 	/* Set direction to output */
 	if (s->flags & SCCNXP_HAVE_IO)
@@ -418,7 +441,7 @@ static void sccnxp_start_tx(struct uart_port *port)
 
 	sccnxp_enable_irq(port, IMR_TXRDY);
 
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static void sccnxp_stop_tx(struct uart_port *port)
@@ -429,20 +452,22 @@ static void sccnxp_stop_tx(struct uart_port *port)
 static void sccnxp_stop_rx(struct uart_port *port)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 	sccnxp_port_write(port, SCCNXP_CR_REG, CR_RX_DISABLE);
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static unsigned int sccnxp_tx_empty(struct uart_port *port)
 {
 	u8 val;
+	unsigned long flags;
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 	val = sccnxp_port_read(port, SCCNXP_SR_REG);
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 
 	return (val & SR_TXEMT) ? TIOCSER_TEMT : 0;
 }
@@ -455,28 +480,30 @@ static void sccnxp_enable_ms(struct uart_port *port)
 static void sccnxp_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
 	if (!(s->flags & SCCNXP_HAVE_IO))
 		return;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 
 	sccnxp_set_bit(port, DTR_OP, mctrl & TIOCM_DTR);
 	sccnxp_set_bit(port, RTS_OP, mctrl & TIOCM_RTS);
 
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static unsigned int sccnxp_get_mctrl(struct uart_port *port)
 {
 	u8 bitmask, ipr;
+	unsigned long flags;
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 
 	if (!(s->flags & SCCNXP_HAVE_IO))
 		return mctrl;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 
 	ipr = ~sccnxp_read(port, SCCNXP_IPCR_REG);
 
@@ -505,7 +532,7 @@ static unsigned int sccnxp_get_mctrl(struct uart_port *port)
 		mctrl |= (ipr & bitmask) ? TIOCM_RNG : 0;
 	}
 
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 
 	return mctrl;
 }
@@ -513,21 +540,23 @@ static unsigned int sccnxp_get_mctrl(struct uart_port *port)
 static void sccnxp_break_ctl(struct uart_port *port, int break_state)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 	sccnxp_port_write(port, SCCNXP_CR_REG, break_state ?
 			  CR_CMD_START_BREAK : CR_CMD_STOP_BREAK);
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static void sccnxp_set_termios(struct uart_port *port,
 			       struct ktermios *termios, struct ktermios *old)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 	u8 mr1, mr2;
 	int baud;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 
 	/* Mask termios capabilities we don't support */
 	termios->c_cflag &= ~CMSPAR;
@@ -594,20 +623,22 @@ static void sccnxp_set_termios(struct uart_port *port,
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	/* Report actual baudrate back to core */
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
 
 	/* Enable RX & TX */
 	sccnxp_port_write(port, SCCNXP_CR_REG, CR_RX_ENABLE | CR_TX_ENABLE);
 
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static int sccnxp_startup(struct uart_port *port)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 
 	if (s->flags & SCCNXP_HAVE_IO) {
 		/* Outputs are controlled manually */
@@ -626,7 +657,9 @@ static int sccnxp_startup(struct uart_port *port)
 	/* Enable RX interrupt */
 	sccnxp_enable_irq(port, IMR_RXRDY);
 
-	mutex_unlock(&s->sccnxp_mutex);
+	s->opened[port->line] = 1;
+
+	spin_unlock_irqrestore(&s->lock, flags);
 
 	return 0;
 }
@@ -634,8 +667,11 @@ static int sccnxp_startup(struct uart_port *port)
 static void sccnxp_shutdown(struct uart_port *port)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
 
-	mutex_lock(&s->sccnxp_mutex);
+	s->opened[port->line] = 0;
 
 	/* Disable interrupts */
 	sccnxp_disable_irq(port, IMR_TXRDY | IMR_RXRDY);
@@ -647,7 +683,7 @@ static void sccnxp_shutdown(struct uart_port *port)
 	if (s->flags & SCCNXP_HAVE_IO)
 		sccnxp_set_bit(port, DIR_OP, 0);
 
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static const char *sccnxp_type(struct uart_port *port)
@@ -721,10 +757,11 @@ static void sccnxp_console_write(struct console *co, const char *c, unsigned n)
 {
 	struct sccnxp_port *s = (struct sccnxp_port *)co->data;
 	struct uart_port *port = &s->port[co->index];
+	unsigned long flags;
 
-	mutex_lock(&s->sccnxp_mutex);
+	spin_lock_irqsave(&s->lock, flags);
 	uart_console_write(port, c, n, sccnxp_console_putchar);
-	mutex_unlock(&s->sccnxp_mutex);
+	spin_unlock_irqrestore(&s->lock, flags);
 }
 
 static int sccnxp_console_setup(struct console *co, char *options)
@@ -763,7 +800,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, s);
 
-	mutex_init(&s->sccnxp_mutex);
+	spin_lock_init(&s->lock);
 
 	/* Individual chip settings */
 	switch (chiptype) {
@@ -860,11 +897,19 @@ static int sccnxp_probe(struct platform_device *pdev)
 	} else
 		memcpy(&s->pdata, pdata, sizeof(struct sccnxp_pdata));
 
-	s->irq = platform_get_irq(pdev, 0);
-	if (s->irq <= 0) {
-		dev_err(&pdev->dev, "Missing irq resource data\n");
-		ret = -ENXIO;
-		goto err_out;
+	if (pdata->poll_time_us) {
+		dev_info(&pdev->dev, "Using poll mode, resolution %u usecs\n",
+			 pdata->poll_time_us);
+		s->poll = 1;
+	}
+
+	if (!s->poll) {
+		s->irq = platform_get_irq(pdev, 0);
+		if (s->irq < 0) {
+			dev_err(&pdev->dev, "Missing irq resource data\n");
+			ret = -ENXIO;
+			goto err_out;
+		}
 	}
 
 	/* Check input frequency */
@@ -929,13 +974,23 @@ static int sccnxp_probe(struct platform_device *pdev)
 	if (s->pdata.init)
 		s->pdata.init();
 
-	ret = devm_request_threaded_irq(&pdev->dev, s->irq, NULL, sccnxp_ist,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					dev_name(&pdev->dev), s);
-	if (!ret)
+	if (!s->poll) {
+		ret = devm_request_threaded_irq(&pdev->dev, s->irq, NULL,
+						sccnxp_ist,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						dev_name(&pdev->dev), s);
+		if (!ret)
+			return 0;
+
+		dev_err(&pdev->dev, "Unable to reguest IRQ %i\n", s->irq);
+	} else {
+		init_timer(&s->timer);
+		setup_timer(&s->timer, sccnxp_timer, (unsigned long)s);
+		mod_timer(&s->timer, jiffies +
+			  usecs_to_jiffies(s->pdata.poll_time_us));
 		return 0;
-
-	dev_err(&pdev->dev, "Unable to reguest IRQ %i\n", s->irq);
+	}
 
 err_out:
 	platform_set_drvdata(pdev, NULL);
@@ -948,7 +1003,10 @@ static int sccnxp_remove(struct platform_device *pdev)
 	int i;
 	struct sccnxp_port *s = platform_get_drvdata(pdev);
 
-	devm_free_irq(&pdev->dev, s->irq, s);
+	if (!s->poll)
+		devm_free_irq(&pdev->dev, s->irq, s);
+	else
+		del_timer_sync(&s->timer);
 
 	for (i = 0; i < s->uart.nr; i++)
 		uart_remove_one_port(&s->uart, &s->port[i]);
diff --git a/include/linux/platform_data/sccnxp.h b/include/linux/platform_data/sccnxp.h
index 7311ccd..096de90 100644
--- a/include/linux/platform_data/sccnxp.h
+++ b/include/linux/platform_data/sccnxp.h
@@ -84,6 +84,8 @@ struct sccnxp_pdata {
 	const u8		reg_shift;
 	/* Modem control lines configuration */
 	const u32		mctrl_cfg[SCCNXP_MAX_UARTS];
+	/* Timer value for polling mode (usecs) */
+	const unsigned int	poll_time_us;
 	/* Called during startup */
 	void (*init)(void);
 	/* Called before finish */
-- 
1.7.8.6

