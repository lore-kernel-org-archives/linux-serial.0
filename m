Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFDD32E6BC;
	Thu, 23 Apr 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975319; cv=none; b=HUxn8duSgyEdJ3g/gC/nlcRpIS/NLwWeYfWgbI3eA6PpxY90+F793OeXUg2vt4JiHP5VJ0Ksaj95ANQwdFXSAfNq10TYitXaDfIIrqMVwKy/bLksdf4Gyd7Vtc+V4cE3SP1MxL20yBjyTr4h6ddSJztgTpsGMlm5BQ/ti6YmufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975319; c=relaxed/simple;
	bh=iLLo/F+Zqk49oSOm6IOqU5eaDxZEgFxpY8X6Ei152tM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8pSiIpDJVRv0WT3sqrKrrQ1CR8sg/oQCXHBoblViKsX9PELWBlIb7CwCJJW7kfmYgqQb6weWebVdeGOh3c6NoKU8/n86c++0TR57yU9OZ+DCDZPiXJPco6iZ/FtxyD+UzhRwott4KLEq7Ds8yLKVcb48VWFez9i3N+5HvSWGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=yCm8sN9F; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="yCm8sN9F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=yzXpb/zzeucTfNpYVg6pG6UVGJTqJuRg/3w0Quig9hE=; b=yCm8sN9FDPIY3L9jZzgEa9xuBj
	Kwwngh2PABM4KUL69Z12bEk2oFDkxFI5ZT8J8uAGzqtXnJ3x4gMU4R43AI5T3+rv7j9kI+t9mwBuV
	KkMYVzBzvC/5Hi+ruaQ6uvo8q3qYBJDeBTVtv/dhINTiGopi5Q7tr6YKjs9NW6FlqGpg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S7-000000002qN-1kOS;
	Thu, 23 Apr 2026 16:15:11 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:08 -0400
Subject: [PATCH 8/9] serial: max310x: use new UPIO_BUS as iotype
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-8-baf82d3b86d1@dimonoff.com>
References: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
In-Reply-To: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
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

