Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF2C32E143;
	Thu, 23 Apr 2026 20:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975319; cv=none; b=RGbERBt3ULqKj5nhpm4qhZ60DhOuNwn3rd7zukhdAcyLYeJp6w7ow26Zci8ekCK+CQFhmw3BjSWUxWicmAc0V5uTIe7xyHqa1XRvfY673ypT/BKk1Sth/OccYVjSUuQYCeqnw5gySPCupqELLucV+5ZdCzsCxuZjV/qG779h8Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975319; c=relaxed/simple;
	bh=LTUpd3TmgtJfdNwrIKLkibUpsbTlF2k8wljPMrLkzgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bszJ/pdpBqANF82+l4xVPBWGRnwi9pu9+lZ5IDHT9QJVPLL+OOFHoN1ZDNQXe4WYM00Nts16Q2aXt9wcPWkn654VhZKRK8KVGMrtkGMB/UD3za9ZWaqWr+KjGyUn1uAAkp5zTQzLLCut/hHrkSAydzyp7TlvGLporEkq1xWamu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=0Vwv7rGV; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="0Vwv7rGV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=6bJXCPaRHdWGSrG/PwXfrp8LFCOjxN3HY3yqJS4aCtw=; b=0Vwv7rGVnqntUxtkBVvEGia9a6
	dsbRwkkwHMSJHJO5SRJhAVcT44X6UaTwuAKNqdf2sP1nRcUjZLhFt4Zkd/VPeCVOTb+kOlHmPKPBl
	H7seqsb9KU7g+y5gVZWy01R2ta4YtH2X0BBeDzPtXhvI7ybXSP6zfXEtHpHBL6/RBp2k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S6-000000002qN-3sBd;
	Thu, 23 Apr 2026 16:15:10 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 23 Apr 2026 16:15:07 -0400
Subject: [PATCH 7/9] serial: sc16is7xx: use new UPIO_BUS as iotype
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-tty-upio-v1-7-baf82d3b86d1@dimonoff.com>
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
port and remove ambiguous membase/iobase workaround.

Note that commit 5da6b1c079e6 ("sc16is7xx: Set iobase to device index")
used the iobase field as an index within the device to allow infering
the order through sysfs, but this is no longer needed since
commit 1ef2c2df1199 ("serial: core: Fix serial core controller port name
to show controller id").

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
This means that displaying iomem_base will now always be zero:

cat /sys/class/tty/ttySC0/iomem_base
0x0
cat /sys/class/tty/ttySC1/iomem_base
0x0
...

But the index can be properly displayed with this instead (example with two
sc16is7xx devices):
$> ls -al /sys/class/tty/ttySC*/device
... /sys/class/tty/ttySC0/device -> ../../../spi1.0:0.0
... /sys/class/tty/ttySC1/device -> ../../../spi1.0:0.1
... /sys/class/tty/ttySC2/device -> ../../../spi3.0:0.0
... /sys/class/tty/ttySC3/device -> ../../../spi3.0:0.1
---
 drivers/tty/serial/sc16is7xx.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1fd64a47341d8263c82fcadd90a4c2e549193e19..4b638e69f36f2d20253d8de31f52ecfe349aa39f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1472,14 +1472,7 @@ static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
 	port->type	= PORT_SC16IS7XX;
 	port->fifosize	= SC16IS7XX_FIFO_SIZE;
 	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
-	port->iobase	= i;
-	/*
-	 * Use all ones as membase to make sure uart_configure_port() in
-	 * serial_core.c does not abort for SPI/I2C devices where the
-	 * membase address is not applicable.
-	 */
-	port->membase	= (void __iomem *)~0;
-	port->iotype	= UPIO_PORT;
+	port->iotype	= UPIO_BUS;
 	port->rs485_config = sc16is7xx_config_rs485;
 	port->rs485_supported = sc16is7xx_rs485_supported;
 	port->ops	= &sc16is7xx_ops;

-- 
2.47.3

