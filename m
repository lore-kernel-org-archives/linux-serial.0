Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3321FFC46
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481588; cv=none; b=k+IZ9Pm3VEEgnckWp1dfrUmWDs4aveAfZAubvvI6oUZZuMvjOsHpfc1EHHh1HHVXRKliz57dPl809Jzy0aTMCypoSgWsUVXPW6fWXHf0ZpsnB2TSaTuRTZ+ta0Va8Ylnnaj9SnT8UbAVsUckas1nWcYn9m0rT/WUrcCEAUmHhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481588; c=relaxed/simple;
	bh=fqtQu82ipUIUs/6YYFaGB1bjUo7+49dZ1md5F4GSAkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZoPYPrLYnyjHe2lKNno5fs2MQ6baAEO3Fm2RlFaWPYMtv7I+xZGAg8i3LZyDT9YmnItKs5JaDnq15GUr7eg8y2yv1HtfszfrDAEtwCZ8yXh3tt8aF04tUeQbafk6O5e4mvdX7G5MCLLbucpVN7O+nPWJGHCJG6VIpi+cojnN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=g0arqI0K; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="g0arqI0K"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23aeac7d77aso44415275ad.3
        for <linux-serial@vger.kernel.org>; Wed, 02 Jul 2025 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481586; x=1752086386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TuxtJxy63LOFr6I+EVcVxkshFZijc4sL8n+d8Zo9F1M=;
        b=g0arqI0K1V691fmhoa1EpltuXizcKRN1OyRP/KBM9ZRaX3YOBMI2zKAXJBhzFCzFhr
         WO5N0jssLXPmXbMOTIqqSK4UR86LOs9Lvpwr0TI7NuUmc0mOBXauNhtpN2ETK4CD1lu6
         vHCCYjQEx9t+yzl5HHHPaCw/mMOXwWTWyhZI27LmKtZbH+sB0EVm4ADZgkZAvowb6C7W
         heZ20gkCblgO9MVTm2qDDlEhTr5CrEjSfKv/2gM+HkDqKN6jGGtcJTU67nkCErRdbPtm
         BlJg7ocObuis82DQPPPxJPXOZRdhlMIQ1KHKE7UM983B+sJRelc9NPnF3/13ajETdV7n
         e+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481586; x=1752086386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TuxtJxy63LOFr6I+EVcVxkshFZijc4sL8n+d8Zo9F1M=;
        b=q2+/16auYFLqPfEdi/+VpXrGu0OSvpNH/6IbxmG4prsq+wkoh7tM3YPLzdcDoZIFFQ
         MJhIAE2rMJ2o8x06iaafQLkGnwHYVHuI4RzOKfJwINxA+bn/7JRaj3M+3uvZmxzTEtK7
         WqJXnknIEoLBT9bMypHxLHQ1Goja23lPvi0ecCV29AeD1h41qiH7HWJGJYmjFd2ec3nW
         8qvASNBbdLxQIEKRpYz4E8I3UDxtD6Tu1LMYv9zcodsXXdjP5jmqz7eJKUvttoyEn6NJ
         ZlcXxg+Y5PDeJW9//I7o7DO8HiUngFNqdpH83i7o//14HbYwHc4q3durImAmYToYF/JP
         hiIw==
X-Forwarded-Encrypted: i=1; AJvYcCWItR1tNPk5pmRq0Nbb0sSZtN0Juows39rf/YgiQNkvczoa7nB/HQSiSjPb9liayFRdGCB3TDMboudW6EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE49Mins/mh55N1WWlXh973e2wS4+yb8WblysOEbL8RZNNaE3u
	pYK4t8HLRhqyamm1SUo9NK1iS2Y87Y4ImmIt2PdZXEbABrg8LetdAe+er3oR93DdCHQ=
X-Gm-Gg: ASbGnctl5bPLYk21NcDeMTNtIxIYk/8nYiuIkIIwAX3PRGtKAQeD5St6WHO5nQIzWl0
	9JwaTXwXz8XXmpENAMCRPHEpXc4L0+aSTVhNPlIT/XLXv+tvGoGjVYBSeSdVDUKPJpbPeK/o8Yi
	VU4OjUPjBYHm71yE9PxhoWJr3zkWY6wZ5MyP1DEuI8dZEX1OYTpFnW5u/i/EjWpIPjKyx8jch4L
	JCl28Q7BJgokHlFH7XxdFQXH994yfya17a9/UXqZFIuiT3R5136Z+eTwxFnGoenNSUzzmfbL2oS
	BCnVRXghXwDmLZNqEplXIGQVGr+Voc5/GAAL+E81P+i72m5ub/yx8dOKz3mT1NiMuD0fIl9YLjd
	I62/5AKBbsroB+QOrL8SCZZY=
X-Google-Smtp-Source: AGHT+IFtjc9wQbx0mnTEIHCa/COpi03QJubyVPHdKqzZsjHI9di0hrmvji1zsNLaFfpKOtfqcICExA==
X-Received: by 2002:a17:903:40d1:b0:234:9375:e07c with SMTP id d9443c01a7336-23c6e558b2fmr47599345ad.46.1751481586359;
        Wed, 02 Jul 2025 11:39:46 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:45 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: linux@armlinux.org.uk,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	catalin.marinas@arm.com,
	will@kernel.org,
	olivia@selenic.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	arnd@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	o.rempel@pengutronix.de,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v8 05/10] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:03 +0200
Message-ID: <20250702183856.1727275-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250702183856.1727275-1-robert.marko@sartura.hr>
References: <20250702183856.1727275-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the Atmel USART serial, so make it selectable for
ARCH_MICROCHIP to avoid needing to update depends in future if other
Microchip SoC-s use it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 79a8186d3361..c33fc6f16d31 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -128,7 +128,7 @@ config SERIAL_SB1250_DUART_CONSOLE
 config SERIAL_ATMEL
 	bool "AT91 on-chip serial port support"
 	depends on COMMON_CLK
-	depends on ARCH_AT91 || ARCH_LAN969X || COMPILE_TEST
+	depends on ARCH_MICROCHIP || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
 	select MFD_AT91_USART
-- 
2.50.0

