Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8F1D6199
	for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678269; cv=none; b=QoH3w+ApiOQSDbBJLI4m5tH+06Dbcr4cfEXRqSO8Y9l+PRAmzQMEkFWS/PJg8mSua6tYV1k6FbxC7bELPrRbspi5zX1LpHdM8GSicVWFTIA3wbQZcFT6qgiY9DF3v37GYWcaIyzjeVz7e9ioAlFh1sF3Ln9amMUpCgprtXlvUrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678269; c=relaxed/simple;
	bh=oorGJmvA6xzxLnok/YZN4p2VL6lLlYylm2VtoiEqIdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ax6WuZ3y24h9WejyFQX2mQ2qrWEm5s//R4hwYa+fCWQ9p1T9J+tdIAO0j7by0fiPMZ35kes/e2REC4bqpv/MkjNsfy7lQWmkHsZoEox5/xn3S56A3/ZlY0nT9KoXsSQcXzITBxvFmqKQuDrSkOqqJz29B9Q2tnaEC5IwuFq+H1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Tt9M//b3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Tt9M//b3"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3821df9779eso1066633f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 15 Nov 2024 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678266; x=1732283066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy6rRM40DC0Xnuy+hKTJ1gL87RxFIFWLdj3y1evJaag=;
        b=Tt9M//b3hgiUITu4GtEnVIA00UnqaXtoE5ioJo3RRiRdI8ZkZUJwDWFGc90uDE9HY5
         57GC6UX0A6dCNOoqhzx/JAz6hKPeE14DFzP6JBxFwqdKTJ11jYeQQ+hAtPYzjigIv6Y+
         +D1gsYAb0+2Jn5kx76TEVtsPYjcEXnbYPzTC1BEmxEUqIJXULnAI7tSYJk67g0mzI32O
         bbuuNSDIhYMKgn/D9SnoBbyybb+anNhWWEcLp5gC2GNMcKQRW7lV2CwryKL4ME4bK35s
         sGkKAsR07qhWNya0gGwW8LTCB9BCUs9ICm8z6DLzhepypRIJcp8dslUm8794Hde2RNUf
         pGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678266; x=1732283066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cy6rRM40DC0Xnuy+hKTJ1gL87RxFIFWLdj3y1evJaag=;
        b=cPFvyVD+m179w+3yRfCPO6SVzcHComsLGdzt3Pyu85oFJjSbgLnyoa3RHJx32CFtTg
         WA+snCQL6P8K12FfPJQGh5NLLqmEMuweZzv9tQvc3tENJXeNgEo81uvwbsa+o2E0/Yih
         1X2362zBR8gjijP+bn3J9PMRkcriVIiSn/X5ScIb4Q/knQbAkVZT+ToGXhLs/YwxAbYI
         YtzalhvCumMv3gzuxHNLVvYtAncLX8y5e8k/UZexeXm8vDFG9KcWzPm/N/4utDoP7QEl
         Ckd2f1zje80EG8IbMFtiNi0/SrxYw6D8hZRG9RBilCv8/tql6ukXwwO36Hh952qO9hgv
         fI1g==
X-Forwarded-Encrypted: i=1; AJvYcCXlybOgjBa9ReFuxAS9aHAKWKDQxMA+emii9CGY06q/F/CRl+/4J5yIBbl6bF8xJip9t5wLhwjEIm8yqz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwifUY0us5x2pDcUceiAU2SNke5SVTgYtGJePLsdvKgwBKfoXio
	w2GP6GRzEBZ3UIS4re/XXEoaaTHpZNVLKCufHMEKwI8VWzMuhBtgH04clqI+wLE=
X-Google-Smtp-Source: AGHT+IElpc/J6dLBHzyye+AXHa2deiO6rAp8errU88VFUq6AVzjbCez9Ff6hHaovJQpzUHSProQ5aA==
X-Received: by 2002:a5d:588b:0:b0:382:1e06:fa3 with SMTP id ffacd0b85a97d-38225acf926mr2344326f8f.47.1731678266107;
        Fri, 15 Nov 2024 05:44:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:25 -0800 (PST)
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
Subject: [PATCH v3 8/8] arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
Date: Fri, 15 Nov 2024 15:44:01 +0200
Message-Id: <20241115134401.3893008-9-claudiu.beznea.uj@bp.renesas.com>
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

Add DT overlay for SCIF1 (of the Renesas RZ/G3S SoC) routed through the
PMOD1_3A interface available on the Renesas RZ SMARC Carrier II board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- none

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

