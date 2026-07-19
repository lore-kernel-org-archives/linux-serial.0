Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF7377A8C
	for <linux-serial@vger.kernel.org>; Sun, 19 Jul 2026 06:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784442998; cv=none; b=U0JBB3j0AzCAD14NyN+k6QB1IBjVEO5f6ZvWSuesKdQfLP70+chtjxHzmxLkNDbO05IH3kcCP7Kn2dijBKHBLtVsM2coVFV4OMHv/0sBZ+XIHBzkPI3OQ2AQtSFo5cuAalda4+3pWTu3Lo8+HvnKX2y9NenMZn1Z7qULD+wNrmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784442998; c=relaxed/simple;
	bh=mkB3xIZNgBskQ9evx5tewNXRxL4ZNzszLj6LDriEggI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvWJOT0tDg5sKkhVGA4RfFSw10qGyiaZ/z2XdtIZecpXQ+qNsHgBfbg2rphcGgMqm7dBZFrCp7rUNsTmgz9REUoVdN2fz8O/zl9L1OTjHPpPDtt45ZtFM1DkpPtoE7trF+zX+u5D43QmzLXZdnH5g7e8QSL0Kxn9sy6ri8EUkTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAkKJ4zi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAkKJ4zi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954d29264cso7371295e9.2
        for <linux-serial@vger.kernel.org>; Sat, 18 Jul 2026 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784442995; x=1785047795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v/s1B1a6XBIG/yN44lOc/BilNlkIq0umJ5mItLmYXAU=;
        b=WAkKJ4zihGEL0P09f/moCxRfp2cVUaDTdfTaAO6scCd93JqtANJtOacfJR7sUavgY4
         nJXPRTsr7h+lMTHeFLtF4IMwlG4riRRNr4cgPO4ScOGqNkMi32dfHJ3ctxlu/CTIJf9F
         NcU4RFN608LB8gJSeyG2/9XWMLKXDmrw4oOpfSDBpyVBjzT7iGYFKqeTzJVfn8XhOqoy
         3KViKQY9xWP5AhCtk6+LpvtAW6tOTr0lTZdEWJqkOrdOZgdBcNBLEoM65Br6b/lXt0qi
         wo+6OAAELejicK7Aq++Y4IHRVjvNlTh1RJhrdJ99moR3U0fjosaHb7SIFgy00Pg18jGw
         sIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784442995; x=1785047795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v/s1B1a6XBIG/yN44lOc/BilNlkIq0umJ5mItLmYXAU=;
        b=pwRSHXS0eIlI/HkudKIWHcO9WhGxIVQvOsa9KjGq1Sv9nZ1kmWsQovvpZzY0WL9V0h
         s4Gi0tFQdfalXpxIpx8iwAOx6jdvn0IKRTpHk4P3LoVaivJqCSy7vRvY13WnM/8aqnTw
         99bNpjUBbMA6SjtMgMVZ5rWKVOhoVGgZInKzKZxBAHqo2WwIVoj1ZGgZcU4cjkyAhIyx
         A7/+dXsbSywlZBhtCBwv/kbBRzZYuFo5XDLHA2sCu2i0vgZ062Ev22aY2f3ZjJwFHCoy
         BqTq5+wzFRDr3WHCNcbDdnVWw4ap9Txj4SsEU/eWjPhP1b32gmfxjrZnMVjo/Kdk/osI
         Ikaw==
X-Gm-Message-State: AOJu0YzqcejIc9+2evZzprqXqLjk67pBKjBAxUr1Cj3q6ybOlsmA8Sjw
	W+2BA1gxuXnw1DBkByGgCmwPrEjgRUKC3CrFgMmNijKA3LeyyhBlb2sm
X-Gm-Gg: AfdE7ckFYMosd/BD67BV1jg69aAXf7ddRY5k4rwan0g1yPaclA1b4SKupS75rgLI6lj
	9O0hlQr18RiG6Xf9Yf5qs2jU1YqPQye8HB6yBgyJoDE8qZOe3axktJrq/Z/5CiPb73TG9y6jW5B
	g6PPriVrVyG3gdk0hKkELiXsW/PI8ygdKYExEt9mtRisAsmfmaYdS4pVh48cp3XjF9Q/RK+i892
	T0DATBiffJ6bK+5k6N+wooT0LcPnks30eWBTo3qeoolH3RmsQZPkjZ7wa/fZMLCjnFoL5+O3uxM
	FS8bSSy6p7KFspEiTtCc1UBN2yGDoRgI1CS1bx1A99W/0qxf94EoH4OlEUyjLbmoiJ2b3cChvI0
	LpynBM5T1d+UAJQtVQT/wCvOr/flw8bzkav3sauWKTF4w4S1PddUfvpWp9dJgK9eGfKLv0/cVkM
	ZfiN448RURbXCJmeRDbvHZCWCgAlgw34O8QxjE5Iak+bo0V922gqbHW3sa8/FFa26yef1VaDcyG
	rAMwAnUguP6ztoYwyJW5Lg/iHjir0RwTmB6hHo=
