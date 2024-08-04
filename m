Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC192B673;
	Sun,  4 Aug 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722732713; cv=none; b=iKQ8dL6Ogh064QE3/Vjv47pqCYLVBX9/C9lwqIaPc7+acxq6EoswOOx0Lqau1IfkT5fLkzx+2eKLz7x+p6Mk+n3NLUnJnYel2L6izceYLpYN7E50WmGlxv7J0avkEht98sy8ADvmlApdhGuPgkKfkP80XNWNWpEztUxrV/8v2Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722732713; c=relaxed/simple;
	bh=i7g9Rk6E1rRqftOtHZzjKlxcVFM+YP6E/P/94xSlZdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFnmpDorX0pqKr7CKin1CWm8K4XawszJ6WKifxaWv8C/O/2yoL3r7MCRZznioCLIz2pHj5nZ/uAdX4P8lbbCI+mga1W/mJptqkz8fkBrNkaL2v3EMx2EqHvWyQT6Xom50TF0k7nPzUJIKTesRvF3d3qujv60HWrmKTOwXEWkABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFutFd+n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBE5EMqj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFutFd+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBE5EMqj"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722732704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwPBydyTGTYXegM2JVbnpVHJON//wTjw/xvV7q8bAP0=;
	b=iFutFd+nbFnB13SQ9hIqx4evQV3KuPsbFZrZfQj0rSBNxSr0adh4NRrPSHbTRuLjNRBU4n
	bGa0pU2JCzxzlMMqqHOvtdshDf05EzUgG+8t1Sd0gMI/m9TI5eyILXqQIjiHgFy6Dh/G2/
	dEFqu2+gtSSQxi6kyjVz8512VzhdHyjX6IkYS/VeZtOumHWGoqS0fOL+1QHw+iKj0DwSbz
	t2Jpv+bslMfpOVzT9fgHSnOfgdPiDP48M/iI1a+lXU4adfTEQom6gncWaFGeBDbbMCf9ND
	i0jbbY1IEcUmvJv2eSGKQY888apUuKoBSbhx/UNlp0fmxINM8JZoipcQ6ADFLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722732704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwPBydyTGTYXegM2JVbnpVHJON//wTjw/xvV7q8bAP0=;
	b=SBE5EMqjeqcj2iTPMMaONIt+erFukqHHiehMt+23DxJToxZWAiKjamvhCzEEAw8tRiPo63
	KdVZe0XST2lXL5Bg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v7 10/35] serial: core: Provide low-level functions to lock port
Date: Sun,  4 Aug 2024 02:57:13 +0206
Message-Id: <20240804005138.3722656-11-john.ogness@linutronix.de>
In-Reply-To: <20240804005138.3722656-1-john.ogness@linutronix.de>
References: <20240804005138.3722656-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It will be necessary at times for the uart nbcon console
drivers to acquire the port lock directly (without the
additional nbcon functionality of the port lock wrappers).
These are special cases such as the implementation of the
device_lock()/device_unlock() callbacks or for internal
port lock wrapper synchronization.

Provide low-level variants __uart_port_lock_irqsave() and
__uart_port_unlock_irqrestore() for this purpose.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/serial_core.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index aea25eef9a1a..8872cd21e70a 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -590,6 +590,24 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/*
+ * Only for console->device_lock()/_unlock() callbacks and internal
+ * port lock wrapper synchronization.
+ */
+static inline void __uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
 /**
  * uart_port_lock - Lock the UART port
  * @up:		Pointer to UART port structure
-- 
2.39.2

