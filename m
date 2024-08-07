Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C241E4EE4
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031903; cv=none; b=hpYUpx1oDEbSdfjVBIfrG9+sjOCTGOBxVo+Uui06SfPNc5sSrDhVh8RRAnx/by7duNOh7I6r/DgsqgPmrvVxL1Rc3K7D3wwqu/rT2eOd4whPl9qMVwd3MsiwaXhTi9LRo27eYcBgf1vQnkrIixF/BmIrvg4bltKFUH/YPjIeK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031903; c=relaxed/simple;
	bh=ggjnJ0raEKzm4Qv0yp9WV/5danRBgVZL970zbgHPk+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgnDpvoIOY4gbPdzJp+pcNvxkY7ZaO/yxODtEH4MuD5fCCTYtLYCwIcjDUbReKWNP3n09B05nWp783Oa/hdiA3m1IEos6zDMIfXsDgudOUexmYF0Tc91izmoYVJmQpbuFPZrARjqkBXXLkabttR3JEAywJk2kGcGEpVzZhS4ACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLqhTPrt; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLqhTPrt"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530e2287825so53667e87.1
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 04:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723031900; x=1723636700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ob/dMG7ffpu5CnJb/3jC4P+DU5cPyh8uWCPmQu8UZIQ=;
        b=YLqhTPrtwuOHgZMsTlwOk/r3Iewmqr43iPceUS7oqya5eXe20VeaOV7w/2F8O6yZgR
         zK15S4bW7J7R2rmoimao4cwx64oCbf1tNvAIOtdtqn2+hdWe+SQ34X723gQsy2hc0/T8
         IeXj0z3bnJTlyBsV7F0tuLMgdBnUHzXpeDijYiMdpxN3h3UXI1j1BMDCXM9QO/cIgAiI
         CwVlASZeIUffN4UDBk827d7VOtNRxEFD7BWxVdDrlgNyApxfwPd/WKarEN3qNJnACb5J
         LT/RuZR6vNVD6+GTSMmX9f5P0RdLHG7wlxzal2YbtYm8fNt12GeyUIlpoMG5HeQ0UIpF
         Z68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031900; x=1723636700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob/dMG7ffpu5CnJb/3jC4P+DU5cPyh8uWCPmQu8UZIQ=;
        b=uQJP4AemIu5T2kUY0drdjyp3SRZ2kB5jfH3n3DLvml1kywUe+xo3HJBdzmyQPpGR5k
         NfFVkvKx6uNfEaZjgXS4qiFKobPeWd70QDQXWGAIr/OxRAa7Y6b/mNUDK5UHUBMPar1w
         gy/O5+J/LIctDyAIJSAouHA49ge8VcAG6v2mRdIAjyD1eGQPb806cGpppBPwmok/uZix
         CsXz9l5dDt2fy9YWkymN3nqLKkEg8Dz8RE0cJVyf8R4N/xxxTX77upN87cMyv8VQOReX
         VGAUf2u+Jdt/jINFIernTd9Q4azSNScE1IKeN7Gu3eYiRTX6lqSE01pl0wtX9fcq2d/c
         Gb4A==
X-Forwarded-Encrypted: i=1; AJvYcCXp4GnQTNLR8R+Hv6Sd5ebYx+hiRszoJOrP9luIf4LCesqnCMmhM+BeLcO0E9Or1mS0zj7WnnVKYJe7sjvhzTLgjsbNSI5vAEDxlMkY
X-Gm-Message-State: AOJu0YwLwud/tQJV6GspmPQ1eimkEs4bghVVqECjER+nGBCR39NHtMlj
	v4oT/4JVx/44bpXLw/+Nm+mX1WctmAPGScI0FKzsHKZTAJam4yDuWMvmDUElLkM=
X-Google-Smtp-Source: AGHT+IGDZqmOeN0Q0y0tQSs0UlBctnHvqqnA7n65bihl/RZDrjmhHLw+CXjoDWECICYBe/4UovaLeQ==
X-Received: by 2002:a05:6512:b8d:b0:52c:d80e:55a5 with SMTP id 2adb3069b0e04-530bb395e1cmr11925471e87.41.1723031899218;
        Wed, 07 Aug 2024 04:58:19 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d45239sm631017466b.119.2024.08.07.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 07 Aug 2024 12:58:19 +0100
