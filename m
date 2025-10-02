Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EF8156230;
	Thu,  2 Oct 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417077; cv=none; b=o5Qqq/Z79R+7mrXQ1FZyCGNzMqnTUk5T84atKlEVWD1kyE+pWKF4+rOogCiHqCWD6AHT5BssqjWsJs5/QwS8pwlF70wxwOGhr8fNMiZZnmfsH8ljFtHqeBDMfSH5qh2j0UaEnriwyp5gtbcB0/ASX0lfFVwgDnafy9c1haSUzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417077; c=relaxed/simple;
	bh=gMNy4QEbMqeU8/mITQaIbAbDT/RyVu50K3NKNO/RmR0=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=mJeq4GFBU7umDxJJs3o8zwm2CHWTSkmYE4udLq0DNZPt4U8vkswEhSDMHBSsnodIelRFyCrSBli2SbqUcyu3CVQfwU3kqq2F4YgdHze4e5brmBvZPURttosQglOQmwTXBumIyqd9NzVX0Kttg6WLLxSXtob1lLKWkLikYcv3Xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=GU7+lusN; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GU7+lusN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=rEQHKSVgxMuVe+bIU/NsbGX/h3ToaQ335nLkMWEqPAs=; b=GU7+lusNsDpkM7nGxHBCAJgCRk
	itqcOBmNS8bbJUBcbAwGw9krDWPEI5neB1/U+O75rn7zU9YINjen6oXiVFFqjNWk68X2NUCId+OZx
	XOMVNNfM4KNuO9RjYeccLnjQmbbtOXCH8wUp8q5bQRMO6xGFlfFt1hZQcdOktjvO7GqA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4Kki-0005hy-9S; Thu, 02 Oct 2025 10:57:52 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu,  2 Oct 2025 10:57:33 -0400
Message-Id: <20251002145738.3250272-11-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002145738.3250272-1-hugo@hugovil.com>
References: <20251002145738.3250272-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v2 10/15] serial: sc16is7xx: simplify to_sc16is7xx_one() with a single parameter
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify macro to_sc16is7xx_one() to only take one parameter, as most
of the time (19) it is called with the "port" structure name. This
improves readability.

For the remaining places where it is called (4), simply use container_of()
locally. This is similar to what is done in other drivers (ex: max310x).
For sc16is7xx_tx_proc(), first assigning "one" variable allows to simplify
"port" variable init.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 48 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a7a6d613459dc..c6d4ad8d84d16 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -366,11 +366,11 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
-#define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
+#define to_sc16is7xx_one(p)	container_of((p), struct sc16is7xx_one, port)
 
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 	unsigned int val = 0;
 
 	regmap_read(one->regmap, reg, &val);
@@ -380,21 +380,21 @@ static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
 
 static void sc16is7xx_port_write(struct uart_port *port, u8 reg, u8 val)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	regmap_write(one->regmap, reg, val);
 }
 
 static void sc16is7xx_fifo_read(struct uart_port *port, u8 *rxbuf, unsigned int rxlen)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, rxbuf, rxlen);
 }
 
 static void sc16is7xx_fifo_write(struct uart_port *port, u8 *txbuf, u8 to_send)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	/*
 	 * Don't send zero-length data, at least on SPI it confuses the chip
@@ -409,7 +409,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 *txbuf, u8 to_send)
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 				  u8 mask, u8 val)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	regmap_update_bits(one->regmap, reg, mask, val);
 }
@@ -441,7 +441,7 @@ static void sc16is7xx_power(struct uart_port *port, int on)
  */
 static void sc16is7xx_regs_lock(struct uart_port *port, u8 register_set)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	mutex_lock(&one->lock);
 
@@ -457,7 +457,7 @@ static void sc16is7xx_regs_lock(struct uart_port *port, u8 register_set)
 
 static void sc16is7xx_regs_unlock(struct uart_port *port)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	/* Re-enable cache updates when writing to general registers */
 	regcache_cache_bypass(one->regmap, false);
@@ -471,7 +471,7 @@ static void sc16is7xx_regs_unlock(struct uart_port *port)
 static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	lockdep_assert_held_once(&port->lock);
 
@@ -484,7 +484,7 @@ static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	lockdep_assert_held_once(&port->lock);
 
@@ -615,7 +615,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 				unsigned int iir)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 	unsigned int lsr = 0, bytes_read, i;
 	bool read_lsr = (iir == SC16IS7XX_IIR_RLSE_SRC);
 	u8 ch, flag;
@@ -782,7 +782,7 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	unsigned int iir, rxlen;
 	struct uart_port *port = &s->p[portno].port;
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	guard(mutex)(&one->lock);
 
@@ -862,8 +862,8 @@ static void sc16is7xx_poll_proc(struct kthread_work *ws)
 
 static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
-	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = container_of(ws, struct sc16is7xx_one, tx_work);
+	struct uart_port *port = &one->port;
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
@@ -895,7 +895,7 @@ static void sc16is7xx_reconf_rs485(struct uart_port *port)
 
 static void sc16is7xx_reg_proc(struct kthread_work *ws)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(ws, reg_work);
+	struct sc16is7xx_one *one = container_of(ws, struct sc16is7xx_one, reg_work);
 	struct sc16is7xx_one_config config;
 	unsigned long irqflags;
 
@@ -933,7 +933,7 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 
 static void sc16is7xx_ms_proc(struct kthread_work *ws)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(ws, ms_work.work);
+	struct sc16is7xx_one *one = container_of(ws, struct sc16is7xx_one, ms_work.work);
 	struct sc16is7xx_port *s = dev_get_drvdata(one->port.dev);
 
 	if (one->port.state) {
@@ -946,7 +946,7 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 
 static void sc16is7xx_enable_ms(struct uart_port *port)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 
 	lockdep_assert_held_once(&port->lock);
@@ -957,7 +957,7 @@ static void sc16is7xx_enable_ms(struct uart_port *port)
 static void sc16is7xx_start_tx(struct uart_port *port)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	kthread_queue_work(&s->kworker, &one->tx_work);
 }
@@ -996,7 +996,7 @@ static unsigned int sc16is7xx_tx_empty(struct uart_port *port)
 
 static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	/* Called with port lock taken so we can only return cached value */
 	return one->old_mctrl;
@@ -1005,7 +1005,7 @@ static unsigned int sc16is7xx_get_mctrl(struct uart_port *port)
 static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	one->config.flags |= SC16IS7XX_RECONF_MD;
 	kthread_queue_work(&s->kworker, &one->reg_work);
@@ -1022,7 +1022,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 				  struct ktermios *termios,
 				  const struct ktermios *old)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 	unsigned int lcr, flow = 0;
 	int baud;
 	unsigned long flags;
@@ -1125,7 +1125,7 @@ static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termi
 				  struct serial_rs485 *rs485)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/*
@@ -1145,7 +1145,7 @@ static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termi
 
 static int sc16is7xx_startup(struct uart_port *port)
 {
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	unsigned int val;
 	unsigned long flags;
@@ -1209,7 +1209,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 static void sc16is7xx_shutdown(struct uart_port *port)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	kthread_cancel_delayed_work_sync(&one->ms_work);
 
-- 
2.39.5

