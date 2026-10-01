Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F218511E8C
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863668; cv=none; b=WR0pVNBtS6FQQrWWa1OIjNNuCjFUX6UPUG6W5TsHQDUcbo4fkDUziJhM9PGlHYYMvk8Bzyqcig1p42comHfOl5y9D7tA4QlLjP37jIz0MDa0xUTCzEG90FHqbYTDn5Fc9uBQQbjDy+1t3n8qvDZN9AzWHDg9+/hmJWTUtj1B8fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863668; c=relaxed/simple;
	bh=xx7TkyJRG+4VcccSoHnCwFaqp8q9ieCXLpMXTiQGnBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xk2zAWSEZb0D/kRaUhfjZwAoWtLFA2HjZXDWt1cBOtuiScT+CJSehX8NU4gZCSmDexP7HeLGCUsY+aRAvzxK/NqYue4ke+68T1od0lZUiPB0/jL7XLSjF5RtC0H83p5qW7qbmF3unc4+dl1TYQWV9XY665kx4xI2tX6SLL4+5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JDXIgVgC; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JDXIgVgC"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso60088875e9.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790863665; x=1791468465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGOFmX7rjCTPXj3AbUWVJx5cDdevq5A7IJ1FffTm9N0=;
        b=JDXIgVgCllaSqTJMJvZPKeWmeaeSWYDkaHGT7Xn4YWvGnl8lDzxtQfZAcXTu/MxzgA
         rf4MISgvnxVmMvFZr7zIJSpR/9mkjCkOGXsuZoGTGwU+JljJ5AGr8IegSlc/rZtKKTq2
         ApreAUkgshmmRvbFnIZuO0h/msxmKMtckDhDEBZgvw/N5PvsqZoIDftcSbooeUPv8jJl
         cPkPAipXymxt39NOs+QAZ23CUYi2ho7Yaa40cTq/yuN9w0wH1Oaq1sVpsc9YKkBeE51t
         0RZKx2y0nPrKJDIvFuWS7t5uJ68+zYxuCR/0tSGhq/anA6ML9HJNT4/Pv0X61JvFBMoi
         4C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790863665; x=1791468465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kGOFmX7rjCTPXj3AbUWVJx5cDdevq5A7IJ1FffTm9N0=;
        b=EA6fpfXBDwdUszBrSxR1cfGkJ+p/WVDxlua4QB0GCjoCjkN8xQJ+kn/4MFb+PpSWAX
         FCnxuDtQUwinunGjBqfCrPzcap1KE/WglCEC9WvXJBXvyQibPeqUw+T7Nt/ULd1A6t3x
         Zv7NCd4b6DCo+6MQdR+Ea2dqjozMMyyH6Rwl3oo9jgBmCFSWPro2C0NV+Uk+qA/P2ghY
         XyDfX8s/64qdCm5LKbtuxsAiPejUlJNcvdAwBIRgm/8RWr3734zln9oCcFlkgtZRkSV9
         fO6jYHBgAMFCSUc8Y53E+A3s3ne7jQzyJzwhhuGggxe8YTcUzHLrIx6criuJMRgIfleX
         y8UA==
X-Forwarded-Encrypted: i=1; AKwUvBy4+hXXP/hbOd+AKAkngMGA/R7IonjFYjZ70ntLIQFfYyBEbl9qRGE4srZyTmJs/O2hGrPKhUpGn8xmFKA=@vger.kernel.org
X-Gm-Message-State: AFuF++moa0mMcErHS6RLoRRkT0pQPQTSVkSv/eVxPO29XHIY48L509Fe
	pWudit6UZkRYlXjrI7CAVRxplC9Pa/cuflFgD11N3aUM35mIqSLcDtaSDqIuaggikd4=
