Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1E3E8684;
	Fri, 10 Apr 2026 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834448; cv=none; b=nBK4BOY01xPWa0el9bNBll4ibI78ZfmbSsiEppDWLt4l67wmdh0QA4AyE1boDz8CwA+UCj5g+VFkew+9xXIMlE9Zg0dPzpixmJWW6fGOolsIYzvddeIeQSoDuCtqacckeZFrbUYUmezZ5rPeUHdhFNvsWiQZxxa4kS1Oo4i6yyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834448; c=relaxed/simple;
	bh=3e34Elp4oZaPgMcs2nANuLRhg9ZhtfPsbrpA4+0I0e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkJ0y3hWKBWWdIAsWQXH/zM4sJljnRQGJyQ+JGaGL11PyHm4WYUQyfK9G3IUBADhqT8ywrVTe35Xfr7uVH3ep9+IyTEFzchP2SV/kPvbTmzBUlr7E7d2DbURqR3i5IIJ/UZ9l6EkTt75py8WDoxbxd4LnMSII92ok44QWq2GbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=IipzORVM; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="IipzORVM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=ZGC9oG8zfUwIe9KviJHYFjpLKRoWK8HAakJygSJlWvw=; b=IipzORVMKL9yHRFoV91a1A55cg
	6tOyCBvQlLSfUP8UqVYhHLNWDc5qwGfgQRaZizIg/dW+zpmvp5siqddawij5yZ28PaPYuGZ+xeDdU
	Hcx7W43gsbkoU3t/lbzZfj4IZewl4Qc7QvIVhDm/vPfez5D6LCA15NKfhSrRsLNTDztE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wBDey-000000008Ub-0ycw;
	Fri, 10 Apr 2026 11:20:41 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 2/5] serial: apbuart: remove check for zero baud rate from uart_get_baud_rate()
Date: Fri, 10 Apr 2026 11:20:10 -0400
Message-ID: <20260410152022.2146488-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260410152022.2146488-1-hugo@hugovil.com>
References: <20260410152022.2146488-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The minimum baud rate supported by this driver is 0, so even for the B0
case, uart_get_baud_rate() will return 9600, not zero. This check predates
commit 16ae2a877bf4 ("serial: Fix crash if the minimum rate of the device
is > 9600 baud") and is no longer necessary so remove it.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/apbuart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 3e46341cfff8a..afb04d727203e 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -210,8 +210,6 @@ static void apbuart_set_termios(struct uart_port *port,
 
 	/* Ask the core to calculate the divisor for us. */
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
-	if (baud == 0)
-		panic("invalid baudrate %i\n", port->uartclk / 16);
 
 	/* uart_get_divisor calc a *16 uart freq, apbuart is *8 */
 	quot = (uart_get_divisor(port, baud)) * 2;
-- 
2.47.3

