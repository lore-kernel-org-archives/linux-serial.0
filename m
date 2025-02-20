Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FD213E7B;
	Thu, 20 Feb 2025 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050218; cv=none; b=IvkkcOgci+pi/1/X5tTLcJEVS34+Tf7HqlXZ6AmGMmEt7wMOIYazML57LO0hEGX7UXFkzia9RsEkxtUS8ZVhGuS+JeGD/jI2mVaMAVwW7Trm+Ygp6xiu86TYIvfXft6bDT6tIqc68yAHtQI3xV/9aojVtekPBam/o1YvjJQHPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050218; c=relaxed/simple;
	bh=IGzAUF8EE1dXcvd38v4OtwuOD4neh/Voi1jl6jZSCRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNw1MZ8JKrgp8qrLR9dTDxwZgkdWjyZ2MZ4AfDuQVbZN4yW5kObDx6UYZtACh22tAX0xhho7Cj9xd/rRj+mt6aQWAfru5q7BmE1Jd6ckkgflda0rjZgjT9fZXhGc5IZx47jj1J6bwYzEwC0cvD1yQAvesP/KjwxMSjQNkU5+mdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARkkX2GA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARkkX2GA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C89C4CEDD;
	Thu, 20 Feb 2025 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050218;
	bh=IGzAUF8EE1dXcvd38v4OtwuOD4neh/Voi1jl6jZSCRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ARkkX2GAACaWzLK4e5Du4JcoS2M1eAVSjvf4ctniB+H05B9ihhVKLDKItjKWFuDac
	 9lqOVyJLJCWUFz+5jGSB1kxOsJC6804TkHGWLpqkgHH74oG97vRM0HdNGk3Url6oKe
	 +jOOPA1iF0Ojx/rdgUUV1a2p9vl0rl3AwhiZ155w7sugBzm5kqsD+ebPZrMkP60OjL
	 VDO/foN1eBL/xoFsy9q7kDASkclpnc2aEgguNjeYWJN+LZPS5XMY738187JapMHRsM
	 xOM14Q0NasC1fFwu8g2rIU9qcJi+Yy0w8uVqi8Il+5QgH5hviDsDfp8os8mzAmKsRO
	 CSIz29ZxokmvA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 27/29] serial: 8250_rsa: simplify rsa8250_{request/release}_resource()
Date: Thu, 20 Feb 2025 12:16:04 +0100
Message-ID: <20250220111606.138045-28-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Use already defined 'port' for fetching start/offset, and size.
* Return from the switch immediately -- so it is clear what is returned
  and when.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_rsa.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_rsa.c b/drivers/tty/serial/8250/8250_rsa.c
index dfaa613e452d..82f2593b4c59 100644
--- a/drivers/tty/serial/8250/8250_rsa.c
+++ b/drivers/tty/serial/8250/8250_rsa.c
@@ -16,30 +16,27 @@ static unsigned int probe_rsa_count;
 
 static int rsa8250_request_resource(struct uart_8250_port *up)
 {
-	unsigned long start = UART_RSA_BASE << up->port.regshift;
-	unsigned int size = 8 << up->port.regshift;
 	struct uart_port *port = &up->port;
-	int ret = -EINVAL;
+	unsigned long start = UART_RSA_BASE << port->regshift;
+	unsigned int size = 8 << port->regshift;
 
 	switch (port->iotype) {
 	case UPIO_HUB6:
 	case UPIO_PORT:
 		start += port->iobase;
-		if (request_region(start, size, "serial-rsa"))
-			ret = 0;
-		else
-			ret = -EBUSY;
-		break;
+		if (!request_region(start, size, "serial-rsa"))
+			return -EBUSY;
+		return 0;
+	default:
+		return -EINVAL;
 	}
-
-	return ret;
 }
 
 static void rsa8250_release_resource(struct uart_8250_port *up)
 {
-	unsigned long offset = UART_RSA_BASE << up->port.regshift;
-	unsigned int size = 8 << up->port.regshift;
 	struct uart_port *port = &up->port;
+	unsigned long offset = UART_RSA_BASE << port->regshift;
+	unsigned int size = 8 << port->regshift;
 
 	switch (port->iotype) {
 	case UPIO_HUB6:
-- 
2.48.1

