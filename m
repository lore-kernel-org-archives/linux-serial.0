Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432760;
	b=iy4YlNtj7oShgnazqSFgRJN9OpeQ0gHWvt9FDSoicKu+LSj8SpocJNa3tidBVZcHpsA8
	 ZrUdI6DOq4tnWm/QNJe5dtQx+AMJb8mfRqLIReBAgN9L7PjkLlKQeAND2CTkoR3ZK4OCP
	 pES/Kv+zFjwLY4pSmzY5MCOvLCYIkGAPjKLmDCOnpU2p9Emw8XvCxrvRnxjcqvJaOJdRG
	 OUwLt9fJDSm4uXkkRYFzURLI0mHIbfsHmPDdIMgCoFNj8mELuXYvsL3FJrw06juTpjVkl
	 o8hRirfszhOMv7r5LRU5Z46OjjSfOJ2WFlrqo5TSrNjFCGgctJygEdkOZ7x9z20voKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZTYyCf3yq+FPJgr8Karin0tCSx+qzJ4PS7WFFQlBVEg=;
	b=qr4SeyJvTZHBF1EnNmc/b4icbfsPIlaNMBrxft1Zz013sO/wSNYRHa7xx/crhyZLEaDe
	 plQ4LAx14nyyjtNxlirTyXJ2zUvMSj1znKKolDsKeWCb+yiFzpCB5jlY2mH3rVTCKLpfV
	 +uveVLtvGQKIi+L4gPHqEXPVQHy8kso4BGvfESyM3cYhmShOvKeeBgyoGwaE/epb8UL/p
	 O4s7HniqdwQcQBxwjrGFqpObdwrw9gZuq9D3PlbTTSUwESB5izBQoC20Wxr5mw05Sws04
	 ASR9ZDFvXATMR8OG1upVOHpYXRE4xzQ5VaFIjQ7SJO0G3a07Ehcm/7YnXo8E/hVHdcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irj4LZ5k;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14511606A68F
	for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 11:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14511606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irj4LZ5k
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d28f75d62so522462866b.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 03:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795432758; x=1796037558; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZTYyCf3yq+FPJgr8Karin0tCSx+qzJ4PS7WFFQlBVEg=;
        b=irj4LZ5kRy6yRgUhGg1kbm92HcmMCoMLneUJ1641AVWfolLANDiIf3OmqL1qK0R86g
         Ztg59feCeB4uIqZUKmoBPxBg/H4XEYVkaT/eYEZiltNrG1SOnYRgzj3YAfeFfVEoJIWK
         1V8zI8+9kody6xxnD1ow7f5yu/kMdzDAEOkfRvWDx1qaHJaU1uqD9tbt1X9kQ8FYZ0yz
         +FvAag8XgfIO+LISFHNN6d5eq9vULtLoT2Pe+xNlwSAzXonylDjoWKMEgxRgc7a3ZBZV
         HK/8SCrP+GMGX7FMKXF8E9mc9oPeOQdPThDbIVyMdZ6aouGkPUI2Ik7Zu7LDLThHuUfO
         Bxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795432758; x=1796037558;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZTYyCf3yq+FPJgr8Karin0tCSx+qzJ4PS7WFFQlBVEg=;
        b=nhGm50XUJzEj0ZstjVrtGrLeEBBt+ghkyf5OXhd7rMYubQxMkliqLoqWXlMtLPKICu
         XWDialbJvL6jAwAudh3WHKeq7VrgcD3X24rBqoDF8wwzsjoZ4sVlQAbsXwHdEYOiw13s
         pBpdKk/Cy4rrerNPJQ/FhoPEN7n3eAKH0pOmZhsZEfd11tyYFkVTUTos4rQLLj1Qcxma
         9GRpS9vxRU/Yy6Mznu2046+3Qgp0g2ROjmTPSQ+7apoT+aksxt6soRSsH7tRCfXRShUr
         u8qJzQfzseag7VBfrT6lFe7z7Pf07QAmID+hXyDv7VzwYr4Q3tHeEbrmME8tQlp4/FmF
         Vv+A==
