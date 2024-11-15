Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5131D5147
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678261; cv=none; b=ZVg1sqa6MqHsppGOIzWUWEnQTO+xyYpsA1i3+NUKLURHPY1YTmH+qN+ySHu3QkEW/ev/FNJNJhMph8T6mm6d+aKI7RT5Gd2s0WNE8guB5NJu/QTawjhXrYb/kFij0NZsKehJP4NFIrWWwh1Bh5NAPewYHAd9RVu31RJWYAAM4Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678261; c=relaxed/simple;
	bh=S2Sv5mBpK4tHtMNdjlKy/M9/mteRMMEFbbSdKa+H3rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ec2qeFmS6qdvrgwYFC3j9b/qJ7INn55GSy5maiFk+11UW+JPd94fa5EjtRL5CcBOzqJ7/IODp3poLSb/1+cyN0sXzCQg1ESDqpA9vF0oCwO43pofLTmZYgnvEpNoKImEZoN93y+WGwFDENyFe7DxVzQSuX0a0wtHIDvGiCOvjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ds2g0M2k; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ds2g0M2k"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso11424725e9.0
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 05:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678258; x=1732283058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0uLg12EKex4iHuIi8vOX2y/fQEpOYkajMjZBOLCugw=;
        b=Ds2g0M2kEl/iCgIAxCmJpbfkdmoy8DeuUNP4HJegk4SQUfPtCSHbR7z2eJ+QqNoXFr
         QUHZRO/iLYw1EJJGb7zEM2B91h1cqNcgaJ21rIvowH037seJ1ITqCFMXJ1at+o2wUcW+
         h4TAay3csVp9ITKoZzcTeRnLRCI0f/ju5SAitk/RYHrz+OibiYNUwKrCvOw+YtRab2s+
         Ybl2E0FHuqFGhO+YK7Z730FAodYZoT5CTj0cIRk+7a2DPjPkPVQiIitCZkeceXBpNUNl
         1C7tPVj0kOYSwqRN908wqGM6QYECXYNmU/oJb0D1D+O+9EEchwRhmopgWmIor84At9Gj
         miQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678258; x=1732283058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0uLg12EKex4iHuIi8vOX2y/fQEpOYkajMjZBOLCugw=;
        b=cZ6nYRBHTLA0o5DQaSN5P48nEsWC+PD4s3J3k7i+cWxNZVtLERHGmkC/ywAEK3jLoS
         0zjLzvLlu5Su2dbGDUKWsUaM0RGuzI8aQSICQzOODX/WihzF11WXedU+vXFbRcbsMXaI
         gvc2WSD3Lwabpsxo+eBXmjJALEyD2xKbyw0SY3rcfcJMVHFdvTIVZuUW5FyK0qZy5S7f
         YZmnMFhoBEk04fPezu9AD65wxH6diXI6jjlQpXCp33oW2AHGofvrVlLYtyiqV/ud+iF/
         +YXdjol9XFDtejsOk0BcBzUgxh5R0NaMpSX7bhXKeg2YfxU65qwmYcJsWQdRrlnAp02H
         wJhg==
X-Forwarded-Encrypted: i=1; AJvYcCUgmBVQX8L7feRY0KvqTdvM67QOuCOcU95YMI80DyoWgFZmBwl8IMEh5knSbUvUIVY7NTZQxtMP9BoFl2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+DVVroV2PjiuDlsDIQGiSLtzQozdqj0gPX4cxC4MbtMzE6kh
	O0KM9AOSZKpR6edSX7ElZXEK87+c3P9kYlow6ziDR2+bXFXaGybq42Z5LbcZbeo=
X-Google-Smtp-Source: AGHT+IHiipXpIQ3kdeL6mxdRYKqKlgX6st4dDiVc11WZAoqSFbfOF+B5thqjNH+k4/ftDJFh4qWzTA==
X-Received: by 2002:a05:6000:18a2:b0:381:f15a:e91 with SMTP id ffacd0b85a97d-38224e71e84mr2721167f8f.11.1731678258123;
        Fri, 15 Nov 2024 05:44:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:17 -0800 (PST)
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
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 4/8] arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
Date: Fri, 15 Nov 2024 15:43:57 +0200
Message-Id: <20241115134401.3893008-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v3:
- none

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

