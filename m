Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4013C3C2;
	Fri, 27 Dec 2024 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339533; cv=none; b=IGXL1Y6g5QmK4oyVHH4qnvtsWSLLMnhrOxv3+qoTfLffo+/q8vMkwhx9n/t/xj+ub60xwtXorESnQfyE5Z2JL6CL7HT0/DLfIc4d0Fnub9+aBxdiE0JeZC2F5yh5st/ImGDrXS9sjO3iwJD9FHIi9N5Bgf/UUbgJllg9RHgM9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339533; c=relaxed/simple;
	bh=GSp3+UV8mlQfwSg8gpPLRwW4W9kFUA1xgRSYLnnjc3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ro5LcHalmqk8sPgYdW+zClUbX5h93ka0yC2nyrYGmq8fekDMfuoEWdBZ+7TERVR5cj+/g9YrANl002ururQeuGsvkqXIKPc11SlLKPv8eW2Uu81NbOmdTyLRfpXfYr8XIRM5FX74vICXXIf0n+R0KR20N32kSgIl80zTScF1pPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J3X4p1b4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avZndI4u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J3X4p1b4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avZndI4u"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735339525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3TkS8QLC2Kih29liLm4IkXScgF/yFQYpNLByhMWPz0=;
	b=J3X4p1b4QSUC+oqLKwC+sL5AL3KxKRwkIqnOjf31w/UB/1hbSKD7AAa/1FdNv6srXpI6eG
	kO9Nk2VYjxIgJ9l/h7OZhPCNQUxE9FRFE8pUag6yAEGy2lmT1831wo7W0xToV1IL1ihfBz
	B03XxsUe1g6y0QTB2j73fyNNGwkB6BtB4ALEUlohVDuEvP8udsvSVAeq2ZV9nhf4+GhGsR
	6tqy+I4EWhMgjdDAiOr9pGb1hJQDyjkOO4naXp4Oh5mHx4FogzR6faV/m1fizmGgSooVxP
	JNcmXC8PX4gTeabxPU0S6+YZIolYbF2h1rbZ79V84wdz7xQ243layelaxK38xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735339525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3TkS8QLC2Kih29liLm4IkXScgF/yFQYpNLByhMWPz0=;
	b=avZndI4uHRpAEAv8Aa6K0aAPF5EZesSdgUj5DzE70jGCDMVCI5Sgu90ZN798Q3nUdC2Kk9
	PAM25iGBFEuoSqAA==
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
	Rengarajan S <rengarajan.s@microchip.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH tty-next v4 2/6] serial: 8250: Use frame rate to determine timeout
Date: Fri, 27 Dec 2024 23:51:18 +0106
Message-Id: <20241227224523.28131-3-john.ogness@linutronix.de>
In-Reply-To: <20241227224523.28131-1-john.ogness@linutronix.de>
References: <20241227224523.28131-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using a hard-coded per-character Tx-timeout of 10ms,
use the frame rate to determine a timeout value. The value is
doubled to ensure that a timeout is only hit during unexpected
circumstances.

Since the frame rate may not be available during early printing,
the previous 10ms value is kept as a fallback.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3a946ebe9139..aeacf9d452e4 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2083,7 +2083,14 @@ static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 {
 	unsigned int status, tmout = 10000;
 
-	/* Wait up to 10ms for the character(s) to be sent. */
+	/*
+	 * Wait for a character to be sent. Fallback to a safe default
+	 * timeout value if @frame_time is not available.
+	 */
+
+	if (up->port.frame_time)
+		tmout = up->port.frame_time * 2 / NSEC_PER_USEC;
+
 	for (;;) {
 		status = serial_lsr_in(up);
 
-- 
2.39.5

