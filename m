Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BB1C686;
	Mon, 27 May 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716791905; cv=none; b=cAfby1CcgxzP3nD4E/B9yqrNSMuQjSPgfxQFhkPYM7hyEIK+vUzaUmOe2sm5lOivfKgfjtsHlr+gWPbhoktctuG2CKLu540dNLbBoh8Nb9DDdXuBhy0MJq24qKf0ORI90kz9t8znh4Btw82VH7G9h6HgTnkeN7um9i1iVPHFu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716791905; c=relaxed/simple;
	bh=AiH8EnN6GRzi8B2qcObkU/HEqg04wntd+nSfmS7tVhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lf2IHOinTeNJW7o3QSgHm1xLWAoSZhia96Nl4NQTui93IwRvAVvtFA59e4SHOkf2Uy9syHwB2n2DE2HJRnLj8Vd1LyPKxx6Al/ihTgVQrBzdtSrg5t5QVNobdsIXDZRTRWhNUH7j+AXZ6STEcOzE4o4OLujqm8zkhBq62FON3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWfm1v/S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mtJG7MYi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWfm1v/S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mtJG7MYi"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716791899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkEmSH+TeCzW4mgc3Qx6oM4UTLT7owCiQ5MwVZZnUf0=;
	b=MWfm1v/SDq5UBs2uYn8xLpTUBfAUg6ebL8WM55kFJWkV7h2WuzJwfQ6sgmqQnn8fSy1SPK
	Rm7aGRiSkufQn6TiKr9IzTkSdChmnAFZECXuFb9Dnda+stuzrxGw7JI8pJ84zHxDe6jH5C
	fM1UShVvGDBI23d3RFshfkf1e936Rx7Lkr9L0C7YdhIcZVZZtOEXo30FYEWgpmBEkd5t0V
	EVSrWhW9rExqdc5qVmVgY0uEEZskuGTukTSO29YUpeMq3DEU21ItQS8BUROysuEKJ6uqev
	ddCH6o5QW0AaOPvxoF1xsZPg3uJ/sUKqacDDo8UCnEy6VfqPZ01zlMpOS0fgjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716791899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkEmSH+TeCzW4mgc3Qx6oM4UTLT7owCiQ5MwVZZnUf0=;
	b=mtJG7MYiy42HnHVpBuzvx+qMo0svogSYJ75Tg/hZgZsaUKanxZKF0fBDT0V/WWRBhJ6b8M
	GjR5PN9ws9T84yCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v6 08/30] serial: core: Provide low-level functions to lock port
Date: Mon, 27 May 2024 08:43:27 +0206
Message-Id: <20240527063749.391035-9-john.ogness@linutronix.de>
In-Reply-To: <20240527063749.391035-1-john.ogness@linutronix.de>
References: <20240527063749.391035-1-john.ogness@linutronix.de>
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
index 55b1f3ba48ac..bb3324d49453 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -588,6 +588,24 @@ struct uart_port {
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

