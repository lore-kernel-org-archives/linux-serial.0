Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6B3A4F26;
	Fri, 31 Jul 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490779; cv=none; b=U/RptE9QmM2IjwHJypzyxpJFg1RtWOyXNGbTswxcZL8o0J5WRHahDqi5TsycMbO714CfdPgAcVib/pBXV4GqgXQFbGEL6CNyIf7FH3jKHwiadUiADlp/ojc6rPcB9xjJlJokUDucIdRbpVZrpukGfjFJrf+3nO7JHg06xzmJNbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490779; c=relaxed/simple;
	bh=n9Ty9fFbfeSt37AJjyEY+9KmMlPmIhv6yCQOpVeFrMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQgVwGHke/M7BV73wvFAVpxFBxSvc9HP8A99Kb7NEH4uxP/MvD167PMtjaa5V5gfUXZtP6vjrE8yOiepQQNwq5hq9R2AXbKUO+cf2Y7uKgF0DsnIj28ERlZ+Lq0fVpGyOo9RhO+nUjpN7oG42slVr2ftXq0zcxsHYYAtzam1ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F44qzywT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F44qzywT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 70A991F000E9;
	Fri, 31 Jul 2026 09:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785490778;
	bh=22Ilw/IkI0k96901vA78kHlE2RFXy9U+AV3Jr6io4iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F44qzywT1iWydYzd/CpjTCvrU9zxNL1vCs26xvmkRPIsw2hfYKxAiZKExSf9scyFn
	 4wDLUb45oEBHlhb6If2nMcwE/FjW9zefObMlFS/YCpY06/aizD1RSmjcME11d116al
	 Buy/bcODq+UX2hxkc1grUKwJS6EYs69Ee4eilhlNrFJIR+avgVqXlVJHfatal6CSeC
	 BOHf6TqxNgSLBycg/EB+v3e+9G1c4bE3AoBatkDAFsM5myrf8V9egpdDCZ0pYmhay5
	 6qH/Ch4I1oiQAVGibT9ehSWphJ6Vfxvv/Tbl0Jbt91zzAgmiSK39cwi6nnL9MJo9db
	 hGtSTqow3Alzg==
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Alan Cox <alan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 1/6] serial: txx9: Drop noop probe function and dangerous remove callback
Date: Fri, 31 Jul 2026 11:39:04 +0200
Message-ID:  <25e2b1d699652b095ee69be030850c8818bf78d8.1785489518.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1785489518.git.ukleinek@kernel.org>
References: <cover.1785489518.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3716; i=ukleinek@kernel.org; h=from:subject:message-id; bh=n9Ty9fFbfeSt37AJjyEY+9KmMlPmIhv6yCQOpVeFrMM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhqycXKc57jfjXG7dmJP3cknbA4Mf5+9pSBX/LKrS/J8ud f+14iHdTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmcvYFB0PndWvj4KlHkyxa nXY9tF0wY3r2vzPrf3s4ls7MqBLLmKw7PTv4KZ/l4dyff210q9fF289KZGKeacWxRyeh/sKkLc3 Jp5Z3XAyvn/1NsYdj39WT7t8j8rtvL4t4129p/JDzWvCR9EgpwXP3W/v2TzR8/tDxvH7aLqPaA6 cTfW+pGy5O+lx8yt58267SzFlxpTbC/QLlxm0/RAO8XnRZ13arB2jMrt9vNLH220yppi0Lb+bp2 fLfmGn20FlqaX5ZYWtax68lYvyrGAyjMstOKife3FXU32OkJyihEKt+nHnZkWN1jDl9ufJpaRyi MrcfRfDZ+KctWbKw6p93pIdEJLtA+fwpX0xszV3PqcsDAA==
X-Developer-Key: i=ukleinek@kernel.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The only platform device that can be bound to the driver is allocated by
the driver itself. That device doesn't have platdata, so the probe
function only consists of a loop that is never run and thus can be
dropped without loss of functionality.