X-Gm-Gg: AYBFou0Z3bu6BmNNbQrQCqQq0ZdR9p3UeuGWWRJFWxVSiL6h7WRAWz5/nC9vH/5eDGu
	qTHNO33yMZAWn6+kmsvSehtrS6SJqp0YoINThBXBAm6fEyh3Bt2ZgQ/6712IF8+MVQgfUdj44VK
	U6V48j5ILsVwaVjePFdsn+y8+5nMdO1Zb/HgC37YmdVXlDX+I0Y3UuNXWcxYyENPK2ZYy52ZJA5
	Wbq6cGYM1/HdgeoVcst3OeS9d8jzLbwdszk/zCgaxhGCQ/Bc8f29DaYTtmCjgyMa39xH5eoJj74
	FzVxChTlHDMgoPHrEhgsGBU8ZaD1erllGJZvSCycqBQ8JhKsOuMVfDoJnZaeQF7whKYdoncINIs
	xuoHdCGJzjehXMgK2SUdlD63L04+6LPNgD6rLZ0Nd1BxJQKSoVguXUOrJWLp17EuC99sgqZTyaq
	TDAPp6j67h+wyDqjwHvGuvGPodl4sz8AbelfXKO13vX+Z3SvYO7wnaD8j2c1T9SK/vIv6uNrK5
X-Received: by 2002:a05:600c:4f8e:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-4a01b00541bmr78662415e9.19.1790863664727;
        Thu, 01 Oct 2026 07:07:44 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f99b113sm81986175e9.14.2026.10.01.07.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:07:44 -0700 (PDT)
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Kees Cook <kees@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	linux-serial@vger.kernel.org,
	Manuel Lauss <manuel.lauss@gmail.com>,
	linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 1/1] braille: nbcon: Allow to use a serial console with NBCON API as Braille console
Date: Thu,  1 Oct 2026 16:07:27 +0200
Message-ID: <20261001140727.124398-2-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001140727.124398-1-pmladek@suse.com>
References: <20261001140727.124398-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Braille console is not registered in console_list. Instead, it is
integrated with the virtual terminal (VT) and shows what is displayed
on the terminal. It writes the data using con->write*() callback
of the associated serial console driver.

braille_write() is called from the VT code under console_lock().
The associated serial console driver can be converted to the NBCON API
though. The situation is similar to flushing nbcon consoles in the legacy
loop when some boot consoles are still registered, see
nbcon_legacy_emit_next_record().

But there is a big difference though. braille_write() is not directly
called from the code paths flushing registered consoles. The VT code
expects that braille_write() succeeds. It does not replay the message
when it can't acquire the ownership. As a result, braille_write():

  + must try harder to get the ownership.

  + has to be synchronized only against non-printk serial console
    which depend nbcon_device_try_acquire() using NBCON_PRIO_NORMAL.

Let's look at it from another side and try to simulate the original
locking using the NBCON API:

  1. Take con->device_lock(), aka the port->lock in the legacy serial
     console driver.

  2. Acquire nbcon context to provide some synchronization for a panic()
     context. Use NBCON_PRIO_NORMAL because it contends only with
     nbcon_device_try_acquire() users. Do it in a busy loop. It should
     always succeed when con->device_lock() succeeded because all other
     users do the same. The only exception is when the context get acquired
     by a CPU handling panic.

  3. In panic, disable interrupts and try to acquire the nbcon context.
     Use NBCON_PRIO_PANIC. And try even an unsafe takeover because
     otherwise the Braille console won't see the text shown during panic().
     It is similar to the oops_in_progress/trylock handling in the legacy
     serial console driver.

Finally, avoid the newline prepending logic in the existing serial console
drivers when they are used as a Braille console. As explained above,
the Braille console shows the last modified line on the terminal (VT).
braille_write() is called when single characters are added. Most
messages are not ended by newline. Anyway, the VT code does not have
logic to reply partially printed messages.

