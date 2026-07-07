Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EE3064B5;
	Tue,  7 Jul 2026 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433436; cv=none; b=PO6TWJd6RTR84aihtEc5qK3w4tm25aV73qxVxXLL1b/1I/McmFPpWOZh+zh+GjQRQqHJGq8VFxws8PrEREI2Z3Mc5E8j8li13e4Fdwp+50DWyvrFruGu+DLNIfQwE/JRjazwUCFdKw+17EjHR7izrguXZkq7UacGYUC+AYkZFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433436; c=relaxed/simple;
	bh=n17GogWboLYox9N1NFGuTWdC4ZpLXVH4J5LNpSArofc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKuXg5IoPuQAsaQZllcSoMWYuPFeQfVREKuEQwDPA+WBpfR55XcRzQx3AVxNL3D5udwOMmX5QA/3yoinxKCGrC8SIJXRm4rViepPOEMb2GRXshpvhwirKaAm58rEkpkto893gYhnE+AduBiVvgykcQVr0eOIZzUpKkSks9hQn5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ObNL4KoP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QswnP4Yk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ObNL4KoP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QswnP4Yk"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783433433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TwvtAFUbh5o2spxk38fHpwaz4M1Gs+k3wYEHBND49vY=;
	b=ObNL4KoPBqvgYC81FBv8pv6MGnzzxqOPBVKyoLTxM9iDKfcwXiM+XTsAs3uGWaaK/lOixn
	ubifwS7StM7J676cIsicCZqH5nFgx+pAmoIfLiMXY5O6rkhRaXXDIgwV0QrhEWf1OuDTDP
	0tjuDzN2A9kraG3w1/aKilVu9RBvf6DvclvxHt0F7iX74u0we+4LwXScM+m0HsvMQ9Ge+2
	e/CxqhKCnKdI1MfWT34ZsRcOsHpeMGawnnQpdqaqsRxlhjCHETxRI7Zj52RzCqmvJRdx7M
	O2VjqqVoEKobRjg2hoMXtu5hYGnRUVuejkQII+iAjgBIwtDHd1RbvkxeWDg/SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783433433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TwvtAFUbh5o2spxk38fHpwaz4M1Gs+k3wYEHBND49vY=;
	b=QswnP4YkO4ZeNO3LIJtjQvGOGKBsVvYTp2M9kUJGRA2gOlCfQuvvveruT4Odq7FFISh3K7
	7Wa/AkJfK9RLF3Bg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH tty] serial: 8250: Ignore flow control on suspend/resume with no_console_suspend
Date: Tue,  7 Jul 2026 16:16:04 +0206
Message-ID: <20260707141032.5074-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If no_console_suspend is specified, on suspend the 8250 console driver
uses a scratch register (UART_SCR) to store a special canary value. This
is used during the resume path to identify a printk() call before the
driver's own ->resume() callback. In this case,
serial8250_console_restore() is called to quickly re-init the 8250 for
console printing.

See commit 4516d50aabed ("serial: 8250: Use canary to restart console after
suspend") for the original motivation.

Unfortunately, this canary workaround does not work in all cases (such as
suspend to mem) because the scratch register will not reset. This has not
been a real issue until now because it could simply lead to some garbage
characters upon resume. However, with the introduction of console flow
control it becomes a real problem because a failed suspend/resume detection
when flow control is enabled leads to all characters hitting the flow
control timeout.

Workaround this issue by temporarily ignoring console flow control when
the debug canary suspend/resume detection is active.

Fixes: 5e6dfb87b191 ("serial: 8250: Add support for console flow control")
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 This should be included in the 7.2 release to avoid fallout
 from the 8250 console flow control support added for 7.2.

 drivers/tty/serial/8250/8250_port.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 630deb7dd3449..38de6398e756c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2000,8 +2000,14 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 
 	tx_ready = wait_for_lsr(up, bits);
 
-	/* Wait up to 1s for flow control if necessary */
-	if (uart_console_hwflow_active(&up->port)) {
+	/*
+	 * Wait up to 1s for flow control if necessary.
+	 * When 'no_console_suspend' is active (in the window between
+	 * suspend() and resume()), flow control is temporarily ignored
+	 * because the canary workaround is not reliable in all situations,
+	 * leading to flow control timeouts for every character.
+	 */
+	if (uart_console_hwflow_active(&up->port) && !up->canary) {
 		for (tmout = 1000000; tmout; tmout--) {
 			unsigned int msr = serial_in(up, UART_MSR);
 			up->msr_saved_flags |= msr & MSR_SAVE_FLAGS;

base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.47.3

