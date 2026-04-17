Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07EE3B5843;
	Fri, 17 Apr 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421477; cv=none; b=hjFWkBPWazyY7lgCgXJLoow7Gth52RcdXtChmeiyfCaPFhpjPBXxyqUypr16HtSlz2JTCEvnbfT8UuOIKifveSs4grTpB+15BnykKM0pXz9eXED0+N4BHiEMS//vY+m6rt8vSCvNsbS+S1cPaEF/rViJ8OawngZeP4bZv5NllWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421477; c=relaxed/simple;
	bh=FBc35jOLYTmmpSOg0YwyTzm85KVf0EeX+eBqFKfNFyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y65e5m+BRNORgcbuiAaR95vu3lAA0NlYsFhJ15hV+6mlEAuUdBW8X3GfEUbRKdoa/t2+pZq+/4dRWWAXzwBArjpqhCCXYjZtQANpNYDNdiaT8lZQ1lZWVO/Yi82weYukNAcLH+VWDZwbfnGaiGmDAUkZGGh4qXOlXVeFTKO1P/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CSLX3ZQY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VryJevP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CSLX3ZQY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VryJevP"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776421465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDCT9NWTKM7j7JKLQuSA1A60h0cYwjtf3icEnr1EbJQ=;
	b=CSLX3ZQYG8BTpJshW6vbPQLMsS5k1xpmEGzzaB599xNYL8DnxsckIfSlupQEjpKH/j2Hax
	kE0ufxG/luJAbLyizP+A/hsg4fr1JbzoeEC8O7Z1NJJRbbVceMRhVqp+Irr6Uxqqb+A5to
	+5KySzgSyd9YMNVaBvBMJZIXGwQfsB/qeDQt0G2BHhD0ttUHoyEfiol0uOy8sgzSbcBiql
	WXdB8CBUI86MRTdPl+muwcyVtnUjwLeRXluNE+WsTdOBg+nKJ2eKmrq14vcQIN/wlzqxw1
	R/RMLAMpBUsOqDMW77oSvevhdbJ+hlkrO/Y878fGGoMMudsOurXYPyLKiHnGRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776421465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDCT9NWTKM7j7JKLQuSA1A60h0cYwjtf3icEnr1EbJQ=;
	b=1VryJevPlcEbgb3C1ubxKN98BPXvQfYaKxAIk5R6oqdOXQFyyV49hiMg0yYL/kBRJopq3y
	tbG/YFgGaXGS7xDQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v3 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
Date: Fri, 17 Apr 2026 12:30:16 +0206
Message-ID: <20260417102423.40984-4-john.ogness@linutronix.de>
In-Reply-To: <20260417102423.40984-1-john.ogness@linutronix.de>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
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
index 6c819b6b24258..07d272dc4e74a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
 	}
 
 	port->type		= SCI_PUBLIC_PORT_ID(p->type);
-	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
+	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
+				  (p->flags & ~UPF_CONS_FLOW);
 	port->fifosize		= sci_port->params->fifosize;
 
+	uart_set_cons_flow(port, p->flags & UPF_CONS_FLOW);
+
 	if (p->type == PORT_SCI && !dev->dev.of_node) {
 		if (sci_port->reg_size >= 0x20)
 			port->regshift = 2;
-- 
2.47.3