X-Received: by 2002:a05:600c:26d4:b0:495:4075:7dfa with SMTP id 5b1f17b1804b1-4954a51e4abmr62580465e9.35.1784442994501;
        Sat, 18 Jul 2026 23:36:34 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-018-194.77.7.pool.telefonica.de. [77.7.18.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96f19sm193053245e9.9.2026.07.18.23.36.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 23:36:34 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for atomic writes
Date: Sun, 19 Jul 2026 08:35:02 +0200
Message-Id: <20260719063502.18852-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719063502.18852-1-kmehltretter@gmail.com>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_console_write_atomic() runs from nbcon atomic context, where
sleeping is not allowed. It calls clk_enable(), which takes the
common-clk enable_lock. Under PREEMPT_RT that is a sleeping lock:
clk_enable_lock() first tries spin_trylock_irqsave(), but on contention
falls back to spin_lock_irqsave(), so an atomic-context printk on an RT
kernel with a clk-backed pl011 can trip:

  BUG: sleeping function called from invalid context at spinlock_rt.c:48
    __might_resched from rt_spin_lock
    rt_spin_lock from clk_enable_lock
    clk_enable_lock from clk_enable
    clk_enable from pl011_console_write_atomic
    ... from vprintk_emit

This was found and reproduced on 32-bit ARM with PREEMPT_RT. In
addition, write_atomic() may be invoked from NMI context and is
documented to avoid locking. Since clk_enable() acquires the
common-clock enable_lock, removing it from the callback also avoids a
potentially unsafe NMI lock acquisition.

An nbcon atomic-capable console must be printable from any context, so
the clock cannot be gated between writes. Enable the clock while the
console is registered: use clk_prepare_enable() in
pl011_console_setup(), release it via clk_disable_unprepare() in the
console .exit() callback, and drop the per-write
clk_enable()/clk_disable() pairs from write_atomic() and
write_thread().

Keeping UARTCLK enabled may increase idle power on platforms where it
would otherwise be gated between console writes.

Fixes: 2eb2608618ce ("serial: amba-pl011: Implement nbcon console")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
The PREEMPT_RT splat above was reproduced on 32-bit ARM (versatilepb,
ARM926EJ-S / ARMv5TE), Linux 7.2.0-rc3 based, CONFIG_PREEMPT_RT=y
CONFIG_HZ=1000, by driving an atomic-context printk; with this patch the
clk_enable() -> rt_spin_lock() splat is gone.

Tested on QEMU raspi (bcm2835, gateable CPRMAN UART clock) with the full
series applied: recycling the console via /sys/class/tty/ttyAMA0/console
keeps both prepare_count and enable_count balanced (2/2 across six
cycles), and console output resumes after each re-registration.
Suspend/resume was not exercised (no platform suspend under the QEMU
model).

 drivers/tty/serial/amba-pl011.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1aa43994a3cd..4facd1b350d5 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2523,7 +2523,11 @@ static int pl011_console_setup(struct console *co, char *options)
 	/* Allow pins to be muxed in and configured */
 	pinctrl_pm_select_default_state(uap->port.dev);
 
-	ret = clk_prepare(uap->clk);
+	/*
+	 * Keep the clock enabled while registered because write_atomic() may
+	 * run in NMI context and must not acquire the clock framework lock.
+	 */
+	ret = clk_prepare_enable(uap->clk);
 	if (ret)
 		return ret;
 
@@ -2556,7 +2560,7 @@ static int pl011_console_exit(struct console *co)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 
-	clk_unprepare(uap->clk);
+	clk_disable_unprepare(uap->clk);
 
 	return 0;
 }
@@ -2630,8 +2634,6 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
-
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
 		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
@@ -2648,8 +2650,6 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
-
 	nbcon_exit_unsafe(wctxt);
 }
 
@@ -2662,8 +2662,6 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
-
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
 		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
@@ -2692,8 +2690,6 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
-
 	nbcon_exit_unsafe(wctxt);
 }
 
-- 
2.53.0
