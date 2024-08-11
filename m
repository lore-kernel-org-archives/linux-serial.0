Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD93C15B7;
	Sun, 11 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723385578; cv=none; b=P/GcZ80kPNyjNCUgYO9/KaWEpeHKU/k2glt1T3JbpRdM26hbNcbShhxBe9oVrB2r5/IA6NpvO5RJEdLt8GvQkGoW0PSkPvAjLXdgEZIQQz4N6W/q8V6QY4MYynBQoqUugSEDR2fhE8umqFaLR/x+mxFln2s/RDTKXVYtZiWj6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723385578; c=relaxed/simple;
	bh=FsXOnoz9SO31Lxbm93ffIh76rgL3IIymEIgRmwk0q9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFio+ljwN5tWoK9SK8609DkhtmkQBZadcx9gW4shmqSx4iWza1fQ03p2HZeN971T2+q9bqaMCCYEMRs3u79DO+kSFiuD3pvRjkSOPJUGsZeWxtOnT8Wk/GgrmVUZJlRBsygDtqpIctsnElx3B+4Qps9/UeEJIv/xl4mAFZ0crR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=SyK7hWfK; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="SyK7hWfK"
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 268D8412A8;
	Sun, 11 Aug 2024 16:12:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SPoyhgfIyU9; Sun, 11 Aug 2024 16:12:53 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1723385573; bh=FsXOnoz9SO31Lxbm93ffIh76rgL3IIymEIgRmwk0q9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SyK7hWfKeZX62wTLr9Ds9evoTE8/l8Xxo/2ryCnia2cGIGugVRdobogwtk/8AKqB5
	 zJvzHluFtjnE421hiIl7j1nwMulG9xufEMj5iEtHJ+uL9lryNeb5ELBSSylVXYNbu5
	 j4VvpUE73lzowqYSWeQ7rMjsv9amQ5pavJbg0TDhBu8NyggB7A+swkD02qTtEgZwwB
	 jjR0xDRFIj02nnk1a7IqhYFDejoaEdW252izuqCYiJztlejmF6I6iw7sA7WemrXCVL
	 lP4TdTdEG/2jHTk5WWdK/LF3jW/rW/qelIN313+iuNYjiHaKCsQ2437b09++RpnJSi
	 gHCB62X8O6g8w==
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
Cc: Celeste Liu <CoelacanthusHex@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 4/4] arm64: dts: rockchip: Add Radxa e20c board
Date: Sun, 11 Aug 2024 14:11:59 +0000
Message-ID: <20240811141159.65505-1-ziyao@disroot.org>
In-Reply-To: <20240811140725.64866-1-ziyao@disroot.org>
References: <20240811140725.64866-1-ziyao@disroot.org>
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
2.45.2

