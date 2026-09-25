Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448341CB2E
	for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 14:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345880; cv=none; b=AHFyR1c5bwdRPQLwBQw/aetyUlkNU194vsFKiq5Z1wlOn5MjWFrhfkiv4MFBOnUeU890OpQgGYkYmG9Oys4c8Iwz7GjyBjm6D8SQuBTpCPahP3iAD7i0hwz//xqlEcCYGXCfntDhQtc1kNSg5zXyjtkesmaKQUnH7wiyh8pXqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345880; c=relaxed/simple;
	bh=QJLgEAbx6T2RSkNSj3kbjYvGdxs6u8UICQH8fY6UTnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdarAsUnXe41oFh71O4QVs+00yEBMcYsu2zT2Sb7SRLt4P8YYlqDU6cme27APiI5eecAxq63ZJJdCp7r/Z40406D0GEG3+W0ZywQgrQ1p6NKgr42yyLpRr0QGDstlDPMxOKq9fde/N6D4rW+zE+z0pUkAW4zkBoHuMloPE4ki9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L/PCWQry; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L/PCWQry"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48882c1f261so156190f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 25 Sep 2026 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790345871; x=1790950671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGYvyRCrQegUYERqeW8YhOk+7/4wogwVHs8c76TG1Lw=;
        b=L/PCWQryaiyE6eyWbtafZAy38MP5Tr/RqnqAAJ8Abj4qNX8NQTvH9atsL3mEt3dwWl
         k3SNM/aKfhejr0TWsAtJlQRljzMDE3ryxfBXOlTQcJm7YOKcQ8DvbtQzX+1TWlOFLyiK
         fsGv9Ke3hV1UNHV0mfM9H8lZwdjSGLh/Qu/42z9TSIEbCUgZ0rXd5e5Xgb/HO7ZmJSLA
         JWbgj8EsyelJQfWg8ysjm5UEnjr8Qj49LSQ1g3+pekiQe5DdXpDsWcAgJVITetl5/vgP
         rwnuqaWqlBGtXsK9bT5e1jjyxQI/xDy4EeTthAIMjSUtoVKxz1CurG3lr20G+MUbHiok
         vGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345871; x=1790950671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGYvyRCrQegUYERqeW8YhOk+7/4wogwVHs8c76TG1Lw=;
        b=MEORr3zz1npVHlwl5WgcOSx2AMfkN61RZYxFXQp0mQC/FAMvW8ZzX0YsD1I+T107Kt
         NFzdR4ym+M6xMg9Cv98nJlVwxq3EWCUIEokM8yJxbjoNlbAgJWkjz20t8O4FHOt5J+KT
         5IwlrLyNny4cWjfYbRKE1dqAvEBUhe2ZOJ0Ww9m66TDBL7zvZQMt4Mn8YOYlWbSB6BGp
         TkTzdPuxTq+LKQrmMcQX2w0sstjWVTfsVa7WRPuqP7PeBr+xld9PlyzohCZmB4sqTW5Q
         js3SmFNB2qu2tC+tva42iAs8crD7MhKR0xCylchLjPodBdQlgTjiKWbnduQF1zR9zqCB
         kCKw==
X-Forwarded-Encrypted: i=1; AKwUvBxWBThSPaS5B8mg8c5u2t5QhblHGhkk5fRZZ4jm9aJqCVO/P79OuYXWflklY8iriwCANfTE9jAodRqojz8=@vger.kernel.org
X-Gm-Message-State: AFuF++lazTwUdmLCFJmQkVuPtiPnwOkYY3I0yiZ6kDxQvmwZjJbhWFyw
	T9XRc1fiy3cipnB4kY7rjqSf65NblfF/OZflM9qvAxQPlV5QRK8ZOuvDTr+8LCm+Bwg=
