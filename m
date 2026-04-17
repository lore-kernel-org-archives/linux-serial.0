Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09523B5846;
	Fri, 17 Apr 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421475; cv=none; b=e3/XGs3gNsSa6SJHVn9dAmUjxJQVaX6JMauB8bteukeWWoW+R2m/EVXewYT6rHNkcarSYhiJqcOmmSm0C+pXxXmKPovPvsdyERlc9vkeXBJRkObaF+fSK4TTo3ik/VPpxXgdmfafOMSevaUfnnKUzc8OX7uUDpyszmLxxCu2Wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421475; c=relaxed/simple;
	bh=T0ZrDrOUya3oWk76FafMuetyc8sBId1vQHkE6ajtlN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyhQgoRQagcWvY7eRX2Q2v5Nmpa0+7/87aAt2OYDgUdWlQbSomDe3izGdIEBZcxaqEvp6md54E7mD7XOof7Ltpbv2G9RuuE2aCq/4yGuEIANOiDOi8TlINq985kIvaOs+9Bx0WTEwcgpZvf8ANWGfJwMIaYikSDxMcereBpiocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWk9eHLt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OhgACVqF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWk9eHLt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OhgACVqF"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776421464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYcmU/kilVLmia4EQ1s3pMoP9RDTiRvnL/dWf1YvggE=;
	b=hWk9eHLtP2IOq9lD8W6aoKEqZvEUvTXZPue2T9bhxRK6TJXsV3m+iZ/qSZWS/tVRUmW3eo
	C2fXzG6pXrx9/uGLuaJZPxE3zGw+ZSsa1fhkiwmk1U4iRJOK6hYKue/2DjYhj8PZfJizWw
	+uA6G+YP+WHFV0rcHACusUD+qvfLd7grSdsrv0yWoAeSWjP6lMCopy8sxDPHF1Udy87hoU
	l4iy971HdXoEPBBiTMYeOjyx6c4j9PvgIev1JrbDW1dI9SFlnxn0dX65DO0yCE6lecyuYN
	5gN7EY0qogSDYzoSLyaRAwsrjzxb2N8sM4mgmA/82VvbLUcbwhsIO+H3Ux1FrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776421464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYcmU/kilVLmia4EQ1s3pMoP9RDTiRvnL/dWf1YvggE=;
	b=OhgACVqFzgiMJWOdWk2luwKUifG72jplYcjQx5v42o99bi6ROrzC/TjKIkWm491yK55Wuc
	bqdYQmlTlONWSkDA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v3 1/6] serial: core: Add dedicated uart_port field for console flow
Date: Fri, 17 Apr 2026 12:30:14 +0206
Message-ID: <20260417102423.40984-2-john.ogness@linutronix.de>
In-Reply-To: <20260417102423.40984-1-john.ogness@linutronix.de>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the UPF_CONS_FLOW bit in the uart_port.flags field is used
by serial console drivers to identify if a user has configured flow
control on the console. This policy is most commonly setup during
early boot, but can be changed at runtime.

The bits in uart_port.flags are either hardware and driver properties
that are initialized before usage or are properties that can be
changed via the tty layer.

The UPF_CONS_FLOW is an exception because it is a console-only policy
that can change at runtime and its setting and usage have nothing to
do with the tty layer. This actually causes a problem for its usage
because uart_port.flags is synchronized by a related tty_port.mutex,
but a console has no relation to a tty (other than sharing the port).

This is probably why console flow control is not properly available
for most serial drivers. And it is hindering being able to provide a
proper implementation. Commit d01f4d181c92 ("serial: core: Privatize
tty->hw_stopped") addressed a similar issue to deal with software
assisted CTS flow state tracking.

Add a new uart_port boolean field "cons_flow" to store the user
configuration for console flow control. Add get/set wrappers to allow
for adding more policies later and/or locking constraint validation.

Mark UPF_CONS_FLOW as deprecated.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/serial_core.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 666430b478997..2327a364ded16 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -533,6 +533,7 @@ struct uart_port {
 #define UPF_HARD_FLOW		((__force upf_t) (UPF_AUTO_CTS | UPF_AUTO_RTS))
 /* Port has hardware-assisted s/w flow control */
 #define UPF_SOFT_FLOW		((__force upf_t) BIT_ULL(22))
+/* Deprecated: use uart_get_cons_flow()/uart_set_cons_flow() instead. */
 #define UPF_CONS_FLOW		((__force upf_t) BIT_ULL(23))
 #define UPF_SHARE_IRQ		((__force upf_t) BIT_ULL(24))
 #define UPF_EXAR_EFR		((__force upf_t) BIT_ULL(25))
@@ -567,6 +568,7 @@ struct uart_port {
 #define UPSTAT_SYNC_FIFO	((__force upstat_t) (1 << 5))
 
 	bool			hw_stopped;		/* sw-assisted CTS flow state */
+	bool			cons_flow;		/* user specified console flow control */
 	unsigned int		mctrl;			/* current modem ctrl settings */
 	unsigned int		frame_time;		/* frame timing in ns */
 	unsigned int		type;			/* port type */
@@ -1163,6 +1165,16 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
 	return ((uport->status & mask) == UPSTAT_CTS_ENABLE);
 }
 
+static inline void uart_set_cons_flow(struct uart_port *uport, bool on)
+{
+	uport->cons_flow = on;
+}
+
+static inline bool uart_get_cons_flow(const struct uart_port *uport)
+{
+	return uport->cons_flow;
+}
+
 /*
  * The following are helper functions for the low level drivers.
  */
-- 
2.47.3