The remove function then should better not undo things that were not
done in the first place. That happens because serial_txx9_init() calls
serial_txx9_register_ports() with the created platform device and so
up->dev == &dev->dev evaluates to true and uart_remove_one_port() is
called twice for each port.

So let serial_txx9_exit() undo exactly what serial_txx9_init() does and
remove the useless respectively wrong functions.

Fixes: 0970769aceb9 ("[SERIAL] serial_txx9 driver update")
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
---
 drivers/tty/serial/serial_txx9.c | 55 ++------------------------------
 1 file changed, 3 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 4ae9a45c8e3a..5ed20129b44b 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -1009,7 +1009,8 @@ static void serial_txx9_unregister_port(int line)
 	struct uart_port *uart = &serial_txx9_ports[line];
 
 	mutex_lock(&serial_txx9_mutex);
-	uart_remove_one_port(&serial_txx9_reg, uart);
+	if (up->iobase || up->mapbase)
+		uart_remove_one_port(&serial_txx9_reg, uart);
 	uart->flags = 0;
 	uart->type = PORT_UNKNOWN;
 	uart->iobase = 0;
@@ -1019,52 +1020,6 @@ static void serial_txx9_unregister_port(int line)
 	mutex_unlock(&serial_txx9_mutex);
 }
 
-/*
- * Register a set of serial devices attached to a platform device.
- */
-static int serial_txx9_probe(struct platform_device *dev)
-{
-	struct uart_port *p = dev_get_platdata(&dev->dev);
-	struct uart_port port;
-	int ret, i;
-
-	memset(&port, 0, sizeof(struct uart_port));
-	for (i = 0; p && p->uartclk != 0; p++, i++) {
-		port.iobase	= p->iobase;
-		port.membase	= p->membase;
-		port.irq	= p->irq;
-		port.uartclk	= p->uartclk;
-		port.iotype	= p->iotype;
-		port.flags	= p->flags;
-		port.mapbase	= p->mapbase;
-		port.dev	= &dev->dev;
-		port.has_sysrq	= IS_ENABLED(CONFIG_SERIAL_TXX9_CONSOLE);
-		ret = serial_txx9_register_port(&port);
-		if (ret < 0) {
-			dev_err(&dev->dev, "unable to register port at index %d "
-				"(IO%lx MEM%llx IRQ%d): %d\n", i,
-				p->iobase, (unsigned long long)p->mapbase,
-				p->irq, ret);
-		}
-	}
-	return 0;
-}
-
-/*
- * Remove serial ports registered against a platform device.
- */
-static void serial_txx9_remove(struct platform_device *dev)
-{
-	int i;
-
-	for (i = 0; i < UART_NR; i++) {
-		struct uart_port *up = &serial_txx9_ports[i];
-
-		if (up->dev == &dev->dev)
-			serial_txx9_unregister_port(i);
-	}
-}
-
 #ifdef CONFIG_PM
 static int serial_txx9_suspend(struct platform_device *dev, pm_message_t state)
 {
@@ -1096,8 +1051,6 @@ static int serial_txx9_resume(struct platform_device *dev)
 #endif
 
 static struct platform_driver serial_txx9_plat_driver = {
-	.probe		= serial_txx9_probe,
-	.remove		= serial_txx9_remove,
 #ifdef CONFIG_PM
 	.suspend	= serial_txx9_suspend,
 	.resume		= serial_txx9_resume,
@@ -1251,9 +1204,7 @@ static void __exit serial_txx9_exit(void)
 	platform_driver_unregister(&serial_txx9_plat_driver);
 	platform_device_unregister(serial_txx9_plat_devs);
 	for (i = 0; i < UART_NR; i++) {
-		struct uart_port *up = &serial_txx9_ports[i];
-		if (up->iobase || up->mapbase)
-			uart_remove_one_port(&serial_txx9_reg, up);
+		serial_txx9_unregister_port(i);
 	}
 
 	uart_unregister_driver(&serial_txx9_reg);
-- 
2.55.0.11.g153666a7d9bb

