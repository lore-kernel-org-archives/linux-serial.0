Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7308206049
	for <linux-serial@vger.kernel.org>; Tue, 29 Oct 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207342; cv=none; b=LUFOK1nfpSJs3Ui8IhZ8EeObH1Q6Abx5YijLlV7MJja4fB9BLHTFYW9v8RBF9OZSKMuIvlEizU3yNqpRXoRdlqC1FenGFmUI7EMSwLpkVz0gwQXwvjPorN/IVl3GScnFoV0POXU0niuh8KRjlnOCq/dnnrQ9AWAOsdMPbJzoys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207342; c=relaxed/simple;
	bh=y96FSSdHpK+e1Nlo504LSE9Z7D8IZHc8wqLSXEAHSCU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JDujUSQ+HXRjYkszo9WhuI4hqNijEwtaVdUEx2YoWUcHPloB6K6Hyp+esYrwSUKj8h9CieQ1nNVpq3oR5k1CByij1i05CBiBuzuXlzIdvcJclwTrTVxAoid3h59GhS4/Dc+BVjeXrTpi6leTUZhBWK75gCYKZZwuilXsQdqtoFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4Xd9R72yzqz3j1C2; Tue, 29 Oct 2024 14:02:58 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] altera_uart: Use dev_err() to report error attaching IRQ handler
Date: Tue, 29 Oct 2024 14:02:58 +0100
Message-Id: <20241029130258.4679-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

In case of multiple Altera UART ports available on the system, the error
message will contain information about the port for which attaching the
IRQ handler failed.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 8eed2542627e..1da9cd465426 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -307,7 +307,7 @@ static int altera_uart_startup(struct uart_port *port)
 		ret = request_irq(port->irq, altera_uart_interrupt, 0,
 				dev_name(port->dev), port);
 		if (ret) {
-			pr_err(DRV_NAME ": unable to attach Altera UART %d "
+			dev_err(port->dev, "unable to attach Altera UART %d "
 			       "interrupt vector=%d\n", port->line, port->irq);
 			return ret;
 		}
-- 
2.43.0

