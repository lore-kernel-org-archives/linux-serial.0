Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C342C433DB
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450DD61A4A
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhCZLPp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhCZLPU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB7C0613AA;
        Fri, 26 Mar 2021 04:15:20 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 32so4406676pgm.1;
        Fri, 26 Mar 2021 04:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y46vDaF1HdB1kpxBeHbUXM+UB0P0da0YQFRlc9sdLKs=;
        b=Ntga5vs0UmKEUadrXPpdiq6+pPkVTyPOlUFGTjpneQCBhjbVxUdM8V2EE+22zhmipR
         Poj0t1UanzEbiaFMsn/dJUezYDzcxH1J5HctaotGlRj4fx1QE8IySCdGGF5qRA9PS1Aw
         r7RtHkM4Fiv0iIzULdVd3KP6ZtbIAiZ2RznczOztO7EX3mKgmONkV4rXkBWk6PvTSHwq
         AuxLyFqgyu7lDoktUppUDCpxbW6DKrDYFBhVAur/3zJXoxPCS42cf+za3EWmGwWZMBbD
         nQhwx3u352qjlglTA/lR2FElE1huZVaf2+WLwmxvKhHhS3CoNm3iWDavDnHjLSPHhhUI
         dZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y46vDaF1HdB1kpxBeHbUXM+UB0P0da0YQFRlc9sdLKs=;
        b=YFJu2+QF/93TvilfyhmRHusKhWN8VCX2ME1KcR4L97A/GgM1vSM88MVXv+9gZ+zqcS
         ONmPCeJEYbIN1HXtLPydrU1SldDLHjV+SpydIyMMB3VXJk+NfezPh7atawVocltqiih2
         ovGXGU8nZr7GeMQ0zZ6k7y1aF8XValXqd07tJjndVBBkBCMPO0np/89VTZFbPDDq9XQy
         oqJjBAU8DDSmxer5N8Q8aUlfo3CfI/RxcVehh/4DFDvg+AG+6Vrq2tdnUTt+Q2DkCuyL
         Fs9C5V4eTj13kz2PNOtY0kolPATg2lnuWV/ZX4Uru2EKtfqvZguLzEVz/fdiZqYj2fhk
         KUEw==
X-Gm-Message-State: AOAM53078yL7Ykk6mjxeA9y3s24tp18wSTCpOtNVq0R+P9P5bMSHBRFV
        hx9mVWzgk5FZwvtBwHFrOX/xc7hWOmzojjaz
X-Google-Smtp-Source: ABdhPJxlQnkyqsgovtXDZQnIjQshWWTHfetmpqxjfkGo0lnV0kHpz/+OKL8gD1HKQcTsFQ2NWZa9vw==
X-Received: by 2002:a62:2585:0:b029:1fb:bd86:2008 with SMTP id l127-20020a6225850000b02901fbbd862008mr11787476pfl.77.1616757319473;
        Fri, 26 Mar 2021 04:15:19 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:19 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 4/9] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
Date:   Fri, 26 Mar 2021 19:14:57 +0800
Message-Id: <1616757302-7889-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch is intend to add support stm32h750 value line,
just add stm32h7-pinctrl.dtsi for extending, with following changes:

- rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
- move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
  to stm32h743-pinctrl.dtsi
- move 'pin-controller' from stm32h7-pinctrl.dtsi to stm32h743.dtsi, to
  fix make dtbs_check warrnings
  arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: soc: 'i2c@40005C00',
  'i2c@58001C00' do not match any of the regexes:
  '@(0|[1-9a-f][0-9a-f]*)$', '^[^@]+$', 'pinctrl-[0-9]+'

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v6:
- add gpiox{gpio-ranges, ngpios} in stm32h7-pinctrl.dtsi
- add status="disabled" in stm32h743.dtsi 
 
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 341 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +---------------------------
 2 files changed, 347 insertions(+), 301 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
