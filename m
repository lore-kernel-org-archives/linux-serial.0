Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596890;
	b=SDNmVb59nrCZRFA6GIEPHapamkONif/XrXm1uCwJIO55MXWK9f75hsN2DuO7pP+jKvJR
	 0yO5QzsVJ1vYdvELeP/q79g5c0U0XW98loCOCKb5MoIGRt/34+gOri/DS5U59sidJNB6u
	 LasEhBNd+hH27hOmOh+aJLV0yEoVmNEI0u/Rg6pqVdzDFI2ghWtY57groa0hYYKOf/mO4
	 F01MHsxMuok9lClTZ+X15fKgU+XNuzkfo6nmm7g2yp2YBtfkBVbbsf8qfBS3gJm6gIgP9
	 kDiGQo8UFGa8fzi4+/TrP/T5Sk0yRRYoKhlPyeVxpKP+/Les69XaeJiRtrN8sutFZ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596890;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gbvwDyU+Acc05Vuh8BWsHE5JqO4e+EP9kLEpKSKS7JE=;
	b=5qff9wErKOViS+/xiBvEDdPuzkDCoeerBia532xN14e/29tVQvWbRRaVkC/p1WUnoC7G
	 JnVZ/h/sK2CUniM2nM4XxP2hEQ74P9FRL8mrFKFc+cT1hnt3nDlwAKCjf/21b/wyrl7Db
	 IzMdRhmHvJej9B0f2fwVvyvmG5OOPj9cPkyHsaTVBLrYX9Pd+8ps0XnkCelXUE7vJlBZL
	 /FX0V4qoJ1zzXThBC+vyXvRqBhzY3XJb5rP56XK2mJ0JkTLKMm0ndpHTms0J3ZLMujxC2
	 jFxtd5TtCRtIsOD4fJfni0DX27U8qrtFbN3JJJ3HbniUhgZ/aQe7l79KRD6/3o76miQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G4tedKCr;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5381A60A5BC1
	for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 19:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5381A60A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G4tedKCr
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4d427836e9so221892466b.1
        for <linux-serial@vger.kernel.org>; Fri, 13 Nov 2026 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794596888; x=1795201688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gbvwDyU+Acc05Vuh8BWsHE5JqO4e+EP9kLEpKSKS7JE=;
        b=G4tedKCr9dTUHeL0osYHCYyb5sGhRprlJVyaCfkJKrgkZ5BdLEMGrYCpKPoiw3xGZE
         x4wRFsryhr1u1jHmsxGRUOKaVgDvUO4AVRmCeUMx9wzbAg0704GjQ6NKSUpUYXOEo4Dr
         OrO/R/o+d0heYsjmowV2I/rmWTmSUNqQa5XX7lVolvGkT4RCo3jKYaYjkK/TAkYRX/2v
         877stSoQ+3S9I9peB61iNcUnGWiDacUURczzYPOiv1+pztlIgF1kc9mvqJrOIqRp52TM
         AMxZWGQvbSW4A+weNKZq7Kj5NR4tGAj0T5HlFjLqtx35nCTxzVYBk+6lbsZ+fYOO5gkA
         asyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794596888; x=1795201688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gbvwDyU+Acc05Vuh8BWsHE5JqO4e+EP9kLEpKSKS7JE=;
        b=mBbqTU6n2IIyto2T6MxZcAINyJ7Z1dRm0Gv6ZESvZcz6CygNgrD0Qt1KC029aJO9EA
         aIKPtXNRV1FhqIacg6wO0eDLUg29KslhxAsg/2z6F9hqEDzack9e6kLheXylcIOSvCW8
         Mqf7CL6R2R1/lG0NsMYC9nvTy2VSpZCYrm4LRhxhLwAZxrY26U/HxmDbqUWx5C894WRL
         xb5f2E1VGLs+7Bxw7JOgH9ARFk52HHKwaChdk7DPcx4Sb+NbZA3WeCJLu0nc7fB6gzIz
         Ih5fET9cb8QMuZu7npmqiJ5Y5ttqiE1wQ0C8gQgPhlKeDTFglwPYiFCaHt34bBpTI6dW
         G8qQ==
X-Forwarded-Encrypted: i=1; AL+hErEUEIL7TT3c5CG1sgkOaU8axuX6+bD9/oQb0VKAw351rMYFc8MRjyBjiF7J+SY235VuCII2xULuWZE4Tog=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y8yYs0+CEQ3KX5IPeH06FxNqqLVnyFJkdjb6naSCNyoHNQN2o
	ubdcDbgINT13VSjyRBpHmjDo0IHRFZICb1zFPz/6Z4oHobTq6Yh5lBSI
