Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099211;
	b=R7EspexRP70X31kgktpNTsKDnplsnDmzP/41WFoMrTGB1piJ5Ja2Plq+BVf6qDbMbAv4
	 6aH0sLQ5Lu+pR3aPUQrR8cFrnFu8AhiUnUUqL8H0WWol+2SWTEzgmjz9Gyjs3lMzHHXpO
	 Bt6rs5v9JGG2mhpiE73B4zHbj8yPfQSo2q3Uw82RnjDeJAIudlMECDymfAjMDLooKem6e
	 f6jVV85N1CEdmfb5nFT2q8K307tszwnjpXwV4fCQqjA2ouRqNzbiJrxjPmbCSvNbpnlqh
	 gYpVje6YpW2btHGHz0f9X3VHi+m2gU0n3kdSJSKZYIE+9m5U8ytYG/HM2v8UPHXdNbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099211;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=At0VEWVYKgYSpxjC/EKa7T6O3xE3CDtI5MHjGgMyTPo=;
	b=0FWrMloJuBei4RvQbLn52JMdUd8UW75+pUnuOK0Wa+Bo2bjAbzHH8BezVeImxMGYQFuI
	 yrv4aS1Nvs/ejT345qdBc7GJIn38R+5kHpeKhzZoWXk+DAziI62G07Oy5oAfeD9jocgKK
	 31lIlEyHVEB/8ODYMBzR6AteTjkofTcme6X1XZmvHHpr/RBQHJy/7TzZ98gnJSk9HCc4b
	 2gKaU75cpXcn41yGlcDIdfnE9u3AOmiqoNU0zvdbCkfXvQ7IrZTj/f3b59xMfQzdX+S7g
	 fDUEn4I5qhtbMCWAI65gQWLqopbzkX5RdDAW5cwlSgam9WhxXy56k40gdyLo9+2BcTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="liEF/T38";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C3606A33B;
	Tue, 27 Oct 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=liEF/T38
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C83F1F01828;
	Tue, 27 Oct 2026 11:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793099210;
	bh=At0VEWVYKgYSpxjC/EKa7T6O3xE3CDtI5MHjGgMyTPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=liEF/T38Q1nEq5+z6GPvnuGjFidjM2uQ/wghKi08Tk/bvh8juxgE4Yk2MlwYlEKye
	 73Z/gwbIJdus9HFxX3GOxgmwEPqGDTu2m+cmHCuCWJMhdLs8IWKQQjL97i22Xk0AaD
	 OBxMnoJR8wA/MrAy3NQ1A4mEm0TbaWjpI0C92e94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 27 Oct 2026 12:06:29 +0100
Subject: [PATCH 03/24] serial: 8250: don't wait for the em485 timers locked
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261027-tty-llm-v1-3-99b0202ae546@linuxfoundation.org>
References: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
In-Reply-To: <20261027-tty-llm-v1-0-99b0202ae546@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>, Joshua Rogers <linux@joshua.hu>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Cc: Tony Lindgren <tony@atomide.com>, Rafael Gago Castano <rgc@hms.se>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Peter Hurley <peter@hurleysoftware.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Crescent Hsieh <crescentcy.hsieh@moxa.com>, Frank Li <Frank.Li@nxp.com>, 
 Sherry Sun <sherry.sun@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 Olof Johansson <olof@lixom.net>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Robert Baldyga <r.baldyga@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kukjin Kim <kgene.kim@samsung.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, 
 Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
 Tate Whiteberg <whiteberg@arista.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 John Ogness <john.ogness@linutronix.de>, 
 Fushuai Wang <wangfushuai@baidu.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=7319;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=u8qM+wmnOTOaYappNa66NnJnJxJnW/rvs3r/WsWRAgY=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkPWvfqaiz+VLzx0AUDnfl8wZ6V6R+1DooYM0zvVTpum
 Pgu42NmRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAEzkw22G+dGPVjP8/qqyYNqG
 Ccx1hy+Uyp3262FYsIPt2k79f2dOiN1aPM3zeu6aO/OtHAE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Josef Bacik <josef@toxicpanda.com>

serial8250_em485_destroy() is called with the port lock held and
interrupts off, from ->rs485_config() and from
serial8250_unregister_port().  It calls hrtimer_cancel(), which waits
for a handler which is running, and both handlers start by taking the
port lock:

  CPU0                                  CPU1
  ioctl(TIOCSRS485), rs485 off
  uart_set_rs485_config()
    uart_port_lock_irqsave()            serial8250_em485_handle_stop_tx()
    serial8250_em485_config()             uart_port_lock_irqsave()
      serial8250_em485_destroy()            spins
        hrtimer_cancel()
          spins

All it takes is to turn RS485 off right after the end of a transmission,
when the timer for delay_rts_after_send expires.

The handlers do nothing unless em485->active_timer points to their
timer, so it is enough to clear that pointer.  What cannot be done with
the lock held is to free the structure: hrtimer_try_to_cancel() fails
for a timer whose handler is running, even if it has been started again
in the meantime.  So keep the structure in the port when RS485 is turned
off, use it again when RS485 is turned on, and free it when the port is
unregistered, where the timers can be waited for without the lock.

A port on which RS485 emulation has been used once keeps the structure,
about 150 bytes, until it is unregistered.

