Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD76DDC7;
	Sun,  4 Aug 2024 00:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732714; cv=none; b=krYK5vxWCY95DyhoDCv5msKQLIddkad0e3XOFPYnHhDlea7rp1+7PWpD/S5T1sk+/6q9XNT3bJFOhc1fIzVVvdSSsmi6CTfSLVM5zor+NlLwioer8YSHFBKBV2u38FISssVAIR0dnFvsSxuoS2lnfuEW6Tti6gCwM3rqaP8dUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732714; c=relaxed/simple;
	bh=qu0GAhjXm3Rql3Yn+yPrWxwrSP6aPTYXniSO6W8yPIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvx2SR6XzikNy8eF+7YevaEgGX2azgssGA/5brE2RvnQjgQT/tn7qFMp9p346IkbRVJ9k0QxBLNxCzpkquNQ/kPKsiTUybtWQj47L3VImBPknrXfHmN9BoQ2KFpuBaoq21qIgJvK7eBW19xwE2hBQQJuwO+6sQ21Y39ZnzmIQgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZxpUXUrY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FY1+qHmM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZxpUXUrY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FY1+qHmM"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72KWg1lC7QoA8wkEDKOEAHKAbxE9DDTme6Zqb5h0emg=;
	b=ZxpUXUrY8CaW5ti+wfDb/ZbpzvhG9JEidFErBsSqKt7OKJ9RHamynwW8Sx2VkU2/QnxNmi
	NcimOs99tJm5nzs5MFDcyX6A4Bj0qbHUOVEUnKA0zjar2ePuYs+DBVCn8tnmWC1bivmjg3
	OhDnFUCeA5kppytVwvL0EqzLFt4v/ABUwZJY32cFBvUoY2r0BM+zceq3jWStzNj5pHlDNj
	SyX3GxBWKnmXEYFdekpVpTt3DJGnI5XrX+Ovz4AwwGcaT7d66oJb7dLqif9bBigXU86CfA
	xDmfJzviXSvG+tOD3SDiIksAGrRJZ6OEbkmY+OA3XBvdoiopwI0bX4QoBJ+/kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=72KWg1lC7QoA8wkEDKOEAHKAbxE9DDTme6Zqb5h0emg=;
	b=FY1+qHmMD6qFcoGjMuZzNHFuL/0ggxtLianNieQkJcCcdZ40Vn48fvRqWqPfUqoja3aF2z
	bjHpKe5ZAugFmQDA==
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
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v7 11/35] serial: core: Introduce wrapper to set @uart_port->cons
Date: Sun,  4 Aug 2024 02:57:14 +0206
Message-Id: <20240804005138.3722656-12-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
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
index 29e4b83e0376..5f9f06911795 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -423,11 +423,11 @@ static int univ8250_console_setup(struct console *co, char *options)
 
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
 
@@ -485,7 +485,7 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return serial8250_console_setup(port, options, true);
 	}
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8b1644f5411e..7d0134ecd82f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2480,7 +2480,7 @@ static int pl011_console_match(struct console *co, char *name, int idx,
 			continue;
 
 		co->index = i;
-		port->cons = co;
+		uart_port_set_cons(port, co);
 		return pl011_console_setup(co, options);
 	}
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9a18d0b95a41..61c7e1268957 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3168,8 +3168,15 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
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
@@ -3178,13 +3185,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
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
index 8872cd21e70a..2cf03ff2056a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -608,6 +608,23 @@ static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned
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

