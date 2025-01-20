Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064231DFE16
	for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378587; cv=none; b=E0k5YqidOsuZrKzQSQUGfBHp9J9XWj55BYEiDpT7FXr6u4FpaRzLpIOubhMgr9C0RTBofG9eJut4oKk9Ec8BWDH7VM/tKrU4a7uEWBxSk6TsTqjTdw88hykiRz+i2PJCAY9M10aXRdDfb2vx2wfJF1KcI5u+GQddp6rBtoXwDFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378587; c=relaxed/simple;
	bh=7n5sMDbwVn+ispnfZZTJJPvroNDzqS+OKERZbs8Fe0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAnDooiiv/+XEjSCSukNS+iIS/bUK5S3KkIRt1f78laY+wuOaNxtQdBcE8AdQ+o/93k1GqRztem9k9xxVpDwqqJ4VXu0+Aj5hYjVmxXSRXl+KM38Npjneo4k6oRwj2MAWLg/+SB8VEWqaB4qs5BRM8N2lXf1pI2R6h4Cgqvrxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y4caGsss; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y4caGsss"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436281c8a38so31561435e9.3
        for <linux-serial@vger.kernel.org>; Mon, 20 Jan 2025 05:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737378583; x=1737983383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gRlxtvByNO5udzwmMv5gFGDjo6tJlSTC3E0AGWaYSY=;
        b=Y4caGsssFUKZXUr41pPOSXGP8Q668FEh1XziKh8tRfwWIBE2MvWuMacekpLEmzr6wQ
         NPBr6TM8JNcYvp1rtZmdfTIZrGz1WEZ/4ku9+4EcYXp4tta9Uw+xQS9oqBHiGbTmzaxM
         4ee7afd3fNNDRSirgdL6fzppbKurcZGDUXSFX6DqSp8MCBA5pyBhXUTh1c/BacGFfqqv
         NK9abCjIkWwJV1U+jEmAwqaunm6aTy40utMsQkHQbVLy/RsBmxkEEx9RuP9K6cOgswLa
         YsfGAqmcIy7xNMfLfORpbpNcvD1JFcVw8MxKUIpz3iINeTZagqSRnlPUfV0dmxOduH0i
         PASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378583; x=1737983383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gRlxtvByNO5udzwmMv5gFGDjo6tJlSTC3E0AGWaYSY=;
        b=vyBQfsjX0cZ5vdtKU2b1kfGbi8oY5OsiEOL/5x+Eid5R6SteS9WUIK8im+jvFlqrKS
         zqqAK0FlBsV6xFCX0j/bhzBllD1D7/1VYMxZBL2nsHINf1PGyeCsGzLdOfTkCgqFnPLn
         n7kYw/Doyb4DJfFLHtPLtj1yoi7+/tOsHmm4WO91fGXlP67w5ZCO4+KkRm/ycB1kdzk0
         +wEyZApzG87drZJ5MSa6Yc00FpbxfrsO28t/a5GdFUSDjlCNCfNfDgy4+eD50q/t7+Db
         QcS7zXWdS8pAOKT9XDnfOJIPeji8hhGHIV1yb1qOXe2t+VnqjOds8BbhwLzx6vOEgcVc
         oOkw==
X-Forwarded-Encrypted: i=1; AJvYcCXc0X0CnC1wB9FscRUGuV1aJEBrKEGsRIdRk1w4ykRsvkHz5oCHNNuN3iTlJLscSI4dJBJueYU/w5FQ9lA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc514q3ShXo/O7hcCGUibdUORnzxYXBGGDUKByOzSOCNm0JRK/
	sRNlDrWsS7Rf9cq/uaG67tZiL63Mfo1Yw0Use1vNLCkLkayVRQsSCNmzuq0wVZ5g0KG7E9DjBHS
	g
