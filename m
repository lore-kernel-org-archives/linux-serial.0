Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E531354A;
	Wed, 24 Sep 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728284; cv=none; b=cjjrHaQsBoLSSyk1E73ECCsPSr1ebwEd2Bc9wBWLEPUiRWvQnqpKeXZDUMMBqHGRaEtbRLQb+SYXEB6wMxfoMJ/IkD37OCPQoRPIPMYzcgxB3iY78VzKWj4Hi7GfAT0QZyWBJiHOfJJIITUeS3GfhOb/zdl0XS8FLr6CwMrrlyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728284; c=relaxed/simple;
	bh=SQ4z9EPm96qEBIOicpn/DdoWhzOW5wag7UA6am4b/4I=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=OJ5WHVjv9LEjg2P/0iTAIXsJJp2DUAwd13cZOBhTvVg7sUu1taQmgkQUxku2rGLaaY34dBvkbReylIjcptN+YsF2rM8T3OI+Y8I2seg5MMIWvKAUBJMCX6flUtPicE9PObkYyjcwhhZj/XjIV9FpbhOmflYr0CuEqyfMH+1onQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=p6Z8v25R; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="p6Z8v25R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Qd+syP+sQg2giLSEgfszdvf82H1TmQUOBeAKHYRGVLw=; b=p6Z8v25R4oJ3RfU3LFhMPgVvcg
	cP4sVgsorC2ES9w+VV7mJywnKt9kI+FOpTItCW79tAPwbJe4Qgv6tgaX6kWvqMtKfbbHIH0Gg/nPm
	65mi5/ApbF85OUU3u+hjP0T0n5uASAxxIEE/qKn4aRKC8ZjcrGJhDGGbkyblIksN1jrQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZA-0000RT-E3; Wed, 24 Sep 2025 11:38:00 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:39 -0400
Message-Id: <20250924153740.806444-15-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 14/15] serial: sc16is7xx: reformat comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add missing space at end of comments and reformat to have uniform style.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 31d43fc857187..b3fbe9459303a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -81,11 +81,14 @@
 /* IER register bits */
 #define SC16IS7XX_IER_RDI_BIT		BIT(0)   /* Enable RX data interrupt */
 #define SC16IS7XX_IER_THRI_BIT		BIT(1)   /* Enable TX holding register
-						  * interrupt */
+						  * interrupt
+						  */
 #define SC16IS7XX_IER_RLSI_BIT		BIT(2)   /* Enable RX line status
-						  * interrupt */
+						  * interrupt
+						  */
 #define SC16IS7XX_IER_MSI_BIT		BIT(3)   /* Enable Modem status
-						  * interrupt */
+						  * interrupt
+						  */
 
 /* IER register bits - write only if (EFR[4] == 1) */
 #define SC16IS7XX_IER_SLEEP_BIT		BIT(4)   /* Enable Sleep mode */
@@ -255,7 +258,8 @@
 
 /* EFCR register bits */
 #define SC16IS7XX_EFCR_9BIT_MODE_BIT	BIT(0)   /* Enable 9-bit or Multidrop
-						  * mode (RS485) */
+						  * mode (RS485)
+						  */
 #define SC16IS7XX_EFCR_RXDISABLE_BIT	BIT(1)   /* Disable receiver */
 #define SC16IS7XX_EFCR_TXDISABLE_BIT	BIT(2)   /* Disable transmitter */
 #define SC16IS7XX_EFCR_AUTO_RS485_BIT	BIT(4)   /* Auto RS485 RTS direction */
@@ -1152,7 +1156,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 
 	sc16is7xx_power(port, 1);
 
-	/* Reset FIFOs*/
+	/* Reset FIFOs */
 	val = SC16IS7XX_FCR_RXRESET_BIT | SC16IS7XX_FCR_TXRESET_BIT;
 	sc16is7xx_port_write(port, SC16IS7XX_FCR_REG, val);
 	udelay(5);
-- 
2.39.5

