Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7051F76C5;
	Tue,  7 Jan 2025 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285230; cv=none; b=OoSoD5drtG+o1YzMlHcia5UZKa2RejWwqxwUh3424jqFNFs48FbVUhpJHTldyttJ8QM1Z6+jTEcw70bLYBX9ke2FFaqHI2YBHbFVaPhqtVFNIE3QycEQzWrMiwpgl69FtKZ1W5/9E6kdYJK91xQmVRvhuKRdOzCEkNaeVx2Sluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285230; c=relaxed/simple;
	bh=OgQFgFI8mqle482HvlsTcIXoK8iw7KjJLocnV26f9e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0KqlpVSTNHSlGjYNx/wxh2fCcM+AVLHygqxqiiRS1B2i5jYE1wHSYQmu3W8J/SuhCuugysy7mzoWqMWrKJc5++GDAs+P8t4VtrtZL4Re/vqLkp9wrk0Ojk1WyY5R6ScVUxBnS7Pfkl4MOg6ofvdEDuxt/bLvu6gQNQTCPgpyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eXsgkppJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NS9Uh985; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eXsgkppJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NS9Uh985"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736285227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ei4zvvvTXWkQeATDXNtrrdLz3tj4qXsyOa/UJODf288=;
	b=eXsgkppJp2LcAij0VSNgD6ghZjadUtNGBbRq6BQnNhNhsNTjhTKIFEN6t28gQMFWvM8YxE
	LYs2gv9uxiJTQWw014JTnD9pr+wjr3z1R9mopXqZrmkDHeqXpl/noL9xdT7RLtzxQqvjZY
	CCvwN4lKWFaOZgsIx8Ne5Chu6D0oQv/aYPTlTtlu+gjSSYOx+2rnxOsnRzl5n0eB/m7O0j
	COdmF0fXeLbaLEo2/2jpWLoISA208E8XtQfOYVqm/FLPMO+WRoScL+JwBNj25TBg50aNFc
	PqHb/Q7jmkxhaQx4mnmPLbNla0Zb0zLmPD4SSae6tAjfi1o1p+IAbrGIixapdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736285227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ei4zvvvTXWkQeATDXNtrrdLz3tj4qXsyOa/UJODf288=;
	b=NS9Uh985Qv0KMqAObhGkeakKJVbSlcBnMKGGX4JNffnwX+ez9AosHeVPocIEdRKhgKO/sA
	jWqqegem7/Oj5VCw==
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
Subject: [PATCH tty-next v5 6/6] serial: 8250: Revert "drop lockdep annotation from serial8250_clear_IER()"
Date: Tue,  7 Jan 2025 22:33:02 +0106
Message-Id: <20250107212702.169493-7-john.ogness@linutronix.de>
In-Reply-To: <20250107212702.169493-1-john.ogness@linutronix.de>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
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
index 08466cf10d73..76a8d74f16e8 100644
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

