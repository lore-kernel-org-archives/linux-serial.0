Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27123C456D;
	Thu, 21 May 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387432; cv=none; b=Fo53ouWbVyTJQgv85nDRN0zoTtdgbuugfu0pA8W/obxKu9/zGHAQVTudywbWKoKM/J4unD7GEtxZ/aZX5maf0OJ0G8pzwlAyy0jAuCt0vPKSGeo6LMAIRCy50yyEWmopzVtQ3UKOKOAhFd1zcBBTZcv/cmKM3j0xq0WEJ25jaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387432; c=relaxed/simple;
	bh=S/NsF+Y4Y/4o1SZppwZAiMwcIw1vC91EvAubmCBvhfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d599R3UP6pfy+YWre0eVc4b+KVdFjimWgW7V9mO7Y0E9ju6zp+DKj0A7IfNhBan+Eif2fk2/RQRs2vZKtmUZYZky/STWeNGhhouyWJ8Ed2553GVq3keAVZtP77KLDbir7nfWmHdZ7r5AeqFN8lDXfWq8jKh8i6FxPoyFWL5EMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=LuJm4HWK; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="LuJm4HWK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=T0OlPy7TqB9wAWBECWcDYOkYn/BSMrIW+IH5VHZocWw=; b=LuJm4HWKSCqF2ohf1xkzQAZUug
	pgso2QOLkgOjre0gJNdR1soIzbCRsUh8jCMDcMFiOj2F7KbdJLW42ejlk7UjFHanmrvT1y8jyGnhK
	JIffVnL4Tdo8BtyqoJ0Qe3uQQC1wPxv5pq43HnPD7JKnl5srjOHyd9xO2RJyIbqIolOk=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x9-000000001yA-2h6b;
	Thu, 21 May 2026 14:17:03 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:55 -0400
Subject: [PATCH v3 09/10] serial: max310x: use new UPIO_BUS as iotype
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-9-bf74567994a0@dimonoff.com>
References: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
In-Reply-To: <20260521-tty-upio-v3-0-bf74567994a0@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Now that we have a new UPIO_BUS I/O type, use it to register our serial
port and remove obscure membase/iobase workaround.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/max310x.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 9f423b3b4201d0db07bbd7b15934db36249e7620..ae3f25d05e83532cd0736c59ff476af916ab24da 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1405,14 +1405,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		s->p[i].port.type	= PORT_MAX310X;
 		s->p[i].port.fifosize	= MAX310X_FIFO_SIZE;
 		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
-		s->p[i].port.iotype	= UPIO_PORT;
-		s->p[i].port.iobase	= i;
-		/*
-		 * Use all ones as membase to make sure uart_configure_port() in
-		 * serial_core.c does not abort for SPI/I2C devices where the
-		 * membase address is not applicable.
-		 */
-		s->p[i].port.membase	= (void __iomem *)~0;
+		s->p[i].port.iotype	= UPIO_BUS;
 		s->p[i].port.uartclk	= uartclk;
 		s->p[i].port.rs485_config = max310x_rs485_config;
 		s->p[i].port.rs485_supported = max310x_rs485_supported;

-- 
2.47.3

