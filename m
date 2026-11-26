Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795696895;
	b=wXDPXdwGgIykk089Rig+CA6a4ovCoOC+t8qfcA0gSbKi32YtM7+22qeM38QAVYsQxgrT
	 sqA/eI3onu7cI75iO6KPW5z6vxTAIn+UhpQBeOu1YxOalqKBGaUf8PY9ClYdI7wNFK9da
	 9h9M5zBofDtovBiGSKSci70PBpeVMsYTr81psOxb2bF6u0WsWkk6clP72iy1m2ADLSkN1
	 lZ///+Ac0PITP164RPSD7b+hDuEBqsTlX62s7RH1Ht927fuci963l90P2n1M0XBGzNkqK
	 sBlLPwTD7fZYGRsZ5tf14+vkrvAjIXDjrA2umyjNWG4XMRCUdXCrFOWR4Hld+3Z5/fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795696895;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xjrOLeIgU+Jt8huWuao5zS5XaiEWZMlqxSTBKIn4L/k=;
	b=yJ52v9vRKs90ZNH/V944V8pdepMluA3Rvwon7XdPQUEtKTdyvyEFJnkpgSMhXKJ76UZS
	 3bIgDYaY38CBXx5ABrBc4LsDX7IvFor5zykZZA1hOxNNvBFHTVkA2hEWYKlFTzowXvvSA
	 s5OEd0obOd53jazFVQ8aR/NvodUH/wje48+N0AlLaw8fNYpsnSE/t2nNgbjZR9M024cUu
	 NrT7O0FsxwRwDRinp0LU+a5ZfTfG0C7ISm8T7DF26bG6bofMlTcro82IWxjVGsXhrM3Oj
	 VAi61xg1FX3Lc0Skcq4jdG4VADbBNFzwPvrexgGcUhlTGDtkmKOjSPP6O8x0sDWFs5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1rqgCJK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439D606A330;
	Thu, 26 Nov 2026 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z1rqgCJK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795696895;
	b=yapFUQs2mMdaIzFV4+u2moU/SINddpzum38bkdbUZScL7i/hzmbYHgA/sKHLQEmpYNmB
	 qiHc79bHRahpq3bqY+mIV2hBQLgP45iRkkqPDYTB9xuMZqWFIp2doVCgX/FhelDa7QmYZ
	 +bXswDfkvi7KLmF3qbWdkXazJD8TS7zCc/iLDcy5NoniF4OW31hG8ygRHlAXBUzaA32jE
	 E1PSTlX9EXxtNXN2YzsePPauMDil+mIZGgiKzYmemCcWflb52S+fWXQzqeXzYjwPwdjkb
	 5IXOZvW5EtiTivxSNzmJXZD4obsAy8nhqO65Od/qhRG3t0vEQ4JPkKQBduhRrvItGgQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795696895;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xjrOLeIgU+Jt8huWuao5zS5XaiEWZMlqxSTBKIn4L/k=;
	b=mGAlX/QvIlKiURH9kpwkIb3xgFKBKQRdlORoPIr0L+hD+SCX0lMlVqL1f1bTcXPiJ5hZ
	 6yvWNsC39MozAEPn3H+F9pLJ/j4MJxTFsS876JKY0ln7EPGrJFjdvEzFw2sxrtjW+RpUm
	 5vECCT0QMwisXfiWS43x1bMCuSniX+Qb/CW9nSQX4//hEyYyzQve+g1znjN9ismwsRJPr
	 3FgsqN7/NniKPORmB8rvjlMz3BYTIY3VGCXdpqMz4CT9ELy0lulFxMhHUcSRhw47rEBCi
	 PINdQ9Z46mjTA6hOoggVYsfvgSUdDpnNgMLoNqmnWYWscWsO89C5T/jjYaGaV4DAHWQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 28CD81F00A01;
	Thu, 26 Nov 2026 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696895;
	bh=xjrOLeIgU+Jt8huWuao5zS5XaiEWZMlqxSTBKIn4L/k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z1rqgCJKhpKFRG2/1td8a55lngW/RECx61TqKt/qEhRhZqHPgl7AAC6bw8Iz4RXHh
	 U6wMtEC4zkRj3wjAhl9qI2qLTcaBZO6B5mWCzLmf6QEFFWVJQpZPsLjA/OtukSU3FN
	 NoEchxn3jUsAHB+Wv/ORMWM8qSLgKctWJHOd6HMpn0e9g72MIPsxRcPYNiDarYJ5o9
	 LK2CQHi2YZj3ivElYUzUaIF+sui7QOBLQUrBIe4PtDpJozIOllS6PNCL6LPQYoWoHg
	 JADj85zRHAwbICJMox41IKtNeNXDhyE8nEtzeMHOH0GakwhW6KOGUcmbngNQaOQlZj
	 pgOrXT9dwl34w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6B2584D4E4;
	Thu, 26 Nov 2026 12:41:17 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 26 Nov 2026 14:40:01 +0200
Subject: [PATCH 8/8] arm64: dts: mediatek: mt6768: add Xiaomi Redmi Note 9
 support
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
Message-Id: <20261126-6768-init-v1-8-abc364a2447e@protonmail.com>
References: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
In-Reply-To: <20261126-6768-init-v1-0-abc364a2447e@protonmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795696875; l=2173;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=ZShCzvXiUl5hDnYMk19Pl4AsLIEnkMmW90NbhX636XU=;
 b=ViSO2Xd7qbcrP7tQ7Atr+iYYMlaWMHJsqTCykJzxr0uCF8iTh/kzta/JBbCKByfGXu/q+i76N
 xu7CAp2Bv25AX3wx/KMpUMiLnMgY9UoN/v3UswcgIon89zN6d1xOCN9
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Xiaomi Redmi Note 9 is a budget phone released in 2020. It features up to
6 GB of LPDDR4X memory and 128 GB eMMC, powered by the MediaTek Helio G85
SoC.

Add initial devicetree support for this device. It can currently boot to
a UART shell and use the simple-framebuffer provided by U-Boot for
display output.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 .../boot/dts/mediatek/mt6768-xiaomi-merlin.dts     | 42 ++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index a86fb313b1a9..4fe50c95321f 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6768-xiaomi-merlin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-sony-xperia-m5.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6768-xiaomi-merlin.dts b/arch/arm64/boot/dts/mediatek/mt6768-xiaomi-merlin.dts
new file mode 100644
index 000000000000..f95bac31caf3
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6768-xiaomi-merlin.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025-2026 Roman Vivchar <rva333@protonmail.com>
+ */
+
+/dts-v1/;
+#include "mt6768.dtsi"
+
+/ {
+	model = "Xiaomi Redmi Note 9";
+	compatible = "xiaomi,merlin", "mediatek,mt6768";
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
+		reg = <0 0x40000000 0 0>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		/* 384 KiB reserved for ARM Trusted Firmware */
+		secmon@4ce00000 {
+			reg = <0 0x4ce00000 0 0x60000>;
+			no-map;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};

-- 
2.56.1


