Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB101D5CCC
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678267; cv=none; b=QuETQxmGibUpoUIZ49t2S8KIHYZ4NKlHg/bwZ8Y37HQVyGX6AXdiU/i2YoLpZJdh+MFSpZoHuIlL02Ne3KYMtN72ykjzC7yPIbHWQRwR973mSPzXXf5GcjOcW0Eo+skmLHXn3lcRMUTDn7KMxlc+TWP4RNiyfy7GofrEU1x5vNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678267; c=relaxed/simple;
	bh=LrCs+Ft93mkejJjJfAZXNdagefh5tGGc4YtY6FNYOrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UUZnJpGPc6c0okTOzdXmEIjCYaSLGqdwBXuN0k7qtkSkW5vVBWBtdR/btavUf/9AJxq27pHfLzIgYbAN3VEeY5lvcENKCf558NVWN3GwrmLC3x+I+QOs2Fkeq8x92REz5MJTCflLeTiuvOQASc/G3E/NqijL1cjajWBIFqEdmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d47pbgHn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d47pbgHn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so5896185e9.0
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 05:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678264; x=1732283064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbikK54OyStuo16iZrOIOl8rBYONkOS/JF88KYtuMkg=;
        b=d47pbgHn8v+kjUS8Dq7DO6zGQ1KQMsW8yLiNrwqzfU+m0WirSU/Uh9Q42sP/ddZQb0
         ceaRbwRTP0XirehB9tkzHOvOzHbFM+ujatYB2u3qvwYBEA/1uihIUGU0QI3y6IUuNmYO
         JZfQWalOLMPv6xlEAXjr8RhIAaSKpDGUD/k9yUfvwxInsP1a5Kg79Dl244rwxSWmAi6k
         FPBz5qcYpLJTv6R/TTMtohI6QzPycYiRejLAxfFCqsPR3AUhGHuIQ83OGxP4tZukyZs/
         c9bka1dkJTVEfUEDtB7kS6gfPw0eSKKwJ+zYIUyjQRq8zr5K6eVrD2OaeV9wUQt/+uh5
         wyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678264; x=1732283064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbikK54OyStuo16iZrOIOl8rBYONkOS/JF88KYtuMkg=;
        b=KwBqsH/KCer7WN9YgOHHX6Ki2f/uJHIHmg7kmseuIwLT2DrC9g9QaxFEl0McxA7mwt
         7gCPnHifNED0DnCZ+ygtg3ojQP4Jn5f/1MiKGYxQDRTNjN+rUN0GY23uoBitIaYWJ7V7
         9JxOALFqdbYv6FCobO2hNitYH0ck1hNBKhV9oOAMysRqpW4GKyBI36Q3xnFwY14WXKqi
         OM29e8f4JHzxFhHZ+sE5yazaoQ/wUs5rd+Oj8S01bbd+Bz8xTZhM+xrihuZEvL34Pvq9
         +ABHpxRZagxIpL+5YHNIfLpgqajO1msiPTv+OHlBq5KGT3Kc1Op/LNlvOcIVFBx2dzhK
         7Yjg==
X-Forwarded-Encrypted: i=1; AJvYcCVKJB/UNMvBHNrJWH7tYMdjNG8+aKR6Yw2obbl42R2egLdqw67OV06kkKBIdKQs5hgtpgjehmymKAHC58Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA2+5YKsXcvWnoM07MAeWilRvyQvAVzNn5dxaXRil/J5avC44S
	BCk0/jJqVgS9AqZ6mQ0R1gLNgQaBvC6AZqOjDlDZU44j5RMcw6crtBiBP58tXRE=
X-Google-Smtp-Source: AGHT+IGrZltzKer/dm8m8qYDs7z7mwJoTu/1frSmXqBSSagNZ5FvyYqOjugYq2GKqHZ+Vm6ZI9Uk1Q==
X-Received: by 2002:a05:600c:3aca:b0:432:c774:2e24 with SMTP id 5b1f17b1804b1-432df72514fmr22784765e9.9.1731678264401;
        Fri, 15 Nov 2024 05:44:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:23 -0800 (PST)
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
Subject: [PATCH v3 7/8] arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
Date: Fri, 15 Nov 2024 15:44:00 +0200
Message-Id: <20241115134401.3893008-8-claudiu.beznea.uj@bp.renesas.com>
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

Enable SCIF3. It is routed on the RZ SMARC Carrier II board on SER1_UART
interface.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 33b9873b225a..1be21ece131e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -9,9 +9,14 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+#include "rzg3s-smarc-switches.h"
+
 / {
 	aliases {
 		i2c0 = &i2c0;
+#if SW_CONFIG3 == SW_ON
+		serial1 = &scif3;
+#endif
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
@@ -102,6 +107,11 @@ scif0_pins: scif0 {
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
@@ -141,6 +151,14 @@ &scif0 {
 	status = "okay";
 };
 
+#if SW_CONFIG3 == SW_ON
+&scif3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif3_pins>;
+	status = "okay";
+};
+#endif
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-1 = <&sdhi1_pins_uhs>;
-- 
2.39.2