Fixes: 13189fa73afa ("printk: nbcon: Rely on kthreads for normal operation")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 .../accessibility/braille/braille_console.c   | 60 +++++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 +-
 drivers/tty/serial/amba-pl011.c               |  2 +-
 drivers/tty/serial/imx.c                      |  2 +-
 drivers/tty/serial/sifive.c                   |  2 +-
 include/linux/console.h                       | 15 ++++
 kernel/printk/nbcon.c                         | 79 +++++++++++++++++++
 7 files changed, 159 insertions(+), 6 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 06b43b678d6e..fc6cd3530b28 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -62,14 +62,50 @@ static void braille_write(u16 *buf)
 {
 	static u16 lastwrite[WIDTH];
 	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
+	struct nbcon_write_context wctxt = { };
+	unsigned long flags;
 	u16 out;
 	int i;
 
 	if (!braille_co)
 		return;
 
+	/*
+	 * Braille console is not registered in console_list. Instead, it
+	 * is integrated with VT and shows what appears on the graphical
+	 * console under console_lock(). From this POV it is a legacy
+	 * console. But it calls serial console driver which might be
+	 * converted to the NBCON API. It is similar to
+	 * nbcon_legacy_emit_next_record() except that we should try
+	 * harder to get the lock. Otherwise, the Braille device won't show
+	 * everything what is displayed on the terminal.
+	 *
+	 * In short, simulate the original locking using NBCON API.
+	 */
+	if (braille_co->flags & CON_NBCON) {
+		if (panic_on_this_cpu()) {
+			/*
+			 * This should be good enough in practice. Most/all
+			 * serial console drivers have the atomic callback.
+			 */
+			if (!braille_co->write_atomic)
+				return;
+
+			local_irq_save(flags);
+			/* NBCON API strictly requires the ownership. */
+			if (!nbcon_braille_try_acquire(braille_co, &wctxt)) {
+				local_irq_restore(flags);
+				return;
+			}
+		} else {
+			braille_co->device_lock(braille_co, &flags);
+			while (!nbcon_braille_try_acquire(braille_co, &wctxt))
+				cpu_relax();
+		}
+	}
+
 	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
-		return;
+		goto unlock_nbcon;
 	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
 
 #define SOH 1
@@ -102,7 +138,24 @@ static void braille_write(u16 *buf)
 	*c++ = csum;
 	*c++ = ETX;
 
-	braille_co->write(braille_co, data, c - data);
+	if (braille_co->flags & CON_NBCON) {
+		nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
+		if (panic_on_this_cpu())
+			braille_co->write_atomic(braille_co, &wctxt);
+		else
+			braille_co->write_thread(braille_co, &wctxt);
+	} else {
+		braille_co->write(braille_co, data, c - data);
+	}
+
+unlock_nbcon:
+	if (braille_co->flags & CON_NBCON) {
+		nbcon_braille_release(&wctxt);
+		if (panic_on_this_cpu())
+			local_irq_restore(flags);
+		else
+			braille_co->device_unlock(braille_co, flags);
+	}
 }
 
 /* Follow the VC cursor*/
