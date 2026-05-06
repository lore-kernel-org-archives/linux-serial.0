Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC3830BF6B;
	Wed,  6 May 2026 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069770; cv=none; b=ghrJLK0q5IxFYs7SYyx5Zv5dEyaNKoNqo/8JuydsuBi/DCG7xumGy4z9g7fdWfRMZTyBCDj2ry0BLIIPqUQ+0e5pFZEKjIYTfQnZaGx9sDasdL0oJj2S/gvk7s5uozFOu/DYojc9pw0P/U4dklFAbG7hBmBXx55KGW2In2yh+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069770; c=relaxed/simple;
	bh=avWyrmKeg9ZZo9XDck9W7JKhxinIKZr03E1hHcoJdSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCvZfHQG4urzX5n/VjQV+4HcRWd3ch1kdLNzcOL8oXkg0D/h8f3qgz6HFaVE0ikaVw5HsFhIbV+8mD2ZSiyXvaMSFYVzQjrhyEd5iIfqumMMHWmb62VH86eECrAS7Mu50NfPSsqpuV/bzUUgMPcId5kRsVWSMjbAB08jLkgCCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ND1fDR4E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=39IC3B2H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ND1fDR4E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="39IC3B2H"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778069767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXGNRsgNxJJCUIR2fDCouVm7b7oiVL7S8VFK1HxgPzI=;
	b=ND1fDR4EE9Fgxsko4CKSyqluJHTm4xwpQ7Hh0LVGD56Fh6TqMdHw3G72/cGqqGUCBBn7eC
	yfJ4h1zkFcERV6xL5X8zdQeK2r+SlsXBDrmx6HhFZxVn/a6ZhaLccZ+vAePg8DeW/bFxda
	ZnuqLSihFrqGQUYQIp9kOCe/Eq36tKjmBSdizDxhsXkZ6pXQVFqIiRXb0A+v4YTppSbOGd
	BusPVfWagkUcZSCSK8PzwQTejhVrBCycHOFrevqoCD2yVKS5JoJ0Y6FnucbUV6Z8n3boF2
	FGlNPRRnkLUC4l4YA8t43/fNlDjg7eYxlk3Ix849G+tib6ox8SRcyL+43KbbqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778069767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXGNRsgNxJJCUIR2fDCouVm7b7oiVL7S8VFK1HxgPzI=;
	b=39IC3B2HDxqF3inerDCUVGlTyYlhfDs2w2PUCj0lMx0x2Doedhzblu8xBejVw1/ohgfCte
	zWl03j7Bv091jQAQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v4 1/6] serial: core: Add dedicated uart_port field for console flow
Date: Wed,  6 May 2026 14:21:56 +0206
Message-ID: <20260506121606.5805-2-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-1-john.ogness@linutronix.de>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the UPF_CONS_FLOW bit in the uart_port.flags field is used
by serial console drivers to identify if a user has configured flow
control on the console. Usually this policy is setup during early
boot, but can be changed at runtime.

The bits in uart_port.flags are either hardware and driver
properties that are initialized before usage or are properties that
can be changed via the tty layer.

The UPF_CONS_FLOW bit is an exception because it is a console-only
policy that can change at runtime and its setting and usage have
nothing to do with the tty layer. This actually causes a problem
for its usage because uart_port.flags is synchronized by a related
tty_port.mutex, but a console has no relation to a tty (other than
sharing the port).

This is probably why console flow control is not properly available
for most serial drivers. And it is hindering being able to provide a
proper implementation. Commit d01f4d181c92 ("serial: core: Privatize
tty->hw_stopped") addressed a similar issue to deal with software
assisted CTS flow state tracking.

Add a new uart_port boolean field "cons_flow" to store the user
configuration for console flow control. Add getter/setter wrappers
to allow for adding more policies later and/or locking constraint
validation.

Mark UPF_CONS_FLOW as deprecated.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/serial_core.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 666430b478997..4f7bbdd900176 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -533,6 +533,7 @@ struct uart_port {
 #define UPF_HARD_FLOW		((__force upf_t) (UPF_AUTO_CTS | UPF_AUTO_RTS))
 /* Port has hardware-assisted s/w flow control */
 #define UPF_SOFT_FLOW		((__force upf_t) BIT_ULL(22))
+/* Deprecated: use uart_set_cons_flow_enabled()/uart_cons_flow_enabled() instead. */
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
 
+static inline void uart_set_cons_flow_enabled(struct uart_port *uport, bool enabled)
+{
+	uport->cons_flow = enabled;
+}
+
+static inline bool uart_cons_flow_enabled(const struct uart_port *uport)
+{
+	return uport->cons_flow;
+}
+
 /*
  * The following are helper functions for the low level drivers.
  */
-- 
2.47.3

