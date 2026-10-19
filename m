Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B22DE6E6;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=BOZA64itFPh4ZRNA2fbd5OFpKoGDcnvlsApkxKC65FxoYDHy+ZJ0dikV1ReOyLVSVAo2YqKm6FEEOwz9UAF8XtcuTMW4/R7CudoM0cufXyolGVNaat64Tw4UZO5IAVtr+hcqhX/Vt89gIYE8LB9JKsP3lI+VWSM2y69KJ5Nr43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=xFq2x/aqRztmAOrFFHAVPQmHYPuRBQTar4Aj32EZfGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dLDiuRoboVK9ZkuQCeMnLSe0kln+Ipb0SlvZGBPVj5IhqBcT5hDWG+yHB6qsC2M9KnkchRyS99ZGGbQfrcWmj7UYyE5cZilu+TqChd9SZ2Gj6WrHfv3fMs+G2ZbA14UtCARFvyWQm44CboHRzBeKwGzT+r2zMDmWBsxsKwCxxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYIH1b6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYIH1b6/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B909C2BD05;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=xFq2x/aqRztmAOrFFHAVPQmHYPuRBQTar4Aj32EZfGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QYIH1b6/lIFsj6LEoOhqJF8IfxaM6E14NztS70ZmBgSuj/2pVtUY0mO656IUAHUvl
	 8iP8cB1lGFkVL66/wu+KI7MTkfdK+ogCrtqj/ZwnfvT4rP0o2MempiOLMPrxcMAGdu
	 /ZAIKkdFcEyaDXbLx6fZT3awv5m/ykooTjOgknK0htM4XFHIdsriuvuFIHLX8bE1sp
	 ZjgdjT0IaHPCEwX97K7VuR5lHDHzLpNNER/akfJQjCs/EzBEAQBmIopqMlD1qT+K++
	 Kd2yRixYdT7+qVmDhUoybOcC0UXYEgrDKJuS8xA6Fp8haz1MBPpaV2PDopHzkaOb6z
	 sWbug3TCSOBPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4268CCCF2DA;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:40:00 +0100
Subject: [PATCH 4/8] dt-bindings: serial: mediatek,uart: Add MT8163
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-4-f2462b2d2437@protonmail.ch>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=917;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=bqpoWOz5GryrI2HN8kHkj5zmoQrbZs18JhW/gGNozgE=;
 b=pY5JB788jlgfUUPbGOrgKX3YZvvIGTDJ3RA+0cCdLeSM0vOOD6IRRKZ7ZMWU1ekwIniBZqGUR
 68JwQqqUL4DBzLi3I+JzVJMDoFKp35H0ZERWDxmEnKGxMoG/zGXs6Wy
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the UART controllers on the MediaTek MT8163
SoC, which are compatible with the MT6577 UART.

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..11801b58f637 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -43,6 +43,7 @@ properties:
               - mediatek,mt7988-uart
               - mediatek,mt8127-uart
               - mediatek,mt8135-uart
+              - mediatek,mt8163-uart
               - mediatek,mt8173-uart
               - mediatek,mt8183-uart
               - mediatek,mt8186-uart

-- 
2.56.0


