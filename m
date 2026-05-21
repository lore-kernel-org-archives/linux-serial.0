Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5B3C342B;
	Thu, 21 May 2026 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387430; cv=none; b=FaR2/Y9Ho9LIHaqqw8IjIyv6z6ZFzHOuUEE0C6IchQU7R37MDKM56W6XbAgKnpsk1aq9U7/WzNbRV4dM4o83kAP7hwK3iqlsBZ9+vitb/+ygUuV015LPjNVBQo5mF94wD+ZazAE9Vj8/I1VXxUMvd9Hd8zOD6Febai0o6ReHuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387430; c=relaxed/simple;
	bh=E9e1Yqrrnnpe3+dDHZNvFehP1OfM/mxITrGq5WxusfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mBfTcry1LlXVKedOQd6wHVWoUa3iaSkH3RrOPFuryeLz1FxxbDDjvG18zz6eYTYNC+z880eTQZ5kBASIsH4RDgnrSTAJO4PYNwkxoill3gTJtJzQn01oYPsJdgDVB4HA/c2FerF0Pb9l2j6lVrfQoL18804MdcrZisBDSqo/qyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=gwTCZVMv; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="gwTCZVMv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=yeSaF9njE5GuFf1Tu4uSm5WErkZGfD4UUUQSnZJxD34=; b=gwTCZVMvoZmC5Ljiqa838LtUYe
	Ng5R5k6apFu6IDdnFhplBfek4Wb5oJG1mCXks0Kc/nKZqmsEwLe8+qbbn+bccugilTwyhuwPxQrHY
	256/RUnt/89wBN4oFWn0/NroShiRqaCH+6D6AQEvYuWE4KJjOWOl0vQGhgzn+7evexjg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x7-000000001yA-2olS;
	Thu, 21 May 2026 14:17:02 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:52 -0400
Subject: [PATCH v3 06/10] serial: 8250_rsa: use uart_iotype_*() to simplify
 code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-6-bf74567994a0@dimonoff.com>
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

Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
to simplify and improve code readability, as well as avoid some variables
init if the iotype is not valid.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/8250/8250_rsa.c | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index fff9395948e33be6b08355bace70275b7515b608..da971437e89c16f718cab71c0d64acd61ed9c436 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -19,35 +19,33 @@ static const struct uart_ops *core_port_base_ops;
 static int rsa8250_request_resource(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
-	unsigned long start = UART_RSA_BASE << port->regshift;
-	unsigned int size = 8 << port->regshift;
+	unsigned long start;
+	unsigned int size;
 
-	switch (port->iotype) {
-	case UPIO_HUB6:
-	case UPIO_PORT:
-		start += port->iobase;
-		if (!request_region(start, size, "serial-rsa"))
-			return -EBUSY;
-		return 0;
-	default:
+	if (!uart_iotype_io(port->iotype))
 		return -EINVAL;
-	}
+
+	start = UART_RSA_BASE << port->regshift;
+	start += port->iobase;
+	size = 8 << port->regshift;
+
+	if (!request_region(start, size, "serial-rsa"))
+		return -EBUSY;
+	return 0;
 }
 
 static void rsa8250_release_resource(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
-	unsigned long offset = UART_RSA_BASE << port->regshift;
-	unsigned int size = 8 << port->regshift;
+	unsigned long offset;
+	unsigned int size;
 
-	switch (port->iotype) {
-	case UPIO_HUB6:
-	case UPIO_PORT:
-		release_region(port->iobase + offset, size);
-		break;
-	default:
-		break;
-	}
+	if (!uart_iotype_io(port->iotype))
+		return;
+
+	offset = UART_RSA_BASE << port->regshift;
+	size = 8 << port->regshift;
+	release_region(port->iobase + offset, size);
 }
 
 static void univ8250_config_port(struct uart_port *port, int flags)

-- 
2.47.3

