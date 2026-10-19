Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F62F8E91;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=IAhjpFmsg5+a7Z8scxbOfaxnKak4gNl4mbfyBVY5Jlv9YMcPusGuaa8LA689V2cRMyAXMm4DbFw9f5s8f73xSNZDRLmR7hq6F/2l+1hwTLNG4BTlV/ossS4HXx8zFxhBoRjLez8LE6XVH9eXwSB61TxUpqpYHTOzV+sWkRbCcA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=aJi2GHcpIfw3nva8jRTMuRpV3QtcVxJMYttpfjIulcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SBohLObhdCxSfZsrqphPj5IodoLK5+EKz0bG1K+rudV+MwLvwfZTfdISyS9n/ZefQqFd9KTfyHfcEnkfjpTeFBUQdppYl+t+R+XhpvjZLtNVL7jzqQHs7SIx/VqcWHTnYm3x9oAlnWWkxMNoEMaXjaKQaEZbaFyZtBrfTvgYh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRPxJA2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRPxJA2e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0F46C2BD04;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=aJi2GHcpIfw3nva8jRTMuRpV3QtcVxJMYttpfjIulcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MRPxJA2e+TS0axySprJNGYoI/tkikStoNLQs5guRaOacZ81yeRV9wD4QSgGlT4gMy
	 eLT/xqC39gbd4s1jILF3Gt2SnoL85obc+sTxTovFF4/0Zvp3QJAkuCzOCypZ4Nr5O+
	 HHaWWLiD1+Ik5fNw4+6Y2/MSoFvaxCZWkcYEneTxPiNV0SrmPTIOFtbQ1hhoHQm+n7
	 ap2j6E4t36HwmgZfuskowrf9aWy3QH6DCkSnzklFkP1vAqWznDw0ijaVkLv5urzWu8
	 MpdXRwNbiofkXe252pargxiYVIY7F9bHQLTPfigPzrxVHLge/nyIbRZ+/ko87yYDrU
	 IA1kBRXP/mXIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA7CCA490;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:40:04 +0100
Subject: [PATCH 8/8] arm64: dts: mediatek: Add Amazon Echo Dot (2016)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-8-f2462b2d2437@protonmail.ch>
References: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
In-Reply-To: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-0-f2462b2d2437@protonmail.ch>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=2808;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=lMdVcco71nADP8HucTPUNLICr3LWil3QPPZ2t6j8t8U=;
 b=p4XX5KEds0C6IcSEby9uWvdCn4txfVKinsxi/2DQ5ZRLYb9RgT70XEdkOHdcYivkPI4/n9b7y
 3p1qPTT6D03AMCILGR/WhFqofuQ/WbM9Q2F+58kZ03UcMaOrEkHGi4P
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add a device tree for the Amazon Echo Dot (2nd generation, 2016),
codenamed "biscuit", which is based on the MediaTek MT8163 SoC.

This is enough to boot to a shell over UART0. The UART pins are assumed
to be configured by the bootloader, as there is no pinctrl support yet.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 .../boot/dts/mediatek/mt8163-amazon-biscuit.dts    | 68 ++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a86fb313b1a9..adf02b9f234b 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -92,6 +92,7 @@ mt7988a-bananapi-bpi-r4-pro-8x-sd-cn18-dtbs := \
 	mt7988a-bananapi-bpi-r4-pro-cn13.dtbo \
 	mt7988a-bananapi-bpi-r4-pro-cn18.dtbo
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7988a-bananapi-bpi-r4-pro-8x-sd-cn18.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8163-amazon-biscuit.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8167-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8163-amazon-biscuit.dts b/arch/arm64/boot/dts/mediatek/mt8163-amazon-biscuit.dts
new file mode 100644
index 000000000000..5fb5d59e4ed2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8163-amazon-biscuit.dts
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (c) 2026 Ben Grisdale <bengris32@protonmail.ch>
+ */
+
+/dts-v1/;
+#include "mt8163.dtsi"
+
+/ {
+	model = "Amazon Echo Dot (2016)";
+	compatible = "amazon,biscuit", "mediatek,mt8163";
+	chassis-type = "embedded";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x20000000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
+		secmon@43000000 {
+			reg = <0 0x43000000 0 0x30000>;
+			no-map;
+		};
+
+		/* 16 KiB reserved for SPM firmware */
+		spm-pcm@43030000 {
+			reg = <0 0x43030000 0 0x4000>;
+			no-map;
+		};
+
+		/*
+		 * 6 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x4380_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x4360_0000
+		 * |     TZDRAM 4MiB       |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee@43200000 {
+			reg = <0 0x43200000 0 0x600000>;
+			no-map;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.56.0


