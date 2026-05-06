Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9184418E3;
	Wed,  6 May 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778069772; cv=none; b=UFfAzikttPn/TCqrCdSNmyHQ5qxS2wET+VTlW0A4NV2Yqmt7MzCkeI+0GbHHPQ8RG6AOWsZVFfWbykFfF2El0s6fbgJj1JDbgGpI5+FhnRqQoI/sA6K0jMbezXtK26jFonXG/9BrZeehSsfExthzQIi6K5RjbA6+rlvyef0Rl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778069772; c=relaxed/simple;
	bh=HqK9WI/4RERvi25TuZkJmKmoMaOvZ4CUokoGM8wn3Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBSWa0DVrDlaTC2C4vv/q9Wg8GRTUoUqzrnduX3GnTtLC5KKIhdAtvorys8JcfWxmU9UGIyz8Feya9Ko0s7HhTjspwRGrlQWD5VPEyYTKSNorbvYqlFoeTbNeCvIdhLZjDYe0ZKeqJB4ARa5CXYtokRyniQF2VEunLuGE/2dZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XTtN0F9b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQf/Z1Uh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XTtN0F9b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQf/Z1Uh"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778069768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrOyFhVPontbzgEAbyb/2JFaAOM/AqtJ/5aPb0vTYtY=;
	b=XTtN0F9btUC8YasjBJhOye0iwPO+dbwbp/eOOolW3QOjE9rNmdQXkIVebs0Hw6tBOk2yj4
	rCf60YOg7oPmy80cMYoDTND+4tloB1XHRjGd+4HNBl7CBUNnZU6iRVIs+SMrYv1xvtLmpl
	VQmJI7czLtsRJ9QUhi4Uonm8Io+kfNh5ZaX8gjTC1NcjRCL7wKpNzJ3+4qq1P9qinqdC7e
	daBIDdwAZr8+Tao7AKqn1Jrh0nC1KfoaKNXeJEyQ1m0XTj6OINtmnpLEM8bP5wZI5jO73C
	eTxz2SPfSSbtzqIHTbZqJ6QBl9Wipzt8YjF19FfM7gyROaghyoUJSmYWElt1jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778069768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrOyFhVPontbzgEAbyb/2JFaAOM/AqtJ/5aPb0vTYtY=;
	b=rQf/Z1Uhmgn3jow7oP5aWU2mRJyRGhfJkbEeZDV4hB7QLigd1sN5ZbM2IfWGm5DAY4HvLc
	IeMgtiy0QLAT5cAA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v4 4/6] serial: 8250: Set cons_flow on port registration
Date: Wed,  6 May 2026 14:21:59 +0206
Message-ID: <20260506121606.5805-5-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-1-john.ogness@linutronix.de>
References: <20260506121606.5805-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since console flow control policy is no longer part of uart_port.flags,
explicitly set the policy for the port.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index a428e88938eb7..b0275204e1167 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -746,6 +746,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	uart->lsr_save_mask	= up->lsr_save_mask;
 	uart->dma		= up->dma;
 
+	uart_set_cons_flow_enabled(&uart->port, uart_cons_flow_enabled(&up->port));
+
 	/* Take tx_loadsz from fifosize if it wasn't set separately */
 	if (uart->port.fifosize && !uart->tx_loadsz)
 		uart->tx_loadsz = uart->port.fifosize;
-- 
2.47.3

