Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D7515251C;
	Sat,  3 Aug 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722689805; cv=none; b=CDCXe1B3qhq5dmW9m7FUjumtH6jOkh0a51KpyLtSq5XiGO06vFJS5HkI7HPbhMtWSvIET8enplHERSojJdGfbkgvedMz7qTlRQDxYbaAbJLmRm9dO2z+iDKNnXkWoPRH7FRLjoFZCVvnekUYxuZjkAcqX3vAqhXsau8yaxZJofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722689805; c=relaxed/simple;
	bh=+39DlTn+1NPKqj39xALS4CS3Z56Hh+NbpNox+jk++Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1JFpDsvQzO8pHkbF3P4YKIErbvNlOLkRxH6DPkMRZTw66oUWo6xq1fk6BNLj8LH9mpCnZpxS69PiH+tRZKi6vUXLqixUFakyJFUBEynfq0xuu+6/GuvFPcSOUmBIgtjWqzQuQUFQ5ha7/60YY6TR/0gCB5gCf65d4xWqkcxA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eIF/28/n; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eIF/28/n"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A43DB41543;
	Sat,  3 Aug 2024 14:56:42 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2rQ8-3FMsvEv; Sat,  3 Aug 2024 14:56:41 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1722689801; bh=+39DlTn+1NPKqj39xALS4CS3Z56Hh+NbpNox+jk++Ds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIF/28/naPF063/OA0n2adU/yOVsmv/FFohGj3I4JN3d0opG4CyFEPkpLA7/8uKrw
	 kNZXWxzFJVXvBpIXn5o3rPGTb68HIe47V7EXhL0VeEFCY76+CNgjDtKQK/yVZ1locv
	 Dt+FpxD4G1Am16eMCNhIdq9sIdxmNdlUUc/3q6i8bx2WP0OVAQRQtDzDeuZNzjwxqM
	 1qQVRwT9f+DtSXIib0JGsg6+JahRZ1SYM5SCTgAyUJqNUNZgQ8Y1WGO/leObpIg7EX
	 oIduQJgkcvdTBFg47ZcvpNlETh2f2x1+whp/liCQvq5RVTB+gmcs7zL5w+r+W1DQtH
	 tlV9Fj/6lO3Ww==
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
	Ondrej Jirman <megi@xff.cz>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 4/4] arm64: dts: rockchip: Add Radxa e20c board
Date: Sat,  3 Aug 2024 12:55:11 +0000
Message-ID: <20240803125510.4699-6-ziyao@disroot.org>
In-Reply-To: <20240803125510.4699-2-ziyao@disroot.org>
References: <20240803125510.4699-2-ziyao@disroot.org>
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
index 000000000000..534bd47e9971
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
+		stdout-path = "serial5:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.45.2

