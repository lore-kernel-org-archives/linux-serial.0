Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A6A3B3C15
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929044; cv=none; b=ZU2j0H2wdS8psjm1lUBfiz4GWrYsi+H95qnHgzs36OIhCcRJu6eiMBSiD6aw2uFtu2x8akF6RUCjHCNvPtkfdOpBG4Gon1ffjPuxjZWmWgPNL8jnCtfk/NNFzKJIETd6sC67fGlOuHKgcxjknoNTAHNiOU72j6YdhJnJS7obeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929044; c=relaxed/simple;
	bh=k0eIj9G6Isnpa32QRNbc3ZJdWbsPOLvyESbeGdG2D8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kal0i0+BYmlfUGM9YPL0a2pzSO0FVnp6FZFJMRfYRYL4sxdolIk8z8JIRqgEFmjcRznfefR75aobflIWf6vNBEMCLtEHehawFZr/eW7qgXV2dhgfwdQ/Hw8NaQZK6rlCIST5GksS+a+qAA8irBXr/1OfG4IVfNanT0Kb6splNpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T20gc38f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T20gc38f"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49548aebcd8so6619675e9.3
        for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 14:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929041; x=1785533841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zw+In47VNqyZ6M3jtrWopK6tPDTD0rxTpVkixtQCLIg=;
        b=T20gc38f83JIJOSoPdH/rUsRKTxHFMK9j6stpBIAvThek//jgOe8/8KE1Qd4SQnkFl
         HNqaeIKnau4gugLRciE6+Y5cG6hMPyoyw8DAYf8B7OzXbs/DtO4gxyE4lqCb0bpLntcH
         B1lLc3xuy4rKQ3DlnQjymjbsqusYhiw4ZkaiA0T/67XDf3UYHdRHwYWdQvRa1alu3QWt
         h36yNB2pJ1DLEa2hB5dyIY14UoCvRaGSpllmUNuZ3iY7MkPLdp+DW5GV8HbdR91qO5Mw
         Nz1qPd/b+WR13C0nXvdlpfsJtl9T/xcVABDVbgQSCAFlOWu4uZHDYQ/2uC7BEijN32Kj
         53gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929041; x=1785533841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zw+In47VNqyZ6M3jtrWopK6tPDTD0rxTpVkixtQCLIg=;
        b=My34rs1BO5PwhBOM6HGxtvNM07mIkiUWgsNkPkmaAqRPxZkYK82aOfHwXzVk8fAWy5
         o2Q46p49HuzqoHUC6fgYteiPkPe3fImqK4OMNc+756a+xjiYlWLO5nuIaNG1DxO2qNxd
         GqkL2BIHjynJw4RevOmubMfT6BSe/mlU3Iv0caHLwMk+bz+gs2yBe5CsfJLpcl7d7GF1
         excSI/aogSBuJre2JmIzcpADLuEjqCWJaUO10HynHTYQnvsSfoFuYLLnjAc8fWOJDQT4
         v1LUD9VTHkDcBBX8gB1TjYKGmYvvc7od+LuSejrEKMCcFL0IilVc7ZBzelxORq2NmwRC
         Vdtg==
X-Forwarded-Encrypted: i=1; AHgh+Rqwuegx+m6gtzzePLG0IV3tqLc7EOfNYPnpZY1tl1Zba9XVZjF95bSVf/aqlvL9Sc2Q/ifj/zZX+FsTzno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzYilIo0xV4QTxs9hkT0GoDW0y5I0moxcU4INBNTFYHAOrRtrC
	TALV3MiT4jU/bw6IqcEYdUxsl6xqdcewSSu9sEw14cEtcYukCMkrQQUR
X-Gm-Gg: AR+sD13GnzpRa4rnGa6CLOFODMhCNzYI25vuISbC/43VZuClrGGZPQcNhC5DxZMypj3
	50Dt5WAdoKLkMcwBM1B7sO7BrbpVSYEB6i/+5qmso8fdDEPvXaM4kfPhUOSlJrcIW+6rNAybtrE
	EURY7NaPNNQNXmHRh7PiobKEvC80WGdkGpzRcr/pmhHF3p5oCoAyxL2kmJZ8KX8ijwuriXdc5bd
	d+RbOWIxEB8BBzyNf6uZUhF57xtkjNKhoknJGCkFYFxor3LDLawvuAaFz22uMiAs5DMx/8kdhov
	d27q6vosMGDaSOacSsEX+beSpRUJeAYyjztcj2QmXrLNfUYtXOjmpHjWhFrOxo5pLyOxUv6w7Yu
	HgpVY7p0yhKmraD9zgHw1aHsYc5zxJ/i3LY8xfKLfLqEsKIaufZhyr6UJcre7iucTKTXf1QhYdA
	35tm1XTfTwdy5/tFBCzL8qefdc6Mr9bfiUnL4FS/HVGl/1VWQMhojtiNbcL0pfTRQqkv5TgNCuq
	L8zKvPNLDEsFbIaq8Tj5bK6rdTn6eFYVoymyW5retWpJUEzprjkfqRreJeVWR14LsbIrZAaep86
	ksAcl5/KjoP/ng==
