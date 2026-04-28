Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75154657D8;
	Tue, 28 Apr 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398880; cv=none; b=ENMSt03z3Mt+dTcg5RXRepokQeFyg8bezLRl3NiUeugC2VdTALjRcdW6QF0IyOCzvM9ZzqeKJSMWGBk8KBYwxfDcIvZvRHlV+1EZXd5iy7CCY+Jcuh45uOnDXcGTJaQUnQToCkMPtScgUV7QnBYj+QHS9S00mY46Xw+16BetPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398880; c=relaxed/simple;
	bh=akFwuQtWodlVwYhtO9cNqwvsgK1oNMhO6zl8UMcg0cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i98n6vJSkQ8XVbN8pWdvqC7Q5m2n4DP8m+SBWTNma1unURqnx1ZEHLn2lxIdp0c6XXWhKnDwFDPBf/0ohBXa3hX+CQ5j7jvd3TYQEOgrirurb8VpdXzuXu6qhIqkKIBdZao03K8h2z/zJK7lmr7n9/XX5E7W2sgt88xAV7LQhwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Aeqo7Ikq; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Aeqo7Ikq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=FMP94OsqG4giphi7dQUK7+QsuCRxV5fNe1oTNPsf76w=; b=Aeqo7Ikqk8WTNYIuV30yUpQNOo
	YWvzC8rP1MP6rSAyLP4tU93qywXYNnlh9n96236GwluakG6pVj6rv4UhkgTTpBNiF5ILMJQPIUqq1
	fOylyEgWSIzTOchhMLQA5fBF7IugsfUKNfXdvbcBLkZUX5hQ+o59MdKOEdrdngEW+gAY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdk-000000004cz-0pkH;
	Tue, 28 Apr 2026 13:54:32 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Tue, 28 Apr 2026 13:53:56 -0400
Subject: [PATCH v2 10/15] serial: 8250_rsa: use uart_iotype_*() to simplify
 code
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tty-upio-v2-10-01c1857cf761@dimonoff.com>
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

Make use of new functions uart_iotype_mmio() and uart_iotype_legacy_io()
to simplify and improve code readability, as well as avoid some variables
init if the iotype is not valid.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/8250/8250_rsa.c | 40 ++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index fff9395948e33be6b08355bace70275b7515b608..010ba5af81a08e737e0198d06d150bbe470e6688 100644
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
+	if (!uart_iotype_legacy_io(port->iotype))
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
+	if (!uart_iotype_legacy_io(port->iotype))
+		return;
+
+	offset = UART_RSA_BASE << port->regshift;
+	size = 8 << port->regshift;
+	release_region(port->iobase + offset, size);
 }
 
 static void univ8250_config_port(struct uart_port *port, int flags)

-- 
2.47.3

