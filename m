Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF747D095;
	Wed,  8 May 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175503; cv=none; b=ua7HuWqsEK89K5GdchMedgK9sSJ8EKhUar56JLiqsRwnjCIRQnDUlRJ2zmmZT7cu6yHySpsTTCdP7mfd9Ql3HwjybbDPK7ztGtaKK14ChV/SyFZ70bCSjfH4gpp+HUbDPPVBSMmdT3CJWOoJAxrW5xLWi+urYj8/LMD9zEEdoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175503; c=relaxed/simple;
	bh=vB0Sjt7S+gjdevIA1MOKWP5yvN4Z07ftcH3hTneiHdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o4upPQsawuwAKaxHj2vrcjoI/nG3w5RayaJarizD87MrFfytWqLVwaHqQMEyufkXk077jNyzdGjwKo800DGlwlLUrh3ZfFWxixyyXI6kAKfXNumHUNt+ehDJuozCEvNb6BTjwcircfd417BYyPtXEI7qD6c8ETwLPQW++Nd4yZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=H2+bo0K7; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qtXJCzoe reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="H2+bo0K7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qtXJCzoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715175500; x=1746711500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1anWl7U0g1N5ReOl67RGFJDhNdBee4tIaUiND+Vgla8=;
  b=H2+bo0K7oLCgYvX4fiB/8hxucoN3XJyPIX8zpROAL4MnIvwOE1u3Os0a
   980VafRB/96O/j7EQQ8WqKlJUZZNx2/QJBIh02YwoAvYBQdqsszmpTjqq
   WLaDavkxvLEUdkLlMfqoQzTt4Gkzwh+ofOc0y5qu2DNjnJZa1VY1V+Jow
   3rglfLXKQGY6zh3UZh3uzpNqTXPbUBQqzcYmmwbrsKfCBjuk3Mwuna13e
   FgyeTwZazyZKs4fnC2NXaxnu6sQH8bRJNNfNYERgXajMUAksLHA2ZDN4x
   5gfTdoKvjIp/RIhu4yp5y7WuKAZ3QPKGgv7nXkLwYNK3ke2b4JTPcJVSD
   A==;
X-CSE-ConnectionGUID: z54Sk1EmRBC1VdH69ne3fA==
X-CSE-MsgGUID: 3vZd3Y/sRkKMGvbzBMbsTQ==
X-IronPort-AV: E=Sophos;i="6.08,145,1712613600"; 
   d="scan'208";a="36814849"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 May 2024 15:38:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D977816E68D;
	Wed,  8 May 2024 15:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715175487;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=1anWl7U0g1N5ReOl67RGFJDhNdBee4tIaUiND+Vgla8=;
	b=qtXJCzoersL5wQiIkKQBAwn4D4j1wABKeNyuQudkAIie3Q8ZmvyTdD5EEbJNiX7a42Ctpk
	W1eBU5pUlT2EFPWCm6CPi5kFsDDgkeP0OUiJjsVJct0eVihbTEg76lQCV7yAo2N+FH5Etn
	PcWCE0YGvTmH1q9BOR0cBxOGgSPG/o0oLR1glcAgFoOz8b3+btIhMgCk1mhPeIjg7K5tBZ
	v9qfdIH/33ko0jAiHFk/lPBP03oCDFu2N5ZCDQ391ng8zlYRQZZPbi96RHuKup5SCpW0AO
	Q3DcCAxCoeIkVPH7W6D6WB+F0LyjF6wjePw6SGW3HHIKKh93QW/RJwxc+AfrRg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Subject: [PATCH] serial: imx: Raise TX trigger level to 8
Date: Wed,  8 May 2024 15:37:44 +0200
Message-ID: <20240508133744.35858-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

At the default TX trigger level of 2 in non-DMA mode (meaning that an
interrupt is generated when less than 2 characters are left in the
FIFO), we have observed frequent buffer underruns at 115200 Baud on an
i.MX8M Nano. This can cause communication issues if the receiving side
expects a continuous transfer.

Increasing the level to 8 makes the UART trigger an interrupt earlier,
giving the kernel enough time to refill the FIFO, at the cost of
triggering one interrupt per ~24 instead of ~30 bytes of transmitted
data (as the i.MX UART has a 32 byte FIFO).

Signed-off-by: Michael Krummsdorf <michael.krummsdorf@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 79f1503cd75b4..2eb22594960f3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1305,7 +1305,7 @@ static void imx_uart_clear_rx_errors(struct imx_port *sport)
 
 }
 
-#define TXTL_DEFAULT 2 /* reset default */
+#define TXTL_DEFAULT 8
 #define RXTL_DEFAULT 8 /* 8 characters or aging timer */
 #define TXTL_DMA 8 /* DMA burst setting */
 #define RXTL_DMA 9 /* DMA burst setting */
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

