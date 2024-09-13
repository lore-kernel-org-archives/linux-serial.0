Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923091DB94D;
	Fri, 13 Sep 2024 14:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236347; cv=none; b=gVjZZxVrVvh+Jp6z0wqmYVFErddTz0qfVC3Cky7jz5BAytOSTnLJ5EAo0+rYKTmOgEB76TNY5ynNsWIhF+zHLKD1XtD/sX1Mg/ktkw/fqqsDjJhX9yvKWKEGb0aEBL3aCIflhfigzKy03M9OFhtgle5DvAQG3nyQ8/kws/RKJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236347; c=relaxed/simple;
	bh=qOLlB2ODIZHd9tadFjGmdop49h0yAytpCHar4CpvpYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sks8Ky7pAM/FT83zkBSjSZpkfe7jSLjkwO8fDUdPqUDCiMRuG2q2lP2JM8w7TLVSJVuthpsmyIxvJ7NhYFU77SK8s1GXa908UNblBvDNj+6WGebJH/j2AZVOQo33FtZeRkhv3yZdL9TmjQx5OOkT+wtwgJLtuer1I66zpMb30r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFp1Ksdd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPiu3/6x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFp1Ksdd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPiu3/6x"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726236343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8MmvbSxGrzA2amsSYnDkpZhNgQm94vpI9KV4RVr0co=;
	b=IFp1KsddfJeXyxTmgTnEHkZrw44Bgmp3mTutq06MHLiE3lyMlHOzyWLMlrDpwu3Cht4Puu
	5fL9UMNfmfaz1GE6W9UxkDOSxU6yk9DlN46OX9N5rK6ljdxeBMOG7YYve1e36eXKUDF8Ex
	y+oNqP/NKHvnnVXjPFrfWTo0c+VH1eLb+IW7aSsdCuXcOexR4ILFnp3PioLCst0odPNmzq
	FqYOa7fcUdbwiLKFdvjz6i8j5V/KX4xJfO2DjfyWZA4qKc8VQY8o11SSs+KZFnwy8hyKbF
	YBOff2m6TqO9WvuvE+ZFcT6kyghVqf8mBeqX46KOOxWA84jL5fA9jO+QJ9mk9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726236343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8MmvbSxGrzA2amsSYnDkpZhNgQm94vpI9KV4RVr0co=;
	b=lPiu3/6xN4ewvXHEFOrqhvILd/pCS0vHbt8IFr5rLywXuK6mKdOYcdceBBIQNlnH9DhrLF
	SlAG+xsowFGU6bDw==
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Rengarajan S <rengarajan.s@microchip.com>,
	Peter Collingbourne <pcc@google.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH next v2 4/4] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Fri, 13 Sep 2024 16:11:38 +0206
Message-Id: <20240913140538.221708-5-john.ogness@linutronix.de>
In-Reply-To: <20240913140538.221708-1-john.ogness@linutronix.de>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
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
index d58a0fa95e3b..fdef0cd01b2d 100644
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
2.39.2

