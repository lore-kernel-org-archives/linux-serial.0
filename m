Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A981E485D
	for <linux-serial@vger.kernel.org>; Wed,  7 Aug 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031902; cv=none; b=qp0QspFmgl6LYOpOPI8BaUOCLGbeHpjgy4Tr6tYUy5g8Isk+J3sbV2K/UjHlqkM08SZ4Q56OGl52c/70q1sQGBoTz9coIobATgoFQ9wfQKcVnx1b6GRKGwQuY3nnFCvFOR/FXO8YTJFJvPjJxzCRJHl5cL9wSX2EnFZRiNb7RmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031902; c=relaxed/simple;
	bh=C0WfsFjQ+8vm0W8joRCkaLKnopigm0TpDNtG9k6jpMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDzdPwm8i/JLuCmteMM7hD4uhYLdpltJK4oSaqmgLt+GqQBlc4+51cvOdFyVKqJaL8zjSlVHy6SKJ0diBVSNY+MMbQGUEHmls1x1ybLpqY18qFeTJFrngcUtqTvHGq2L3GdoM57wANAuXsnRDoW8KoOkVZnofwCINGCA4srdfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k2eSwrGT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k2eSwrGT"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a843bef98so189626266b.2
        for <linux-serial@vger.kernel.org>; Wed, 07 Aug 2024 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723031899; x=1723636699; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMjvgficlM8E7OFHsCNQI4tsZ98VKn4/e3uEzM8rqJg=;
        b=k2eSwrGT4N10qW1QpzRMc4fNJ+UOskao7bA0kjY4HGQynu6b4FfP9Y/pCdZ9vejS3n
         UhZSueJakcbj9bE5EZYA3ZZ1S0c6B4xPsuLI0WySCC3wp5JaCLgzXNELHzcFW15pKE+2
         /dugAdewdcCbuOI9A5awbaWyxbhmuoA/bpAw0ZDs/szv/meJL5WtrkK60IJwSPJWciHM
         pu+CduJsxt3RGbnNUhMHP8dMK6TyxECk+xxei8nT/cq58QArjnn+MmcrLXo/MSbN07Da
         dh5ZOqxBabsm/rXLxhanXBQHJfsy5EmqG898G4ZKT+u8ZYKHFVdj7nnbUCK2YT3QG2Ps
         CxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031899; x=1723636699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMjvgficlM8E7OFHsCNQI4tsZ98VKn4/e3uEzM8rqJg=;
        b=AQ47oVHypKmuWUOUfApGT2GCu94wo0lz9qwxaC0dj3zi6Bqh4Y4r5i8O88+pBKxlQL
         cVCys6yFw3oc+ggoUXcSnPfOpwp6NbZ4euHZZUrjOepFIBQ/lUId9qPGoadGpodvZoxM
         MvI/+u8Yxn/bePHznktgP0bN1XH69/87UrKtBgzAIlCBuqdjwVCqmO3lwln9EIKwjbzU
         h8bKW1hxKnnxbNgTm7B7Tf65jt09fxHNC8M2I7WFwhd3I0ii8Mkil1BMYJs5wm8L52QA
         3axqJVPr0U4RYuheeqkDv604IOXm6xVBUjCH0gJLmvKHw/jDXh2QwFnXKwUXyfH+f6V8
         LYcw==
X-Forwarded-Encrypted: i=1; AJvYcCWibXYHx2YjabdLKJiPg6yvWj3AA/UwVcxkFyONGOly9BBtygNZzAa1ZybJGBB73CM4MhvREcKk0TNsAVuVppxwOJXCdNWQS7D3whVk
X-Gm-Message-State: AOJu0YysGWrA1U6nR5L/y7C5UxmY/uB0UBRxO/Svly3eRekQlnfHaJSe
	He8nYq/XRGQdlKUo8ARnUMWMI0JmirGXFGy1HsEfU7AJG90rz8jXThLWQs02HSM=
X-Google-Smtp-Source: AGHT+IFX/mnj8z/gOU4S/Qjsm2FR4qQxyCrhiZEmvGKW7LyZfNdC7JaX0Q3SxwF74ucLtHDokfAeBQ==
X-Received: by 2002:a17:907:1c19:b0:a6f:4fc8:2666 with SMTP id a640c23a62f3a-a7dc506ce86mr1394858366b.44.1723031898724;
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d45239sm631017466b.119.2024.08.07.04.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:58:18 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 07 Aug 2024 12:58:18 +0100
Subject: [PATCH v2 1/2] tty: serial: samsung_tty: drop unused argument to
 irq handlers
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-samsung-tty-cleanup-v2-1-1db5afc9d41b@linaro.org>
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

The 'irq' argument is not used in any of the callees, we can just drop
it and simplify the code.

No functional changes.

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index dc35eb77d2ef..1c6d0ffe5649 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -855,7 +855,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t s3c24xx_serial_rx_irq(int irq, void *dev_id)
+static irqreturn_t s3c24xx_serial_rx_irq(void *dev_id)
 {
 	struct s3c24xx_uart_port *ourport = dev_id;
 
@@ -928,7 +928,7 @@ static void s3c24xx_serial_tx_chars(struct s3c24xx_uart_port *ourport)
 		s3c24xx_serial_stop_tx(port);
 }
 
-static irqreturn_t s3c24xx_serial_tx_irq(int irq, void *id)
+static irqreturn_t s3c24xx_serial_tx_irq(void *id)
 {
 	struct s3c24xx_uart_port *ourport = id;
 	struct uart_port *port = &ourport->port;
@@ -950,11 +950,11 @@ static irqreturn_t s3c64xx_serial_handle_irq(int irq, void *id)
 	irqreturn_t ret = IRQ_HANDLED;
 
 	if (pend & S3C64XX_UINTM_RXD_MSK) {
-		ret = s3c24xx_serial_rx_irq(irq, id);
+		ret = s3c24xx_serial_rx_irq(id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_RXD_MSK);
 	}
 	if (pend & S3C64XX_UINTM_TXD_MSK) {
-		ret = s3c24xx_serial_tx_irq(irq, id);
+		ret = s3c24xx_serial_tx_irq(id);
 		wr_regl(port, S3C64XX_UINTP, S3C64XX_UINTM_TXD_MSK);
 	}
 	return ret;
@@ -971,11 +971,11 @@ static irqreturn_t apple_serial_handle_irq(int irq, void *id)
 	if (pend & (APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO)) {
 		wr_regl(port, S3C2410_UTRSTAT,
 			APPLE_S5L_UTRSTAT_RXTHRESH | APPLE_S5L_UTRSTAT_RXTO);
-		ret = s3c24xx_serial_rx_irq(irq, id);
+		ret = s3c24xx_serial_rx_irq(id);
 	}
 	if (pend & APPLE_S5L_UTRSTAT_TXTHRESH) {
 		wr_regl(port, S3C2410_UTRSTAT, APPLE_S5L_UTRSTAT_TXTHRESH);
-		ret = s3c24xx_serial_tx_irq(irq, id);
+		ret = s3c24xx_serial_tx_irq(id);
 	}
 
 	return ret;

-- 
2.46.0.rc2.264.g509ed76dc8-goog

