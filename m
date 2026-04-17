Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911B3B4EA5;
	Fri, 17 Apr 2026 10:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421478; cv=none; b=LYmJn5euu7uFpJokI9OKLbBn8g9mriui34363Uf2VrKGWIakjQhtc9uLfvMKYo+V5wSg9onIfvJXT83vrLNQwVbR02r+HYZztiq5DVoMQpkxNrS07aMb6kO+OufnS/mR3/R+LOwHkdk1Step4Zu6T4TkSW6YdOY0DXqRP14OeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421478; c=relaxed/simple;
	bh=ZX5GXVmVzRtuIIlqSB17DJ71jWWOjYQmqPSXs+OjCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpEnrqATj/E20PNghogjsNl0pZSMlngTkiDdI8+V+bUMwbeMWurbjK2bpYCujHENke9mYuNIb6LssXYF/rvJnmTVYrFfRIEYEl9bo3R6GJ1RPQgXoqiAyCwbqz1q1Cqso4JRZ05+SiCpOPFUeaTfc3VVe1SipaiZXot5aVH8C08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtaHV79c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UWC10xuQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtaHV79c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UWC10xuQ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776421465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vaT9CcLP8jwFrjEqEJkhzbb3urNIEyX/8R45U6Cak4=;
	b=rtaHV79cjuxc1myWNuNCEPUNZ+Er1g8pEGqC7tfiMlzISom4fuYGkkJuHudtPTpCJvxUCF
	3x4acLXvCrIkcQY2g9BC1fGkPpBNuxP1O7ZLfa9WtohwzlrcMETAsh+UzUG0bEX8t4GMHb
	cbHmOL7+UI/QNx0NVcDBP+za78KRAJJ83VjjW4xDD7AO4TjMhJDumbbMMAEEoH4R8iyMY5
	zS9mBDjb3+dpBPDhEXg6mUG8HK4aJRZW7Ai9YV37J4x/ngDrjSxGa3kGfaeOLp6D380by4
	65QDcsq9MLtzHPZkaRWS/7D0y/H2BDatI+GCJNYYcQgU+SySd0jHZSF909PYug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776421465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vaT9CcLP8jwFrjEqEJkhzbb3urNIEyX/8R45U6Cak4=;
	b=UWC10xuQviFzpTIEaJmWDGkqWYy4iZX18hD7/c9752LGoH8ixXDz3ybRp8NeseJ0iaL6Ta
	1uabZkTzN5Dp9TAg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Ingo Molnar <mingo@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v3 4/6] serial: 8250: Set cons_flow on port registration
Date: Fri, 17 Apr 2026 12:30:17 +0206
Message-ID: <20260417102423.40984-5-john.ogness@linutronix.de>
In-Reply-To: <20260417102423.40984-1-john.ogness@linutronix.de>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
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
index a428e88938eb7..32b894ab26768 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -746,6 +746,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	uart->lsr_save_mask	= up->lsr_save_mask;
 	uart->dma		= up->dma;
 
+	uart_set_cons_flow(&uart->port, uart_get_cons_flow(&up->port));
+
 	/* Take tx_loadsz from fifosize if it wasn't set separately */
 	if (uart->port.fifosize && !uart->tx_loadsz)
 		uart->tx_loadsz = uart->port.fifosize;
-- 
2.47.3