X-Gm-Gg: AYBFou2DV+n5cDtnQzmCPwYd+LIVVR2QGE6riUSRP2qOr4Xmb/tUf2ju6wNfupvtNOR
	qaQlMI85UuTN09lTLsLz8Z+kVk0yc2cn0F5LLFDZp2PlHkMwWDOR3gXgfwB18iSpkbVfPfEZuaZ
	AZH3HEfFPAZ+R2y0Z1bk8mWMeiEH2KZ/Y3bBNsbCChF/WyOd/07dDEkt78nFaeuBtLKWG5fiz3M
	b3LfvwheVUFIGyBU32WDiQc8zwJr09hAiEMsn82ERS6RkNgOZV5+b0KUYMiox0MQe7Gyhy0PKzn
	I0YdtmsOcGFG9kZoV7NbAVXdooTX8zjPcldDdSjhCPAHfFkeePZbYpWaXYHcYUM1oNdpAXs/hCt
	83YBdsAB4ZUSG7ikB/ixWPv14ua34N06t7uQlOqpT2Gi8wZjSHIM2XyUzmrtaVp2zcroZGbSTwQ
	mRpjjoOytS1vP/4rgTQ5G+pAIA84S/mvdDxVuAnqyyoSZCkZcVDFJBroieukHjkYo3TAOMq9x1y
	GJBZmA83jw=
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fe66c80c8mr104930275e9.2.1790345871128;
        Fri, 25 Sep 2026 07:17:51 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff023f12esm63339395e9.0.2026.09.25.07.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:17:50 -0700 (PDT)
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
Subject: [PATCH v2 1/1] braille: nbcon: Allow to use a serial console with NBCON API as Braille console
Date: Fri, 25 Sep 2026 16:17:29 +0200
Message-ID: <20260925141729.173943-2-pmladek@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925141729.173943-1-pmladek@suse.com>
References: <20260925141729.173943-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Braille console is integrated with the virtual terminal (VT) and
writes its data using the legacy con->write() callback of the associated
serial console driver.

When the associated serial console driver gets converted to the NBCON API,
the braille write callback should use con->write_atomic() callback
with an appropriate locking.

It must be the atomic variant because it can be called under a spin_lock,
for example via:

  + kbd_event()
    + kbd_keycode()
      + atomic_notifier_call_chain(&keyboard_notifier_list)
	+ vt_notifier_call()
	  + vc_refresh()
	    + braille_write()

In addition, it can be called from printk() in any context via
the graphical tty driver (vt code) even when the Braille driver is not
in console_list directly.

The locking is inspired with nbcon_legacy_emit_next_record(),
nbcon_kdb_try_acquire()/release(), and the original serial driver locking:

  1. IRQs are explicitly disabled to prevent CPU migration and nested
     calls into the serial driver code.

  2. New nbcon_braille_try_acquire()/release() API allows to initialize
     the write context and acquire the ownership. It is using
     NBCON_PRIO_NORMAL because it competes only with the other operations
     on the serial console driver which are serialized using
     nbcon_device_try_acquire().

  3. It uses a busy loop until it acquires the ownership. Otherwise,
     the messages would get lost. [*]

  4. It does just the best effort when oops_in_progress is set.

Also, adjust __serial8250_console_write() in the 8250 serial driver to
exclude Braille consoles from the newline prepending logic. The serial
port is not used for standard printk logging which might be interrupted
in the middle of the operation. In the Braille mode, the serial driver
is supposed to write exactly what it gets. In fact, it does not print
any newlines at all in this case.

[*] The busy loop is not safe on PREEMPT_RT where the current owner
    might sleep. We will need another solution there.

Fixes: d3539347022a ("serial: 8250: Switch to nbcon console, take 2")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 .../accessibility/braille/braille_console.c   | 43 ++++++++++++-
 drivers/tty/serial/8250/8250_port.c           |  5 +-
 include/linux/console.h                       |  8 +++
 kernel/printk/nbcon.c                         | 64 +++++++++++++++++++
 4 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/drivers/accessibility/braille/braille_console.c b/drivers/accessibility/braille/braille_console.c
