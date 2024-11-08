Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E81E2305
	for <linux-serial@vger.kernel.org>; Fri,  8 Nov 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731060337; cv=none; b=bOK3WiCQf6AjNIK/ZG3L5wtyuTsbxsrMhnPB2E5Hqc8j6Ym7hObad80gPDcGHhpSKtwPEARBm5++U7zIpFy0y2FmpKT2Pc46e1PEBc7WurrqQoQrJwNZwBLMEBLf4KwXMKdF099GJEuZfkT+GgAKA8eKDKCP+M2XYqEPIthWXgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731060337; c=relaxed/simple;
	bh=WXOaEI6jufTbI6EahyD1h2aSZrThHJ9yPxKkqRHlgyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/aUQq23HLs4i6ki6u36pqj0RlwOn4o5P/kfzYRJ1Rz+qvNrerrGvDx029xpA5vCeajz48f1lqyxnsrobkFlpT3k8PCeG89VaROWsamCAsa1BIwqdjUgGmEu/590GMYj+JdnF7Si7K4589+1CuIGJ0odJal8p0TUKnEByq/J9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hTiOVqdB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hTiOVqdB"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso2822634a12.2
        for <linux-serial@vger.kernel.org>; Fri, 08 Nov 2024 02:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731060334; x=1731665134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s1WjmrDgsXQD1fDWfFv2WZnub8z80SBG2S1+jyXmdw=;
        b=hTiOVqdBHei5Bnb9TX1dmXmKGXRu5L3oPpIF+O8E3N/vVqW0+Nm6IeT6x6GAL5MgAf
         bnyBGEJRmLmAVQTjBM1eg2J1xMpO78ewWAOo6LaRecibfCehh1i6nnS60yjIZgs3zQkD
         tvP3G4vny4czVrwud4bBqdQNoVxruwr9BmJGcpqqxlMMsLfXpZ4xEFLZJ5dcdKyMlU5f
         HM0Z6nHLQep0L/zEGfbZ/U9Y44cm9YH5oe/+G7mGI4p+X2m4dYr2tkDsupmzkozE+R2H
         8t/jxw94zLlQ3QOf9I1Z/xlkQX+lK78RpgrsordzrAvni1bgS9ti0v0jToD5gvUCQdw1
         5YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731060334; x=1731665134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s1WjmrDgsXQD1fDWfFv2WZnub8z80SBG2S1+jyXmdw=;
        b=uEloLBhc+kFQcfq7neJWAoSJnvD7oK31wF2ujbGyyTnpKhDVd9MaavXxYpxN1PBJRC
         6PZ7ikEW841af9bDHJvahTKuxzm2HzuG6Pw2jIjraF9/8v1BO3cxq/5F1/nU4MmTE7ac
         Q1uJ/MNaCoBJCOGqtii/stiM8JofXLoH62qSXcXWf13J+qdHKVlSId3NonH9HVmMdRGn
         tm/VIdK1gZ6N0+m/FXaL7lwO7hbK5V+HA3YAqW+Zj/2liihoOXVl6EaZFC2jCdSG3kFQ
         xx/YOuRCDErq65vVL2Nr/9MkaEGoHf+bOiRotRG3MI7vc8YJdPS8wsPhSJlO8Jx/mbwO
         6QcA==
X-Forwarded-Encrypted: i=1; AJvYcCVuop2Ou3Q073BItLQqzAoyUz5qJ3uJri1GIugytZ8kBFifA7ddznNclyd0wAT0ao/h1+TBe6XPtfJL6Hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN8OcZA3NMoOU40BzPxeny3QMPDDo3JppLeEugSrCNOi/zuD4q
	S0DHveVRoao9sT2tfRH9zQt5rqpoZEatVdW+GEYdY7yg41u8nFm5FqyKIp0tA9Q=
X-Google-Smtp-Source: AGHT+IG3dlRf668wyXmEnmvxDXq6fizOY14rJiE8NtfdLEoS2vHpHWEa1ni5yd+1qHGg0L/RJ9/RjQ==
X-Received: by 2002:a05:6402:2692:b0:5c0:903e:963a with SMTP id 4fb4d7f45d1cf-5cf0a45e113mr1386632a12.29.1731060333975;
        Fri, 08 Nov 2024 02:05:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4f0bdsm1775959a12.56.2024.11.08.02.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:05:32 -0800 (PST)
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
Subject: [PATCH v2 4/8] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Fri,  8 Nov 2024 12:05:09 +0200
Message-Id: <20241108100513.2814957-5-claudiu.beznea.uj@bp.renesas.com>
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

The Renesas RZ/G3S SoC has 6 SCIF interfaces. SCIF0 is used as debug
console. Add the remaining ones.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index be8a0a768c65..5b15ff2482ab 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -73,6 +73,96 @@ scif0: serial@1004b800 {
 			status = "disabled";
 		};
 
+		scif1: serial@1004bc00 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004bc00 0 0x400>;
+			interrupts = <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF1_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF1_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif2: serial@1004c000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c000 0 0x400>;
+			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF2_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF2_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif3: serial@1004c400 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c400 0 0x400>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF3_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF3_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif4: serial@1004c800 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004c800 0 0x400>;
+			interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF4_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF4_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
+		scif5: serial@1004e000 {
+			compatible = "renesas,scif-r9a08g045", "renesas,scif-r9a07g044";
+			reg = <0 0x1004e000 0 0x400>;
+			interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi",
+					  "bri", "dri", "tei";
+			clocks = <&cpg CPG_MOD R9A08G045_SCIF5_CLK_PCK>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A08G045_SCIF5_RST_SYSTEM_N>;
+			status = "disabled";
+		};
+
 		rtc: rtc@1004ec00 {
 			compatible = "renesas,r9a08g045-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x1004ec00 0 0x400>;
-- 
2.39.2

