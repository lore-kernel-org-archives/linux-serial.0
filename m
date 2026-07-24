Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA741D13D
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885535; cv=none; b=drGLhruKt94MQKoUgDV9HHbq56U7BW8oaXbQDGHeOZafUvxrAj7W1HBKPEOXgy3ZuwEm7g5xLPtk2hCFKEgtLg4hJ/2xw9htWcXnl/7rCQSEgMo/rkHyO0jxdZiZK3pBm5gWyBTttRWqqLydMpUqqed3olQdCMK3inAsoBsJ4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885535; c=relaxed/simple;
	bh=7hV4JPOT2HYRhZDtAzM2Jia/QBdg0LWZajGAq/IvQt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LNyouG8vLWvVqJMyrO0fMJqo8ltgdQUB8uFTFUOz7+UTonzvdMqW71FgcLs3K6d/Bouji/S5m7p+ek3rNOGEA4FxcesizWP2X6fDKP4NPdejbXJ4uTrl8Ki26YZa4ETMbGfA/Z5nK+7SP4imuK+MOg+hSsnlIG1UkSYcS/LB1Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HUCMFugq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HUCMFugq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784885529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TdyWUbYwd+tGnxrMPNIHdo/fsQia1BgdcGkErM6IEk4=;
	b=HUCMFugquDENTYxkKv/bQNAZO0XyjOQcUKU+d+nvUNTGMFryNHVU/KJtX7XjepTC/UpmAB
	gym2nfhVGmVgzwJeuMYJ6j2ccR8L/n1ofDln+3pmtNrPlJ59OQLLD/q/05Xd1dGOcCLxEr
	ADL23GCG5B8kYKgXBdPQy6ZkkkAa0zU=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de,
	osama.abdelkader@gmail.com,
	jackzxcui1989@163.com,
	asrinivasan@oss.tenstorrent.com,
	andy.shevchenko@gmail.com,
	broonie@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH v2] Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"
Date: Fri, 24 Jul 2026 17:31:51 +0800
Message-Id: <20260724093151.53216-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

This reverts commit d338ab1d90603f875c4f7ed223406535378173a5.

uart_console() only indicates that the port is selected as the console.
It does not mean that the console has already been registered or has
printed the buffered messages.

On platforms where an initial 8250 port is replaced when the real UART
device is registered, clearing CON_PRINTBUFFER causes the console to
start at the end of the printk ring buffer. Without earlycon, all
messages logged before UART registration are therefore lost.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Link: https://lore.kernel.org/all/20260522101042.21976-1-fushuai.wang@linux.dev/
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
---

The reverted commit is currently in tty/tty-next and tty/tty-testing,
and has appeared in linux-next since next-20260717.

v1->v2: Expand the commit message with detailed explanation of the regression.

 drivers/tty/serial/8250/8250_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index c0e8a4efbdcc..f49862d90eeb 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -720,12 +720,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 	/* Preserve specified console flow control. */
 	cons_flow = uart_cons_flow_enabled(&uart->port);
 
-	if (uart->port.dev) {
-		if (uart_console(&uart->port))
-			uart->port.cons->flags &= ~CON_PRINTBUFFER;
-
+	if (uart->port.dev)
 		uart_remove_one_port(&serial8250_reg, &uart->port);
-	}
 
 	uart->port.ctrl_id	= up->port.ctrl_id;
 	uart->port.port_id	= up->port.port_id;
-- 
2.36.1

