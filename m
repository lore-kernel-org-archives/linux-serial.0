Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9825E301121
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481568; cv=none; b=hbqKfRfAnGwKqeS82MttgCOcP+GhImWWghQyxZlI4m1AquSZRrmZMlQ5C5zA7a3mDhEp1RH9XVs5R5UnR1ZRfRRZWhdLD23ytUH8nJ9mx5EK+YAtTfnJF3ttHM/dPpttRVxG6ZJd6FP8cDG0BbHWihNR0kG/a2ZSDVY/FhPjrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481568; c=relaxed/simple;
	bh=pWc/eD8EhDRsDdlnhyulEE6WLssNw7EFTkXiniULJX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9nbSBFCGBaVxgC3beHUTtH5YgJQWH1cDqOxqxK4VhmlESKHb5Hx8rcCgpgqkrIPGJBTezO0qsqtZp156sZRV9LKnTOFBJ/9JxvSqX8cikAL206uTEmox9HIGiCgQuIx26f7aJODPyb0D5dmpEriTLnCfmg0fyAX7W4zaQFk+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=GhLtnOfv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="GhLtnOfv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235d6de331fso62050075ad.3
        for <linux-serial@vger.kernel.org>; Wed, 02 Jul 2025 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481566; x=1752086366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZyb0UMcbDIGOtSibbw+mdySBJCf7k9AVSTNZQQyRng=;
        b=GhLtnOfvNZLfbHR5QS+Vwm1vvaC+govuXOeE92Xd2wE32ADB1kD1rvcM662lwzHbC8
         Y76IljoRQYOoGp1vtFSBR5saKfQFJZuQ0t/YLBgGKGrlHdGWT8Ex1JTdIweJfXHDBLXu
         ntK7ktCyGWjYmkleXtsGQvvL5E06SOD8dw171T0JkWKzievyYLwRYKT4zr8M+Wdx7uiz
         wuv4Yi45xw8tlpHPoIOoi1raEyfn1rnVqymHt6caR3F4uH2h3o7iQLCxqgx6XqI4Qi5F
         S92xP1MEA884K2SySSyPsb3mvKWo2Jo/WgFG7NO+8VajzDCjzqCwDWJorr7ePoCIh1iC
         M6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481566; x=1752086366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZyb0UMcbDIGOtSibbw+mdySBJCf7k9AVSTNZQQyRng=;
        b=Q67XUdL5kKwkGlS5dOuthNwE/aoNexvOgirPuHOmJB1w7ZNwZaraJbcm7nkiFRDjvx
         eYC/MQrFqcqWAygklK0xUvFVhAxFldcoGKJTHa9Y+VPt1/yV2DpXqeCQo3dBydBkIZ/2
         H0e7hb1DdiDCidEtjgBxeewjTX1c1CUE2TyyH6Rcm8tz9TSYArwdzMcQS4ZGyu8RmH6D
         MkaSBAAmJCko5JPFIQrt7QyRiDmiD1ngcgI/SYoMJFISk4pLInr6ZyNc9KC3aMV/wAM1
         ij8hLlEd0qaYfnEPIQmkYPez72B27Su2mmQgHX1mPbB5c8rFXaDkWLbFGYEOiKfBqYP+
         U9Sw==
X-Forwarded-Encrypted: i=1; AJvYcCW8tjpsaTAZA+LR7f9trnp3OkJLhNgHyCI6Tgb1mXO2Pf4rBpSaO/nYyViCaQsULmfdVtT3V0L0kNE643g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5v7CT2J2gO7H/N+aZfxyyl7dLabuVwanaASmNy9egvdoL9eV4
	NS6lsYPTMs/4NPTHL46QeJnjqBt6OHFjdOZS6MniredDMYk3BYbs/6FgcNexsv9g7OA=
X-Gm-Gg: ASbGncsk7BNz+ZnVMZmWIjmJ0D2Cx5G7OGakg+vd1eqx20FIFN4cEGgSxLsYJb8cfkN
	MjPM8ci5UDrNeywKUz3sjMj2+96VBufl24hPvh70J0Kvz9SMt6yG86UXFYgrUCc9N8WOzD3PKPm
	btVCa7N3cD86kmnFBFKWo0yiDnCsT0WLDJI+VDPipuBJS2O/rMvX17+dcq9vMIVupu9nDbnt0fw
	LqHGRhxQ4lLtPb/TjsdfravPwuaP12feQQMRBJiywHSCqI249C0qivy2YNFFrGgaelUmRj0D++w
	om6CVQ3Tqm2ugfxtQx9HTskubEuVCbSuNhw2WCewXAUjZaoS80AngQck2XJPLoUYCXVyQ/CMUOO
	fXQhFeyh20v6L00JmBz3A6NU=
X-Google-Smtp-Source: AGHT+IHRiK65iyeejNhxV2BsQ0zei81m23wsBqj5xXwWoUN5V5PxEC+r38Kfp0CXgbxe6/9g9H5UFg==
X-Received: by 2002:a17:903:46cf:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23c79692071mr5155225ad.29.1751481565983;
        Wed, 02 Jul 2025 11:39:25 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:25 -0700 (PDT)
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
Subject: [PATCH v8 02/10] ARM: at91: select ARCH_MICROCHIP
Date: Wed,  2 Jul 2025 20:36:00 +0200
Message-ID: <20250702183856.1727275-3-robert.marko@sartura.hr>
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

Like with the ARM64 Microchip platforms, lets add a generic ARCH_MICROCHIP
symbol and select it so that drivers that are reused for multiple product
generation or lines, can just depend on it instead of adding each SoC
symbol as their dependencies.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-at91/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 04bd91c72521..c5ef27e3cd8f 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config ARCH_MICROCHIP
+	bool
+
 menuconfig ARCH_AT91
 	bool "AT91/Microchip SoCs"
 	depends on (CPU_LITTLE_ENDIAN && (ARCH_MULTI_V4T || ARCH_MULTI_V5)) || \
@@ -8,6 +11,7 @@ menuconfig ARCH_AT91
 	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
+	select ARCH_MICROCHIP
 
 if ARCH_AT91
 config SOC_SAMV7
-- 
2.50.0

