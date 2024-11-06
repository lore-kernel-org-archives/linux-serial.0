Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A456A1DF726
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894505; cv=none; b=GL3/OobF8APHYALy4mY//79mgfeCRfxggrChZcR4spgMiIIl60joEW7H474A4gVoKGpWemLY3krOgB8gasR0Dc64wgM4w5h5AmMq4lfHl/vLDxfZ1JI71T9yn3x8IDrNDPxhjjj0lQmXfGRbVXPsBnX4l1x6oKVpEBTbNtshizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894505; c=relaxed/simple;
	bh=gkZYPsH/vb3WY/1lIzQ8Dj4FgRmceTUwrzbmFMLCPH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mcixDfLkl5IQRIxmI/65u/RRpE952Szs3ceE/h0NVaU79EI8oE1Ul4GjC+AkPR+S5cxhzUCsYhdDH/gSXW4ZhFHKbwAfMCG/0Nwa9Fgxg2t3UHnhZ9pOJIhlJ3vsNkIvuPAiu8gO/JoNevbA8kjfGHIiiSW6UvnyeFVizHrn4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i6EBt7lA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i6EBt7lA"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so1433750a12.0
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2024 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894502; x=1731499302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTk49kg3sxHgDomjJGsue14cSnQ2z3PLgvI6znyFaQc=;
        b=i6EBt7lACXMMBbi5Okt4M1bwae2aWgrwLVTy06xOgSmOUy9IPLmAnBayrwEkDz7ti+
         m6Fn8OOb3z+s/WlLSscFh7J+MTBG/WMmKA6DfzbxLJWXEO0l/wz9WgYTPEMt/WKvLkAp
         FTQGlkI5czhRl1iOb79WgJOkfxBifDQrpou8T9A6ZzSP/BXEz+iDrUxW9kwfdl2CV9Pt
         z5bRSYOAmfW65k55uRi1E69Ynv7lTyNioLIEkV8qq2IW4l8alEwuJ6a9dKRi566NwcB5
         pvgFikqFs81bbqezshEylIXnbDOkJotcTCSyaIuhZ8EMMRheyhxYLdA08Bo15wA5v7BD
         axbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894502; x=1731499302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTk49kg3sxHgDomjJGsue14cSnQ2z3PLgvI6znyFaQc=;
        b=hqUsC8OXZIz8MBJxkRRFTdFmyCaBr0uC165mXElrFqyaJlfKADGG9Qdkyz5Hioba6O
         pjS36ylui1ez/27/OQKWZ9CsoghiwYesoQLorpCmZmYIv53MU7sC8WhPH2gwIAiVfgYq
         8ly4Os9N/P4Arm/msDJwQMYQ6P7uJAHneJxuhIA6mPW1eOYq326CmBxSwpL6wg//jBuI
         saJBHI6dznrHTLr/wcnslbM7sDuA3GnCNDcISQzHaYiz9g08P2KCNZliq5nX6nCTe6C6
         veor1riez9tl5lA6vUd+tcDIBl2EPxSyKU21ivFNW9qssS4rJiuk5uY5wKelxlM+OvzE
         y9gg==
X-Forwarded-Encrypted: i=1; AJvYcCWE5WiFiEqZ+DUriVclwjxIXGEar62Upz1xVwl0jV0Y3sLzFji424dgABj5mLAzTqBQ7dD/ZOXa1A7/yVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8v4MC+RNIyNx68qqXUia0d7E6NYoIKpYmIswRr3b1BPsMEWwG
	U/FXjLmqF5PHvUZKJFB40Q8FYX9Yg6VKuR1+z+1b+jQrMjCcySLfm8QrBi8tGh0=
X-Google-Smtp-Source: AGHT+IGsGf47lgcF/WyQLx8YrH90sARYpGTUy3Y4l7vmameX6vDncBFwbLkpZsYyaEeHNlLQDhUJbQ==
X-Received: by 2002:a05:6402:5383:b0:5ce:c940:5182 with SMTP id 4fb4d7f45d1cf-5cef54d1a82mr2310638a12.11.1730894501685;
        Wed, 06 Nov 2024 04:01:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de,
	ysato@users.sourceforge.jp,
	ulrich.hecht+renesas@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6/9] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Wed,  6 Nov 2024 14:01:15 +0200
Message-Id: <20241106120118.1719888-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241106120118.1719888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The debug serial of the RZ/G3S is SCIF0 which is routed on the Renesas
RZ SMARC Carrier II board on the SER3_UART. Use serial3 alias for it for
better hardware description. Along with it, the chosen properties were
moved to the device tree corresponding to the RZ SMARC Carrier II board.

Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
Fixes: d1ae4200bb26 ("arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 -----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi     | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 2ed01d391554..55c72c8a0735 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -43,11 +43,6 @@ aliases {
 #endif
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 4509151344c4..33b9873b225a 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,10 +12,15 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
-		serial0 = &scif0;
+		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial3:115200n8";
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
-- 
2.39.2

