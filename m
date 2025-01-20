Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977521E1A2D
	for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378589; cv=none; b=jQt5/yQ352jWYLV4lBQyw2hsQOC20Ajh+lQiBYEVUxTOqyrssldMgFLkgB9NvF4Jh0Wc3anQFphpjk2WN9Mv5YJhsku+ozbxz/4yJhzQeFnRuRYbL2QdYtA57wrjk8U3ri9MQ1qvwJ15XeuzFO9EnX8p88N5krhiEdLUrnJBM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378589; c=relaxed/simple;
	bh=7o3Y+E7nnBZwgQGYjXgcYEZjLUWyl3PQWnVN9lSAnOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2nhH0UyYEbUQdF2jHOfEbVmiBpyFRNMMBZwYTV4johL1vLFVqrpeB65ICPMnLDoBuWxPWfzMQG6a4t32+IutaOv5FzLl4G1hp5e5GErit6SiNIxt/6X5tcYsRiFWe3OuInce6WZgXVftjisW95ywva+n7rrBroyk7TnGhDC9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=onaj1ljd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="onaj1ljd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436345cc17bso31574815e9.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 05:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737378585; x=1737983385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lPi/twN6zUkfiC5mOpKuXZ209zqYTSm0G6i4T4io+0=;
        b=onaj1ljdkRsIYtjBEwJW48yzPCGLBwRuE7i6+GWZc1UNZkmgyma9zKOgFdjoMiofao
         pSqjSqfAdTrjhqEHiMatSquI4JVNAPCrKTuQ71WpLQt+zJ+WRlE9kNlWPK+zupvUvaFj
         h3VAo4ge5R/qSxHGdKrBITU9cwq23sUI2uSi6bcZde4Pm9lPtZV6vVJ6qTr2SmN0B6l3
         Y2X8VTYKWY2H1/NxK7njQGJsF0beLHcRBwmCF3CHrRwZ6jnphn709nxehJlqT1VsjEO6
         sM6ZFyfO32MFhDsQnCdvhGCRUThFIVpnoYP02kUP+dSzAzK2YK+YOhBlY8jz3IMCsToN
         DKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378585; x=1737983385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lPi/twN6zUkfiC5mOpKuXZ209zqYTSm0G6i4T4io+0=;
        b=s+0oG/7G1yjeNMCkTUmzlGRzmnLXPuVuP52mx6bNJdJZrB8FhIybUAiOLIpDIYuuPl
         8k4sGpd0IH63pXXKMnRIAVDZvPOuXbdV0vw7pQ9TOftIr56Gh0kxXCbMBmPH66VDBTgF
         OZFfSmE+Dl5TRAXf5fR/EfO9/nkrfj+CxyV/4XtwR2IJUxK3iGYx1erFLUk3sqx9hkhy
         Qikodl+x9BOc8yxGV8pDsvbWNy+Syw3wcAm+6k1jm2T4f5PLxsYa/N9vt8fKfviOpsQy
         oC82CGlDfgZt8ogjgQmDVuaZlQykdmwHlB5YRQxTXQhJ5HEQXMG9xY8YFi2QOvuMr5q+
         1Mdg==
X-Forwarded-Encrypted: i=1; AJvYcCUrZRS05+CCFewjAy9pSJ1+Q8LyIOi7q5sGHxzC7ZjR6fCMyR6ZB17ND008j18vJLbDSlbCyDAruVPYPJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbctPdONXNg4+Up9WDwHnTRRElG6rm2froMrtpgvzNN8Yni6RH
	YD/zUPWyKveBEzpRd0fVTQfExWX6MYbZtE9y4TgmxcPwcZAH+ubdfKsNWacqrLo=
X-Gm-Gg: ASbGncsGONFCsvN8c0OVHTfbY9Ux5E5rPEDxvY1P4AnHuHl0f7vX3jhmJtjHfav+hat
	6LqgkrgBUavie2K0hazkGqQ24DfdUCr6+35dlrJUFgLa5Cv97OwBfxdMB9SZUtWf6aINf/i2m9F
	Ywj08+lqBhTmS/Jrq7l1XESFH3oil3GgkR6jSAy/FuJCkj3v6BU7SBR118iz/o/1lNs9z3rax1U
	gKPujyncjiwdD68Q3XOMTXog7wSYI9spWk1NftQiOiREjInY1DYEC65GkXqbjn1LWfrr5fy7Gif
	RusgNPclfcvGNZPwVh49VoM=
X-Google-Smtp-Source: AGHT+IEcU/85w7UbVunXHIxQ5T1EeguZXj0W8RnMAbTNHN0/tPf0amR8m308HxvIlVOOV/v1s38tVA==
X-Received: by 2002:a05:600c:c0e:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-4389142968emr119630415e9.22.1737378584913;
        Mon, 20 Jan 2025 05:09:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f61bsm138001955e9.17.2025.01.20.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:09:44 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	claudiu.beznea.uj@bp.renesas.com,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 3/4] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Mon, 20 Jan 2025 15:09:35 +0200
Message-ID: <20250120130936.1080069-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250120130936.1080069-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Enable SCIF3. It is routed on the RZ SMARC Carrier II board on SER1_UART
interface.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- dropped checking the SW_CONFIG3
- dropped the include of rzg3s-smarc-switches.h

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 81b4ffd1417d..0851e0b7ed40 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,6 +12,7 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
+		serial1 = &scif3;
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -162,6 +163,11 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
 	};
 
+	scif3_pins: scif3 {
+		pinmux = <RZG2L_PORT_PINMUX(17, 2, 7)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(17, 3, 7)>; /* TXD */
+	};
+
 	sdhi1_pins: sd1 {
 		data {
 			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
@@ -208,6 +214,12 @@ &scif0 {
 	status = "okay";
 };
 
+&scif3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif3_pins>;
+	status = "okay";
+};
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-1 = <&sdhi1_pins_uhs>;
-- 
2.43.0

