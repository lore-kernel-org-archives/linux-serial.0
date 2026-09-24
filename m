Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0B43BDC8;
	Thu, 24 Sep 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239190; cv=none; b=qkRiFtvJoQEJJhrJAK5JYDp6PDW7OmX+xSM/OY4H+FPB8jCdEqToLAl97eSDtGmnxhrC1+0NH2A5gKr5Z4UuVSFJPPP2TlgkFKfeRsKCbA7XtL1DfCqOwMSt/C9NEbJhUTxcrromWt3g6yOavqCGzdUydvKOt455Nz/7ppBb/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239190; c=relaxed/simple;
	bh=EETdgEDLf9xnEdLLlR5xefqHysCkpeORLVvQGQ1eyMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=geRt2Mx3WRQl1jsHKnwPnaXZg+cXmqc9etsu3HmsgO4z9kU/fZ+CZ8Fd+7wDlTCor4xOlcWLFHOvJGjZ6un6bXZ9Hh4kUFqIEeN+FdZZvMI8vH8ry5PU9dqhIyaI8BoXBMGPU2GEeTANCIQRgzKqRLNGyhwoxfbd73LEDd+TLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j9VofeK5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j9VofeK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790239187;
	bh=EETdgEDLf9xnEdLLlR5xefqHysCkpeORLVvQGQ1eyMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j9VofeK5yUZlxAnjy3Sd24TUNbe2q0htxw8A8COQW0vV68/uILWcHKSN4fU/46Vez
	 9Wx0EuOOIT6hoY7QatxUvjot8n9bwFxRSSX+xkH2I8iQd99vVIH8819/0uyXOS4nDO
	 yX3qnAW+FKgdyCm6YAAjB+hv3saSRlhHTMn+AXWpoe8hW7DG48oVQ0mNNyD5wmG+e+
	 gwC54PmSqToF2+6azUX5mqmrCUUdmPzKCEgsCZKKyHMP4cedR8dE+6FR2/z/t//KCF
	 c6x6WgjYEGXQa2Hdg4vfBwT83MQw3RGetTOSUbQFU3C1l2yANZ2741OO+XCJbtavkd
	 eWNzZnmHiqDiQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E2C8617E0A6A;
	Thu, 24 Sep 2026 10:39:46 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 10:38:13 +0200
Subject: [PATCH v3 4/4] arm64: dts: mediatek: add Genio 520-EVK board
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-add-mediatek-genio-520-720-evk-v3-4-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239184; l=3368;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=EETdgEDLf9xnEdLLlR5xefqHysCkpeORLVvQGQ1eyMk=;
 b=TXovTYgd41NpTpxrSao0sRVf/zsni/cXGy69f9J/nwCaVk9DcyJtpMZ+qsJgluIP+6+/BabBX
 bDqHuILwm9RBaktDU5JwNv87o9wcrw+SkldMyaifzK+EaKNJViN/UDF
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add devicetree for the basic hardware enablement of the Genio 520-EVK
board, based on MT8371 SoC.

MT8371 SoC is a variant of MT8189 SoC with the following differences:
  - Arm Cortex-A78 CPU core maximum frequency (2.2 Ghz for MT8371, 3 Ghz
  for MT8189).
  - Arm Mali G57 MC2 GPU core maximum frequency (880 Mhz for MT8371, 1.1
  Ghz for MT8189)
  - one ISP engine instead of two
MT8371 hardware register maps are identical to MT8189.

The Genio 520-EVK has following features:
  - MT8371 SoC
  - MT6365 PMIC
  - MT6319 Buck IC
  - MT6375 Charger IC
  - 8GB LPDDR5 RAM
  - 64GB eMMC 5.1
  - 128GB UFS
  - 20V DC Jack
  - USB Type-C Power Adapter
  - Micro SD card slot
  - Push Button x 4 (Power, Reset, Download and Home Key)
  - LED x 3 (System Power, Reset, DC-IN Power)
  - USB Type-C Connector (USB 3.2) x 2
  - USB Type-C Connector (USB 2.0) x 1
  - 3.5mm Earphone Jack x 1 (with Microphone Input)
  - 3.5mm Line Out Audio Jack x 1
  - Analog Microphone x 1
  - Digital Microphone x 2
  - Gigabit Ethernet with RJ45 connector
  - DP x 1 (Mode over USB Type-C)
  - LVDS port x 1
  - eDP port x 1
  - UART x2 with serial-to-usb converters and USB Type-C connectors
  - UART Port x 2 on Pin Header
  - M.2 Slot x 2
  - I2C Capacitive Touch Pad
  - 4-Lane DSI x 1
  - 4-Data Lane CSI x 2
  - I2S Pin header
  - 40-Pin 2.54mm Pin Header x 1
  - CAN Bus x 1 (RS232 Connector)

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 arch/arm64/boot/dts/mediatek/Makefile              |  1 +
 .../boot/dts/mediatek/mt8371-genio-520-evk.dts     | 32 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 5c75ea1ef09a..e6a8109ffbaa 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -168,6 +168,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-genio-510-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-grinn-genio-510-sbc.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8370-tungsten-smarc.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8371-genio-520-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk-ufs.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8371-genio-520-evk.dts b/arch/arm64/boot/dts/mediatek/mt8371-genio-520-evk.dts
new file mode 100644
index 000000000000..b4fd343bc08a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8371-genio-520-evk.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+/dts-v1/;
+
+#include "mt8189.dtsi"
+#include "mt8391-genio-common.dtsi"
+
+/*
+ * MT8371 SoC is a variant of the MT8189 with only one ISP engine
+ * and lower maximum frequency on the big cores and on the Mali GPU.
+ */
+
+/ {
+	model = "MediaTek Genio 520 EVK";
+	compatible = "mediatek,mt8371-evk", "mediatek,mt8371",
+		     "mediatek,mt8189";
+};
+
+&cpu6 {
+	cpu-supply = <&mt6319_sid6_vbuck1>;
+};
+
+&cpu7 {
+	cpu-supply = <&mt6319_sid6_vbuck1>;
+};
+
+&mt6319_sid6 {
+	status = "okay";
+};

-- 
2.55.0

