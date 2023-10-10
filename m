Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D43CD98E7
	for <linux-serial@archiver.kernel.org>; Tue, 10 Oct 2023 22:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbjJJWuy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbjJJWuZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA3F5
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:50:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3248ac76acbso5508664f8f.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Oct 2023 15:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696978213; x=1697583013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8B+1n8ZspvMDAO+6CGyqMp1YUiIBa+Rr/m0wXbQpt1w=;
        b=XEcGGDWa+ltAk6yU5x8v/VX0p1xtXMFqwqzZj5H3IaqH9s0WWzrv8BUzjE/wEdbs6f
         9u3YEk1jdqLgZatgpQH5Y+rbS9nDJo0+z3Yi5USi/+Phqftko3zmYKY7ah6up9Gr03PG
         nNnPxxXmqmOliHEnVxm1w73nyIxHTpqXX6/jt5rwM3/7J2B4ZYvfo90qySiNO8HYqvV9
         KeSmhP0xDYGcRfovcGSjuNCkluVgEANXJKqe06D1d6Dg7EUdxL6C1ioQfouorSfiZcqR
         7cE5HyZnrj9SeA+vJ4qyop2bqhA8aUxNjVZMrrs3bYTHi79qBeQGGJmYu8/N34fjXUZ6
         Ur8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978213; x=1697583013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8B+1n8ZspvMDAO+6CGyqMp1YUiIBa+Rr/m0wXbQpt1w=;
        b=SJElhnk0WJgRUcJAjzgxkMSXnC1utBGG4tZUh+B7k4t4cM4Y5VQ0GBmwn9TxF6zWES
         J4BYi3YtEcbUtV9ONVID7whXv95dGkZ6CBTlEFgrB0luTr59/b64h6GXE4yMqoWoA7Sr
         DxcyjezG9PPHgSSuoMOxQXap7WTSO1bLOVLTc6/TH+jjrMAgMpxUXq6J4uHr1IIVJXTv
         pc8lb1Vr/iewFazqvJrbGMtEbKnWKwQtAWJOB359KgV9NIpSHB4gAZWUT5y+pYszrrRz
         jPOqkkY+WfbyWTp+T5AnKXC9PZEcrHRPTw2JCF9hQ8ZIc2Z6iyZjpgnjZRqSjTfmbTKA
         8aZg==
X-Gm-Message-State: AOJu0Yx7xewxeoyW7brdWesBoJkP52oXYYBzcw6bbWl6zCY/PgR6qf5H
        sjm02wS1Wc5WLdR/oKSOS2il6Q==
X-Google-Smtp-Source: AGHT+IFNKYWmXPYya1Bjw42Oh7jD9oz26ynuGCLLvWuIaWGFX6zOsUeNHcNJv6bU1UptvL6ZW4qmrg==
X-Received: by 2002:a5d:5103:0:b0:31f:b138:5a0 with SMTP id s3-20020a5d5103000000b0031fb13805a0mr16014732wrt.48.1696978212798;
        Tue, 10 Oct 2023 15:50:12 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm13689547wrm.64.2023.10.10.15.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:50:11 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: [PATCH v2 18/20] arm64: dts: google: Add initial Oriole/pixel 6 board support
Date:   Tue, 10 Oct 2023 23:49:26 +0100
Message-ID: <20231010224928.2296997-19-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010224928.2296997-1-peter.griffin@linaro.org>
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add initial board support for the Pixel 6 phone code named Oriole. This
has been tested with a minimal busybox initramfs and boots to a shell.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/google/Makefile         |  4 ++
 arch/arm64/boot/dts/google/gs101-oriole.dts | 79 +++++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 arch/arm64/boot/dts/google/Makefile
 create mode 100644 arch/arm64/boot/dts/google/gs101-oriole.dts

diff --git a/arch/arm64/boot/dts/google/Makefile b/arch/arm64/boot/dts/google/Makefile
new file mode 100644
index 000000000000..5cea8ff27141
--- /dev/null
+++ b/arch/arm64/boot/dts/google/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_GOOGLE_TENSOR) += \
+	gs101-oriole.dtb \
diff --git a/arch/arm64/boot/dts/google/gs101-oriole.dts b/arch/arm64/boot/dts/google/gs101-oriole.dts
new file mode 100644
index 000000000000..3bebca989d34
--- /dev/null
+++ b/arch/arm64/boot/dts/google/gs101-oriole.dts
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Oriole Device Tree
+ *
+ * Copyright 2021-2023 Google,LLC
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include "gs101-pinctrl.h"
+#include "gs101.dtsi"
+
+/ {
+	model = "Oriole";
+	compatible = "google,gs101-oriole", "google,gs101";
+
+	chosen {
+		bootargs = "earlycon=exynos4210,mmio32,0x10A00000 console=ttySAC0";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&key_voldown &key_volup &key_power>;
+
+		button-vol-down {
+			label = "KEY_VOLUMEDOWN";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&gpa7 3 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		button-vol-up {
+			label = "KEY_VOLUMEUP";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&gpa8 1 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+
+		button-power {
+			label = "KEY_POWER";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpa10 1 GPIO_ACTIVE_LOW>;
+			wakeup-source;
+		};
+	};
+};
+
+&pinctrl_1 {
+	key_voldown: key-voldown-pins {
+		samsung,pins = "gpa7-3";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
+
+	key_volup: key-volup-pins {
+		samsung,pins = "gpa8-1";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
+};
+
+&pinctrl_0 {
+	key_power: key-power-pins {
+		samsung,pins = "gpa10-1";
+		samsung,pin-function = <0xf>;
+		samsung,pin-pud = <0>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
+};
+
+&watchdog_cl0 {
+	timeout-sec = <30>;
+};
-- 
2.42.0.609.gbb76f46606-goog