X-Forwarded-Encrypted: i=1; AL+hErF/KXHBJrOBxRD9igtT1WbmOpO7tyXKI8myMRv8h4fFoLLw7Za3uFgAlL7EyniE2WP0W1BKk3S0liDY+Tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+1c4Otp+G6PWxaC/eAQn40Sa+SxicATBZwqr9tofZLQJivI+3
	uAn59wx+MGjcewb7AMMwZkDa5h/yZFY3glgJmEuXjR/1AWqW0kzdXooI
X-Gm-Gg: AZFdTZddJ7ojq+gee+Mq6Wa7V+yBb/z4L/m9Mtuz8FVMIMq0eElaPs2pUk0+0EzVzQJ
	8RzvjN2J+EZgFXN6LcI2Kpy3eQvzVfnfMdBEa7rnYqAuvnMQg0PauIJDLuzoOiQ0DxvSII82hSe
	5YC+xfQhMIkwOmGuuNlqlCm0Iwo0T2G5VHD88RywS2ni4u29ckz0hFp700zYm7JNgiHtOVWyR3A
	PHuWR9Ezw54yEY/UFgUyipP4Uwd5bJKXwPdc/O0J/RjXtLY/hNBbS3kFhq8c+034OKHYXJ06Xph
	/pBTSOLwBwO8H+B/hX+srzlmPLRJWG10cO9HRHI0wGnShdPToRkX6jPFD8Qdfo4FgmL8wWH5tDb
	PdvwaaUXg7Xg7ayHs8lYGjHfszWGPlO9WIEfx2npm2SNvynB6YiB3nBc6p7OPDjJH7BrHwuxOxC
	bAQaVbUhFEO7Lunuhy2ZbH9bOkPW5CkJaW1D96at/e1ArCJreFhxP3hn7+p5iR/3qIOMlbmtriV
	k5z+jh1GQYE6HOP19yWY7kXWiyyLpj3PNJNsQ+4zG+MKBPkzjKMtWz41IP9Osw00mL/IVlhq9e4
	Xxv5EevAB5q/rt3Wv4+BY7T2owQuP71jHesgXSRM88fuNH9UQ1CEhvR5o16pJapIVQ==
X-Received: by 2002:a17:907:1396:b0:c48:a838:c16d with SMTP id a640c23a62f3a-c513ab4925bmr609639066b.30.1795432758535;
        Mon, 23 Nov 2026 03:19:18 -0800 (PST)
Received: from [10.120.183.232] ([50.7.123.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc679bsm392442266b.63.2026.11.23.03.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 03:19:18 -0800 (PST)
From: Alexander Letuchiy <asalde.le1@gmail.com>
Date: Mon, 23 Nov 2026 14:18:40 +0300
Subject: [PATCH v3 7/7] arm64: dts: mediatek: Add Xiaomi Poco X4 GT
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
Message-Id: <20261123-initial-mt6895-v3-7-95c46597e63d@gmail.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
In-Reply-To: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
 phone-devel@vger.kernel.org, Alexander Letuchiy <asalde.le1@gmail.com>
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
index 000000000000..7bfe0d438803
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
+		/* The size will be filled in by the bootloader */
+		reg = <0x0 0x40000000 0 0>;
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
+			console-size = <0x40000>;
+			ftrace-size = <0x10000>;
+			pmsg-size = <0x10000>;
+			record-size = <0x10000>;
+		};
+	};
+};
+
+&keypad {
+	debounce-delay-ms = <32>;
+	keypad,num-columns = <1>;
+	keypad,num-rows = <1>;
+	linux,keymap = <MATRIX_KEY(0, 0, KEY_VOLUMEDOWN)>;
+	pinctrl-0 = <&keypad_pins>;
+	pinctrl-names = "default";
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

