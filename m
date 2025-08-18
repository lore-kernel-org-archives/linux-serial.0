Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77730C37E
	for <linux-serial@vger.kernel.org>; Mon, 18 Aug 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510753; cv=none; b=sYEfd2t4I2sQ63xGNClPmFLKMNR4hSpwsLXi7lo9XstPCWSbZPUvQUZugp2pDPwklgChUwV6qDjCyXfP/lGRGgeRnFMloNlkUE+DQX+bfV/2726ET0sbGr+/je8lrSmXK3seliImVC/blVn3cxfGkY4uikSX4rUKAwuSQb38f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510753; c=relaxed/simple;
	bh=GEH4sVrqdyXsvmd39LRDUvvvgW0EleSqjIxmeVWQ+n4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QvPeUH0AQm/LqGEu2RQQMX+A3NE24F23wuWoJunjsp3WXAOq6J2GC6p0rD+137vUSqamRmCJ+04AcEheS6a7CeTEDjcHB8qPjB6ChDWhBTn1yajJk1wdtRrZG1QNvF7fSFJxnY7RSiDjNC7HH+oARLEYzuPKbblBbfBAWHqIYy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/etYS79; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BPWtQDvC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/etYS79";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BPWtQDvC"
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755510744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M6EK46JCLPWTafG4jxdiVO3Gdt5cOp+Y6v+pK4MTSmc=;
	b=Z/etYS79pM+J3rkZzxd2VkKQSjeexVcJESxg1A6ZZAe//o07TAznurLsUn+D/LtHtZddx8
	OTrAey79Ee4bA29vRfiRS5BeCTmJlhpfC03CyN7gqrxFSTJjdKHB3246ojl4Ne+k4wCrI3
	2T0akJQ2lDjuhg4hklApJXrGKMMGfmI5YqDACbMaD5ni5LZS74oqasQfoJ0RUtgVjHW4YO
	GQ0/4IngmeNg8aNVg8omLsjlWPlSHWk8GxbLKv/128WAaoKktkB37tcRJ9znZu/4Poa7Mf
	eZFnY2C9pbYQ+66WoFUw9PNXxYEvl/49tVHSYB9l5fAfiaVFluO8C+bctXumGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755510744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M6EK46JCLPWTafG4jxdiVO3Gdt5cOp+Y6v+pK4MTSmc=;
	b=BPWtQDvCC1WbxatMqkvzgJ6qCvUgNx6ZvX2p+9nB/HhRg+bNuN8GOiCZZaKwr3JOw0u49d
	FOt4xgy6heboPRBA==
To: Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH] serial: uartps: do not deassert RS485 RTS GPIO prematurely
Date: Mon, 18 Aug 2025 11:52:16 +0200
Message-Id: <20250818095216.795550-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After all bytes to be transmitted have been written to the FIFO
register, the hardware might still be busy actually sending them.

Thus, wait for the TX FIFO to be empty before starting the timer for the
RTS after send delay.

Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
I tried using the TX empty interrupt instead of polling the register,
but it doesn't seem to be firing reliably, which is why I chose this
implementation instead.

 drivers/tty/serial/xilinx_uartps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fe457bf1e15bb..38d2b33d0b6c8 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -454,6 +454,10 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
+		/* Wait for the tx fifo to be actually empty */
+		while (cdns_uart_tx_empty(port) != TIOCSER_TEMT)
+			udelay(1);
+
 		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
-- 
2.39.5

