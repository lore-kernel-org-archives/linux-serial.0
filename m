Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1866C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 10:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiFHKYS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiFHKXE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 06:23:04 -0400
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36F1F1F66E3;
        Wed,  8 Jun 2022 03:12:24 -0700 (PDT)
Received: from NTHCCAS04.nuvoton.com (NTHCCAS04.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 9DAD11C811B0;
        Wed,  8 Jun 2022 17:56:34 +0800 (CST)
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 8 Jun
 2022 17:56:34 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 8 Jun 2022
 17:56:34 +0800
Received: from taln60.nuvoton.com (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 8 Jun 2022 17:56:33 +0800
Received: by taln60.nuvoton.com (Postfix, from userid 10070)
        id 210FD62EFF; Wed,  8 Jun 2022 12:56:33 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <jirislaby@kernel.org>,
        <shawnguo@kernel.org>, <bjorn.andersson@linaro.org>,
        <geert+renesas@glider.be>, <marcel.ziswiler@toradex.com>,
        <vkoul@kernel.org>, <biju.das.jz@bp.renesas.com>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <robert.hancock@calian.com>,
        <j.neuschaefer@gmx.net>, <lkundrak@v3.sk>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 06/20] dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
Date:   Wed, 8 Jun 2022 12:56:09 +0300
Message-ID: <20220608095623.22327-7-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220608095623.22327-1-tmaimon77@gmail.com>
References: <20220608095623.22327-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add binding for the Arbel BMC NPCM8XX Clock controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../bindings/clock/nuvoton,npcm845-clk.yaml   | 63 +++++++++++++++++++
 .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 50 +++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h

diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
new file mode 100644
index 000000000000..e1f375716bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM8XX Clock Controller Binding
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description: |
+  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
+  generates and supplies clocks to all modules within the BMC.
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm845-clk
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: 25M reference clock
+      - description: CPU reference clock
+      - description: MC reference clock
+
+  clock-names:
+    items:
+      - const: refclk
+      - const: sysbypck
+      - const: mcbypck
+
+  '#clock-cells':
+    const: 1
+    description:
+      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
+      list of NPCM8XX clock IDs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    ahb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@f0801000 {
+            compatible = "nuvoton,npcm845-clk";
+            reg = <0x0 0xf0801000 0x0 0x1000>;
+            clocks = <&clk_refclk>, <&clk_sysbypck>, <&clk_mcbypck>;
+            #clock-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
new file mode 100644
index 000000000000..229915a254a5
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Nuvoton NPCM8xx Clock Generator binding
+ * clock binding number for all clocks supportted by nuvoton,npcm8xx-clk
+ *
+ * Copyright (C) 2021 Nuvoton Technologies.
+ * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_NPCM8XX_H
+#define __DT_BINDINGS_CLOCK_NPCM8XX_H
+
+#define NPCM8XX_CLK_CPU		0
+#define NPCM8XX_CLK_GFX_PIXEL	1
+#define NPCM8XX_CLK_MC		2
+#define NPCM8XX_CLK_ADC		3
+#define NPCM8XX_CLK_AHB		4
+#define NPCM8XX_CLK_TIMER	5
+#define NPCM8XX_CLK_UART	6
+#define NPCM8XX_CLK_UART2	7
+#define NPCM8XX_CLK_MMC		8
+#define NPCM8XX_CLK_SPI3	9
+#define NPCM8XX_CLK_PCI		10
+#define NPCM8XX_CLK_AXI		11
+#define NPCM8XX_CLK_APB4	12
+#define NPCM8XX_CLK_APB3	13
+#define NPCM8XX_CLK_APB2	14
+#define NPCM8XX_CLK_APB1	15
+#define NPCM8XX_CLK_APB5	16
+#define NPCM8XX_CLK_CLKOUT	17
+#define NPCM8XX_CLK_GFX		18
+#define NPCM8XX_CLK_SU		19
+#define NPCM8XX_CLK_SU48	20
+#define NPCM8XX_CLK_SDHC	21
+#define NPCM8XX_CLK_SPI0	22
+#define NPCM8XX_CLK_SPI1	23
+#define NPCM8XX_CLK_SPIX	24
+#define NPCM8XX_CLK_RG		25
+#define NPCM8XX_CLK_RCP		26
+#define NPCM8XX_CLK_PRE_ADC	27
+#define NPCM8XX_CLK_ATB		28
+#define NPCM8XX_CLK_PRE_CLK	29
+#define NPCM8XX_CLK_TH		30
+#define NPCM8XX_CLK_REFCLK	31
+#define NPCM8XX_CLK_SYSBYPCK	32
+#define NPCM8XX_CLK_MCBYPCK	33
+
+#define NPCM8XX_NUM_CLOCKS	(NPCM8XX_CLK_MCBYPCK + 1)
+
+#endif
-- 
2.33.0