Subject: [PATCH v2 2/2] tty: serial: samsung_tty: cast the interrupt's void
 *id just once
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-samsung-tty-cleanup-v2-2-1db5afc9d41b@linaro.org>
References: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
In-Reply-To: <20240807-samsung-tty-cleanup-v2-0-1db5afc9d41b@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The interrupt handler routines and helpers are casting the 'void *'
pointer to 'struct exynos_uart_port *' all over the place.

There is no need for that, we can do the casting once and keep passing
the 'struct exynos_uart_port *', simplifying the code and saving a few
lines of code.

No functional changes.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2: fix -Wdiscarded-qualifiers, sorry
---
 drivers/tty/serial/samsung_tty.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 1c6d0ffe5649..951e16c87471 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -707,9 +707,8 @@ static void enable_rx_pio(struct s3c24xx_uart_port *ourport)
 
 static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport);
 
-static irqreturn_t s3c24xx_serial_rx_chars_dma(void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_chars_dma(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 	struct s3c24xx_uart_dma *dma = ourport->dma;
 	struct tty_struct *tty = tty_port_tty_get(&ourport->port.state->port);
@@ -843,9 +842,8 @@ static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_chars_pio(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = dev_id;
 	struct uart_port *port = &ourport->port;
 
 	uart_port_lock(port);
@@ -855,13 +853,11 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_irq(void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_irq(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = dev_id;
-
 	if (ourport->dma && ourport->dma->rx_chan)
-		return s3c24xx_serial_rx_chars_dma(dev_id);
-	return s3c24xx_serial_rx_chars_pio(dev_id);
+		return s3c24xx_serial_rx_chars_dma(ourport);
+	return s3c24xx_serial_rx_chars_pio(ourport);
 }
 
 static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
@@ -928,9 +924,8 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 		s3c24xx_serial_stop_tx(port);
 }
 
-static irqreturn_t s3c24xx_serial_tx_irq(void *id)
+static irqreturn_t s3c24xx_serial_tx_irq(struct s3c24xx_uart_port *ourport)
 {
-	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
 
 	uart_port_lock(port);
@@ -944,17 +939,17 @@ static irqreturn_t s3c24xx_serial_tx_irq(void *id)
 /* interrupt handler for s3c64xx and later SoC's.*/
 static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 {
-	const struct s3c24xx_uart_port *ourport = id;
-	const struct uart_port *port = &ourport->port;
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
 	u32 pend = rd_regl(port, S3C64XX_UINTP);
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
-		ret = s3c24xx_serial_rx_irq(id);
+		ret = s3c24xx_serial_rx_irq(ourport);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
 	}
 	if (pend & S3C64XX_UINTM_TXD_MSK) {
-		ret = s3c24xx_serial_tx_irq(id);
+		ret = s3c24xx_serial_tx_irq(ourport);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
 	}
 	return ret;
@@ -963,19 +958,19 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 /* interrupt handler for Apple SoC's.*/
 static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 {
-	const struct s3c24xx_uart_port *ourport = id;
-	const struct uart_port *port = &ourport->port;
+	struct s3c24xx_uart_port *ourport = id;
+	struct uart_port *port = &ourport->port;
 	u32 pend = rd_regl(port, S3C2410_UTRSTAT);
 	irqreturn_t ret = IRQ_NONE;
 
 	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
 		wr_regl(port, S3C2410_UTRSTAT,
 			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
-		ret = s3c24xx_serial_rx_irq(id);
+		ret = s3c24xx_serial_rx_irq(ourport);
 	}
 	if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
 		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_TXTHRESH);
-		ret = s3c24xx_serial_tx_irq(id);
+		ret = s3c24xx_serial_tx_irq(ourport);
 	}
 
 	return ret;

-- 
2.46.0.rc2.264.g509ed76dc8-goog

