Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D0466B69;
	Tue, 28 Apr 2026 17:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398881; cv=none; b=ZTeRP+0ixNpq5QoZUoLE4mHD2mlFCv9ArscUAvGu2WEg6ymsmL5lD/7s6YVfWKoZa1LpAdkRHCjHQFDXs1l/+VoNG6adPQM9S5Wuio2SKQomWzFoGU9kpq8U33pJb4kENFD7aLPFo2EgGIOVCq7Yj/ekxzFs8yZFqHawhMjqKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398881; c=relaxed/simple;
	bh=iLLo/F+Zqk49oSOm6IOqU5eaDxZEgFxpY8X6Ei152tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUQA1RQkbpkW3aKc5YEDUIQRUvyc20gDdLB53JNCnbAk4ug1DfuwfPCMbDe7KAI1VBjWnZo1J7UkQJQPHVeUloV6g16bDuutU4R3Qmfwin+yDy3XQZi38Mqnzuqa2ivooIZW4MyuwQzUPMigvGc9NjVfA7A2IGyZEQMc/rtdBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Xw5nmdTd; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Xw5nmdTd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=yzXpb/zzeucTfNpYVg6pG6UVGJTqJuRg/3w0Quig9hE=; b=Xw5nmdTdUrY4xOcjdFlP9bG4uw
	A8dH50rEEH9RFcJsMhIK5PuElJmnXA0qBJ7V/XTTmyq6fHDYy+gFG4dyYzM/odv364P8qRMfFuktT
	c8+4pTbrc/rF2/uXiGzbgMo88ETsbuq0eiI+/E1Y9M/MO2JdV/eHq15f8Kq+y/xyCBr8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdl-000000004cz-31z2;
	Tue, 28 Apr 2026 13:54:33 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:59 -0400
Subject: [PATCH v2 13/15] serial: max310x: use new UPIO_BUS as iotype
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-13-01c1857cf761@dimonoff.com>
References: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
In-Reply-To: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
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
index ac7d3f197c3a5ce3531d5607f48e21a807314021..cd0496e307091dae1f53911abf86726f52d5770d 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1380,14 +1380,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
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

