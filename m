Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED33A7D6F
	for <linux-serial@vger.kernel.org>; Fri, 24 Jul 2026 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877921; cv=none; b=dEBz9JJKViE+Qhk147sxXmWxC3ocoHHh9/T3gqu+e1ehle3ZCi3l2K2C8j4ZKdFHNuWgsfqddL2G8FAo5WzYOs5KlB/CaDTwn8Cs54LsGMxqPqwyYQnl8OAmsoxxZ/WYHneMgEIQ2XGCHtYaDrssmWaLcX3+4hySa4Yzjx1La0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877921; c=relaxed/simple;
	bh=aDAuXLEf5tJ4d6j+WWoC5vsExRedffUtI0haldHKxVk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VA8xfQat7psXrqTZvl6dI5Lqfv3VF4Ic3uNemtQial/8RLiYaANJMBmObFcTJrp+5I+0jEf6iKwIWgmRLGko27VkKAQGbRzlduEwwfyH4jHLfkQl0azjPjwpQi1JED3ewGOel0bn4zHYCJM3EsMhctO/NbMqJu2qYZvhQbsgSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMz4X3w4; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMz4X3w4"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784877915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aBWKWkjIoFjEIMuuQonymKiJljJBB82pP/HajYbb/F8=;
	b=CMz4X3w4gsNH4w11PxU8NMXpr5jpnftmATgzWkXnygqoiRKh9u5ZkXXvBQcbCLWMag6GOl
	Yx3xHzc57TZINUkMeCa06Oop3/trQVbRrpt1QrXGZfOT5BmWUPrqSDXV6BUtUamz7i5vMd
	V6zMDLC6w511BVVjm3JBxDOLw2zbmq4=
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
Subject: [PATCH] Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"
Date: Fri, 24 Jul 2026 15:24:52 +0800
Message-Id: <20260724072452.40455-1-fushuai.wang@linux.dev>
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

This may cause some boot logs to be lost on some platforms.

Reported-by: Mark Brown <broonie@kernel.org>
Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Link: https://lore.kernel.org/all/20260522101042.21976-1-fushuai.wang@linux.dev/
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
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

