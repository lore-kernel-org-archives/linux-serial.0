Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC71DF682;
	Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135410; cv=none; b=r/KW3MBfExDRgyoWQOBNHXiUphGkPa25wSHzWWIv/1Lke0cYPJEHEPnl0hRKYoNKpkd4kPe0NtLvoCcqzxFFUgVMo593CqVYex3J7T1k75TVpNRnqBNhzsUkrrtyFt9x5gfZy+IBgUyUEcGovViduJD53AkYQvazcxaPGrpCnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135410; c=relaxed/simple;
	bh=i7g9Rk6E1rRqftOtHZzjKlxcVFM+YP6E/P/94xSlZdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IW/eYXwt++krARhTPiI6Lefm1S1Y7QCmfocSmGDbhqitsz9oRFeXM23Ts6/w/amHxBm+Sw5EgFLqM983CYjAZnIrgOtnszyX+IsPQzA5t/999n2AYnVhp/mi44CdA4j7gp/o7EO4ghQ0AGHAGujUMllokcTRaFFxV/FDF4Yf+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O5BQalka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDHwQPqG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O5BQalka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDHwQPqG"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwPBydyTGTYXegM2JVbnpVHJON//wTjw/xvV7q8bAP0=;
	b=O5BQalkalK7zZPgt3fErkgDV4eC6/ml5srqxQHZrbpScL9I55IJ/DlgwZrEqgya0lk8jih
	0Esi66Qud+99remrqw0jOD3/7uN7cZ/SCyP1Zz7xdVl41RLWfEpdrm9IcxRLnruSPePuEC
	3AbLceTYJcuE/MTcS6AOeD616RL+CrBONF5qtoWWdiVGBxAMVnWifqU+ZH6F5UzCky3CNL
	IijmHUy4SxPc+8quLpjXUv42U7fmKX20f5gTImDC3wGMVEfI6JOgDCOZSE/W6IbL8HWLHx
	l8gk2C5TJ+/8qPPVp1Tqc7j9SgYyAxoWmWCpn+hS8SpEciflXwV/sifBPBI4BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwPBydyTGTYXegM2JVbnpVHJON//wTjw/xvV7q8bAP0=;
	b=LDHwQPqGQdH/HPXU+CGwA0xY62VS8vK5IOR4eWPCDuSRgV4kEFZfry7+gzuEtDhA0gIgp8
	Pcy0uwTsfb3nLrBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v8 10/35] serial: core: Provide low-level functions to lock port
Date: Tue, 20 Aug 2024 08:35:36 +0206
Message-Id: <20240820063001.36405-11-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
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

