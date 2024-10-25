Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3691FDF89;
	Fri, 25 Oct 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729853857; cv=none; b=S7769Am51GNqZsKfNOMTHLe41ylXjF0i9dMaiB7lZF5TlvdZK+JHXRCo/98vYX35STgE8eZbFYp7SLlfDiqfp+rtBAXwhNnVm3JfzzqtrOeRN4kyp2W9skIU4U7MZnmqbUmiVW/sqnWJZdrMzjTCSGw1Wu41bWJqNwRTmjCLXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729853857; c=relaxed/simple;
	bh=uCi25v7dZPwJgSMo0oWApVBb4GIOCxuUJNEt29mFJas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BM3A9VY87DStW/CwZ/D4MV68OL+vsIiCWpKH2Y5FJYhLC8KnDQpXFwxCgFl+goCchIiYIZztKKmuu+L49IQBniJRdd0arLUV26db3pgeuD/Nkvc2q1VvNGcyjcekPDGO95emt9ikqn0JlsGxhd8wxqwPRR+HoLaeOgP2b3wP26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0mo9aEbL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iSH4i65F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0mo9aEbL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iSH4i65F"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729853853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ckN3By33osOOhRu/7ilSfmb+7G76g/geNYlu+/gEoU=;
	b=0mo9aEbLzREU4cfbGF2y5izFQahu2ae32q4Ia6v82UAR9CwoIMaSwFz2jxfs68leoOGykG
	ljg2fbSA4X9jElNoZNo9UlgpXC1gi+5LaBLREFq4WVbg38WBPv25NwZkFzjDHt2rMelQOe
	HvVSUYOzbFTduUX2wzF2WD54yFV+MJfieR/TVzlqGs0orzp3FeAMgiyMQmO3qMzCJL+cEd
	9gWdfABggE6reYDTQkcnDHg2vII1pbl3Pn7aNigY3lkq0Z+RvKF5qqR1Sl3wTBfLjU5LZQ
	ene6hOVjPFreuStAO6cE5K5+IaK3ZA7yGBIe4yI61rmIzjS9+3RP7nTRU5Fkew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729853853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ckN3By33osOOhRu/7ilSfmb+7G76g/geNYlu+/gEoU=;
	b=iSH4i65FcFCuVT0n3G4AJF/yOrpOrN1FJILpJmGqTbok/MwMA5aGA1X8CtHEqlKb8PmAQr
	z+/WaDVZX28OoLDw==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH tty-next v3 6/6] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Fri, 25 Oct 2024 13:03:28 +0206
Message-Id: <20241025105728.602310-7-john.ogness@linutronix.de>
In-Reply-To: <20241025105728.602310-1-john.ogness@linutronix.de>
References: <20241025105728.602310-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 0b3596fab061..5c8778ec30a3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -706,6 +706,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
 
 static inline void serial8250_clear_IER(struct uart_8250_port *up)
 {
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&up->port.lock);
+
 	__serial8250_clear_IER(up);
 }
 
-- 
2.39.5

