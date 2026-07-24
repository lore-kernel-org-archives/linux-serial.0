Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF81421257;
	Fri, 24 Jul 2026 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889419; cv=none; b=jp+sVQxYV4nSNMtH5WR7iyReZkwrOr3Gp20NBDH/2zUNUOuDf5eDVbqbXCE3cVu29BXeEMO6doRDxDNrnzyE2hOjs+M/ktITEAyNsNxcRmzIzAVXIWpMLQIopohfTSe+e8x1rzQ1L4iQ/1FGH4UyqX1kPS35eTKKSDb6zZdZe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889419; c=relaxed/simple;
	bh=YDsWxF32IXHatoVIsPlgwuPo9q9sJVW8xuwPnNz3N+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXsRrG1cDAjh+hGWvhAdCfngBz5H693I3UdyP1pDHE1+KQOB5YHkq3rHZp6Lwvimx5bmTJDwlPftM63zrVQvvXdJMroyaiKkj58yfQgKmLcfsYi7nTiIJTQSYP7wD4EC5ePCTctctax7gWYMKpRz5punHmV1ut22sulNPl+m0Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zbg74v5q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hQ0MrHbI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zbg74v5q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hQ0MrHbI"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784889415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLbwiyzjEATin6rkNNW5n9+l5khVtWzHpDl8gsQuNCM=;
	b=Zbg74v5qfomzYfs4qaOvnZRJ5xzG4FxT9sFiQ/bILknrY5PyO4CjcaXV1hjqYIJW+v5N4C
	/aK6nXQli1E9oTnqfMNe7VNpeL/5o6B8aUa9bXvXBqStv3OJLxvvMx+1Zd7+UWtfg8MVft
	HFIHs7//0Yc8f/qOOrWQdNcNMzXSHoD5Hgqsp4t0v+J97wseqc2rINM81GzMC1HQp3zhX7
	Syx+kblCkNfDCbpNpY5QPxPG0OICLriCZ1XBwj6OG6jayt11s8J/IABmg02H25Vtqa4XM4
	0jsKNL0oF3xEBhLx0C3RGO/X/Mv8QLi6mRDsrRIdOjmi/wU6yLFnIjdxWMrnbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784889415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLbwiyzjEATin6rkNNW5n9+l5khVtWzHpDl8gsQuNCM=;
	b=hQ0MrHbIzQb7TBtBpKhGYpOpfqLkuLEiDpoq2zQ9KJoVfR8Dsy+tGjESOvDuSxHTxvK0+L
	dMAVdYYxaxKGzQAg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v9 2/2] Revert "serial: 8250: drop lockdep annotation from serial8250_clear_IER()"
Date: Fri, 24 Jul 2026 12:42:52 +0206
Message-ID: <20260724103654.133654-3-john.ogness@linutronix.de>
In-Reply-To: <20260724103654.133654-1-john.ogness@linutronix.de>
References: <20260724103654.133654-1-john.ogness@linutronix.de>
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
index 855a7aa48c2d2..ffe40ce4dc207 100644
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

