Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC9D3196D7
	for <linux-serial@vger.kernel.org>; Wed,  2 Jul 2025 18:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481575; cv=none; b=hxfJI2eFRdJKRkn1RnUFzc5zhqFONcZ3AgZYd6roCfLG3PNXW8y0YBFnKcdqhnB2xRWQFsM7RUwFfkuIJgQ7HDD421z63/Wk7X8a5rbnyinC1yTKqMwpCNIl82mTc2gYZA7bUKJ/y/N7moDAT6p4mqg/VUpnlH6oaNPwci0/RgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481575; c=relaxed/simple;
	bh=AC1ZGqepD8ba3vU9mbjs5GP1sS+hEoxO5U/tJ71XQ34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M51WXY6aZEw3+s1rTfNSpNFy7+P4azlRwxu0FGuSuWhQ+jBxeKYa308XcOZoSx1pIHHES8Yqr2bqXNqPSIqaMp6phUqC2WZGkmeEFG2WbHZrvZdLYcUrpeBiTq9p7Dwnu+NdcAM3XJ4gPcitE/8+WHdTYgyJwzoOPcjoGrnFDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Iz6hrVm7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Iz6hrVm7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2366e5e4dbaso1438805ad.1
        for <linux-serial@vger.kernel.org>; Wed, 02 Jul 2025 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1751481573; x=1752086373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvUZO7FvlWPW+SQ9YyArMTwQthW4Z2c8jZOVUNIjFN4=;
        b=Iz6hrVm7SFHDkNjapMU+73vWNMofHdkdJj/sac4I0iSABrshZYejXx7utVEKFAKh4i
         z9h+1ruz8HXmfCjyar+wP3Hbdaterm2s6cj/2cTU243YooXcUaHKKXA0ZoAGizfdTkgB
         ZFPwykC038hJhLRviJjhCHyZ1xqpOO7x76jDdNrNX4mSf1JMhc/x0iQ7xQm2b3MqOR5x
         Bftp4lE6DX0BP9ouVdYAU4WuAxnQuQxFN8AyAjl/jDLPGrXzUji4rPhajPWPa/Bo/3/l
         MEPXOxuPkkZbUbFm6f2AOUyOLyO+k+dktFZoVeCw1NfS7qTJ/+LgEGjIVtT/dhWFC+t5
         gbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751481573; x=1752086373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvUZO7FvlWPW+SQ9YyArMTwQthW4Z2c8jZOVUNIjFN4=;
        b=EVo0Oso/d2+IIdJSJ4EEWRDOIaT6rREbi3CdySH9wKy+yfHtP5cyLA2l6snmejzqIZ
         +OiaCvZRZuOIMb5UBRjiNFGGehOOO7dUDlq+59Ej+TMx4LsmbXlTaUbVOYzyKWl6iXeT
         6z9h+gVSEGU9ZCBEdyB4QBg2XBFt8M2iV1ko/hRvZwpKW3EcxiUnkUwGFrSUzibuOk5y
         PdxiCVoOuSS1zlKN21jpBX1sZ4834ntmfgarSVI0g+xRG3Iz7p2NOnDpC5D3mICQ4P9/
         Jgk8LjwW2oAB21UBXuQEFCnMc0Y9j5ZAZ4yrp5Wf/5lGEblFe3jGO/bnDtrKd+pdxon7
         83wg==
X-Forwarded-Encrypted: i=1; AJvYcCVEYpdZaWJuDIMKNsAeJKtPdo+vYg78urZ1S9kal1xeTE6kU+1/AWrW42ZOKQAA2fdks4XjJUQDX4aNakk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNoBgOMg8m9VYxcN5r4JBD3aQjpYJWrc4dfRbwAzllFE62DnCy
	VL0CZNJOgEvPRwBDDh4gq5IeIJN2E1jh5Qoa+5fHa9ZfQuo+IZBBvmme7xfsERq7mjo=
X-Gm-Gg: ASbGncs6lnbmGIF9oQrujSP50h6GcT6kkwLEPKnagV26uaOEeI3HLeSX7XfS7T/pZ39
	Wp1che5Nj8i6MauefMLHBWMOk3lxk8ny3xQW6PWcodUUiYwkW/JwNUQ0lqlA9EI/ozoQJtzshP8
	ZOgOht14rVpwkFUMEqTLRyW4grMiqTvkKdBshjw/4SlkyjD15VKb5HjJMe0VckIGXecLPQvXrUj
	FeLY0t2dmG2CX1scT4M9HiKHJQkUTr4vdLdy3itkbsghCa12hjdczQr3z98h38L53RtMvAPfvUD
	JioA4jRI04bsLsO8aymrxH5pGNBbEpG2mvhYApbVixlUtWxYxQU8x7ygwqJjEH6okowJoTkwJSX
	cBdXxw/naNOGv0wPzE0wOn7Y=
X-Google-Smtp-Source: AGHT+IHgAEOa6mf+31gGe4dh9PyI8zLR+UZCgE3uY8g7x79OUwcJ315/76XmuML+S/JTyWRQqdR46Q==
X-Received: by 2002:a17:902:f68b:b0:234:adce:3eb8 with SMTP id d9443c01a7336-23c793c0f84mr9871445ad.12.1751481572766;
        Wed, 02 Jul 2025 11:39:32 -0700 (PDT)
Received: from fedora (cpe-94-253-164-144.zg.cable.xnet.hr. [94.253.164.144])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23acb2f39bdsm143034195ad.80.2025.07.02.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 11:39:32 -0700 (PDT)
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
Subject: [PATCH v8 03/10] arm64: lan969x: Add support for Microchip LAN969x SoC
Date: Wed,  2 Jul 2025 20:36:01 +0200
Message-ID: <20250702183856.1727275-4-robert.marko@sartura.hr>
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

This adds support for the Microchip LAN969x ARMv8-based SoC switch family.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v8:
* Place LAN969x under ARCH_MICROCHIP as suggested by Arnd and drop review
tags due to this

 arch/arm64/Kconfig.platforms | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index f2d5d7af89bf..083e9815259c 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -165,6 +165,20 @@ menuconfig ARCH_MICROCHIP
 
 if ARCH_MICROCHIP
 
+config ARCH_LAN969X
+	bool "Microchip LAN969X SoC family"
+	select PINCTRL
+	select DW_APB_TIMER_OF
+	help
+	  This enables support for the Microchip LAN969X ARMv8-based
+	  SoC family of TSN-capable gigabit switches.
+
+	  The LAN969X Ethernet switch family provides a rich set of
+	  switching features such as advanced TCAM-based VLAN and QoS
+	  processing enabling delivery of differentiated services, and
+	  security through TCAM-based frame processing using versatile
+	  content aware processor (VCAP).
+
 config ARCH_SPARX5
 	bool "Microchip Sparx5 SoC family"
 	select PINCTRL
-- 
2.50.0

