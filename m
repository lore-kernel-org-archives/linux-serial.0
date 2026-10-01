Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CD4825C6
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847607; cv=none; b=LWh8hTVdi4h3T2/zSfpynUxQuyrHvjLIcbD5fdj+NQCfEW79NIv/QNKSZn4K45R8pmyzRlPoxNUvweqqT12lO1S39aaWP4IpNs76Wv7B9AR0zxWswWCG546oeYPE9dFUMLmzP81DXY/anXvF011uCUtqErlMRHY+t84ylQbcMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847607; c=relaxed/simple;
	bh=vbPkMFZBM/XJIyhSTiZdRCNqu+nsyMzyYeV2NHex8Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcNSzKNCCOY7Ztl6W3Joll/kWuBRsFUrwMdy3sUNozJ3Qq7VpQA55q2dZCHw/49Px9MJFzkvpNajYVoIb7BNGRnm7g3W1oAj1tRlkPKXDaTyyvRsP+JYG4tO8ywYURyLs2Crp6jVlWtdlgLgROtnIIh7AFkB0inDjwd2ss7l1eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MQ+ecDYK; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MQ+ecDYK"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffb83bf7aso41598015e9.2
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 02:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790847604; x=1791452404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1kAAvntcKHasGD50tBSq7FYJAbVGHGjPM0X+fPNy8OQ=;
        b=MQ+ecDYKQLuRwpkH4JLs4bvIkXD+oReSA8vkHuVits0NmsujpCsiCwC/tutPAyI3bA
         5RhMWYbP+GIZVAsh14j+73SHrR+9BP7hwqBsQtldqP2kgaTSm4J7odcuDxbHObCCQTWS
         LPpHIaPpaU+/D4TEdf97KWbfUBLFXw+Dlu0vio+sC2JxS8cuI2pl8r5ti2kyRCM2UCzx
         IpOnEB95ig6/yBOP73Rp/AQSTVvVNR/IHCtHkfbyB3QY+0r5nY79oypcfm6QH8S702Nf
         f+m+u/Y/DQ6NYAKATUAA20izSVeVjNj3N8Whb4+bx9w42YJ6/6Yx/WQagQNz7RX7uFma
         9iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790847604; x=1791452404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1kAAvntcKHasGD50tBSq7FYJAbVGHGjPM0X+fPNy8OQ=;
        b=GmGMri5NnZjpNwGXQWGZenkKvChHKsqawqgdnBgn9axS/D1jBISJ18SlnIph9DcDAd
         Lc/QeNcnv4ApZFJfp3659CIiemThzDt0aN/mttwFuW9Jq0USGwQjHQQavoyqUF+WtZET
         /9T7dURIHiRH4cA7gynqui44Td7qJowZhFY1rcUTqF6GJeq5n73xQme90exUW3wxjIB1
         ECRgNEAIs6P1e8D3RFJQxLwLZzXeG1r6vh4maTJzKgzM2sZPI+dV2NkEAO6mgtavC/HQ
         aJBEWATamBE0NO+fQXPzYmLqaxLtK/8pAvRkY02Hf/oYfUY7j/1oM02QZNx2P2U6GNy7
         Iu0g==
X-Forwarded-Encrypted: i=1; AKwUvBya5fB9IN6sY+7PMTUpF+CvJkVcKwF6kN4JOVUXQyfyKqEZM8B+AbspkyH3dokREXFuVux/kJh1feELm7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++n11Tfe+mIxWQYAiYsZd3CdgBTHRbf/adhBKE76yW3WBSunbtP6
	9Lsj7P6B4I+VRdFMhNpyZybl1Nu4sWCB5Rv6z7R5vgd0dRbhp3PwinFX5clDxMT3Y1I=
X-Gm-Gg: AYBFou0Jl4ZhoUt2V39fHy6asF6SaqBYlSSv3YQhDMw0e7HL7CL30PqsigbStcBr+us
	jbvnR5EKNpeXq/0rb3biHJaC/vX99KvdZCC7YHTa0GbQcNEqwG67MKUUM9uYj5lh+pxLH+CKq4o
	dhx/FGLYCpsyMUxmk1RWEUQau/EjccVhd+gUZHrH7AOJp9afLqhDrP5VG+8nqkiS4ZoAm0lF2NZ
	D8itT39yzLmG5C0sB7futnbXYtug5HIU439kCkvnEYS2AqfklG2pAQSkNP6tJySBqhd7Iabq7BZ
	cEpyIj8r0HDp1XMubreVgw2kHJQJJRGZlFvyA30fD4b9ojCmv8dWo82m5Ghkdcn18YtE8MPpkW+
	UcecCobilTPrmBrXtFiVs98FraTB7tH6xteWgFyPLIjmcysR3Pg36Lt2CXl1RBkTkZ6bbtFVc1S
	LvxbUC5DQp4rnipjMvFKBQjt1D93q9BCF67HtyD6rINXWqfGdgNmXSY3Kku7zeIV7o4kC0mEIC
