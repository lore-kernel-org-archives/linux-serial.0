Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A4F3ABD83;
	Mon, 27 Jul 2026 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164016; cv=none; b=TqL9/DPT6rvjR6CiVsLk8HTgGs8lmDbvY95yuAihIfLTBg5HEt4jhotRjHYxsPJkjxjvYfYrz+MhlSTJ7KegeM0HIvI/KOmzo5PFK9KXlL+CbLOnuEwIXmbWmRuo73S9RDMET2BbNbfF5TALls8LqIm9GVR+ECyzwfcuAlWjydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164016; c=relaxed/simple;
	bh=BZ0+JI99SM05bVmvT9PNZxg77urnVMIny3Fc59K5Ydk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFUH2nN9bvta8uVwRsmMvUXXeCPyIekqUxiI25HCa4VUyWAeyWbYktXSyrV2LBtrb7mDmdAHuSOxjt4ZfAv5CtKsjnYRyxVkqPJZIF0ItrqIzfyz3IuYSXcIeiujst43ANFnMcb1kqlJq2GMAerGJ0J/SN2H2RmVVx7WpUhsvdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxqlL8Ar; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GkSXLEcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxqlL8Ar";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GkSXLEcx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785164013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgSWyUg+F0+7DOASKVk1JKPzzbYYtMc7vh8U2IPl/c=;
	b=CxqlL8Ar6ggX/1UEaUdaQMTnkEtlPtbqnqN6t36F+pVH3e66haQLPyOjHc7z3igDpbGKN6
	yOFesHVqrfpNSELzmH3Fo80RVh1vf0NhfaiMnIqj5IEp3pNyDarm7ZHnTkFlMh8ZR1iMbL
	jhWz6p/8oopVxnkgnKVY1mzw3AyS8tmasOVhFrx2v9Ve4ioA3n0JJNDnMzt8173W+ibygN
	3i7q2jiDAUdAjglHHTpMe1f/Yxtqfhjgq//TjzSjiRR47ZitcBsFEgRPLTHw7C9TAFENee
	34rZIIW/e3KLrdcm4BqVPfOsMK8z7xe3Pu4cG0HBIafxJWtF3RX16caeyn2fHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785164013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fgSWyUg+F0+7DOASKVk1JKPzzbYYtMc7vh8U2IPl/c=;
	b=GkSXLEcx7ACnxQEP2y8KVqaK+DtIcPw7FFPpRs+6+wpoGeEVbQ5zK/xbeuDXHCuVewngoF
	gU37nqdxUIz+3xBQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v10 2/2] Revert "serial: 8250: drop lockdep annotation from serial8250_clear_IER()"
Date: Mon, 27 Jul 2026 16:59:20 +0206
Message-ID: <20260727145332.231949-3-john.ogness@linutronix.de>
In-Reply-To: <20260727145332.231949-1-john.ogness@linutronix.de>
References: <20260727145332.231949-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3d9e6f556e235ddcdc9f73600fdd46fe1736b090.

The 8250 driver no longer depends on @oops_in_progress and
will no longer violate the port->lock locking constraints.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5bcbb6deb12f7..12162a8928922 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -719,6 +719,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
 
 static inline void serial8250_clear_IER(struct uart_8250_port *up)
 {
+	/* Port locked to synchronize UART_IER access against the console */
+	lockdep_assert_held_once(&up->port.lock);
+
 	__serial8250_clear_IER(up);
 }
 
-- 
2.47.3