new file mode 100644
index 000000000000..a5c295eca081
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
@@ -0,0 +1,341 @@
+/*
+ * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+
+&pinctrl {
+
+	gpioa: gpio@58020000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 0 16>;
+	};
+
+	gpiob: gpio@58020400 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 16 16>;
+	};
+
+	gpioc: gpio@58020800 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 32 16>;
+	};
+
+	gpiod: gpio@58020c00 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 48 16>;
+	};
+
+	gpioe: gpio@58021000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 64 16>;
+	};
+
+	gpiof: gpio@58021400 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 80 16>;
+	};
+
+	gpiog: gpio@58021800 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 96 16>;
+	};
+
+	gpioh: gpio@58021c00 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 112 16>;
+	};
+
+	gpioi: gpio@58022000 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 128 16>;
+	};
+
+	gpioj: gpio@58022400 {
+		status = "okay";
+		ngpios = <16>;
+		gpio-ranges = <&pinctrl 0 144 16>;
+	};
+
+	gpiok: gpio@58022800 {
+		status = "okay";
+		ngpios = <8>;
+		gpio-ranges = <&pinctrl 0 160 8>;
+	};
+
+	i2c1_pins_a: i2c1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
+				 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	ethernet_rmii: rmii-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 11, AF11)>,
+				 <STM32_PINMUX('G', 13, AF11)>,
+				 <STM32_PINMUX('G', 12, AF11)>,
+				 <STM32_PINMUX('C', 4, AF11)>,
+				 <STM32_PINMUX('C', 5, AF11)>,
+				 <STM32_PINMUX('A', 7, AF11)>,
+				 <STM32_PINMUX('C', 1, AF11)>,
+				 <STM32_PINMUX('A', 2, AF11)>,
+				 <STM32_PINMUX('A', 1, AF11)>;
+			slew-rate = <2>;
+		};
+	};
+
+	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
+				 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2{
+			pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
+			slew-rate = <3>;
+			drive-open-drain;
+			bias-disable;
+		};
+	};
+
+	sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
+				 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
+		};
+	};
+
+	sdmmc2_b4_pins_a: sdmmc2-b4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('D', 6, AF11)>, /* SDMMC1_CK */
+				 <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-disable;
+		};
+	};
+
+	sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
+				 <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('D', 6, AF11)>; /* SDMMC1_CK */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-disable;
+		};
+		pins2{
+			pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
+			slew-rate = <3>;
+			drive-open-drain;
+			bias-disable;
+		};
+	};
+
+	sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC1_D0 */
+				 <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC1_D1 */
+				 <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC1_D2 */
+				 <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC1_D3 */
+				 <STM32_PINMUX('D', 6, ANALOG)>, /* SDMMC1_CK */
+				 <STM32_PINMUX('D', 7, ANALOG)>; /* SDMMC1_CMD */
+		};
+	};
+
+	sdmmc1_dir_pins_a: sdmmc1-dir-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
+				 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
+				 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
+			slew-rate = <3>;
+			drive-push-pull;
+			bias-pull-up;
+		};
+		pins2{
+			pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
+			bias-pull-up;
+		};
+	};
+
+	sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
+				 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
+				 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
+				 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
+		};
+	};
+
+	usart1_pins: usart1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	usart2_pins: usart2-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
+			bias-disable;
+		};
+	};
+
+	usart3_pins: usart3-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
+				 <STM32_PINMUX('D', 12, AF7)>; /* USART3_RTS_DE */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 11, AF7)>, /* USART3_RX */
+				 <STM32_PINMUX('D', 11, AF7)>; /* USART3_CTS_NSS */
+			bias-disable;
+		};
+	};
+
+	uart4_pins: uart4-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('I', 9, AF8)>; /* UART4_RX */
+			bias-disable;
+		};
+	};
+
+	usbotg_hs_pins_a: usbotg-hs-0 {
+		pins {
+			pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
+					 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
+					 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
+					 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
+					 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
+					 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
+					 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
+					 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
+					 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
+					 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
+					 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
+					 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+	};
+
+	spi1_pins: spi1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('A', 5, AF5)>,
+				/* SPI1_CLK */
+				 <STM32_PINMUX('B', 5, AF5)>;
+				/* SPI1_MOSI */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <2>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('G', 9, AF5)>;
+				/* SPI1_MISO */
+			bias-disable;
+		};
+	};
+};
+
diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index fa5dcb6a5fdd..6b1e115307b9 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -1,306 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
- * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
+ * Author: Alexandre Torgue  <alexandre.torgue@st.com> for STMicroelectronics.
  */
 
-#include <dt-bindings/pinctrl/stm32-pinfunc.h>
+#include "stm32h7-pinctrl.dtsi"
 
