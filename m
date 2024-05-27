Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52B200A9;
	Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791904; cv=none; b=JqTVGaeofWEfsZ4sxiXX2nHX4EbtQaGMGbnLt1gOTRnC4XuBgtImQ1n/G1jnOQI+fT3/q7Sykevfw0qtGZaHLPdQa47id5o0nRvX4pzFVZP5IHjZt+7MVJ6f4HJL0XIODMRDg7Nl0CLJYUeJT5bNW6E+NbWQj2KqEwl9aCA9jbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791904; c=relaxed/simple;
	bh=cFwc6eXZwJgEsJEy8i2WPFC0zBMSmXI8t49qE0YAxa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYBK6Qho6NegaAb33nqifYa4MVyVU78cDfAh6sHCw5Fvt3gQyD9hIIaht4Rxww+HhWk2Jb8YvSaP/gSw8RbSlRjPDcZM53TCYZ2h9GHnLpuu6SBeDALRd88IJVVHmFoY7/ytjN2oOZ6dFEoTA5LWtgKza/jD4YB9aYE8BEikqSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=alK1KWjc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHgWJcuS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="alK1KWjc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHgWJcuS"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWt1+yEDsP6qOdCR9l91mhS5ulhADY7ilusdjp03eQI=;
	b=alK1KWjcHbZGtwKO5rEHuvhQN+AFvXZTR2VcpjaRXXmHSJqrk9eX/rhVBhybSQfoqHDuCc
	7BALICZJbIv1oXDy33GHvvuDEQ3lzNzd3hxfn3JbzplGji24L+K9tICF43zR0nld85t025
	9dCd47lIiU350Crod3RGlZrFhjMMXgMznAb+zFL2JcIBMn0Y3vwKqBY0cuXvyLMkCVRZR/
	fvUATcVHV54RAYu2GMSXKn1vivJ+WFU4AVjbn9gvdBLy647Un5fBq91UTkT+bAlUqlflco
	NzeOJCARYpGP843XGPXlgV4LFlw0fTuYaJ9kpQAlNgElOXeEUrKSMj4UGs1Xzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zWt1+yEDsP6qOdCR9l91mhS5ulhADY7ilusdjp03eQI=;
	b=NHgWJcuS3yBBDume6ZAX5icDc5ue9u6aySYB5XIb+jN5Kcf56ppxj0jzVp2bujVbzXMeTu
	b3Rwbfht6ZVBVjDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Fabio Estevam <festevam@denx.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v6 09/30] serial: core: Introduce wrapper to set @uart_port->cons
Date: Mon, 27 May 2024 08:43:28 +0206
Message-Id: <20240527063749.391035-10-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce uart_port_set_cons() as a wrapper to set @cons of a
uart_port. The wrapper sets @cons under the port lock in order
to prevent @cons from disappearing while another context is
holding the port lock. This is necessary for a follow-up
commit relating to the port lock wrappers, which rely on @cons
not changing between lock and unlock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Tested-by: Théo Lebrun <theo.lebrun@bootlin.com> # EyeQ5, AMBA-PL011
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_core.c |  6 +++---
 drivers/tty/serial/amba-pl011.c     |  2 +-
 drivers/tty/serial/serial_core.c    | 16 ++++++++--------
 include/linux/serial_core.h         | 17 +++++++++++++++++
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b62ad9006780..41d74ee3d95a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -627,11 +627,11 @@ static int univ8250_console_setup(struct console *co, char *options)
 
 	port = &serial8250_ports[co->index].port;
 	/* link port to console */
-	port->cons = co;
+	uart_port_set_cons(port, co);
 
 	retval = serial8250_console_setup(port, options, false);
 	if (retval != 0)
-		port->cons = NULL;
+		uart_port_set_cons(port, NULL);
 	return retval;
 }
 
@@ -689,7 +689,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return serial8250_console_setup(port, options, true);
 	}
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index cf2c890a560f..347aacf8400f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2496,7 +2496,7 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return pl011_console_setup(co, options);
 	}
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d6a58a9e072a..0c13ea6a3afa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3145,8 +3145,15 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->uart_port = uport;
 	uport->state = state;
 
+	/*
+	 * If this port is in use as a console then the spinlock is already
+	 * initialised.
+	 */
+	if (!uart_console_registered(uport))
+		uart_port_spin_lock_init(uport);
+
 	state->pm_state = UART_PM_STATE_UNDEFINED;
-	uport->cons = drv->cons;
+	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 	uport->name = kasprintf(GFP_KERNEL, "%s%d", drv->dev_name,
 				drv->tty_driver->name_base + uport->line);
@@ -3155,13 +3162,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 		goto out;
 	}
 
-	/*
-	 * If this port is in use as a console then the spinlock is already
-	 * initialised.
-	 */
-	if (!uart_console_registered(uport))
-		uart_port_spin_lock_init(uport);
-
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb3324d49453..038693774f21 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -606,6 +606,23 @@ static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned
 	spin_unlock_irqrestore(&up->lock, flags);
 }
 
+/**
+ * uart_port_set_cons - Safely set the @cons field for a uart
+ * @up:		The uart port to set
+ * @con:	The new console to set to
+ *
+ * This function must be used to set @up->cons. It uses the port lock to
+ * synchronize with the port lock wrappers in order to ensure that the console
+ * cannot change or disappear while another context is holding the port lock.
+ */
+static inline void uart_port_set_cons(struct uart_port *up, struct console *con)
+{
+	unsigned long flags;
+
+	__uart_port_lock_irqsave(up, &flags);
+	up->cons = con;
+	__uart_port_unlock_irqrestore(up, flags);
+}
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
-- 
2.39.2

