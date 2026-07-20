Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125A233920;
	Mon, 20 Jul 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555651; cv=none; b=Z9uLm/Bf9UJltUZnLlejsYR5Ipvg2M67Fp4vtlvdphtJsEeWhUdLL6qsLAEYxgQjdIK26iSxue0uz3DeJnpusvZyTmDt4eheJqLXmZCVY7F7yVgoRfdn5yqmR7ujyWmjFIXgCS/jVfBfcHZqquRW+oKD5agmjc4ZKQisERmiQaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555651; c=relaxed/simple;
	bh=xDeFhiyAgX/FS56y0k14yW6IHjTbgYopmR3Fk8WmNQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UcELJxq4xjtDeY/g2gDMefmsUXjo1bFNE565ppzZEeVVzbMWFiuw98pFAWC0zL5TqOmJrzRAm7fjDnNjom4ByQ2wRXVeu7FfxVyZQ07/m/hYs/Oa7eFBA+B43v6zkgue59N4oWU/v1B1bn6/AR5ajyhQdR4P4RUMSlwkWXErpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0xkit7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wTUxovhj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0xkit7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTUxovhj"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784555648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWG3iJA4jSN4wlHLyGzRzSLz1sFi1wVJIkv+GZTilBE=;
	b=f0xkit7aDycS0EPgutfOUHiMCi1kzs32xSJGymYuCXJotiT65702kGe4LS1O65STEJfBBh
	wSjtJILlKM2VDcGgFWK1w4aOs+RZu0SCM709CWiscTDAjxa1mPH7IFSw7cl54H/U1+1SHs
	wmWzz7oV8lrSFaOPBGMmOq3hRhD4KEZ9Y9965GHx28iVD5Hi3zMjVcCDJmSHvDt0tqv4z0
	weXvx0N85NW8a7XqDuqgazHRIqOG4OGqYuNQKpfXZnr8QzYrHV0a3byc8rBH1kZM9o8PNy
	N7/+uBvr7gNSPoo0qaES9geH1rUQQdnEvHhFBAF9IDhe4p5HUF18nXs6RoCD/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784555648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWG3iJA4jSN4wlHLyGzRzSLz1sFi1wVJIkv+GZTilBE=;
	b=wTUxovhjHjXCM7HdiNB8FUsHv3IHvaGDoGVdGXLeimHeH2PAp4IcITbG0Ayqli48+ZDkgy
	t7RUknDHszjnD4AQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jacques Nilo <jnilo@free.fr>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v7 2/2] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Mon, 20 Jul 2026 16:00:04 +0206
Message-ID: <20260720135407.3925-3-john.ogness@linutronix.de>
In-Reply-To: <20260720135407.3925-1-john.ogness@linutronix.de>
References: <20260720135407.3925-1-john.ogness@linutronix.de>
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
index 8753f86d633ef..31386dd283ef8 100644
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

