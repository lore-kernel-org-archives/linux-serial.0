From: Christian Pellegrin <chripell@fsfe.org>
Subject: [PATCH v1 4/4] max3100: introduced to_max3100_port, small style fixes
Date: Tue, 23 Mar 2010 11:29:53 +0100
Message-ID: <1269340193-6606-1-git-send-email-chripell@fsfe.org>
References: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:40493 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab0CWKcP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Mar 2010 06:32:15 -0400
In-Reply-To: <1269340105-6503-1-git-send-email-chripell@fsfe.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, grant.likely@secretlab.ca, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.netlinu
Cc: Christian Pellegrin <chripell@fsfe.org>

static inline to_max3100_port was introduced for clarity. Whitespace
fixes.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 drivers/serial/max3100.c |   77 +++++++++++++++-------------------------------
 1 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/serial/max3100.c b/drivers/serial/max3100.c
index ec3e13a..6644222 100644
--- a/drivers/serial/max3100.c
+++ b/drivers/serial/max3100.c
@@ -131,7 +131,7 @@ struct max3100_port {
 	/* poll time (in ms) for ctrl lines */
 	int poll_time;
 	/* and its timer */
-	struct timer_list	timer;
+	struct timer_list timer;
 
 	int console_flags;
 	/* is this port a console? */
@@ -153,6 +153,11 @@ struct max3100_port {
 static struct max3100_port *max3100s[MAX_MAX3100]; /* the chips */
 static DEFINE_MUTEX(max3100s_lock);		   /* race on probe */
 
+static inline struct max3100_port *to_max3100_port(struct uart_port *port)
+{
+  return container_of(port, struct max3100_port, port);
+}
+
 static int max3100_do_parity(struct max3100_port *s, u16 c)
 {
 	int parity;
@@ -344,9 +349,7 @@ static irqreturn_t max3100_ist(int irq, void *dev_id)
 
 static void max3100_enable_ms(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	if (s->poll_time > 0)
 		mod_timer(&s->timer, jiffies);
@@ -355,9 +358,7 @@ static void max3100_enable_ms(struct uart_port *port)
 
 static void max3100_start_tx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -366,9 +367,7 @@ static void max3100_start_tx(struct uart_port *port)
 
 static void max3100_stop_rx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -382,9 +381,7 @@ static void max3100_stop_rx(struct uart_port *port)
 
 static unsigned int max3100_tx_empty(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -395,9 +392,7 @@ static unsigned int max3100_tx_empty(struct uart_port *port)
 
 static unsigned int max3100_get_mctrl(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -409,9 +404,7 @@ static unsigned int max3100_get_mctrl(struct uart_port *port)
 
 static void max3100_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int rts;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -431,9 +424,7 @@ static void
 max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 		    struct ktermios *old)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int baud = 0;
 	unsigned cflag;
 	u32 param_new, param_mask, parity = 0;
@@ -557,9 +548,7 @@ max3100_set_termios(struct uart_port *port, struct ktermios *termios,
 
 static void max3100_shutdown(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -586,9 +575,7 @@ static void max3100_shutdown(struct uart_port *port)
 
 static int max3100_startup(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -600,7 +587,7 @@ static int max3100_startup(struct uart_port *port)
 	s->rts = 0;
 
 	if (request_threaded_irq(s->irq, NULL, max3100_ist,
-			IRQF_TRIGGER_FALLING, "max3100", s) < 0) {
+				 IRQF_TRIGGER_FALLING, "max3100", s) < 0) {
 		dev_err(&s->spi->dev, "cannot allocate irq %d\n", s->irq);
 		s->irq = 0;
 		return -EBUSY;
@@ -626,9 +613,7 @@ static int max3100_startup(struct uart_port *port)
 
 static const char *max3100_type(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -637,18 +622,14 @@ static const char *max3100_type(struct uart_port *port)
 
 static void max3100_release_port(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
 
 static void max3100_config_port(struct uart_port *port, int flags)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 
@@ -659,9 +640,7 @@ static void max3100_config_port(struct uart_port *port, int flags)
 static int max3100_verify_port(struct uart_port *port,
 			       struct serial_struct *ser)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 	int ret = -EINVAL;
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
@@ -673,18 +652,14 @@ static int max3100_verify_port(struct uart_port *port,
 
 static void max3100_stop_tx(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
 
 static int max3100_request_port(struct uart_port *port)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 	return 0;
@@ -692,9 +667,7 @@ static int max3100_request_port(struct uart_port *port)
 
 static void max3100_break_ctl(struct uart_port *port, int break_state)
 {
-	struct max3100_port *s = container_of(port,
-					      struct max3100_port,
-					      port);
+	struct max3100_port *s = to_max3100_port(port);
 
 	dev_dbg(&s->spi->dev, "%s\n", __func__);
 }
@@ -1010,9 +983,9 @@ static int max3100_suspend(struct spi_device *spi, pm_message_t state)
 	s->console_flags |= MAX3100_SUSPENDING;
 	disable_irq(s->irq);
 
-	if (s->max3100_hw_suspend)
+	if (s->max3100_hw_suspend) {
 		s->max3100_hw_suspend(1);
-	else {
+	} else {
 		/* no HW suspend, so do SW one */
 		u16 tx, rx;
 
-- 
1.5.6.5