X-Gm-Gg: ASbGncsGduP9RhVMKlLB7L8hEAC3MLwWs3ITkJQG8kW1iUZ3pOLeuLzZNVzsW8USoBK
	yBYwUrILUZJQenU7RM/+GfKnQRYJalCNpzcQP+Qlp9hzuxacnmxT2XS9wkXGMX7KOmmk7VhpSks
	ztOaMZYeorbtoqmTCWDb1XRz+MFmk3PmWsXfUygswqwn58FrQ5uIBp9drXvnqq2yAmJXZn+gFS2
	+jGw6dUN34aT8cpR+L45piMBoi6GUxy+WgHhr4GjqYGDRZ3pK8TnI3rlUiAYdeJmWjL22ben8Zl
	r4q8OHvHZ86o2dyd9w9TXcY=
X-Google-Smtp-Source: AGHT+IGUE8yPgR7lQfCZF5G3ZqkDOFLEhMezebE22LyEhYPqM8owjlY/N8nCg5j028/go6Z7PsODoQ==
X-Received: by 2002:a05:600c:6c9a:b0:438:a240:c54 with SMTP id 5b1f17b1804b1-438a2400d95mr64394965e9.9.1737378583223;
        Mon, 20 Jan 2025 05:09:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f61bsm138001955e9.17.2025.01.20.05.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 05:09:42 -0800 (PST)
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
Subject: [PATCH v4 2/4] arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe different switches
Date: Mon, 20 Jan 2025 15:09:34 +0200
Message-ID: <20250120130936.1080069-3-claudiu.beznea.uj@bp.renesas.com>
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

There are different switches available on both the RZ/G3S SMARC Module and
RZ SMARC Carrier II boards. These switches are used to route different SoC
signals to different parts available on board.

These switches are described in device trees through macros. These macros
are set accordingly such that the resulted compiled dtb to describe the
on-board switches states.

The SCIF1 depends on the state of the SW_CONFIG3 and SW_OPT_MUX4 switches.
SCIF1 can be enabled through a device tree overlay. To manage all switches
in a unified state and allow users to configure the output device tree, add
a file that contains all switch definitions and states.

Commit prepares the code to enable SCIF1 on the RZ/G3S overlay.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- adjusted the patch description
- used GPL-2.0-only OR BSD-2-Clause license
- used proper description for SW_CONFIG3

Changes in v3:
- none

Changes in v2:
- none

 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 20 +-----------
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index ef12c1c462a7..39845faec894 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -9,25 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
-/*
- * On-board switches' states:
- * @SW_OFF: switch's state is OFF
- * @SW_ON:  switch's state is ON
- */
-#define SW_OFF		0
-#define SW_ON		1
-
-/*
- * SW_CONFIG[x] switches' states:
- * @SW_CONFIG2:
- *	SW_OFF - SD0 is connected to eMMC
- *	SW_ON  - SD0 is connected to uSD0 card
- * @SW_CONFIG3:
- *	SW_OFF - SD2 is connected to SoC
- *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
- */
-#define SW_CONFIG2	SW_OFF
-#define SW_CONFIG3	SW_ON
+#include "rzg3s-smarc-switches.h"
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
new file mode 100644
index 000000000000..514a8a6dc013
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * On-board switches for the Renesas RZ/G3S SMARC Module and RZ SMARC Carrier II
+ * boards.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __RZG3S_SMARC_SWITCHES__
+#define __RZG3S_SMARC_SWITCHES__
+
+/*
+ * On-board switches' states:
+ * @SW_OFF: switch's state is OFF
+ * @SW_ON:  switch's state is ON
+ */
+#define SW_OFF		0
+#define SW_ON		1
+
+/*
+ * SW_CONFIG[x] switches' states:
+ * @SW_CONFIG2:
+ *	SW_OFF - SD0 is connected to eMMC
+ *	SW_ON  - SD0 is connected to uSD0 card
+ * @SW_CONFIG3:
+ *	SW_OFF - SD2 is connected to SoC
+ *	SW_ON  - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ */
+#define SW_CONFIG2	SW_OFF
+#define SW_CONFIG3	SW_ON
+
+#endif /* __RZG3S_SMARC_SWITCHES__ */
-- 
2.43.0