Fixes: 6e0a5de2136b ("serial: 8250: Use hrtimers for rs485 delays")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: "Ilpo Järvinen" <ilpo.jarvinen@linux.intel.com>
Cc: Tate Whiteberg <whiteberg@arista.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Fushuai Wang <wangfushuai@baidu.com>
Cc: Rafael Gago Castano <rgc@hms.se>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_core.c |  5 +---
 drivers/tty/serial/8250/8250_port.c | 60 ++++++++++++++++++++++++++++++-------
 include/linux/serial_8250.h         |  1 +
 4 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 21ed9c41b751..82a3b8359643 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -235,6 +235,7 @@ int serial8250_em485_config(struct uart_port *port, struct ktermios *termios,
 void serial8250_em485_start_tx(struct uart_8250_port *p, bool toggle_ier);
 void serial8250_em485_stop_tx(struct uart_8250_port *p, bool toggle_ier);
 void serial8250_em485_destroy(struct uart_8250_port *p);
+void serial8250_em485_free(struct uart_8250_port *p);
 extern struct serial_rs485 serial8250_em485_supported;
 
 /* MCR <-> TIOCM conversion */
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843cb5b..0951d3e42e1f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -947,10 +947,7 @@ void serial8250_unregister_port(struct uart_8250_port *uart)
 {
 	guard(mutex)(&serial_mutex);
 
-	if (uart->em485) {
-		guard(uart_port_lock_irqsave)(&uart->port);
-		serial8250_em485_destroy(uart);
-	}
+	serial8250_em485_free(uart);
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
 	if (serial8250_isa_devs) {
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 36b2b0a2c05c..3d47f535d6f1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -574,15 +574,22 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 	if (p->em485)
 		goto deassert_rts;
 
-	p->em485 = kmalloc_obj(struct uart_8250_em485, GFP_ATOMIC);
-	if (!p->em485)
-		return -ENOMEM;
+	if (p->em485_idle) {
+		p->em485 = p->em485_idle;
+		p->em485_idle = NULL;
+	} else {
+		p->em485 = kmalloc_obj(struct uart_8250_em485, GFP_ATOMIC);
+		if (!p->em485)
+			return -ENOMEM;
 
-	hrtimer_setup(&p->em485->stop_tx_timer, &serial8250_em485_handle_stop_tx, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-	hrtimer_setup(&p->em485->start_tx_timer, &serial8250_em485_handle_start_tx, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL);
-	p->em485->port = p;
+		hrtimer_setup(&p->em485->stop_tx_timer,
+			      &serial8250_em485_handle_stop_tx, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
+		hrtimer_setup(&p->em485->start_tx_timer,
+			      &serial8250_em485_handle_start_tx, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
+		p->em485->port = p;
+	}
 	p->em485->active_timer = NULL;
 	p->em485->tx_stopped = true;
 
@@ -604,6 +611,11 @@ static int serial8250_em485_init(struct uart_8250_port *p)
  *	The function is supposed to be called from .rs485_config callback
  *	or from any other callback protected with p->port.lock spinlock.
  *
+ *	The handlers of the timers take that lock, so they cannot be waited for
+ *	here. One which is running does nothing, as no timer is active any more.
+ *	The memory is kept for the next serial8250_em485_init() and freed by
+ *	serial8250_em485_free().
+ *
  *	See also serial8250_em485_init()
  */
 void serial8250_em485_destroy(struct uart_8250_port *p)
@@ -611,14 +623,40 @@ void serial8250_em485_destroy(struct uart_8250_port *p)
 	if (!p->em485)
 		return;
 
-	hrtimer_cancel(&p->em485->start_tx_timer);
-	hrtimer_cancel(&p->em485->stop_tx_timer);
+	hrtimer_try_to_cancel(&p->em485->start_tx_timer);
+	hrtimer_try_to_cancel(&p->em485->stop_tx_timer);
+	p->em485->active_timer = NULL;
 
-	kfree(p->em485);
+	p->em485_idle = p->em485;
 	p->em485 = NULL;
 }
 EXPORT_SYMBOL_GPL(serial8250_em485_destroy);
 
+/**
+ *	serial8250_em485_free() - release the rs485 emulation of a port
+ *	@p:	uart_8250_port port instance
+ *
+ *	Must be called without p->port.lock, as it waits for the timers.
+ */
+void serial8250_em485_free(struct uart_8250_port *p)
+{
+	struct uart_8250_em485 *em485;
+
+	scoped_guard(uart_port_lock_irqsave, &p->port) {
+		serial8250_em485_destroy(p);
+		em485 = p->em485_idle;
+		p->em485_idle = NULL;
+	}
+
+	if (!em485)
+		return;
+
+	hrtimer_cancel(&em485->start_tx_timer);
+	hrtimer_cancel(&em485->stop_tx_timer);
+	kfree(em485);
+}
+EXPORT_SYMBOL_GPL(serial8250_em485_free);
+
 struct serial_rs485 serial8250_em485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_TERMINATE_BUS | SER_RS485_RX_DURING_TX,
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index d91c0477be9d..0556bb722db4 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -173,6 +173,7 @@ struct uart_8250_port {
 	void			(*dl_write)(struct uart_8250_port *up, u32 value);
 
 	struct uart_8250_em485 *em485;
+	struct uart_8250_em485 *em485_idle;	/* kept while rs485 is off */
 	void			(*rs485_start_tx)(struct uart_8250_port *up, bool toggle_ier);
 	void			(*rs485_stop_tx)(struct uart_8250_port *up, bool toggle_ier);
 

-- 
2.56.0

