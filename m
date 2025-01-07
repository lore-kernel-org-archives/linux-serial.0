Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66F21DF98E;
	Tue,  7 Jan 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285228; cv=none; b=G9ZBD7ZWPaAorLXsfsy9/PcdWR5r9UqAM7f+jFQ+pn+ZuOO56wHnYhN4W2sCGuU2lOwcVOnN3WVAJSLlcSXaA+E2iWc2dPog6GW7EWypbFSFQZKOgMU4a2g/zhgvFaLIwLqnWslFPu8eHnar7Bn3BqIfS+qbq+URUX83Mu/Qs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285228; c=relaxed/simple;
	bh=k0Q7/kE8NFWHNVqwkfK4VuiF6b9NdEUM/yuU8tMN0yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OO4Na30ElYTNhFDmnYTjUqGijCp8t8Jb73YY93zEnhO7h46q7EPMb+4pwM9qoDxo0FBELNrCpQUrPfCzdvE1bv7Lc/3ATIUOEcyM254KW+FjLlc/Z3h+Q+DaGAMYLnS63+UZIgV5DCVADqNSjn8VrzGl7cGdYg5KnsbTFhJyHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eaNzQpF3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/eM0g+St; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaNzQpF3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/eM0g+St"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736285224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXHBlOmJeQ1OCbuaqy6OasohF0dAyiGphfIWtBEz/jg=;
	b=eaNzQpF3ErnHuhPJAByo3tJ/09h3jVwbeA3AwZc+XsXjDMHE+tBIJEHanENV6QK4tIspRr
	p6sN85i/nUNM/g5NoSjyk6nG5C4kDUaKE0B7EHaT0tR4eiWdbfX8xWnUawcUeMKPqK9G2s
	oaholfX3VRU+xazEyuXwHUIv3OKZaPd9yiOGI1NWw5J9VVSYsfajbHdK3AxXoppUxF/ZdV
	xqMVaXDbRBu4OsQNMBeFDrBW5QR3iic4qreezQ4TUNUQc3DHbqRfSoGm4mE1VkIFG0vP+1
	d3mflhqWSMXQ3GXyqvWS3FkkS+XPGLAfK+emqxgB1fnnMTTUSgJTH1h+RnBU0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736285224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXHBlOmJeQ1OCbuaqy6OasohF0dAyiGphfIWtBEz/jg=;
	b=/eM0g+St07im1wc9YBFQM9f6hZ13n3lzXXoo9XcW70A02MxanVC9fZXAcMHkf2t7iop0WJ
	2bwlOsr7ia6TgFBg==
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
Subject: [PATCH tty-next v5 2/6] serial: 8250: Use frame time to determine timeout
Date: Tue,  7 Jan 2025 22:32:58 +0106
Message-Id: <20250107212702.169493-3-john.ogness@linutronix.de>
In-Reply-To: <20250107212702.169493-1-john.ogness@linutronix.de>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using a hard-coded per-character Tx-timeout of 10ms,
use the frame time to determine a timeout value. The value is
doubled to ensure that a timeout is only hit during unexpected
circumstances.

Since the frame time may not be available during early printing,
the previous 10ms value is kept as a fallback.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_port.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 3a946ebe9139..ca8f6f3855eb 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2081,9 +2081,17 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 /* Returns true if @bits were set, false on timeout */
 static bool wait_for_lsr(struct uart_8250_port *up, int bits)
 {
-	unsigned int status, tmout = 10000;
+	unsigned int status, tmout;
+
+	/*
+	 * Wait for a character to be sent. Fallback to a safe default
+	 * timeout value if @frame_time is not available.
+	 */
+	if (up->port.frame_time)
+		tmout = up->port.frame_time * 2 / NSEC_PER_USEC;
+	else
+		tmout = 10000;
 
-	/* Wait up to 10ms for the character(s) to be sent. */
 	for (;;) {
 		status = serial_lsr_in(up);
 
-- 
2.39.5