index 06b43b678d6e..bae177cb8cf9 100644
--- a/drivers/accessibility/braille/braille_console.c
+++ b/drivers/accessibility/braille/braille_console.c
@@ -62,14 +62,36 @@ static void braille_write(u16 *buf)
 {
 	static u16 lastwrite[WIDTH];
 	unsigned char data[1 + 1 + 2*WIDTH + 2 + 1], csum = 0, *c;
+	struct nbcon_write_context wctxt = { };
+	unsigned long flags;
+	bool locked;
+
 	u16 out;
 	int i;
 
 	if (!braille_co)
 		return;
 
+	if (braille_co->flags & CON_NBCON) {
+		/*
+		 * Braille console might be called from unknown context via
+		 * vt_console_print() from console_unlock() from printk().
+		 * Use the atomic callback and synchronize it just using
+		 * the console context. Disable interrupts to prevent a nested
+		 * call into the driver code which might cause a deadlock when
+		 * trying to acquire the console ownership, see
+		 * __nbcon_atomic_flush_pending_con().
+		 */
+		local_irq_save(flags);
+		do {
+			locked = nbcon_braille_try_acquire(braille_co, &wctxt);
+			if (!locked)
+				cpu_relax();
+		} while (!locked && !oops_in_progress);
+	}
+
 	if (!memcmp(lastwrite, buf, WIDTH * sizeof(*buf)))
-		return;
+		goto release_nbcon;
 	memcpy(lastwrite, buf, WIDTH * sizeof(*buf));
 
 #define SOH 1
@@ -102,7 +124,24 @@ static void braille_write(u16 *buf)
 	*c++ = csum;
 	*c++ = ETX;
 
-	braille_co->write(braille_co, data, c - data);
+	if (braille_co->flags & CON_NBCON) {
+		if (braille_co->write_atomic &&
+		    !(braille_co->flags & CON_NBCON_ATOMIC_UNSAFE)) {
+			nbcon_write_context_set_buf(&wctxt, (char *)data, c - data);
+			braille_co->write_atomic(braille_co, &wctxt);
+		} else {
+			pr_warn_once("Braille requires a safe braille_co->write_atomic callback\n");
+		}
+	} else {
+		braille_co->write(braille_co, data, c - data);
+	}
+
+release_nbcon:
+	if (braille_co->flags & CON_NBCON) {
+		if (locked)
+			nbcon_braille_release(&wctxt);
+		local_irq_restore(flags);
+	}
 }
 
 /* Follow the VC cursor*/
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38fa45e74a37..6eb0b439e433 100644
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
+	if (unlikely(!up->console_line_ended && !nbcon_is_braille(wctxt))) {
 		if (use_fifo)
 			__serial8250_console_fifo_write(up, wctxt, "\n", 1);
 		else
diff --git a/include/linux/console.h b/include/linux/console.h
index 502d1abe3f50..d780f6de303a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -615,6 +615,10 @@ extern bool nbcon_allow_unsafe_takeover(void);
 extern bool nbcon_kdb_try_acquire(struct console *con,
 				  struct nbcon_write_context *wctxt);
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
+extern bool nbcon_is_braille(struct nbcon_write_context *wctxt);
+extern bool nbcon_braille_try_acquire(struct console *con,
+				      struct nbcon_write_context *wctxt);
+extern void nbcon_braille_release(struct nbcon_write_context *wctxt);
 
 /*
  * Check if the given console is currently capable and allowed to print
@@ -678,8 +682,12 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
+static inline bool nbcon_is_braille(struct nbcon_write_context *wctxt) { return false; }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
+static inline bool nbcon_braille_try_acquire(struct console *con,
+					     struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_braille_release(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index d17704fe93ae..e5a0506330eb 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1887,6 +1887,7 @@ bool nbcon_device_try_acquire(struct console *con)
 
 	memset(ctxt, 0, sizeof(*ctxt));
 	ctxt->console	= con;
+	/* Keep in sync with nbcon_braille_try_acquire(). */
 	ctxt->prio	= NBCON_PRIO_NORMAL;
 
 	if (!nbcon_context_try_acquire(ctxt, false))
@@ -2002,3 +2003,66 @@ void nbcon_kdb_release(struct nbcon_write_context *wctxt)
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
+bool nbcon_is_braille(struct nbcon_write_context *wctxt)
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
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->console = con;
+	/* Keep in sync with nbcon_device_try_acquire(). */
+	ctxt->prio = NBCON_PRIO_NORMAL;
+
+	return nbcon_context_try_acquire(ctxt, false);
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

