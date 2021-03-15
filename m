Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E8C433E6
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD664EBD
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCOJp2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhCOJpB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:45:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D316C061574;
        Mon, 15 Mar 2021 02:45:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u18so14999760plc.12;
        Mon, 15 Mar 2021 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67QvrTuPkSOTu9hZW2iZ6dz7yxlmEYHpuvd7fTt+xMk=;
        b=A/to4kbR/0o1IKWP8iniOjA+SYFm0D2WhtH3orbdEvDHW1XTGbH83Pi+eA9Kci/NnT
         Z7R3hJNs6Lfk7wV177QOXa3ZAb10Q6rqwvxAnWizByJS9KOfjybn6fJkoMB/vNdSoWhe
         mbMtiWNiPQwSc/Zw+1pbqOP4PxMhtuxoG/eB0VUZjDexLDHLK55nvNqHxxGu30eI6N6F
         Qpk6HRL4LYhQgIvnjr/JsXqPKr4qyNvHiVgfghVuxm0/sD5TqAefoz66Kfr70mcOmX7Y
         gR2sQHDJ1BJFe8oIyQgRheEBsP11Ra9vcMo+iN9AEwM5L+mfbPpUGQuloQF6FR89k4F/
         tSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67QvrTuPkSOTu9hZW2iZ6dz7yxlmEYHpuvd7fTt+xMk=;
        b=s5G9nhXT8Lyrs/OIEHvDnIruWnCggogYlptau1iT1bh7CngaLHe0wkO4e5mOnJThja
         LVtUycPeLdZU13wB1FWbNNYeL+IpONs1V37+rxOydnpIFX4sfEqJG6QpG3FScx22ZEfs
         LQ4J53CAG8mV8gQblzjoI8Hoc8L8hZhFZEAubSpwaac0MXNHQIhtAHXyaXidN4dBa/gK
         blFuRr5CBH/F+NvJKsPdzxg4mI2dTRL89hooXJupg4BrsGiO0tjtD/usYopCz4+AMxzt
         kWoDoxGc2L5Sul0e35NcHkrb6LVcZSqUkK1lgSwmWzu6M9EMSWl9tEwpgYLStQRg4kF9
         qZOQ==
X-Gm-Message-State: AOAM531bPqSjxiJrTrwukL2bnuu0JHig97U6FgIzfHMkWwYdLLs9d/J3
        LGbePdCCalE4XPqo6jzRN9Y=
X-Google-Smtp-Source: ABdhPJxRaGCVnvYwRiT3x8OJOMf/UkxzfePL9dn/6WbXH71L66jnf/jc33nExQT9jKV2eojmANMxsw==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr5570380pjb.46.1615801499909;
        Mon, 15 Mar 2021 02:44:59 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:44:59 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 4/9] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
Date:   Mon, 15 Mar 2021 17:43:51 +0800
Message-Id: <1615801436-3016-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch is intend to add support stm32h750 value line,
just add stm32h7-pinctrl.dtsi for extending, with following changes:

- rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
- move compatible string "st,stm32h743-pinctrl" from stm32h7-pinctrl.dtsi
  to stm32h743-pinctrl.dtsi
- move pinctrl: pin-controller{} from st32h7-pinctrl.dtsi to stm32h743.dtsi
  to fix make dtbs_check warrning
  "dtcheck warnings: (new ones prefixed by >>)"
  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller: {'type':
     'object'} is not allowed for {'#address-cells': [[1]], '#size-cells':
     [[1]], 'ranges': [[0,
  ....

Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v3:
- fix dtbs_check warrning
  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller: {'type':
     'object'} is not allowed for {'#address-cells': [[1]], '#size-cells':
     [[1]], 'ranges': [[0,
v2:
- reorganize the pinctrl device tree about stm32h7-pinctrl/stm32h743/750-pinctrl
  stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
                        |                          |-> stm32h743i-eval.dts
                        |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
 same to the stm32f7/f4's pinctrl style

 arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 273 +++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +------------------------------
 2 files changed, 279 insertions(+), 301 deletions(-)
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
new file mode 100644
index 000000000000..4157c1b7450b
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
@@ -0,0 +1,273 @@
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
+				slew-rate = <2>;
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
1.9.1