X-Received: by 2002:a05:600c:4f94:b0:493:eb71:5cc6 with SMTP id 5b1f17b1804b1-496b5720ac4mr429335e9.27.1784929040710;
        Fri, 24 Jul 2026 14:37:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ae93-f301-cdd9-d5ea-080d-9131.310.pool.telefonica.de. [2a02:3100:ae93:f301:cdd9:d5ea:80d:9131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b499cc49sm20754015e9.9.2026.07.24.14.37.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Jul 2026 14:37:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>
Subject: [PATCH v2 2/2] serial: amba-pl011: keep console clock enabled for atomic writes
Date: Fri, 24 Jul 2026 23:33:48 +0200
Message-Id: <20260724213348.77418-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260724213348.77418-1-kmehltretter@gmail.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pl011_console_write_atomic() runs from nbcon atomic context, where
sleeping is not allowed. It calls clk_enable(), which takes the common-clk
enable_lock. Under PREEMPT_RT that is a sleeping lock:
clk_enable_lock() first tries spin_trylock_irqsave(), but on contention
falls back to spin_lock_irqsave(). Therefore, an atomic-context printk on
an RT kernel with a clk-backed pl011 can trip:

  BUG: sleeping function called from invalid context at spinlock_rt.c:48
    __might_resched from rt_spin_lock
    rt_spin_lock from clk_enable_lock
    clk_enable_lock from clk_enable
    clk_enable from pl011_console_write_atomic
    ... from vprintk_emit

This was found and reproduced on PREEMPT_RT. Arm32 and arm64 DT SoCs are
affected; arm64 SBSA/ACPI has no clk, so clk_enable(NULL) short-circuits
before the lock. In addition, write_atomic() may be invoked from NMI
context and is documented to avoid locking. Removing clk_enable() from
the callback also avoids a potentially unsafe NMI acquisition of the
common-clock enable_lock.

An nbcon atomic-capable console must be printable from any context, so
the clock cannot be gated between writes. Enable the clock while the
console is available for output: use clk_prepare_enable() in
pl011_console_setup(), release it via clk_disable_unprepare() in the
console .exit() callback, and drop the per-write clk_enable()/clk_disable()
pairs from write_atomic() and write_thread().

When printk suspends consoles, drop the reference after
uart_suspend_port() stops console access and restore it before
uart_resume_port() -- but only if suspend actually marked the port
suspended (a wake-capable tty stays running and must keep its clock), and
keep it when console_suspend_enabled is false so no_console_suspend works.

The active power cost of keeping the clock enabled is platform-dependent:
none where the UART clock is a fixed always-on oscillator, real where it
is a gateable clock branch, which then cannot be gated (nor possibly can
its parent clocks) while the console is available for output. When serial
core actually suspends the port, the reference is released so the clock
provider can gate the clock tree.

Fixes: 2eb2608618ce ("serial: amba-pl011: Implement nbcon console")
Suggested-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/all/8733xeaxix.fsf@jogness.linutronix.de/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/amba-pl011.c | 40 +++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1aa43994a3cd..611d1f6a0590 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2523,7 +2523,7 @@ static int pl011_console_setup(struct console *co, char *options)
 	/* Allow pins to be muxed in and configured */
 	pinctrl_pm_select_default_state(uap->port.dev);
 
-	ret = clk_prepare(uap->clk);
+	ret = clk_prepare_enable(uap->clk);
 	if (ret)
 		return ret;
 
@@ -2556,7 +2556,7 @@ static int pl011_console_exit(struct console *co)
 {
 	struct uart_amba_port *uap = amba_ports[co->index];
 
-	clk_unprepare(uap->clk);
+	clk_disable_unprepare(uap->clk);
 
 	return 0;
 }
@@ -2630,8 +2630,6 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
-
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
 		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
@@ -2648,8 +2646,6 @@ pl011_console_write_atomic(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
-
 	nbcon_exit_unsafe(wctxt);
 }
 
@@ -2662,8 +2658,6 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!nbcon_enter_unsafe(wctxt))
 		return;
 
-	clk_enable(uap->clk);
-
 	if (!uap->vendor->always_enabled) {
 		old_cr = pl011_read(uap, REG_CR);
 		pl011_write((old_cr & ~UART011_CR_CTSEN) | (UART01x_CR_UARTEN | UART011_CR_TXE),
@@ -2692,8 +2686,6 @@ pl011_console_write_thread(struct console *co, struct nbcon_write_context *wctxt
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
 
-	clk_disable(uap->clk);
-
 	nbcon_exit_unsafe(wctxt);
 }
 
@@ -3080,21 +3072,45 @@ static void pl011_remove(struct amba_device *dev)
 static int pl011_suspend(struct device *dev)
 {
 	struct uart_amba_port *uap = dev_get_drvdata(dev);
+	int ret;
 
 	if (!uap)
 		return -EINVAL;
 
-	return uart_suspend_port(&amba_reg, &uap->port);
+	ret = uart_suspend_port(&amba_reg, &uap->port);
+	if (ret)
+		return ret;
+
+	if (console_suspend_enabled && uap->port.suspended &&
+	    uart_console_registered(&uap->port))
+		clk_disable_unprepare(uap->clk);
+
+	return 0;
 }
 
 static int pl011_resume(struct device *dev)
 {
 	struct uart_amba_port *uap = dev_get_drvdata(dev);
+	bool resume_console;
+	int ret;
 
 	if (!uap)
 		return -EINVAL;
 
-	return uart_resume_port(&amba_reg, &uap->port);
+	resume_console = console_suspend_enabled &&
+			 uap->port.suspended &&
+			 uart_console_registered(&uap->port);
+	if (resume_console) {
+		ret = clk_prepare_enable(uap->clk);
+		if (ret)
+			return ret;
+	}
+
+	ret = uart_resume_port(&amba_reg, &uap->port);
+	if (ret && resume_console)
+		clk_disable_unprepare(uap->clk);
+
+	return ret;
 }
 #endif
 
-- 
2.39.5 (Apple Git-154)

