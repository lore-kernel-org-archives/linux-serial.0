Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40F17B410;
	Wed,  3 Jul 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005978; cv=none; b=Y4s0uA9bnXfSUi6u+yTclyqY1ZRVmEk8rwEQ87V0GEtMf2k40XQadon7h8DkKkCzPOol6C0xWujtuCcwge2UZxDPzQDlSAl3jHnQ2Q9EHvZ4Flscc0qGbJ5VpaffKGW4CkwQkBJWy+17eQcnHGJUNYgPi1mvrNwgxIVyeXouyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005978; c=relaxed/simple;
	bh=8JndRnspM5RDjpsWE9ZsbTjXeCN5YcBE71YC4B5qx14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jy6yhb9Gw2jOyY4VCfcCyGlhf+1QnThclPljDzCR3t5cz9EOb+31/3s5nERXRd7X+tBVEhRqbb5qDOsQZ1wZUDVi26Spbgiu8f/sKLk7v7HW3CfUtGwM9JGBcIHZV5OMv2rdFxuM72oGgveFSxH6WILzI+cqWEOyB62Z3x7BsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9nWnPWe; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9nWnPWe"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so53910481fa.3;
        Wed, 03 Jul 2024 04:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720005975; x=1720610775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A+2MqGa7e9k/H+mBR0AcQlM4kYrNvHVCP7g1hxy4Qxw=;
        b=O9nWnPWetj2jYCRNCve3MSUmtOshfK9DxV5k9eGQYY/Phlsl46jLB4W1ypQ7BOFV+o
         xAJFlD32six0VgJUZaGa3gFWBGfNuEecSst0h8x3N9II+ZtyI+fa+IJHWP8AOhaS5BiE
         KTbO5XxNpFmvfDBUfLkmODGM/uHILaTtKDuN+XU8P/5rzvRK8TALrd0t+ro+vrFfKprP
         fToogKHPse/D59eWlOv2SmAPnNwe8WQgQanHGeP3T2rXwZhXBR73dcw/qpiSZ4wbUvzY
         nBz6n8sYR1lYKasLAk15y63k5Xq2XGdMo+2omCVy1lpNdE2CmSuboajhMJUe4ttBEf04
         tkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720005975; x=1720610775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+2MqGa7e9k/H+mBR0AcQlM4kYrNvHVCP7g1hxy4Qxw=;
        b=jzbM/EC160R9/4nsvucZ1QWHSwar9+UayUubsx+EZz4dvRH5HnqCzSLl14xKuZ3R1C
         3rztAoBbjgA7HoH4h0V+Fpp1HqneTsJulTGlI/9H7ONHleHt2aLTDPVVQYd8qp3iv0mV
         VIiN30Dxnq1+YHajlgH2H8YfOXzWlZVXoPHQia5/svgOGTmhj9XJFGhbVlBj6JoUfoTO
         P8ObD88EE7Zgsm8yh3WRYYvtC7sGaoR2971w9F83c0RHzE/UTo+xbO8nd5WCXoZgB+em
         msgIdh/V2vtTFjr+wXh/8fUu8nj6R5I84y5Z6LW9iaPerW2JQbNcoFVnGp6PZw0bv7yS
         R37w==
X-Forwarded-Encrypted: i=1; AJvYcCXUkSRCRN+L4W3boHITs0fKfJroCyeiJa5iKODJPy7zdkgzEYX//uUB6Mggu1JevQqiYXbbKYuXRmPaP38UqtL/RvFT8FKthFU3WxX0
X-Gm-Message-State: AOJu0Yxl+VRdLRnDxGMWC8v70knFQHeck2SoUbnz0FQnJhvQ4kf+6wk0
	bknVrU6BfhnSai5e4ucF0MSJKBkMqcIPcoSoCEshvpKP8fuxiJ2m
X-Google-Smtp-Source: AGHT+IEJXFekNY3fsB5tfjE9fQZRtx+cCV4tRGUY0n2mFuccdc2QjvzsFIB813RbvbxYXhi1K/b+xw==
X-Received: by 2002:a2e:2409:0:b0:2ee:4d91:3d88 with SMTP id 38308e7fff4ca-2ee5e39e5e2mr64257721fa.16.1720005974635;
        Wed, 03 Jul 2024 04:26:14 -0700 (PDT)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af37828sm242351875e9.9.2024.07.03.04.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 04:26:14 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	cniedermaier@dh-electronics.com,
	stefan.eichenberger@toradex.com,
	l.sanfilippo@kunbus.com,
	tglx@linutronix.de,
	rickaran@axis.com,
	francesco.dolcini@toradex.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1] serial: imx: only set receiver level if it is zero
Date: Wed,  3 Jul 2024 13:25:40 +0200
Message-ID: <20240703112543.148304-1-eichest@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

With commit a81dbd0463ec ("serial: imx: set receiver level before
starting uart") we set the receiver level to its default value. This
caused a regression when using SDMA, where the receiver level is 9
instead of 8 (default). This change will first check if the receiver
level is zero and only then set it to the default. This still avoids the
interrupt storm when the receiver level is zero.

Fixes: a81dbd0463ec ("serial: imx: set receiver level before starting uart")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/tty/serial/imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index f4f40c9373c2f..e22be8f45c93e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -120,6 +120,7 @@
 #define UCR4_OREN	(1<<1)	/* Receiver overrun interrupt enable */
 #define UCR4_DREN	(1<<0)	/* Recv data ready interrupt enable */
 #define UFCR_RXTL_SHF	0	/* Receiver trigger level shift */
+#define UFCR_RXTL_MASK	0x3F	/* Receiver trigger 6 bits wide */
 #define UFCR_DCEDTE	(1<<6)	/* DCE/DTE mode select */
 #define UFCR_RFDIV	(7<<7)	/* Reference freq divider mask */
 #define UFCR_RFDIV_REG(x)	(((x) < 7 ? 6 - (x) : 6) << 7)
@@ -1933,7 +1934,7 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 				 struct serial_rs485 *rs485conf)
 {
 	struct imx_port *sport = (struct imx_port *)port;
-	u32 ucr2;
+	u32 ucr2, ufcr;
 
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		/* Enable receiver if low-active RTS signal is requested */
@@ -1953,7 +1954,10 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
 	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
 	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
-		imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
+		/* If the receiver trigger is 0, set it to a default value */
+		ufcr = imx_uart_readl(sport, UFCR);
+		if ((ufcr & UFCR_RXTL_MASK) == 0)
+			imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 		imx_uart_start_rx(port);
 	}
 
-- 
2.43.0

