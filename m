Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D701FF611
	for <linux-serial@vger.kernel.org>; Wed, 13 Nov 2024 11:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.92.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731498556; cv=none; b=smVCMiwyrNXod6oqd9q9fRo3/caPMh7OWaODGyAI89agz3bocVYVVJJdN1AfoxOTyuUH7rvGUrMdwnNqGPfJz57kn0NTB6oOsefQQ7LnGx9ebhRJW84i1TqXfVF192U+Nhs6E7Bkp3kcGxFmr6QPnPYae4MfFygNPwtkVw5Kz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731498556; c=relaxed/simple;
	bh=LIuxohaxGqozPvoT47YiF+HA/Kl/4CBvMfL4rdmMAp8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Kg6sTCHfIbdf9SDmkJM/lWI36BsRryY8dzIfdGj1/Z3vRG4ssphEPDQxEJnK9imNXNFv/wO2lCyz8OPjuikH+wJ43hIq5CKuFBHeqjk96enkQhxVOoG1lloCANgftBiGoEglH6bN+FtSvgtmChDeva+FrKARVZNDF9ihhFJfSZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch; spf=none smtp.mailfrom=sym.noone.org; arc=none smtp.client-ip=178.63.92.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=distanz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sym.noone.org
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 4XpLyV5Nwrz3j1C8; Wed, 13 Nov 2024 12:43:30 +0100 (CET)
From: Tobias Klauser <tklauser@distanz.ch>
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH] tty/serial/altera_jtaguart: unwrap error log string
Date: Wed, 13 Nov 2024 12:43:30 +0100
Message-Id: <20241113114330.16995-1-tklauser@distanz.ch>
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
 drivers/tty/serial/altera_jtaguart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 4c7bde5dd856..b9c3c3bed0c1 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -175,8 +175,8 @@ static int altera_jtaguart_startup(struct uart_port *port)
 	ret = request_irq(port->irq, altera_jtaguart_interrupt, 0,
 			DRV_NAME, port);
 	if (ret) {
-		dev_err(port->dev, "unable to attach Altera JTAG UART %d "
-		       "interrupt vector=%d\n", port->line, port->irq);
+		dev_err(port->dev, "unable to attach Altera JTAG UART %d interrupt vector=%d\n",
+			port->line, port->irq);
 		return ret;
 	}
 
-- 
2.43.0

