Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE671E2316
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060340; cv=none; b=fjLbTrfEC3y7BRAXMg2ndjRaO+yf5PA65GaaE/8FibFChgpTIBJEOoCscY9NypoH0ailss/80oVnVuaTnbeWkXAES9YB4s7OiY1U2X+VsjSRg3LUSTZfeW+UptCMa0Ezs3pQWKpCJ9NjFDr2hQdhQwIWtkpBG6SlLroa45kt798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060340; c=relaxed/simple;
	bh=aVeWIhV+EQgINF/dzLhLAY+zJ+kL2qc72LUlFGQF1ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfK+gWehQCsNAAXinQOnjFhr2aNxgeTGSCaRBp7B+pu8ESAVGZ2A5iFItcfk1lGFq6zCLE74fTaxyIig7vIjFlJhD41QV0NSRLxLQFs8KAIKiKh1Hld/OAjSduFV7AA7cqX82XlRprONSyXOHJPADl869Ynwl1Z+ptQEXeo0mJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=WdeJYyzM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="WdeJYyzM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so1167636a12.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 02:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060336; x=1731665136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cwCXjU0n2G3z+UZFHjOKDveE8Cms1D3rG5Gj4FG1Ng=;
        b=WdeJYyzMfDHB3RNFOPzCwN0kvYWctAD+e+egwAkKdcVoQGp4bGaclcKgF6LmRXvL6x
         2I4H6IcFsg/sWrEYRy3PyoGTOIzIZIW2pXiR9+iTt5r0pGfst+mH0Pzd8XEmgfXZJpR7
         vJvMRX5Hi4+eKVYmIkUCoXNs1MvFSPCA8rwQfKjx33yZBKfYYyHI2ONsEslk4qyfdx16
         n8Xa21JN15Z8NpWpByR0EemOy6eVAe5iLaQU2XSTR9xy7XK0G0StM8+VeWxIsvfI3WOZ
         HXq1yNhagdZL4GUmzVBgFXApLdJBgmoYuHirp80o0sS4pSIF71fAamV8ibGx25PL4J0m
         iCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060336; x=1731665136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cwCXjU0n2G3z+UZFHjOKDveE8Cms1D3rG5Gj4FG1Ng=;
        b=aNTwSK7bNIbq4ruBV5tNWm2kVUGCnTcNdY2VP5Uw8u31mkUpQG9Fft+X4SNAl248OM
         EXvqtRgtLboOm6QlpzOpTAmtpQ5i8lt1/xl371NMIpEx2wD8LEp7vCjnDI0Bz88m4+Ge
         ufVgS9Szz8Rjdf5722hmEnApgJa5sccUuhswxTwzM2HCQHkO4GSQk3PcOtfFUpQr5KhI
         UMpH2W51e6gDVQXg9o4TszxHqd0fDBEfWw93weSI8iCk5Ec/kAFAWwgdjioVmno1sgXH
         XA839ocJJM7hdxV0vZJ4wy7U4/Dw0gDYoQEMVroOMrL784dGQXTXB069ezeClNBiaE46
         zZNw==
X-Forwarded-Encrypted: i=1; AJvYcCXAmJh6mm4CmRu4fDyZmz1HMyCMPZAcLUcTtI25A4yqvupTWkxwUn0SYcnEuNfGXw6oeCCakS9aMP9klEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzalE7yd/msBN9yYCOs6LHU3/tDxXG/asaOyFYaG0Rm78h0yJJ
	d97ePDgQhaZSNV1MFVZ2E71WZMaBwbyo+VT30tGiA2GsVb9zGNNaBcN9xR+EGhA=
X-Google-Smtp-Source: AGHT+IEhAY36VlwWizUIHL2fn1f9dEMQ6HoqJ2ZC+QNZ3eCzorNxh6EUQp5eUYFZp0uhHTBZAdJVUQ==
X-Received: by 2002:a50:9f89:0:b0:5cf:11cc:91d3 with SMTP id 4fb4d7f45d1cf-5cf11cc9357mr775907a12.9.1731060336107;
        Fri, 08 Nov 2024 02:05:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:35 -0800 (PST)
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
	g.liakhovetski@gmx.de,
	lethal@linux-sh.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 5/8] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Fri,  8 Nov 2024 12:05:10 +0200
Message-Id: <20241108100513.2814957-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241108100513.2814957-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v2:
- none

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

