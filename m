Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43A18DF7A;
	Thu, 29 Aug 2024 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724923753; cv=none; b=V3LHNzStE9p91XEXuLfxQykcyjJe1HMPIgbndpClBw/2VVEdtTKouzRpY9/Ehgwi5FF+7y1DkDcTONzf2D/nHTQusJ7y0eSJdh9UztZTNCMT7T0f7CYJuHZXHNl2JqVFsxq/ViEaModxeT3W/e8eW7CWKKQbqzkOzQ8QCOZffnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724923753; c=relaxed/simple;
	bh=cIqSVAB+/UhZd//K3owngicdgqTbJSSxHcKfNZh6dnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED05LeZGA2H6g3nI20hNwRn3/LP9q6h0lF/xCNcCFb2hxaUgrGm5W4kExMF1kChnBqFleBnhNsixAzQNkyc8+xwdkq2TyYzx4v08UrVDEUaMSJd2ErhADBEKy+3godaQG9pVtMkYAqB/5dxls3dIFBnQs6onpA9Q9nmki1vQJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ZO+SYgEF; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ZO+SYgEF"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B415344D6B;
	Thu, 29 Aug 2024 11:29:09 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Rnl5TPTdR9L; Thu, 29 Aug 2024 11:29:08 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1724923748; bh=cIqSVAB+/UhZd//K3owngicdgqTbJSSxHcKfNZh6dnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO+SYgEF8EqsDtQh41e9CjckxBkUawOuN+h3fRooXCXzkLeCqoxSnRE+0xlT3GKHf
	 QQYLybvvQPpb9Vzp7RCwmVExXEych44ZRwLcFOKqDGzTY0mFG1YDTA0M/MA2CI23MN
	 7Eu1JvyyxLuSYVSm3jBmlttw0IAU8PgFOfPgfth0DCGaFsk6KRatfBc2ulj+7RvD+v
	 /RYlDHO0FS3KQjj0Pw388L5bKg6+skTw5yn9WLVwG9VBw3IhKrTlvgQjgQsPf2iQ5B
	 CXhYs7bw00H0A72IgT/Y9cdFz0J5yMf3KRvCFiJN/aFm4vkyxM1imcMdMOfDcdkNGV
	 38TuEeCz/XTGA==
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Muhammed Efe Cetin <efectn@protonmail.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Ondrej Jirman <megi@xff.cz>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 4/4] arm64: dts: rockchip: Add Radxa e20c board
Date: Thu, 29 Aug 2024 09:27:05 +0000
Message-ID: <20240829092705.6241-5-ziyao@disroot.org>
In-Reply-To: <20240829092705.6241-1-ziyao@disroot.org>
References: <20240829092705.6241-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add board-level device tree for Radxa e20c board[1]. This basic
implementation supports boot into a kernel with only UART console.
Other features will be added later.

[1]: https://docs.radxa.com/en/e/e20c

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3528-radxa-e20c.dts   | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index fda1b980eb4b..ecdd767d0323 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -74,6 +74,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399pro-rock-pi-n10.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3528-radxa-e20c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-d.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg-arc-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353p.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
new file mode 100644
index 000000000000..d2cdb63d4a9d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3528-radxa-e20c.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2020 Rockchip Electronics Co., Ltd
+ * Copyright (c) 2024 Radxa Limited
+ * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
+ */
+
+/dts-v1/;
+#include "rk3528.dtsi"
+
+/ {
+	model = "Radxa E20C";
+	compatible = "radxa,e20c", "rockchip,rk3528";
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.46.0

