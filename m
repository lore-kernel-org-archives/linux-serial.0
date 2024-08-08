Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65334126F1E;
	Thu,  8 Aug 2024 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097211; cv=none; b=NhaAQNIftmS4Wg+Wwmd0Opkhe5pGfr9DrucnvJiDMCVbDpFWfd3kmb0XwbziehI+cMG95sRvUeyPNuQAJu/xZSDxyg+oUpCenTxJSpN+nSApzntDZHGGCofLbESCU4xpHXMan5gWYmWqPGJpWCcn7nesILbjLGgxpDqWRtSBfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097211; c=relaxed/simple;
	bh=RWF7dUZD89u04DTojhwoD7Vw/cA4F3RvNKMJmGvD+Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITeMgmBjzFQSX5LRJWAxyy9IgLO54BgdtyY5pLEeETkG3BvQB3+s3Ac1r2YCAp8bjpltdG6YJxkkWK5PuXuS9UJsQEDfH+Dd87HdO25Ct8QyUMgAJy+6dGsr1v9BUOcQQJlHfIBzMP78pfjS86bD+SiPXpxEMDdO/RXaSvZwzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=XCjkHT3U; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="XCjkHT3U"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1sbwIM-0000GG-Fx; Thu, 08 Aug 2024 02:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
	references; bh=dPnHCZkMyi4sPBDmcehTv7Rl0E4zJPeC8eYBG6fTrNM=; b=XCjkHT3UUOFb10
	eZWp+ft1Tu3PuYROQdd3b+b58k3RUR8k4YfyZ+1h+ZNcC9Vw+xy5hpKhsqK6XEv62yu24/K/cc2h6
	4r+Ty3qRaBOzp+3IBwhZ7OfCwBVuqcPGF4oGOCdR0+CSex2REsSexeBNalUHuZdONNZ6faTFpTxJx
	/gzRO8voPY9C3nY4C2JjxFEz+ODvVon3WGqeeZfr+NTJcms5WdEu+vtNqgCYZSlCh3enLTudaxY7t
	lsvTVrEaBefh4oM1llW2CqW/utAmdIMbXMAHyLEwQKEvfCTx2NrXHfVyeoTi99GAZ+6Q7OtQ4tQqO
	PlNVGKjtB54TLRLTSSbg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Richard Genoud <richard.genoud@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH] tty: atmel_serial: use the correct RTS flag.
Date: Thu,  8 Aug 2024 08:06:37 +0200
Message-ID: <20240808060637.19886-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RS485 mode, the RTS pin is driven high by hardware when the transmitter
is operating. This behaviour cannot be changed. This means that the driver
should claim that it supports SER_RS485_RTS_ON_SEND and not
SER_RS485_RTS_AFTER_SEND.

Otherwise, when configuring the port with the SER_RS485_RTS_ON_SEND, one
get the following warning:

kern.warning kernel: atmel_usart_serial atmel_usart_serial.2.auto:
ttyS1 (1): invalid RTS setting, using RTS_AFTER_SEND instead

which is contradictory with what's really happening.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/tty/serial/atmel_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 0a90964d6d107..09b246c9e389e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2514,7 +2514,7 @@ static const struct uart_ops atmel_pops = {
 };
 
 static const struct serial_rs485 atmel_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
-- 
2.45.2