X-Received: by 2002:a05:600c:4512:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-4a01b00ee5dmr71593375e9.22.1790847603967;
        Thu, 01 Oct 2026 02:40:03 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f97a0aesm51159615e9.3.2026.10.01.02.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:40:03 -0700 (PDT)
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
Subject: [PATCH v3 1/1] braille: nbcon: Allow to use a serial console with NBCON API as Braille console
Date: Thu,  1 Oct 2026 11:39:46 +0200
Message-ID: <20261001093946.112999-2-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001093946.112999-1-pmladek@suse.com>
References: <20261001093946.112999-1-pmladek@suse.com>
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

But there is a big difference thouhg. braille_write() is not directly
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
     context. Use NBCON_PRIO_NORMAL because it fightling only against
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
 .../accessibility/braille/braille_console.c   | 64 ++++++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 +-
 drivers/tty/serial/amba-pl011.c               |  2 +-
 drivers/tty/serial/imx.c                      |  2 +-
 drivers/tty/serial/sifive.c                   |  2 +-
 include/linux/console.h                       | 15 ++++
 kernel/printk/nbcon.c                         | 78 +++++++++++++++++++
 7 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 06b43b678d6e..78611019b671 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -62,14 +62,45 @@ static void braille_write(u16 *buf)
 {
 	static u16 lastwrite[WIDTH];
 	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
+	struct nbcon_write_context wctxt = { };
+	unsigned long flags;
+	bool locked;
 	u16 out;
 	int i;
 
 	if (!braille_co)
 		return;
 
+	/*
+	 * Braille console is not registered in console_list. Instead, it
+	 * is integrated with VT and shows what appears on the graphical
+	 * console under console_lock(). From this POV it is a legacy
+	 * console. But is calls serial console driver which might be
+	 * converted to the NBCON API. It is similar to
+	 * nbcon_legacy_emit_next_record() except that we should try
+	 * harder to get the lock. Othewise, the Braille device won't show
+	 * everything what is displayed on the terminal.
+	 *
+	 * In short, simulate the original locking using NBCON API.
+	 */
+	if (braille_co->flags & CON_NBCON) {
+		if (panic_on_this_cpu()) {
+			local_irq_save(flags);
+			locked = nbcon_braille_try_acquire(braille_co, &wctxt);
+			/* NBCON API strictly requires the ownership. */
+			if (!locked) {
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
@@ -102,7 +133,27 @@ static void braille_write(u16 *buf)
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
+		if (panic_on_this_cpu()) {
+			if (locked)
+				nbcon_braille_release(&wctxt);
+			local_irq_restore(flags);
+		} else {
+			nbcon_braille_release(&wctxt);
+			braille_co->device_unlock(braille_co, flags);
+		}
+	}
 }
 
 /* Follow the VC cursor*/
@@ -353,13 +404,22 @@ int braille_register_console(struct console *console, int index,
 	if (!console_options)
 		/* Only support VisioBraille for now */
 		console_options = "57600o8";
+
 	if (braille_co)
 		return -ENODEV;
+
+	if (console->flags & CON_NBCON &&
+	    (!console->write_atomic || console->flags & CON_NBCON_ATOMIC_UNSAFE)) {
+		pr_err("Braille console requires a safe braille_co->write_atomic callback\n");
+		return -EINVAL;
+	}
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
index 110d67613192..c44183cbdd8b 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -821,7 +821,7 @@ static void sifive_serial_console_write_atomic(struct console *co,
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
 
-	if (!ssp->console_line_ended)
+	if (unlinely(!ssp->console_line_ended && !nbcon_is_braille(co)))
 		uart_console_write(port, "\n", 1, sifive_serial_console_putchar);
 	uart_console_write(port, wctxt->outbuf, wctxt->len,
 			   sifive_serial_console_putchar);
diff --git a/include/linux/console.h b/include/linux/console.h
index 502d1abe3f50..94b926ad8c9c 100644
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
+	return con && con->flags & CON_BRL;
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
index d17704fe93ae..228c75f90662 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1887,6 +1887,7 @@ bool nbcon_device_try_acquire(struct console *con)
 
 	memset(ctxt, 0, sizeof(*ctxt));
 	ctxt->console	= con;
+	/* Keep in sync with nbcon_braille_try_acquire(). */
 	ctxt->prio	= NBCON_PRIO_NORMAL;
 
 	if (!nbcon_context_try_acquire(ctxt, false))
@@ -2002,3 +2003,80 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
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
+	 * Try hard in panic, othrewise the Braille console would
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

