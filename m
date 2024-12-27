Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6201D157E88;
	Fri, 27 Dec 2024 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339535; cv=none; b=f40AOhBo2deXP7ls1F6ykdv58NMhpJYzQytLPnlaiHeiNpO3Kwmz5WAyxLWMKfsfeb4scZqoqIdufopqq494G3On/S1B6ZTZR0Y3f2v94HkmpVmJ9l0v7GnWA1lL0lCDg+gIHW8hr+VNNdPpHLUTihFkeFobwBpnLLHmBkf3Uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339535; c=relaxed/simple;
	bh=GkKtEopb/vxipA1rE+mu+UbFX4e/7ABwXI/xzZ7fn+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhIBRqsNmNPEhpijMaRXB/KiBh56TGOcOlbJdUattPG2sU/LN9R9RW1ZKcqAF198RBSnkKA3lEk8vXeAPoiF4MPsXvm6/WimSTKBD3Jng60mPYLw1hup2EtqHWn8yK/PcrLaZ+teSRLZhQEYB9OQ1plFMTY3IV2efTHW+4+xC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X6uz2rsi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pbhOgYJn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X6uz2rsi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pbhOgYJn"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735339527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X+WdzHUSBBjVLy5D98VD/ORPFzC0dNUp9SeiqSm6E8=;
	b=X6uz2rsiyzSwXG5rfJRLVj6wlz7PUe2Rqnnm+1t76UqM2thyrJ7jeHk1ZCJmx+2rMqgR+4
	fp+fJVFk8DFXIYfwQfW9FGMAgTLfstwuebuq22hm17y6e3PZ4RcP9BUGoK5hRIvSyidGCv
	apzrq4Uy8rrvyiIXO2lq/pGeLV2iYTk3XUdb+gzS9BB/7Ldr391veVlQtCkPkvcWXsbHSl
	W78U3SjHcrOBd8wzpXM7REXlAdYWsTLRYZ4xs3J3BSfI3SpiavSOulMQa8ePcA/hApIxvR
	hpQWMRDZpPr2qR4ac3cUd0FchbwPoJfQY9atl3Ofm6nYn0xMI2JWyrwbKDYGaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735339527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X+WdzHUSBBjVLy5D98VD/ORPFzC0dNUp9SeiqSm6E8=;
	b=pbhOgYJnesnVhsiU2Ff21JX3XC8ACIpg4Gcjm9y3jmilnZAmGHhoZ8QgIb5ZLtesGti2NH
	RcnWD+2BYM8U22DA==
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
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH tty-next v4 6/6] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Fri, 27 Dec 2024 23:51:22 +0106
Message-Id: <20241227224523.28131-7-john.ogness@linutronix.de>
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
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
index fbba4746eccc..bc70e660a403 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -726,6 +726,9 @@ static void __serial8250_clear_IER(struct uart_8250_port *up)
 
 static inline void serial8250_clear_IER(struct uart_8250_port *up)
 {
+	/* Port locked to synchronize UART_IER access against the console */
+	lockdep_assert_held_once(&up->port.lock);
+
 	__serial8250_clear_IER(up);
 }
 
-- 
2.39.5

