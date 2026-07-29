Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB7446BE2;
	Wed, 29 Jul 2026 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785326684; cv=none; b=cgUsylgqjWoDiD8qrXmoCJI42lMFp/bwPy+r7VC9NlRsDu01T2T/DWJN+9q1hyP9i7XMCfSfczZObyeT8k9nKdrHgxc/Lp/zTqOad89qFMo4mwXLZ1SambangqEbdZEf6uUAo8mcx6xsZ9nyRBl3lARBY4Xv/zcByrn6zpptthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785326684; c=relaxed/simple;
	bh=5DpodCD7UbvkAvLWBGKD7rDpFaoEH5gU9nhGKOsmfyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNw2Fr7l+52b4NKCoLyKeW3kBOK/0sMq24vF0ZliNRRPHYualJa/B5fA1uIDRRYHKt3O59lbjEokhZpwmEg77OAyTlqqNjzUjGRBUJ0tbOWbbq0/SqBSs8+5DfvLqK0RlcaBs9pcUpu1lIej/UyE4PP1I/yjqecEW5dUwGHG4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ETgFu22; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/yU7vlo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ETgFu22";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/yU7vlo"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785326681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/a2DTcIsSriqOA8ZHehGBFU8QSR6UxQrQ4Np2bZ+uA=;
	b=3ETgFu22D+1Yi+IpfEytx6NrzvWjbO5k8D8eWecSPoIsilGbgDfzD4wGzD0cJXV3J4l0fh
	64dtXkKVx681q9S1eNfgVMrr0by7j+QbpqnO0D8DaDbZJYH0resRcZfJPGOYfW3NmZYYga
	2Y1RkyfjYFGYDNoZwnvofe/tKuaMe9TH/8RQt3HU+uHQOi90LldIdZ5qNQW++AJdIQ9v+4
	nN53o4d0fAsQolTCAbZm0pVzitlQq7lpzqjy9bKn+jUnokCJzVEAW8pMc8so4OUytW48Ji
	lEqKx5WlHh4mrmgeX/WMkkRjGeHFZ3lqdMovf52KpsqDacN4ZyfUiOubBO/J6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785326681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/a2DTcIsSriqOA8ZHehGBFU8QSR6UxQrQ4Np2bZ+uA=;
	b=T/yU7vloKvKWJR5DY7kHcgsemFWJfm7APgf1epEaoPBXUnl81VW07qYyt8HnBuMJz3r30R
	eZ1YJBZqo+WmdKDQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty v11 2/2] Revert "serial: 8250: drop lockdep annotation from serial8250_clear_IER()"
Date: Wed, 29 Jul 2026 14:10:34 +0206
Message-ID: <20260729120439.281252-3-john.ogness@linutronix.de>
In-Reply-To: <20260729120439.281252-1-john.ogness@linutronix.de>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
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
index b9ea4f898474e..6c10bff109701 100644
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

