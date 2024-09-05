Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A1617C9AE;
	Thu,  5 Sep 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544044; cv=none; b=tnUm7He9bD+obd7ZgBC5gnAkPvzyCyP6favUojyLJVyZjIZ5G/5HPAmJQ1u9E7zRjBwXs8ylTYyJ7ToUieMkORoulyd13v8G1FB9WwkZfp/jCEvV6FpKlwU7omC+vfJSMdsgkCq0w/YBAA1YTGmciPK4aG2ijnqz1vgsmCLSH5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544044; c=relaxed/simple;
	bh=AOn6Ll9ai4K/u6uf9vZ+jX0+M6RhyBBOqA4799es7aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5Uggr71AD7V8SnFZVzzKH9PBkrw1QngXfS2DLRcwcvk60HUBVqZMWrIJY/6Cu+ssXppKd3lSQSzlG/wU1xzFETkXK4QIbppCgPvKEVewajubF5JT2e3aBaoe49CpAI/7WX4+4e4xcNYqJ4kx2tWFy51Wslo9M3vtMnwCRgQsQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NeYeEDCb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XzdR8k34; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NeYeEDCb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XzdR8k34"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725544041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlP6kusqtPG5pPJZY/w1PqH3fKGrdHhT4n2wnmhWeF0=;
	b=NeYeEDCbzT0P1OYbMjJHWVskJLk4BmvRZ60tzMCNWwNNZScyGGA69+qtp15gmB+OJntq7J
	kjG35W9+Ws7z1mc2Z2PBcKmcAO2wbGRlISYmXnTNZxc9zFwUf9Qf6mNldoQKlTrnYvOqSY
	HScPivxmP/H91fpWV03aeUubkn4htfghoNvcrYPll0YuYCHO4rLwnNjOmpegxNiL4eDxed
	MvLM92vY8WjW3djdACW2qJytyKD5pBtg3oJMAAJZ2g62BoJUz05z/9FglFG/GUL1llomr7
	M9cdOqiVZBfAc8g55xGUV4CNB+ah2FcMOPrnL450Xv0BVbIZPnzAZpKy2FpIXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725544041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qlP6kusqtPG5pPJZY/w1PqH3fKGrdHhT4n2wnmhWeF0=;
	b=XzdR8k34wZGMeFazggmgjYlFxCnm7Z4nx2H5h//zhSrPqt5uFQyMcaasZthP1pmAJFVx73
	FkMaivFzpCV2TCBw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH next v1 2/2] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Thu,  5 Sep 2024 15:53:19 +0206
Message-Id: <20240905134719.142554-3-john.ogness@linutronix.de>
In-Reply-To: <20240905134719.142554-1-john.ogness@linutronix.de>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 8250 driver no longer depends on @oops_in_progress and
will no longer violate the port->lock locking constraints.

This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index ce841c62900d..1b4524f6d9b9 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -712,6 +712,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
 
 static inline void serial8250_clear_IER(struct uart_8250_port *up)
 {
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&up->port.lock);
+
 	__serial8250_clear_IER(up);
 }
 
-- 
2.39.2

