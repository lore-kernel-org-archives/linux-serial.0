Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D2390603;
	Thu, 21 May 2026 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779387423; cv=none; b=srkJbKcn4qPSFMJdsz8N8sOdWIh8c2XIIyaNahclqG4gys0F91+F2do0+iHTj7QE63CL7TULO9IP+9NuM5ixdcZNl92LNEy1iuZnoVojsKXXIjTiuqzaZOHaohM3xAtCdq+F/SLF0MqKWDU2IdUhgD/BcOPHszxbqbRXGlF7zDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779387423; c=relaxed/simple;
	bh=5iCG+PyHFrpKEGp+55YcNnA4lwF5tKz+xc9+d4l6Pb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQxummjNcqy5CN99nrE49HhY5rQuWspX92BCPODCRCF/PnHqgHYTKensPwUxblqgEzak5ci1MdhzO3LJct1Ck1SaY4bgVE4yOzp3742JbHPnHftj5ZM70n/1V7ZUQ9gcL8l9fASmoUv0fqvYuqA2+YL7hNp1E2NFq3BnXEzxYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Z1Z27fke; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Z1Z27fke"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=ReAjWItx4B5vt5013uQRiM57/Z3EWQ3eEakVlyH8+Ic=; b=Z1Z27fkeW3NACgOILgzJ1GMgcZ
	VmPbW1GDwxbtlGIECQDZNaxXdPxGH0y0vX7GJdP1UhXN5uh4NAoKlFCD1LZBQUYlXwo8Sku7+q/na
	LxzFJFDlS/laTF3Zx5bBYJ0+eOVxtcD31zuJCKivEkcOq6W1fEFDYlWtgWKammqRiRAY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wQ7x5-000000001yA-1b9L;
	Thu, 21 May 2026 14:16:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Thu, 21 May 2026 14:16:49 -0400
Subject: [PATCH v3 03/10] serial: core: use uart_iotype_*() to simplify
 uart_match_port()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-tty-upio-v3-3-bf74567994a0@dimonoff.com>
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
to simplify and improve code readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/serial_core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7a29f17814641f085b37e9b9cc5227e2a249aaa9..432281c96f80ce3be317e3f53324923292b3eb44 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3218,22 +3218,14 @@ bool uart_match_port(const struct uart_port *port1,
 {
 	if (port1->iotype != port2->iotype)
 		return false;
-
-	switch (port1->iotype) {
-	case UPIO_PORT:
+	else if (port1->iotype == UPIO_PORT)
 		return port1->iobase == port2->iobase;
-	case UPIO_HUB6:
+	else if (port1->iotype == UPIO_HUB6)
 		return hub6_match_port(port1, port2);
-	case UPIO_MEM:
-	case UPIO_MEM16:
-	case UPIO_MEM32:
-	case UPIO_MEM32BE:
-	case UPIO_AU:
-	case UPIO_TSI:
+	else if (uart_iotype_mmio(port1->iotype))
 		return port1->mapbase == port2->mapbase;
-	default:
+	else
 		return false;
-	}
 }
 EXPORT_SYMBOL(uart_match_port);
 

-- 
2.47.3

