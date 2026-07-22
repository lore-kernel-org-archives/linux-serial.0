Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C38330B3F;
	Wed, 22 Jul 2026 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784718570; cv=none; b=TXg72HNfS3RCkpi++j0GxFzDku8QAIqjlredqVUVBIeBJ8HjSdt85GfIuCuShwbaQacgnRzg4JFKXMTQlhLMLWmaG+ptgVc59b09jP/z6Xo6Dr0LIIUXl50fhmhPqK4qV0XDPsWbIgdH9d/iZTNEKQTTN38Zw9NAZtl40NZwjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784718570; c=relaxed/simple;
	bh=xykJXsV3mRnkko0gK9dMrjBGra2+eftCapShUVTPaQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+T5gI902qM3l+Cy4bAMG6/pHG7c+3M8ZU/jXvFRetWGpD9/zyLdOqZEpbw1SqcNkjoHC4BaDeX52O/cBNHHqVPLCRCVzacr+RV+CRg8EiOBxSsve9uhuzIwTwrEI6YFpn3XZuDt0Z6L8SKSkj+AP8pHk7Qr4de1LWsoarTgiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYakmQuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eCwP68TQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYakmQuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eCwP68TQ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784718567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoEraJQwivohbAi6mEy+yR3zr36FrVzi0EMzICpQzps=;
	b=YYakmQuqt5Du5QhD5QI/7jjvRsbdvp2aGg+JVQeKv9el52R2gGSNE2KmbnJR3wdLvzlbkq
	VfrP2pr9fE9elXxKNQ3uJTnVtwBq97oLJ9BpFwVDOBgkT5A1SqsTJIwVB83+PNUnq0pQIp
	5FoRgzEJ/M7KG+MkgoqdryrCggK3N9rFQs3ND9muGOn7XrHRxnFTWwUJVItmsQcGKUkjkI
	395sbOTUQYbbt9lHT3rxQ+8OGq8ff5nldzLZsG9+fUN0Q4GiqZIMcIE6ks0M4hrj+OpqCZ
	RzFL2gQXGWYs4yn6GAnwBE4xoggAcy0D3zyZ/zTYApq4pbEk8dxSZNtOxcPXvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784718567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoEraJQwivohbAi6mEy+yR3zr36FrVzi0EMzICpQzps=;
	b=eCwP68TQW5NBbSzoia8iQ37Fv3Z1xa7PR/ZyIbNdEE7RMWJYrgX4UTJASIrM5YG/0OKxVf
	M9jTUwcLjZstcNCA==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v8 2/2] Revert "serial: 8250: drop lockdep annotation from serial8250_clear_IER()"
Date: Wed, 22 Jul 2026 13:15:19 +0206
Message-ID: <20260722110925.74387-3-john.ogness@linutronix.de>
In-Reply-To: <20260722110925.74387-1-john.ogness@linutronix.de>
References: <20260722110925.74387-1-john.ogness@linutronix.de>
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
---
 drivers/tty/serial/8250/8250_port.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 7726cca00d364..dfbdaf1fcc79c 100644
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

