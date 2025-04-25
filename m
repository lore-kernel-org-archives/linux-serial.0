Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE723DEB6;
	Fri, 25 Apr 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579606; cv=none; b=ON95vbYj0mVpP721gcCk7diup4TxYWhEUC4IVM7BdIek8fxxUtaKZiMpttaJkyISyDUB296ZAgs7CBCBjdfFgLrEyNheVnFfeIDZ+kc4BXTiNHnMVPkUue0jlmkWdUUzVgx5H+o4kQHpCipvzsAT1zdWVomEF9bJ4FG/+Ye4ZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579606; c=relaxed/simple;
	bh=RZuTYAp+J9porolOraxUHRSEcCgxu0uikSg3bbj46JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KykBn7ONzZSonw43TQ/iFyDofiZWG4EJPmB8QCMWZC7d50BwlOozpw2sMoc9AL7DUYgrQkdSNzmRkMUfZSN9skKgBV3EEJG9Ohy9u8tx+jeX4efvu2s33b9pMpHJs8yW7xyfue0CvzZ7t9yL6qdRx7w6edyBHIMZdHEH6d+97Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfyezEZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfyezEZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8C6C4CEEC;
	Fri, 25 Apr 2025 11:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579606;
	bh=RZuTYAp+J9porolOraxUHRSEcCgxu0uikSg3bbj46JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfyezEZEFWNzXJsKPa+kOVL3vke2LJUdz7kerX9AeX/hfajo6MRtRwCafeMgtyg4e
	 kQy1L18mN5EFqh4kql7uF+umyW4buXYgqM4p50lFQjlT02KOC1YwazS9nKVAAiQqqn
	 WpSikoT/fIzCtD4g6hepGaku5/7vfURqpjXYk/gTtVVfecy1Zj7rv5SoU106Xk6mia
	 4tlnKUOdXdZ2lbA4PJtuFxat3Vi6F50YaNe4EnaupWnAMtypvoxzA/csG098XLxUt/
	 cHMqlFjiW7sXXG3HmW4imBltPe08jNkeQnwUErc4DGEY1ZMY5lRtdoZ3q/9/Zp01Hk
	 maVpZtIVkFTZQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 5/6] serial: use uart_port_ref_lock() helper
Date: Fri, 25 Apr 2025 13:13:14 +0200
Message-ID: <20250425111315.1036184-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425111315.1036184-1-jirislaby@kernel.org>
References: <20250425111315.1036184-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uart_get_icount() and uart_carrier_raised() open code
uart_port_ref_lock(). Use the helper instead.

The difference is we use _irqsave() variants of a spinlock now. But
that's "safer" than _irq().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 52e764be42c4..1f7708a91fc6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1276,14 +1276,13 @@ static int uart_get_icount(struct tty_struct *tty,
 	struct uart_state *state = tty->driver_data;
 	struct uart_icount cnow;
 	struct uart_port *uport;
+	unsigned long flags;
 
-	uport = uart_port_ref(state);
+	uport = uart_port_ref_lock(state, &flags);
 	if (!uport)
 		return -EIO;
-	uart_port_lock_irq(uport);
 	memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
-	uart_port_unlock_irq(uport);
-	uart_port_deref(uport);
+	uart_port_unlock_deref(uport, flags);
 
 	icount->cts         = cnow.cts;
 	icount->dsr         = cnow.dsr;
@@ -1915,9 +1914,10 @@ static bool uart_carrier_raised(struct tty_port *port)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
+	unsigned long flags;
 	int mctrl;
 
-	uport = uart_port_ref(state);
+	uport = uart_port_ref_lock(state, &flags);
 	/*
 	 * Should never observe uport == NULL since checks for hangup should
 	 * abort the tty_port_block_til_ready() loop before checking for carrier
@@ -1926,11 +1926,9 @@ static bool uart_carrier_raised(struct tty_port *port)
 	 */
 	if (WARN_ON(!uport))
 		return true;
-	uart_port_lock_irq(uport);
 	uart_enable_ms(uport);
 	mctrl = uport->ops->get_mctrl(uport);
-	uart_port_unlock_irq(uport);
-	uart_port_deref(uport);
+	uart_port_unlock_deref(uport, flags);
 
 	return mctrl & TIOCM_CAR;
 }
-- 
2.49.0

