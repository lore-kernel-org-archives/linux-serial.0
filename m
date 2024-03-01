Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575159144
	for <linux-serial@vger.kernel.org>; Fri,  1 Mar 2024 21:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329977; cv=none; b=KtMsmrhmygmBq7WKKgLFim1oQUpo9xHBwWqLYGpHvTBaioUOI51kdqPK4OCUqV1miUgpvcV0hbngtoNen5pzfEpbGAKhTOBbWbUaMArJOBKZ/GEKgs4wBivg2EHOOiovAGamCPzjLntfL8x8C8+BPJ5/i3FMJFmApXd9Hjn/3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329977; c=relaxed/simple;
	bh=P+hCeeWTiwQ956ZhzC5IWqeVkfRNJPOR3rmG6/WGOPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRv0Z5I6AWRPecwuZa0WvCZq7mWVHiyw7tq/UXRr1e0EnfmyeDCnGyd3DBrXdeb4G8WPuylRP5SBtC5hmzl4o6o8J4le0pK7ArxvSw2xFfAwKDjtVLwmcvtrnLKuba3l9JZmdUxpB4g8RR8qizEb5cywtYYzIuuqtlJ3B9uIZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0/QBNf4I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ebzA5Hmm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0/QBNf4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ebzA5Hmm"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7R39kvA5nWx/SHLkwt/oBPRXP7RjZNc6ixojjlPi0s=;
	b=0/QBNf4IgMRfw2pMIvLY/+ufqDgbJ+mJ0y7/Y1Fj1j9vPByFNLCcRss+KyMSASwuMvMVEV
	gxNzsvj09422np2aQm9l8Flk2xyq0w2IfLb5VVMtFk1gxOVy94DPUEHST5Oe0NI5H+hYc0
	238QlnwCHRy/x/BST3gCKMnKu74tYZ4NJiAAd02w6v5to1plt38nhtkECyt71U4VvMDqzk
	1i95o816KeNqBQ8ZMd6Yxkf3HW8ji/Y1C46QaHkBDa1Kg0U40/owVsWjaBPq+hgBntJh2d
	02SKurrcCnbvCyG7b2IBuu1HZfDcFOSwLNdgXcRWFpWskf+r5wn4pk4+mzzzzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709329973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7R39kvA5nWx/SHLkwt/oBPRXP7RjZNc6ixojjlPi0s=;
	b=ebzA5Hmm7uP1CoOmJvVGUtbjuTQGElZMrsxO9J/5ipZpXhiW0gRj8/p1wyP2CheMBUqMF6
	QnWiUexhhbnpMxBg==
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 13/18] serial: pch: Invoke handle_rx_to() directly.
Date: Fri,  1 Mar 2024 22:45:26 +0100
Message-ID: <20240301215246.891055-14-bigeasy@linutronix.de>
In-Reply-To: <20240301215246.891055-1-bigeasy@linutronix.de>
References: <20240301215246.891055-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

handle_rx() is only a wrapper around handle_rx_to() without any
additional functionality.

Invoke handle_rx_to() directly and remove handle_rx().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/pch_uart.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 436cc6d52a11b..29ed6f8621d7d 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -778,11 +778,6 @@ static int handle_rx_to(struct eg20t_port *priv)
 	return PCH_UART_HANDLED_RX_INT;
 }
=20
-static int handle_rx(struct eg20t_port *priv)
-{
-	return handle_rx_to(priv);
-}
-
 static int dma_handle_rx(struct eg20t_port *priv)
 {
 	struct uart_port *port =3D &priv->port;
@@ -1051,7 +1046,7 @@ static irqreturn_t pch_uart_interrupt(int irq, void *=
dev_id)
 						PCH_UART_HAL_RX_INT |
 						PCH_UART_HAL_RX_ERR_INT);
 			} else {
-				ret =3D handle_rx(priv);
+				ret =3D handle_rx_to(priv);
 			}
 			break;
 		case PCH_UART_IID_RDR_TO:	/* Received Data Ready
--=20
2.43.0

