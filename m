Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372D1CFA9
	for <linux-serial@vger.kernel.org>; Tue,  6 Aug 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958200; cv=none; b=RKFW3WrcDcm1uYFqYPLu9uxz1XKeMZZakwCEVgW0gCx/jWMvW3SGwME1ZK8PbyRbsXlwGQt9jcmhUU4Fn2Lac8q3G3tdLgxEtrfY+QMd2UegiOl6r0hdQdvESXnOkK/5ZAQghniH5eyTtxGdt531PuuFN9etwG/onU47Ha9vRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958200; c=relaxed/simple;
	bh=bPeZihTCF+Ow/O7uL47gsdFVGSiVkl8vSkFqcaDBcF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQkJogb4WPZQg+PeBeidbESRTwpbbAe8XZKxy8zdzm3bnKKAvSRgQ2mdKS393ZUQv6/hKHBim7JPfBxy9Hh3/H/CQ/gGg0PPeOe6nk0Jh4/IdP2qX+m1VyYDNt8JjXh+XvaWgV7GxXSDNNhwfmjCkYyWlXmfl/bCL533MO+lvJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FHho+nBb; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHho+nBb"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so1425083e87.0
        for <linux-serial@vger.kernel.org>; Tue, 06 Aug 2024 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722958196; x=1723562996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk2Awb+sGDAUp2fed+2uqRPu8RHHDA4mh3PcSw6gyEg=;
        b=FHho+nBbmIvVErziWtqg1ezzjYrPDFztv2R1cezhc4jRqjKO510g0JZE2akgrISH04
         Tc7zVLSv/oGHkwrxNpQ8j8vcxV+OOhjsbJZX3QHzdSI8Pr9PLZJlkZQu3V09Y6qrWNkJ
         SskT2xzdrTKyv9dsHg0ZTsV+FS7g/6TJjf3XDlBN8xHgj88wZSgogUF7CQE+DhGlteS6
         zhMc2HZpdiOy0EDr9h/gRuXxuEDg+OmtPvjAVGkVWcgLMZRcHvu5c4nSLILPu8HjD6UK
         pn0sNUFtVgIajWG7y4dGxoT3i+2hz/rZa1N46MWkNP54I90smA6yX7kev0LKfu1iEkyf
         6cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958196; x=1723562996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rk2Awb+sGDAUp2fed+2uqRPu8RHHDA4mh3PcSw6gyEg=;
        b=UwsvfnYoxMUHZDMsCin5VrlRv4TMfq15aU09CXKjZ8lAVOaCvsV4R++kI+IkJh+Lcy
         h1iMESt244oH4FwxYoCO7wrFv7VThr3YUGa7v0O4lHGES9WryGAWGxFAGb+rQGshu+Yj
         dCqK/R/a/AWZoDvFloRvPM2aVaSxSdfbZZOol6Z7FJDRWGbXN9+jEOwPLlwSTieLjfz7
         wWI1oJHPIA5wyxhcnPCRdtGLHi8T1jL/fMru9TS5qiopOhkeEmYIduOFYnFxxiNbthOu
         xNsySJbVTmPV85UuLNjM9ttFzmrfKCqAN/jaY/BP4OXdnobSXyOOb+vFskw99VMlJfJv
         B6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWwV3roBmwg0pvecNaHDRfmbOJhsvGryfizzsvPstkwqCjF5XDSj8nRirhKAHFsuAV/hkaOIAA9jVvug4mPYhXvdDaErB90VUTz1H3
X-Gm-Message-State: AOJu0YyF177fqM2ePytFa00nOe2zhM40q1zqI7Gy5eWoFNFLIiyLI+c1
	ls8+GcrAlxoha/44Ic5poJu760i8ZGznY9MamlppfifyDReuxvpX2a5pHXyZIvw=
X-Google-Smtp-Source: AGHT+IEzRSe9RZ8IZ7a79GIk6K9Ld7GIQxp37hHU2EYAuNypM9NuHuI6ejLRItdRTqLiJvXepFVECQ==
X-Received: by 2002:ac2:4c88:0:b0:530:bbe7:4db3 with SMTP id 2adb3069b0e04-530bbe74f4cmr7491016e87.39.1722958196387;
        Tue, 06 Aug 2024 08:29:56 -0700 (PDT)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d4294fsm555274266b.103.2024.08.06.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:29:56 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 06 Aug 2024 16:29:45 +0100
Subject: [PATCH 1/2] tty: serial: samsung_tty: drop unused argument to irq
 handlers
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240806-samsung-tty-cleanup-v1-1-a68d3abf31fe@linaro.org>
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

The 'irq' argument is not used in any of the callees, we can just drop
it and simplify the code.

No functional changes.

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

