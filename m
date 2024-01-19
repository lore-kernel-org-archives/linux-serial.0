Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748494E1B3
	for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661142; cv=none; b=oG0pM4zGfYeQxwKxz5tOzcVk4Nink/DSTNXVO3U+gDOGd/7c41bqU2jDpwDoTpiC2oQv77/afHKt93aPMwy1QGH3PBesPgX1ij2khXVv5O/Zb4cMhpcZOMsrGcyQ2MK05M9IUCJ6p56k283+6MOdA3FkNY95eJscpGY86EXVEuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661142; c=relaxed/simple;
	bh=w6W+mfvaxX1qFMEdiY1DtchDNaqFiT36ojS9y1tEpzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aj1UDfOMlRAa18WNnQWSZgkEwL1ltUaOJL2li28lCcVG3o2wI5nwTZ02szgCoVLOwu3pai+MLvmwEfwV9ZYEQPSffcfWiKEVGnv5Byv08ddj5OYF+9lVeVoW9ameCQ5F3quxlsYoXBmQgsVQMD7gR9KXBL7k0vOP4xWFqNz+mR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+yKEpQd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+yKEpQd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e8f710d44so7714245e9.3
        for <linux-serial@vger.kernel.org>; Fri, 19 Jan 2024 02:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705661139; x=1706265939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TK/43wqdGd1BmSd/bcLv2LcMLavutkwolM8oqYB4bwI=;
        b=L+yKEpQdS/UE25TzH8KXjGQObZ4H0bxPpDFImzAgowc3hb6Z38fciOPQPAp3Zg00NL
         KuWSLq1NIQey0E0wfdvMD5bzxoiqO/1ZdkMfVNdIwB4y6OvKBMdVY/CH9N4EII+choCp
         PwQcuKqBNuG+yDY6KyoHgaoEJZr3m02AaBJANwZrC2NDY93IjJYjFcc9nZixUc2dB0ai
         AH88232GQrAj5cEdOYyKlpbQiem7M10k11Aw1bQZQpDEUVWj0ZoHpC0t5VvQDFPdn8RH
         QECh9FyJ4mxb+PQD5u4y8dTRprxT3i9Uakt0P2vMXuUeXyluzJ4RUUoioQyK7hOUch2n
         YV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705661139; x=1706265939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TK/43wqdGd1BmSd/bcLv2LcMLavutkwolM8oqYB4bwI=;
        b=rgRUQ9wkIiePTtVUs/aCOAEzQoF+EcmRRgudbXwDBJ4a6mQJv+aahdGeugeMjt4aXq
         /seV3RazYyFoqxRAEqc76iQxMw0duF74u8QJP6QbhdfInZvQe+gsNpgaCMj5Hw73fSCA
         B2lvyV9HVR33OtFQ7sgZN3m3LSTkcJw6d2QajsF3CTfBGBPategp5zO4DiF/hT6k7n7B
         FniQAVx7WyiIX4Gbe9aJ8LDmss3G5yJfOYEzt29vXQb4qQSTJxlYz+oLlLCGQjiBFTzu
         jNpo7acyhmRFHcC7A/c5ur0bBtKILHMCxNoPxnN20odS3+v5ATpewIv96z4egXTGQRXW
         yW8g==
X-Gm-Message-State: AOJu0YzVJza/EPyxtr0vtjL2LmAImOiP6t/hhLhhvUTxo+QisynXWkpy
	dO6FSJWqFytaH/e3LTfVuJQV1lDY88EHmYIg2tCTPKfLK6ovWCCDhJQ0nzC9TRc=
X-Google-Smtp-Source: AGHT+IEpbFblD8CYjgh0LghRYa+vNw+y1xW37yAzYgWrkcD5AoaCq81PCOmFUQXU5s/jy/U6ZLo7Fw==
X-Received: by 2002:a05:600c:2205:b0:40e:3f09:78b7 with SMTP id z5-20020a05600c220500b0040e3f0978b7mr1187949wml.128.1705661138872;
        Fri, 19 Jan 2024 02:45:38 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b0040ea10178f3sm77470wmb.21.2024.01.19.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 02:45:38 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 10/19] tty: serial: samsung: move open brace '{' on the next line
Date: Fri, 19 Jan 2024 10:45:17 +0000
Message-ID: <20240119104526.1221243-11-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
References: <20240119104526.1221243-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move open brace '{' following function definition on the next line.

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 303b67498c65..b6d34c9f46ea 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1739,7 +1739,8 @@ static struct uart_driver s3c24xx_uart_drv = {
 
 static struct s3c24xx_uart_port s3c24xx_serial_ports[UART_NR];
 
-static void s3c24xx_serial_init_port_default(int index) {
+static void s3c24xx_serial_init_port_default(int index)
+{
 	struct uart_port *port = &s3c24xx_serial_ports[index].port;
 
 	spin_lock_init(&port->lock);
-- 
2.43.0.429.g432eaa2c6b-goog

