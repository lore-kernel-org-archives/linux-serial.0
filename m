Received: from twinsen.zall.org (twinsen.zall.org [109.74.194.249])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E560221DB5;
	Wed, 28 Jan 2026 11:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.194.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769600108; cv=none; b=qYnPd0oBXZnf7KVmwNw+/4dvigWvbOXy3Ut580/JZM4RH18vSfoFXTfasIm7sHnOBTcPBc3qWeBunbYmR0X3RwrbbzRDulR8F4mcVyYI4bOmpNRBx7ug5AIl9XYQR4onjz/JtHGwjIIS/UPAc7kEHbBmm66MrJAfEoLYX4CMtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769600108; c=relaxed/simple;
	bh=pWF/AjDwYIl1fzngFOeAyCmY0tpTpu9uKImTzC0XgX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bhr3I0nNhVkA6dV6Th7aFkrSAWeVik48gi91JtguqHbMry7Lr/021aSii8hH6DgxVmXg4hXqaBC7UUDQoed2RfKwuNmSz2W02TRoG0uBq0i98HmWhI+aGIBTCtV0FB8C0FPbXYHiaRRa86TqBPMP8MGiuo/RQ2jfZjBmsNtCZYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zall.org; spf=pass smtp.mailfrom=zall.org; arc=none smtp.client-ip=109.74.194.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zall.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zall.org
Received: by twinsen.zall.org (Postfix, from userid 1000)
	id C76786E3F; Wed, 28 Jan 2026 11:28:54 +0000 (UTC)
Date: Wed, 28 Jan 2026 11:28:54 +0000
From: Alyssa Milburn <amilburn@zall.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Faraz Ata <faraz.ata@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Alyssa Milburn <amilburn@zall.org>
Subject: [PATCH] tty: serial: samsung_tty: avoid dev_dbg deadlock
Message-ID: <aXny9km6N1v9eoXU@zall.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

commit a05025d0ce72 ("tty: serial: samsung_tty: use standard
debugging macros") changed the debug prints to dev_dbg, which can
result in deadlocks:

s3c24xx_serial_set_termios can be called with the port lock, and then
calls dev_dbg, which needs the console mutex. At the same time,
s3c24xx_serial_console_write can be called with the console lock
(e.g., inside console_unlock), and needs the port lock.

To avoid this, move one dev_dbg call and just delete the other.

Signed-off-by: Alyssa Milburn <amilburn@zall.org>
---
 drivers/tty/serial/samsung_tty.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 563688c50751..4a82779a4c38 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1582,12 +1582,12 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 		ulcon |= S3C2410_LCON_PNONE;
 	}
 
-	uart_port_lock_irqsave(port, &flags);
-
 	dev_dbg(port->dev,
 		"setting ulcon to %08x, brddiv to %d, udivslot %08x\n",
 		ulcon, quot, udivslot);
 
+	uart_port_lock_irqsave(port, &flags);
+
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
 
@@ -1607,12 +1607,6 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	if (ourport->info->has_divslot)
 		wr_regl(port, S3C2443_DIVSLOT, udivslot);
 
-	dev_dbg(port->dev,
-		"uart: ulcon = 0x%08x, ucon = 0x%08x, ufcon = 0x%08x\n",
-		rd_regl(port, S3C2410_ULCON),
-		rd_regl(port, S3C2410_UCON),
-		rd_regl(port, S3C2410_UFCON));
-
 	/*
 	 * Update the per-port timeout.
 	 */
-- 
2.52.0

