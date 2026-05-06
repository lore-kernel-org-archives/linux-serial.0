Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93A4418DB;
	Wed,  6 May 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069771; cv=none; b=ZsJgbJnGfCOdgBTU7gS7pTQ+6vY/+jYYRUpK58uZgebLKriownNzN6eAFAfFn479sfKJTGK73LlwmJY3E5nXavqqSk5OqyHfpHcu/v56QsA1ZqPKaUMsuFZd/xrgT1UvwjVqjOTo0i3VE/qLzSwqMh9tLAwv0T0JSdobAqOy6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069771; c=relaxed/simple;
	bh=8IiTdQ06fzqy60Mm7+cFMWGC38P/MeXTqUDPLPEZXqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucFlhZZGUphmQM7ufTtiT9LYf3/3a+ERViae3iyuLarQWVsSn45yz2sLeKn4UK+tt8gQPtHDjJ7H+gLCJPXiDY72P41fxOGBF/vAox8+6+rVzXmxQIdtIegI1qrUf98S/hnX1LRUdR8yh6cNbJ1JrFxmQ/Jz81UexS7ee5KgIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaR8OlvU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdPWKe4g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaR8OlvU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdPWKe4g"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778069768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fg3GZ8rSJr7vLPo7KPLI57+/qD3MxzntSQWRoVBb4to=;
	b=JaR8OlvUAsTtZ10Yo3HbI50WIIRszAI6nVd+MUj0P4znxqRN6gs4tRrQZB7QD9+QfiLUv2
	kqsV387TJ3s+adkdmfuaT3JzRSrJ/THUF5LXsdZ2vBJGfuQD4utYBok9nbICkWhu2K+yBZ
	5W43rGNj23+zk0QuEItAYXvleIaN/kEzj+/SulNkBhGKKpuw0VOvxbHE34qIWWyT97d1cc
	ZimRAtPm5uviICqP7H56JWsf4/KHuMKqTPhikZ98UUz4btLAJSvEjXJErqHsrimV8dnYHP
	b4JZxRuBZFBE1jeLnfjIlrXALB5n0RK7HeBZpLGQmbCFW08P6Iy/raEngvvG4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778069768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fg3GZ8rSJr7vLPo7KPLI57+/qD3MxzntSQWRoVBb4to=;
	b=kdPWKe4gO+V4WODj7TFgnkaiOEO2mkmXK2McTyTh/66k2zHmJ8UV10UcaaZy741KhLFGDU
	Xfkz1e2d33BYByAw==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v4 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
Date: Wed,  6 May 2026 14:21:58 +0206
Message-ID: <20260506121606.5805-4-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-1-john.ogness@linutronix.de>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid setting the uart_port.flags deprecated UPF_CONS_FLOW bit if it
has been configured in the platform data. Use the new cons_flow
wrappers instead.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/sh-sci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6c819b6b24258..a1328a3b6638d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
 	}
 
 	port->type		= SCI_PUBLIC_PORT_ID(p->type);
-	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
+	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
+				  (p->flags & ~UPF_CONS_FLOW);
 	port->fifosize		= sci_port->params->fifosize;
 
+	uart_set_cons_flow_enabled(port, p->flags & UPF_CONS_FLOW);
+
 	if (p->type == PORT_SCI && !dev->dev.of_node) {
 		if (sci_port->reg_size >= 0x20)
 			port->regshift = 2;
-- 
2.47.3