-/ {
-	soc {
-		pin-controller {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "st,stm32h743-pinctrl";
-			ranges = <0 0x58020000 0x3000>;
-			interrupt-parent = <&exti>;
-			st,syscfg = <&syscfg 0x8>;
-			pins-are-numbered;
-
-			gpioa: gpio@58020000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x0 0x400>;
-				clocks = <&rcc GPIOA_CK>;
-				st,bank-name = "GPIOA";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiob: gpio@58020400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x400 0x400>;
-				clocks = <&rcc GPIOB_CK>;
-				st,bank-name = "GPIOB";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioc: gpio@58020800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x800 0x400>;
-				clocks = <&rcc GPIOC_CK>;
-				st,bank-name = "GPIOC";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiod: gpio@58020c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0xc00 0x400>;
-				clocks = <&rcc GPIOD_CK>;
-				st,bank-name = "GPIOD";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioe: gpio@58021000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1000 0x400>;
-				clocks = <&rcc GPIOE_CK>;
-				st,bank-name = "GPIOE";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiof: gpio@58021400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1400 0x400>;
-				clocks = <&rcc GPIOF_CK>;
-				st,bank-name = "GPIOF";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiog: gpio@58021800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1800 0x400>;
-				clocks = <&rcc GPIOG_CK>;
-				st,bank-name = "GPIOG";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioh: gpio@58021c00 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x1c00 0x400>;
-				clocks = <&rcc GPIOH_CK>;
-				st,bank-name = "GPIOH";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioi: gpio@58022000 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2000 0x400>;
-				clocks = <&rcc GPIOI_CK>;
-				st,bank-name = "GPIOI";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpioj: gpio@58022400 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2400 0x400>;
-				clocks = <&rcc GPIOJ_CK>;
-				st,bank-name = "GPIOJ";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			gpiok: gpio@58022800 {
-				gpio-controller;
-				#gpio-cells = <2>;
-				reg = <0x2800 0x400>;
-				clocks = <&rcc GPIOK_CK>;
-				st,bank-name = "GPIOK";
-				interrupt-controller;
-				#interrupt-cells = <2>;
-			};
-
-			i2c1_pins_a: i2c1-0 {
-				pins {
-					pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
-						 <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
-					bias-disable;
-					drive-open-drain;
-					slew-rate = <0>;
-				};
-			};
-
-			ethernet_rmii: rmii-0 {
-				pins {
-					pinmux = <STM32_PINMUX('G', 11, AF11)>,
-						 <STM32_PINMUX('G', 13, AF11)>,
-						 <STM32_PINMUX('G', 12, AF11)>,
-						 <STM32_PINMUX('C', 4, AF11)>,
-						 <STM32_PINMUX('C', 5, AF11)>,
-						 <STM32_PINMUX('A', 7, AF11)>,
-						 <STM32_PINMUX('C', 1, AF11)>,
-						 <STM32_PINMUX('A', 2, AF11)>,
-						 <STM32_PINMUX('A', 1, AF11)>;
-					slew-rate = <2>;
-				};
-			};
-
-			sdmmc1_b4_pins_a: sdmmc1-b4-0 {
-				pins {
-					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
-						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
-						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
-						 <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
-						 <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
-					slew-rate = <3>;
-					drive-push-pull;
-					bias-disable;
-				};
-			};
-
-			sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
-						 <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
-						 <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
-						 <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
-						 <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
-					slew-rate = <3>;
-					drive-push-pull;
-					bias-disable;
-				};
-				pins2{
-					pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
-					slew-rate = <3>;
-					drive-open-drain;
-					bias-disable;
-				};
-			};
-
-			sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
-				pins {
-					pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
-						 <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
-						 <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
-						 <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
-						 <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
-						 <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
-				};
-			};
-
-			sdmmc1_dir_pins_a: sdmmc1-dir-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
-						 <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
-						 <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
-					slew-rate = <3>;
-					drive-push-pull;
-					bias-pull-up;
-				};
-				pins2{
-					pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
-					bias-pull-up;
-				};
-			};
-
-			sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
-				pins {
-					pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
-						 <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
-						 <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
-						 <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
-				};
-			};
-
-			usart1_pins: usart1-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
-					bias-disable;
-				};
-			};
-
-			usart2_pins: usart2-0 {
-				pins1 {
-					pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <0>;
-				};
-				pins2 {
-					pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
-					bias-disable;
-				};
-			};
-
-			usbotg_hs_pins_a: usbotg-hs-0 {
-				pins {
-					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
-							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
-							 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
-							 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
-							 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
-							 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
-							 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
-							 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
-							 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
-							 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
-							 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
-							 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
-					bias-disable;
-					drive-push-pull;
-					slew-rate = <2>;
-				};
-			};
-		};
-	};
+&pinctrl{
+	compatible = "st,stm32h743-pinctrl";
 };
-- 
2.7.4

