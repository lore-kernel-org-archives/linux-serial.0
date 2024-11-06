Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B41E7657
	for <linux-serial@vger.kernel.org>; Wed,  6 Nov 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894513; cv=none; b=pUHoI3PDp52vbqcxK2kPO2541Sg1NFcAY9ke+Iie3oPYxAhOaFSdSWWz4+H1b+mV/RICqq1PC6SoFg97KlkpE3uTtbhdcSm6FcgmLn8tdifM15nM35Gegy4D6hJTcx8dKeX0J8Hm1/peF89KUd9woc3ki2d7CZ4rX0vrTY8A2OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894513; c=relaxed/simple;
	bh=l2nLfEhXQdqdldj7HMRPD/BKF+Yo/cZTkzGKteJPuqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EA9LjH26n8S2w4SmlUjEpsAbWb/1I3vDstBKQxobnYVJaWmlLnytOEuj6e5w1k7xzT1lRq1WqAu7YXs39sYHtt3yQtrcfX8cCk8pJW1juuN+ynQLotr8MU6wYLfSCvXNAGjSTq2s3hMFH+N9c5VJ6ECnEOzL6yI67jXX6W6bfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=p7eZhhzi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="p7eZhhzi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so56627641fa.3
        for <linux-serial@vger.kernel.org>; Wed, 06 Nov 2024 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1730894510; x=1731499310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JwPCGHe69m/pJb0qH1LaF4qTTUiifIIPi692eTZlzU=;
        b=p7eZhhzip/ycZoC9bUx4Xj/Raxbv8DKTYi0hclsnVElxx1IDTDWMDv5/zujT7ImHPF
         wl+QzTqzCAUbSiT83jzRNj1QjmEajok6udXAvz1YjO+CBItLEtdzfvJVcrlMrR2me5nQ
         Oy+mcAQGzcu9mGqqUC3jChXcooSuEafTKKTviT0GUVpUbcY/SvG4A5ttcARCb1+DsVdL
         VFoxJYqMPk4TSKdw3W+21R+zUCWcRP6NVyA4w+RTQ5258ECYkB76+xabnDgfJV1B7ydE
         G4gQEvlHSKhjCT3FpxG+0MrY6BcJvtSqOR3FLmyez6BYFyTTcw2HHg4+kHBSSzURMwun
         wbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894510; x=1731499310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JwPCGHe69m/pJb0qH1LaF4qTTUiifIIPi692eTZlzU=;
        b=EC9gK+SnN60HV+6vY+L+J3q5QCTf+IH7T1PCPeTLXTSNyE5vN2RmFipuRxEGIIT/IW
         pBzyxkMAlCnq75jU2/O9oyMhzkBZiFBthybwqfngCF3KVgGAIx+1+v5yC4ZFXwK3YVin
         0e9RcRy7Sy6RR0wMiO3swXAPX/Z1F5YOM1kxP/1YTO3lmvC1xETsIlh9f8Iu5qpukXJr
         hoVuGy5gu+ATt5lVnauJuWUq8PjtCWZOk0lOsYbCN0KdJvFShk7Au7sCWbMBp5QyJ3Xe
         PYsj00FHDUF12YeJnmymGbVnxwHmp35BdQUcRx2fLRfLjB/el/wzr5PsJl2+fdbNInBP
         MU4w==
X-Forwarded-Encrypted: i=1; AJvYcCUOCFqXOOXgPXPnHa3MB17s2tN3Ni8V+HJJ3UGFFFqdKthVF1+IS1s5hox9UH6RgGUD8g4gEOF/BVHtvr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbnWUiUyZOrj+5Xat8KC2ibbxhtiizJfg+9OfXH8XpksRX9lh
	dS0LXzXN0jQg0k/6x6qhegHgZZfTjIb7rJhODArO4aUACg+Sg0lWq1LMU3F4+f4=
X-Google-Smtp-Source: AGHT+IGmZAnyNN2H3HVq8mWB2A4J8BfLSHy4gBsMu6TgAseykCSA2VwSabOZhkZzxv828ZqhYx8Qgw==
X-Received: by 2002:a2e:b8c8:0:b0:2fb:4b0d:9092 with SMTP id 38308e7fff4ca-2fcbdf69fbemr189607851fa.1.1730894509534;
        Wed, 06 Nov 2024 04:01:49 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe528sm2697984a12.55.2024.11.06.04.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:01:49 -0800 (PST)
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
Subject: [PATCH 9/9] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
Date: Wed,  6 Nov 2024 14:01:18 +0200
Message-Id: <20241106120118.1719888-10-claudiu.beznea.uj@bp.renesas.com>
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

Add DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through the
PMOD1_3A interface available on the Renesas RZ SMARC Carrier II board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  3 ++
 .../dts/renesas/r9a08g045s33-smarc-pmod.dtso  | 48 +++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 97228a3cb99c..7ad52630d350 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -137,6 +137,9 @@ r9a07g054l2-smarc-cru-csi-ov5645-dtbs := r9a07g054l2-smarc.dtb r9a07g054l2-smarc
 dtb-$(CONFIG_ARCH_R9A07G054) += r9a07g054l2-smarc-cru-csi-ov5645.dtb
 
 dtb-$(CONFIG_ARCH_R9A08G045) += r9a08g045s33-smarc.dtb
+dtb-$(CONFIG_ARCH_R9A07G043) += r9a08g045s33-smarc-pmod.dtbo
+r9a08g045s33-smarc-pmod-dtbs := r9a08g045s33-smarc.dtb r9a08g045s33-smarc-pmod.dtbo
+dtb-$(CONFIG_ARCH_R9A07G043) += r9a08g045s33-smarc-pmod.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
diff --git a/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso
new file mode 100644
index 000000000000..7d637ab110e1
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZ/G3S SMARC Carrier II EVK PMOD parts
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ *
+ * [Connection]
+ *
+ * SMARC Carrier II EVK
+ * +--------------------------------------------+
+ * |PMOD1_3A (PMOD1 PIN HEADER)			|
+ * |	SCIF1_CTS# (pin1)  (pin7)  PMOD1_GPIO10	|
+ * |	SCIF1_TXD  (pin2)  (pin8)  PMOD1_GPIO11	|
+ * |	SCIF1_RXD  (pin3)  (pin9)  PMOD1_GPIO12	|
+ * |	SCIF1_RTS# (pin4)  (pin10) PMOD1_GPIO13	|
+ * |	GND	   (pin5)  (pin11) GND		|
+ * |	PWR_PMOD1  (pin6)  (pin12) GND		|
+ * +--------------------------------------------+
+ *
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+&{/} {
+	aliases {
+		serial0 = "/soc/serial@1004bc00";
+	};
+};
+
+&pinctrl {
+	scif1_pins: scif1-pins {
+		pinmux = <RZG2L_PORT_PINMUX(14, 0, 1)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(14, 1, 1)>, /* RXD */
+			 <RZG2L_PORT_PINMUX(16, 0, 1)>, /* CTS */
+			 <RZG2L_PORT_PINMUX(16, 1, 1)>; /* RTS */
+	};
+};
+
+&scif1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&scif1_pins>;
+	uart-has-rtscts;
+	status = "okay";
+};
-- 
2.39.2