@@ -353,13 +406,16 @@ int braille_register_console(struct console *console, int index,
 	if (!console_options)
 		/* Only support VisioBraille for now */
 		console_options = "57600o8";
+
 	if (braille_co)
 		return -ENODEV;
+
 	if (console->setup) {
 		ret = console->setup(console, console_options);
 		if (ret != 0)
 			return ret;
 	}
+
 	console->flags |= CON_ENABLED;
 	console->index = index;
 	braille_co = console;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37..548fd68ad1fa 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3417,8 +3417,11 @@ static void __serial8250_console_write(struct uart_8250_port *up,
 	 * If the console printer did not fully output the previous line, it
 	 * must have been handed or taken over. Insert a newline in order to
 	 * maintain clean output.
+	 *
+	 * Braille consoles are an exception. The serial port is not used
+	 * for printk(). The driver is supposed to write exactly what it gets.
 	 */
-	if (!up->console_line_ended) {
+	if (unlikely(!up->console_line_ended && !nbcon_write_context_is_braille(wctxt))) {
 		if (use_fifo)
 			__serial8250_console_fifo_write(up, wctxt, "\n", 1);
 		else
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c4824c201e1c..e67f2ac454b6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2656,7 +2656,7 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 				uap, REG_CR);
 	}
 
-	if (!uap->console_line_ended)
+	if (unlikely(!uap->console_line_ended && !nbcon_is_braille(co)))
 		uart_console_write(&uap->port, "\n", 1, pl011_console_putchar);
 	uart_console_write(&uap->port, wctxt->outbuf, wctxt->len, pl011_console_putchar);
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 513dbe95f7e9..986fefb45c63 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2136,7 +2136,7 @@ static void imx_uart_console_write_atomic(struct console *co,
 	imx_uart_writel(sport, ucr1, UCR1);
 	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
 
-	if (!sport->last_putchar_was_newline)
+	if (unlikely(!sport->last_putchar_was_newline && !nbcon_is_braille(co)))
 		uart_console_write(port, "\n", 1, imx_uart_console_putchar);
 	uart_console_write(port, wctxt->outbuf, wctxt->len,
 			   imx_uart_console_putchar);
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 110d67613192..f615701fceb7 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -821,7 +821,7 @@ static void sifive_serial_console_write_atomic(struct console *co,
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
 
-	if (!ssp->console_line_ended)
+	if (unlikely(!ssp->console_line_ended && !nbcon_is_braille(co)))
 		uart_console_write(port, "\n", 1, sifive_serial_console_putchar);
 	uart_console_write(port, wctxt->outbuf, wctxt->len,
 			   sifive_serial_console_putchar);
diff --git a/include/linux/console.h b/include/linux/console.h
index 502d1abe3f50..df23148987ee 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -615,6 +615,15 @@ extern bool nbcon_allow_unsafe_takeover(void);
 extern bool nbcon_kdb_try_acquire(struct console *con,
 				  struct nbcon_write_context *wctxt);
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
+extern bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt);
+extern bool nbcon_braille_try_acquire(struct console *con,
+				      struct nbcon_write_context *wctxt);
+extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
+
+static inline bool nbcon_is_braille(struct console *con)
+{
+	return con && (con->flags & CON_BRL);
+}
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -678,8 +687,14 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
+static inline
+bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt) { return false; }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
+static inline bool nbcon_braille_try_acquire(struct console *con,
+					     struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
+static inline bool nbcon_is_braille(struct console *con) { return false; }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d17704fe93ae..8dac9bda4fe0 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1887,6 +1887,7 @@ bool nbcon_device_try_acquire(struct console *con)
 
 	memset(ctxt, 0, sizeof(*ctxt));
 	ctxt->console	= con;
+	/* Keep in sync with nbcon_braille_try_acquire(). */
 	ctxt->prio	= NBCON_PRIO_NORMAL;
 
 	if (!nbcon_context_try_acquire(ctxt, false))
@@ -2002,3 +2003,81 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
 	 */
 	__nbcon_atomic_flush_pending_con(ctxt->console, prb_next_reserve_seq(prb));
 }
+
+/**
+ * nbcon_is_braille - Checks whether the nbcon write context is using Braille console
+ *
+ * @wctxt:	checked nbcon write context
+ *
+ * Return: True when the write context is associated with a Braille console.
+ *	   Othrewise, return false.
+ *
+ * Context: Can be called in any context but only when Braille console is
+ *	registered and the struct console could not disappear.
+ */
+bool nbcon_write_context_is_braille(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+
+	return con && con->flags & CON_BRL;
+}
+EXPORT_SYMBOL_GPL(nbcon_write_context_is_braille);
+
+/**
+ * nbcon_braille_try_acquire - Try to acquire nbcon console for braille_write()
+ *
+ * @con:	The nbcon console to acquire
+ * @wctxt:	The nbcon write context to be used on success
+ *
+ * Context:	braille_write() for emitting a single buffer on Braille console.
+ *
+ * Return:	True if the console was acquired. False otherwise.
+ *
+ * Braille console is not registered as a proper printk consoles. Instead,
+ * it is integrated with the graphical virtual terminal.
+ *
+ * This function is going to synchronize the Braille write against other
+ * operations on the used serial port. The port can be used also for a user
+ * input but printk() won't emit the messages there directly. It means
+ * the other operations will get synchronized using nbcon_device_try_acquire().
+ */
+bool nbcon_braille_try_acquire(struct console *con,
+			   struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	bool success;
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console = con;
+	/* Keep in sync with nbcon_device_try_acquire(). */
+	if (panic_on_this_cpu())
+		ctxt->prio = NBCON_PRIO_PANIC;
+	else
+		ctxt->prio = NBCON_PRIO_NORMAL;
+
+	success = nbcon_context_try_acquire(ctxt, false);
+	/*
+	 * Try hard in panic, otherwise the Braille console would
+	 * miss a text on the related VT.
+	 */
+	if (panic_on_this_cpu() && !success) {
+		ctxt->allow_unsafe_takeover = true;
+		success = nbcon_context_try_acquire(ctxt, false);
+	}
+
+	return success;
+}
+
+/**
+ * nbcon_braille_release - Release the nbcon console
+ *
+ * @wctxt:	The nbcon write context initialized by a successful
+ *		nbcon_braille_try_acquire()
+ */
+void nbcon_braille_release(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+
+	nbcon_context_release(ctxt);
+}
-- 
2.55.0

