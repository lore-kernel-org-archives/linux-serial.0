Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F1A2E62AC;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=WMCAEmZFkw+I6JxXyjrqrU9SeHfLLhv1Us5dFpHhMz1N1WZ0ey/6zspbmbBcBn+zSw/jbLNCVC67n1ZJ3oglA/0Nf7tq5MZ7C8la8v8Q3xcddwryeH5LUKL4cS19Vtwd8csywPBxgbSG+8uUQmAlJs5GLgrtXCIPentsjZVSznY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=7PwLVEQ1l/CWam5avwfDAl4WzI+bbNpJUldCYiORND8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4wUgGPv97Ncci9UuFxejx29g0q2YS7k93gB0CFoFZYk5LHyRofOJYmVthAN0kmSQBjjbhDgBgQevj/DOcjW0+pdw1ve07RXVD0l0kDJ18HSgvd8CPPM5l8KAqoNfNUiDmUflxB//6hlhIeBqlfvpv3Euu6ECPmsC79Sz50DlEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEBuS4j6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEBuS4j6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68A45C4AF0F;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=7PwLVEQ1l/CWam5avwfDAl4WzI+bbNpJUldCYiORND8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eEBuS4j6b6pUwZfrmcJCBnqwXgIM/7gbc3kGHmVa4Tvqgt0KWBYxFoH95nFUdgor1
	 NIZEPFzqzLlJcwwjgJbwvBnuuvcDzUFuxeKnFX/jzsS+piaN/kO6MbBaeMZrg8XHBi
	 KP0jcl21DwmxhDF3TRQfuKKTS/ePSSbY/fRtVXguqtZoWIynM/sD6oVmw4iFJ3saPE
	 P5y+G/flE2WekDqyfBJ6vS9uELUcCKbpY6AeaqAhUXDN5gcmjcIKElqHtvm42XSuxC
	 cO6ujVVpYs0RrYpir6Q6+ZSwM8OubP0115S8rcomdQwoKId4uCt4XsilzON80N8KaM
	 Tpb1D6TEuDj5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5549BCCF2D5;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:40:01 +0100
Subject: [PATCH 5/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add MT8163
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-5-f2462b2d2437@protonmail.ch>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=2097;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=Vulm21NvWmavPeagurzk/kzAQkRmOdO7M6nqGQtWAlM=;
 b=GVu4gT99GFaTJ/F/Oke2/vOoYoNcqwzj/sP4S54j3BL0yNla+HRzsTkjX4BSOY8+11cfZic1H
 /SoNNOWwGP2AHpfZTYtLPOlNvzIOAD+gaa3Y1WtvjoihU+2PT9Kz8Dc
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the Top Reset Generation Unit (TOPRGU) and
watchdog timer on the MediaTek MT8163 SoC, along with a header defining
the reset IDs it provides.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 .../bindings/watchdog/mediatek,mtk-wdt.yaml        |  1 +
 include/dt-bindings/reset/mediatek,mt8163-wdt.h    | 23 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index f9b725592c27..8e8991ac95ea 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt6795-wdt
           - mediatek,mt7986-wdt
           - mediatek,mt7988-wdt
+          - mediatek,mt8163-wdt
           - mediatek,mt8167-wdt
           - mediatek,mt8183-wdt
           - mediatek,mt8186-wdt
diff --git a/include/dt-bindings/reset/mediatek,mt8163-wdt.h b/include/dt-bindings/reset/mediatek,mt8163-wdt.h
new file mode 100644
index 000000000000..e6add5281e65
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8163-wdt.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RESET_MEDIATEK_MT8163_WDT_H_
+#define _DT_BINDINGS_RESET_MEDIATEK_MT8163_WDT_H_
+
+/* TOPRGU resets */
+#define MT8163_TOPRGU_INFRA_RST		0
+#define MT8163_TOPRGU_MM_RST		1
+#define MT8163_TOPRGU_MFG_RST		2
+#define MT8163_TOPRGU_VENC_RST		3
+#define MT8163_TOPRGU_VDEC_RST		4
+#define MT8163_TOPRGU_IMG_RST		5
+#define MT8163_TOPRGU_DDRPHY_RST	6
+#define MT8163_TOPRGU_MD_RST		7
+#define MT8163_TOPRGU_INFRA_AO_RST	8
+#define MT8163_TOPRGU_CONN_RST		9
+#define MT8163_TOPRGU_APMIXED_RST	10
+#define MT8163_TOPRGU_PWRAP_SPICTL_RST	11
+#define MT8163_TOPRGU_CONN_MCU_RST	12
+#define MT8163_TOPRGU_MJC_RST		13
+#define MT8163_TOPRGU_MDLITE_RST	14
+
+#endif /* _DT_BINDINGS_RESET_MEDIATEK_MT8163_WDT_H_ */

-- 
2.56.0


