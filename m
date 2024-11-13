Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD51FF7BF
	for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498556; cv=none; b=Y22ugqTDMfGL/svBTZY16R3/hU/yKVlZDZGXy0gkk5pEFkFn2aQxN+RMW+WVoDrccJIHpoGSqotOGlXBcQn18TDlpvNFunaHarDSKTL3Mp8L733VVDodScXaF2b7ogjXmfTtcvp0owVfi66LlNE2ugHGKurYiDhFTAbjdmkOfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498556; c=relaxed/simple;
	bh=BaoIWgFxdLhN2GLYrMIUFyWxEkQ25bbewizRIqTOgkw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dD8Ey4y2qkaTP6yOr2fo5xVJ6qLRu3UZCC0mod8Ovo0r46HRE1H39TvnGK2BnwQKCMsuonQb5ORKtNFPN5G1bW26mSqkYHnqyd1ufkyHmP7z7Wg5F/5mbQmttLcbt/nbhLcxDPKlmOszjpAHQyBAqRxWUAM/GPs9Qlk3PKl+lic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4XpLyH1WWVz3j1By; Wed, 13 Nov 2024 12:43:19 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty/serial/altera_uart: unwrap error log string
Date: Wed, 13 Nov 2024 12:43:19 +0100
Message-Id: <20241113114319.16636-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

The error log string should be a single line, unwrap it.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/26034117-26b6-4eeb-bd66-969955b70e9b@kernel.org/
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/tty/serial/altera_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 1da9cd465426..c94655453c33 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -307,8 +307,8 @@ static int altera_uart_startup(struct uart_port *port)
 		ret = request_irq(port->irq, altera_uart_interrupt, 0,
 				dev_name(port->dev), port);
 		if (ret) {
-			dev_err(port->dev, "unable to attach Altera UART %d "
-			       "interrupt vector=%d\n", port->line, port->irq);
+			dev_err(port->dev, "unable to attach Altera UART %d interrupt vector=%d\n",
+				port->line, port->irq);
 			return ret;
 		}
 	}
-- 
2.43.0

