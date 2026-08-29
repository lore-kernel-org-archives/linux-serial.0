Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553C3F1ADA;
	Sat, 29 Aug 2026 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020186; cv=none; b=CmaTO9Uyk6YIttjD300xnuFjP0+JEKKi5s49i6i9OvOaR4kei6AOjcyp1+/ECvs/pRqRm+gBJVHhmF03yQKTBVv4LXaKax4lE9gxTWtu2kSQ73IVpwwzBXjYoRB972SWxcf9VrPCV3NvSjWENkXEv2PKp4CRLw4tXJGpQSfVifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020186; c=relaxed/simple;
	bh=mMN9QqRnJUj18c3qYawSslLuAcpjtpQ/jQxX2r9fvzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAfH87i1AXfnuxzg8nsefin5Ln2FZxlFa4TkdvflHZD2Qgewkp1R/yrvqFvAZG5O21wNknIsO7JHc6jFq/AxCKjGNB0ZJgvnhG70erJ7flIGsjddpyfGFCHN6YMHOXiYZVcLeUyKr46bA7GHILwYgCJUsMsfaTvoRrSUGD1Ugl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=P0TsPUM1; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=I0ouGfHg; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="P0TsPUM1";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="I0ouGfHg"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788020179; bh=cfVMFIJrg+09/nJj00CWZEw
	QgKdYXaKHGfOUSAKISi4=; b=P0TsPUM1bXbFJTTpdDQ6HEWM9y5oFzSBCioUqVPZvsH0J8Qd52
	+YMYgJL0+nvW8eDoR9Iym1FtY0L3oCWTiT76ufUULtWgPcPDqEJWKhiUoRsTyD4GhhYL/epC1Py
	gX24zVmjSaHf9UCL7HgBJCGL5NAwR/GnO1KWIvQl/fSCTS3xV3Q/KOWgOzsfN+ZDYEFwfc5D6HR
	zCTonpFbAWZNEHN5iSM/F+fJpuiKe69P2U7UHHUY20oonlLt9eUwoImGyHAIaGbJY0L3IrjpWq+
	6V6IR9emUeOA1RIU9+pVEKyY75sdd4Yw0z7rEIEbDH3Blvy2EINoGd1DqjdbOgReW4w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788020179; bh=cfVMFIJrg+09/nJj00CWZEw
	QgKdYXaKHGfOUSAKISi4=; b=I0ouGfHgbGIx9hsqSjhFqMKu1f82oQmSKKSS4OvKNv0aHRb6GM
	MfJLFLEVC2SFDzK8JysIFU9hZaj4PgZjV2AQ==;
From: Bradley Morgan <include@grrlz.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH 3/5] tty: sc16is7xx: convert to kthread_run_worker
Date: Sat, 29 Aug 2026 16:16:20 +0000
Message-ID: <20260829161620.19047-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260829161150.16301-1-include@grrlz.net>
References: <20260829161150.16301-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

Embedding a kthread_worker and running kthread_worker_fn yourself is
the old way. Convert sc16is7xx to kthread_run_worker(), dropping the
separate kworker_task pointer.

This is part of removing the worker->task self-assignment in
kthread_worker_fn().

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/tty/serial/sc16is7xx.c | 39 ++++++++++++++++------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7107a0fb1e7b..2cfc1f290009 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -306,8 +306,7 @@ struct sc16is7xx_port {
 	unsigned long			gpio_valid_mask;
 #endif
 	u8				mctrl_mask;
-	struct kthread_worker		kworker;
-	struct task_struct		*kworker_task;
+	struct kthread_worker		*kworker;
 	struct kthread_delayed_work	poll_work;
 	bool				polling;
 	struct sc16is7xx_one		p[];
@@ -434,7 +433,7 @@ static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 	one->config.flags |= SC16IS7XX_RECONF_IER;
 	one->config.ier_mask |= bit;
 	one->config.ier_val &= ~bit;
-	kthread_queue_work(&s->kworker, &one->reg_work);
+	kthread_queue_work(s->kworker, &one->reg_work);
 }
 
 static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
@@ -447,7 +446,7 @@ static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
 	one->config.flags |= SC16IS7XX_RECONF_IER;
 	one->config.ier_mask |= bit;
 	one->config.ier_val |= bit;
-	kthread_queue_work(&s->kworker, &one->reg_work);
+	kthread_queue_work(s->kworker, &one->reg_work);
 }
 
 static void sc16is7xx_stop_tx(struct uart_port *port)
