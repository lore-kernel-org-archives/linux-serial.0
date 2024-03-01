Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE358AC0
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329979; cv=none; b=ZGBs8gZezvIkqAIiT99jr4bKzHHlGiALcDCtr2IuXijg+LrNHJGUTzYXV8emf4Qf42AX2HdiYwfst5T/q2PVM3+6TCUQsjAnN5rJobn3PyLzMchblQuEO024dvwTvcSG6YFfJP94kU112sApdvpp0ZUUyL1E0WGg5hCB8zMDpNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329979; c=relaxed/simple;
	bh=6S3rT8ew5SW4ooRI3s2dS7P0BAIVcBK43n3pP2nVPVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g48jAJaJsnzPArWQ7cK+S/L8D/s5pvbz15774C+jYgzWVJHqNafwDltFA1EsB9WBOnUxjvhbFF8hjOpjFSyQJjrBp+uKgGLi0UahhjrmKjwCCL3e8nS7FNJ9iagMTQkg1JqBWfo0dActq6KOLzPo/cKvdNgSkErEdod7PemDDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K+FjPxZ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXpUL8nw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K+FjPxZ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXpUL8nw"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0g8itF+ExlpYzEJYeSCnD2J1K8E/AB5H3Ar0pbseLU=;
	b=K+FjPxZ8Rtk1jizL2MM1FuvCxEyiWV/8Nk3pn1RjQVbRtxAMzIohciVlPyJJIAJ1eN7Rbe
	Erb3AfTpPr9TPQEPzme6rOHfsKKOo/+W2raT2XzQNkJKbBULMdZTQhRVXIYh8/PGNKJ/Gq
	F1fw6X2ZzF2p53XjvEw2ovUJhmrrlneVXkBrweJXx8z3ZDGLmPjEfe2/DnAkwes5gengrb
	zvTZbqSUOaq6ACvbaxT6D+TmMazs0A7zkDogpYmI6pelKBKY93ALQFsXjctAsS0NA9SasO
	W9OH7miXOIk1zayA+ZZujrhEEhQs64xnQBvDPyj0oTeeUa0SzES8tmFgqcdZ0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K0g8itF+ExlpYzEJYeSCnD2J1K8E/AB5H3Ar0pbseLU=;
	b=kXpUL8nw3U+vuu4eRO/NLXoNlmdO4pUAyCDjw2UKJtx1k4VgfR7W8d2rz5pKISrZeB8pOx
	IxSSoLbJbbq6rzAQ==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 16/18] serial: pch: Don't initialize uart_port's spin_lock.
Date: Fri,  1 Mar 2024 22:45:29 +0100
Message-ID: <20240301215246.891055-17-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no need to directly initialize the spinlock_t in struct
uart_port. The structure is later passed to uart_add_one_port() which
initialize the complete struct including the lock member.

Remove spin_lock_init() on uart_port's internal lock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/pch_uart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6e259f4139153..3911703918764 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1725,8 +1725,6 @@ static struct eg20t_port *pch_uart_init_port(struct p=
ci_dev *pdev,
 		 KBUILD_MODNAME ":" PCH_UART_DRIVER_DEVICE "%d",
 		 priv->port.line);
=20
-	spin_lock_init(&priv->port.lock);
-
 	pci_set_drvdata(pdev, priv);
 	priv->trigger_level =3D 1;
 	priv->fcr =3D 0;
--=20
2.43.0

