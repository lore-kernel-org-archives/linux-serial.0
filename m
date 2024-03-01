Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3585916C
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329979; cv=none; b=ZB5D7rwyXuKoCNEYGBHZD+uxef8kMBLZDYXB1Qwvy3z0T3Ktvy0ssVJawvYGUA+DIIa6pzv3Vmp+xVWRf3mFxSisammKDk0aHdvIqAcqm/hmLsUTPfnTeRaK4si2TC8NcfMViDW784IkwHjtT7PzV6K9R2vyNL979q2N61ky408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329979; c=relaxed/simple;
	bh=/03FG9FF13NAdHycAZCWAZFqqx2USc4J/DxFaLppJ5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOWeP3KIDYpEdPccLCYInpgtk9kdHDKKaqBKnI2QMQvQeqs0DFt7si9pJsrmeD7mtxF/kFENnluHCB6VL1BQp51KWDw38jGGHy3gmB736zrsJR4NjDrR4X/i7A6wTsKc0IQs3Z0JgwOsQpN6d3DfucaH2TwNRKrnQ+xOxthTGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLCULnuv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HZZ0rg7T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLCULnuv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HZZ0rg7T"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lXM/uFYefXXbiK1CgREiM4AYl7rnjz2Bx/xobHfCzg=;
	b=XLCULnuvVEZwwEC7AqxENYf+76zxma9AZAK3fSdcy0haYMwvlCe1o+XCcAqtMVEErF3C2W
	o7lcXOdbzTtkOjwcAPYqywHG7vL7oTA6O5lp9kABLiZiGrlztuA0RAPSfygyqqmkt+EuHc
	242I3OFDt1k32V9f8ZPMPq3vue+93UWrzekwLKf1kywNY+4a8+Jm1oBWPjrgrOFssiUiJ4
	OBPDALVe3wHwHzBz4wTEgalpQqKuV4hjHOWpW4dHEXB2q0m0kn1Jk+G0Ptb7LAcnp1wDIZ
	droRykQnmPaHHWoNkBGUqBAqMseVTZyfhCmZ284lIHuGexKvJNYpJIjRKfZHOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8lXM/uFYefXXbiK1CgREiM4AYl7rnjz2Bx/xobHfCzg=;
	b=HZZ0rg7TpVyhq8LlAAOu/CBuIf00NhCzbXrH+CBdAjxZxFMsAnmkA1OKKEXDMCXss+ZebH
	ZXOP/cIOQtF5uSAQ==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 15/18] serial: pch: Don't disable interrupts while acquiring lock in ISR.
Date: Fri,  1 Mar 2024 22:45:28 +0100
Message-ID: <20240301215246.891055-16-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The interrupt service routine is always invoked with disabled
interrupts.

Remove the _irqsave() from the locking functions in the interrupts
service routine/ pch_uart_interrupt().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/pch_uart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 124eb816fca7e..6e259f4139153 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1010,11 +1010,10 @@ static irqreturn_t pch_uart_interrupt(int irq, void=
 *dev_id)
 	u8 lsr;
 	int ret =3D 0;
 	unsigned char iid;
-	unsigned long flags;
 	int next =3D 1;
 	u8 msr;
=20
-	spin_lock_irqsave(&priv->lock, flags);
+	spin_lock(&priv->lock);
 	handled =3D 0;
 	while (next) {
 		iid =3D pch_uart_hal_get_iid(priv);
@@ -1074,7 +1073,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *=
dev_id)
 		handled |=3D (unsigned int)ret;
 	}
=20
-	spin_unlock_irqrestore(&priv->lock, flags);
+	spin_unlock(&priv->lock);
 	return IRQ_RETVAL(handled);
 }
=20
--=20
2.43.0