X-Gm-Gg: AYBFou3XEy/iLG6lTY+3annIBSVJAABAoavoz6jGxs6YKQoE4AszUmLmwf+vg6ghmMX
	YjdLnw6vDlhavJOF4NwbW2Pk/AAdfJkbOHsbTX1UNCuCFPV69tJubu/a+ncyuFSQzgJ5TpYfFSP
	QO/QHJKBp8LmspSa3LLwwIoeUt892rYzwhElDd7ckO/8o2vLm2tcCYYsZj1RVBBeHKofpNxo3d0
	cxrM1PW60qxr+QnL/EgEEyXimScHtcU+/YwQFUgBGKBQcbkohFn2DxhwTZe8yscDOuqDs9R6pw/
	Q0BUbnGJo0bFUyyP92478E3pd2iU7z+ZNBLlcPYUrHCTqQOe0z5sF8tpXE7HaW8yWAw7QwvPMrQ
	ceZLdD/X60GfYAHeHKbyaaU+4BztEVlhOQLzvms+7RP7fof1obsfVPvIXWQjl2oKOBoCwe2h+SY
	1P+6Zp8KFDsYuNm2E3WCJ8NGiy6bn2lX9vuiAurhLMwdN9XKko0ldP0b3gSw3Bm2uX5cv6R1Jc6
	1XBzMT9gr6tAq3GRqwa6/t6EzONzNAlehc/mfB7/7WVPCeWeOHZzTUIXONenCYY6ZeqUnSfGbwG
	mHRJSzUKjX/HbnTzU9aEhcEJKPh6YEIEb5EHuRypgf4AutylcfyxaLighBUkAx/B
X-Received: by 2002:a17:907:8687:b0:c46:7645:86c with SMTP id a640c23a62f3a-c509641d1eamr287876866b.47.1794596887578;
        Fri, 13 Nov 2026 11:08:07 -0800 (PST)
Received: from [192.168.1.100] ([163.245.50.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23b09sm129444166b.26.2026.11.13.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 11:08:07 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Fri, 13 Nov 2026 22:05:05 +0300
Subject: [PATCH v2 9/9] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-initial-mt6895-v2-9-4ab0aa9fa391@gmail.com>
References: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
In-Reply-To: <20261113-initial-mt6895-v2-0-4ab0aa9fa391@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
 Alexander Letuchiy <asalde.le1@gmail.com>
X-Mailer: b4 0.15.2

Add a device tree for the Xiaomi xaga board, which is sold as Xiaomi
Poco X4 GT, Redmi Note 11T Pro/Pro+ and Redmi K50i. It enables a serial
console on UART0 and the volume down key on the SoC keypad. The power
and volume up keys are connected to the MT6363 PMIC, which isn't
supported yet.

The DT only describes the memory that Linux itself uses, which is the
ramoops region. The bootloader updates the /memory node and adds the
firmware carveouts to /reserved-memory, so their addresses are not
hardcoded here. This DT must not be booted with a bootloader that does
not do this, as Linux would then use memory owned by the firmware.

The ramoops zone sizes place the console zone at the offset where the
bootloader expects to find it.

Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 .../arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts | 87 ++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a86fb313b1a9..d73489149ab5 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -6,6 +6,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6895-xiaomi-xaga.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-bananapi-bpi-r64.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7981b-cudy-wr3000-v1.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
new file mode 100644
index 000000000000..8d529062eea1
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6895-xiaomi-xaga.dts
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 Alexander Letuchiy <asalde.le1@gmail.com>
+ */
+
+/dts-v1/;
+#include <dt-bindings/input/input.h>
+
+#include "mt6895.dtsi"
+
+/ {
+	model = "Xiaomi Poco X4 GT";
+	compatible = "xiaomi,xaga", "mediatek,mt6895";
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		/* The size is updated by the bootloader. */
+		reg = <0x0 0x40000000 0x2 0x0>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* The firmware carveouts are added by the bootloader. */
+
+		ramoops@48090000 {
+			compatible = "ramoops";
+			reg = <0 0x48090000 0 0xe0000>;
+			no-map;
+			record-size = <0x10000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x10000>;
+		};
+	};
+};
+
+&keypad {
+	pinctrl-0 = <&keypad_pins>;
+	pinctrl-names = "default";
+	debounce-delay-ms = <32>;
+	keypad,num-columns = <1>;
+	keypad,num-rows = <1>;
+	linux,keymap = <MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)>;
+
+	status = "okay";
+};
+
+&pio {
+	keypad_pins: keypad-pins {
+		pins-col {
+			pinmux = <PINMUX_GPIO107__FUNC_KPCOL0>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+			input-enable;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins-rx {
+			pinmux = <PINMUX_GPIO88__FUNC_URXD0>;
+			bias-pull-up;
+			input-enable;
+		};
+
+		pins-tx {
+			pinmux = <PINMUX_GPIO89__FUNC_UTXD0>;
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};

-- 
2.56.0

