Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14DE1DDEA
	for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958200; cv=none; b=GCYtrqQBgHEONEuzSVmc6Yy9SK0bQ5bc7suVECUq0zM5YDzQNOoJ5F5UH/vtuHzXe3X51k8Tq5rat8YFUzSx4n+zzmLHVQ/XxB2nzD9oiBFPly9dFbCduD0XeBfA4uxZ4okRjCsWn1y2heUTHjPHUO2cZsSUracFIVXxsVXm09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958200; c=relaxed/simple;
	bh=PF0Vxx/H/Fh+6ybEWx6+PwT0mzFwGK4sk9orjriQwGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aEhSmfz6KPuR3gFfom5LEEZnaC2y4yjbuDGwITWo1TEvnWu0vlWD1OULZyGXc0W1oTl1ct3Ogz4wecobPeq4CRdBWQxU9gSaaeAwtgI7TvW8ml/G/8WtyT30XgUY+mpFH8lSJYqPR5IKaLsd+NhMR6ULTxV3JGTezL3ilvZObn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k88V720B; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k88V720B"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so1858140e87.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2024 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722958197; x=1723562997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McdwXMf+aVpukum1jWBbRDvrxSrkWixRhMvgP59hNnk=;
        b=k88V720BVBKIcCJIBbzvwKHL25gQJ8JtselYsz6TfTylt3yw8/WpSgPMdTnLaZpbW3
         WXkKMw5ptMOGQsm7/TZ/JJqQoR5/jCTV8qeE51wqgBGmOwwLhje8UW86vDMe1ibWfQP0
         hJ3X9MIUXvYARLmhN/ScGKpB+rLEaURk8X0+QWJvjEjfEu2yJGw1u9z6c/5YH6FN2foM
         HwrXclkvislpuZpLkijGPmU2lK7MELLgdYQpupam3dBimBXzueLCwIN1nsY+bWXkOGyI
         ZUlKM8ye49MSCNiW9meRItSJWH82SMmletmSLNJEv3RI6SXWJ7rQWy2LATFnPm8MCDKi
         F9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958197; x=1723562997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McdwXMf+aVpukum1jWBbRDvrxSrkWixRhMvgP59hNnk=;
        b=Nwmwoh+QygqAiQooCmS7ZRvTzkbNH+qV5/7GYydcYL2JQdrxsO2W7h/4NBB/fxP7t8
         IOMsi7Mx5/CWjt/bdUmLThgimtAtvyFdBbUUyarNGFZYAzJnR4lYUtXNFSoWXP9i4B02
         ROhTvnVO1b/3cbMQIJFSqiG4WeIZIO6J1BHOtW6EiytNvvPYMPHBuhkoJR9WOPT7T9YI
         HXloLuc2PHdtgqeTNg4xbFfO5EyVTBnL9FU9Z7Vjzsap1KYbFvaE3852p1mVaiSPowNy
         lddNncXnYdmBrOJAROcCLQS8tl+sgHxQKuN5VbZwI7J6FeEpmQUiQTQ3pBaKG32jqE8i
         MZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUaePKdmWZ8zo9EZMFkgbRWzIgeC04X/PbO40+SSN2jMCdg+CeeYH94RW1VywjHb5nPPR1iYBGm86l/LoXv1aQ2FbDRZUn3v7ovboMQ
X-Gm-Message-State: AOJu0YzDzqDtJX2EymbfR3PN1bvZ7072nhOMfBPtTPATqeoOcM1RecFV
	HZ6vV40S/Sh34oSuKPlY5GllnKFZGjhwJIt851q5go9xCHtzeoKKqyQNLGlsF4CRM/XzxIVwFdc
	UC0YL3Q==
X-Google-Smtp-Source: AGHT+IFyj16EIZLaKK/87iLqK95suicQ+dQY2KgzMLkd9+nLfafpYvKVTsIdMVkQYiVfRocIZ68TBA==
X-Received: by 2002:a05:6512:3e26:b0:52c:dd25:9ac6 with SMTP id 2adb3069b0e04-530bb38cae9mr13232800e87.29.1722958196994;
        Tue, 06 Aug 2024 08:29:56 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4294fsm555274266b.103.2024.08.06.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:29:56 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 06 Aug 2024 16:29:46 +0100
Subject: [PATCH 2/2] tty: serial: samsung_tty: cast the interrupt's void
 *id just once
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-samsung-tty-cleanup-v1-2-a68d3abf31fe@linaro.org>
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
In-Reply-To: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
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

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 1c6d0ffe5649..971765aaeaca 100644
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
@@ -950,11 +945,11 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
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
@@ -971,11 +966,11 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
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