@@ -813,7 +812,7 @@ static void sc16is7xx_poll_proc(struct kthread_work *ws)
 	sc16is7xx_irq(0, s);
 
 	/* Setup delay based on SC16IS7XX_POLL_PERIOD_MS */
-	kthread_queue_delayed_work(&s->kworker, &s->poll_work,
+	kthread_queue_delayed_work(s->kworker, &s->poll_work,
 				   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
 }
 
@@ -900,7 +899,7 @@ static void sc16is7xx_ms_proc(struct kthread_work *ws)
 		scoped_guard(mutex, &one->lock)
 			sc16is7xx_update_mlines(one);
 
-		kthread_queue_delayed_work(&s->kworker, &one->ms_work, HZ);
+		kthread_queue_delayed_work(s->kworker, &one->ms_work, HZ);
 	}
 }
 
@@ -911,7 +910,7 @@ static void sc16is7xx_enable_ms(struct uart_port *port)
 
 	lockdep_assert_held_once(&port->lock);
 
-	kthread_queue_delayed_work(&s->kworker, &one->ms_work, 0);
+	kthread_queue_delayed_work(s->kworker, &one->ms_work, 0);
 }
 
 static void sc16is7xx_start_tx(struct uart_port *port)
@@ -919,7 +918,7 @@ static void sc16is7xx_start_tx(struct uart_port *port)
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
-	kthread_queue_work(&s->kworker, &one->tx_work);
+	kthread_queue_work(s->kworker, &one->tx_work);
 }
 
 static void sc16is7xx_throttle(struct uart_port *port)
@@ -968,7 +967,7 @@ static void sc16is7xx_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port);
 
 	one->config.flags |= SC16IS7XX_RECONF_MD;
-	kthread_queue_work(&s->kworker, &one->reg_work);
+	kthread_queue_work(s->kworker, &one->reg_work);
 }
 
 static void sc16is7xx_break_ctl(struct uart_port *port, int break_state)
@@ -1098,7 +1097,7 @@ static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termi
 	}
 
 	one->config.flags |= SC16IS7XX_RECONF_RS485;
-	kthread_queue_work(&s->kworker, &one->reg_work);
+	kthread_queue_work(s->kworker, &one->reg_work);
 
 	return 0;
 }
@@ -1159,7 +1158,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 	uart_port_unlock_irqrestore(port, flags);
 
 	if (s->polling)
-		kthread_queue_delayed_work(&s->kworker, &s->poll_work,
+		kthread_queue_delayed_work(s->kworker, &s->poll_work,
 					   msecs_to_jiffies(SC16IS7XX_POLL_PERIOD_MS));
 
 	return 0;
@@ -1186,7 +1185,7 @@ static void sc16is7xx_shutdown(struct uart_port *port)
 	if (s->polling)
 		kthread_cancel_delayed_work_sync(&s->poll_work);
 
-	kthread_flush_worker(&s->kworker);
+	kthread_flush_worker(s->kworker);
 }
 
 static const char *sc16is7xx_type(struct uart_port *port)
@@ -1595,14 +1594,12 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	s->devtype = devtype;
 	dev_set_drvdata(dev, s);
 
-	kthread_init_worker(&s->kworker);
-	s->kworker_task = kthread_run(kthread_worker_fn, &s->kworker,
-				      "sc16is7xx");
-	if (IS_ERR(s->kworker_task)) {
-		ret = PTR_ERR(s->kworker_task);
+	s->kworker = kthread_run_worker(0, "sc16is7xx");
+	if (IS_ERR(s->kworker)) {
+		ret = PTR_ERR(s->kworker);
 		goto out_clk;
 	}
-	sched_set_fifo(s->kworker_task);
+	sched_set_fifo(s->kworker->task);
 
 	ret = sc16is7xx_reset(dev, regmaps[0]);
 	if (ret)
@@ -1676,7 +1673,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 	}
 
 out_kthread:
-	kthread_stop(s->kworker_task);
+	kthread_destroy_worker(s->kworker);
 
 out_clk:
 	clk_disable_unprepare(s->clk);
@@ -1705,8 +1702,8 @@ void sc16is7xx_remove(struct device *dev)
 	if (s->polling)
 		kthread_cancel_delayed_work_sync(&s->poll_work);
 
-	kthread_flush_worker(&s->kworker);
-	kthread_stop(s->kworker_task);
+	kthread_flush_worker(s->kworker);
+	kthread_destroy_worker(s->kworker);
 
 	clk_disable_unprepare(s->clk);
 }
-- 
2.47.3

