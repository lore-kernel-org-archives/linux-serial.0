Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082B1DA314
	for <linux-serial@vger.kernel.org>; Tue,  3 Dec 2024 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232366; cv=none; b=BU/LZyUZDvtsYfpQPH5sDCsOmPNxOt+iD9TSy87a4AgxLbrRSj29Qtwga0HLEzshe6BOwgihSTllM72x8onn+xHOel0+wI4Ff24SJXwC3mbhOqR6jH6qRdzBmSVo1zFZ2Xmq36wKZrosRXWbqKPF9q119I14gW/JYpDgMLuICdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232366; c=relaxed/simple;
	bh=30S23RP1xcuI0L/UxZmMEpg9QpSORHSNk9Kv+uzv4kQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tKKF/aV/i+l/uvGBYKid+fvMPWVkUP1nRXw8X0vLEftkWeHt6WD3zy6zTObC6qR0YvL1Tu7DOwGOewUJ3qCT/Bmu5R5nTFa3u+8xCqpAswuNv55wAOVIhQr22kgim/3r18X0O7a9/ND6ewmk1nBHkg9a8vfu6BbzXkaxpzFpVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Y2hHV3V85z3j1Ck; Tue,  3 Dec 2024 14:25:56 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] serial: altera_jtaguart: Use device name when requesting IRQ
Date: Tue,  3 Dec 2024 14:25:56 +0100
Message-Id: <20241203132556.14182-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The request_irq name parameter should be the device name, not the driver
name. This leads to more informative information in /proc/interrupts.

Before this patch:

$ cat /proc/interrupts
...
40:        123          0     GIC-0  72 Level     altera_jtaguart

After this patch:

$ cat /proc/interrupts
...
40:          6          0     GIC-0  72 Level     ff200100.fpga-juart0

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_jtaguart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index a9dd083d45d1..d47a62d1c9f7 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -171,7 +171,7 @@ static int altera_jtaguart_startup(struct uart_port *port)
 	int ret;
 
 	ret = request_irq(port->irq, altera_jtaguart_interrupt, 0,
-			DRV_NAME, port);
+			dev_name(port->dev), port);
 	if (ret) {
 		dev_err(port->dev, "unable to attach Altera JTAG UART %d interrupt vector=%d\n",
 			port->line, port->irq);
-- 
2.47.1

