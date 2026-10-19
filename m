Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D32DA75A;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792370443; cv=none; b=u0TI75XMV5NXULIwy0IEBuCjuTRdfWfqvCdjJpLi7fBRzluqfdXYj8wXa84VY0wZ74HC5TSVDeR0li3yNuB390juG2Tch843bOvKc5BUYdtmetFMQfpdUj8g3kM4F9AmCTR+XDMmjWZdXyWFnC8vNhXbQTe0VACAZX5FNh5WP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792370443; c=relaxed/simple;
	bh=Vzcnb7fHZtnglUZyGE1LG4oLfK8EgPIOWvY+smgPiZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8+cCM4hgCc5c/je7GpV/3V3lUYDOaX0LJaJn4nf2XtrIcb4cgSNcX9uLfaMM4EEmtrJJikOlDgNOJ286UykLOAx20MHpPG2XWd6XC1R4+Em+rWcZ4vxYii2Ygxjb+iGE1rC3/jakY1EtAzM+ODYg3MbL1dacqQoc2l+qDorGrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/k4pss6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/k4pss6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D916C2BCC7;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792370443;
	bh=Vzcnb7fHZtnglUZyGE1LG4oLfK8EgPIOWvY+smgPiZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=o/k4pss6LwOwLKq4RM4ZjOX5nLYOApDAhReGsl4EzyKlB/LDtWFnQvlxAXNV0MFgm
	 8KVKlmBYd6pQEENzTSgpqL0ZHtpCt+RR/m5Kcf0HCdAvG9cb+o0jxtLX40cpvAEwcc
	 /hkcCUThEaDdB39B/DuaFs6RznnzlBLpgrCx4NLyi/+iOKbKgQFXtBSzfefhdyF2tJ
	 QsH3kLRThBJeUP8IyG6KsDaO/zWGhoNhMc+1lqjC3aOFJNCYBZkE1W2xjrPixOEZZs
	 UlMkNBqgbecfr9xR7AVusAWlLe5LuCgdJl8a4XSLbF2lcn8ADOnW18W8WyDvwWJuGE
	 BMFUNHVQVD7Uw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D8CCF2D4;
	Mon, 19 Oct 2026 00:40:43 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Mon, 19 Oct 2026 01:39:57 +0100
Subject: [PATCH 1/8] dt-bindings: arm: mediatek: Add MT8163 Amazon Echo Dot
 (2016)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-arm64-initial-support-for-mediatek-mt8163-soc-v1-1-f2462b2d2437@protonmail.ch>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792370441; l=894;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=Sj9uUU4hqeBMvxPCCdbhjJhVHzkddt07Do2ZWZ88abg=;
 b=i8t+LWCw5nZGoTonFvFX5VP1Sm9vmycUfNTUKkT7CgI1E1JImpienLWsMNsdvjkiFmuush4kG
 Wz0jic5UwFfArO7uIHcpAwPQ19q8KsjeQ4Zwxei/b5GOmlQCq3m1T1m
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch

From: Ben Grisdale <bengris32@protonmail.ch>

Add compatible strings for the MediaTek MT8163 SoC and the Amazon Echo
Dot (2nd generation, 2016), codenamed "biscuit".

Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 180e6e4948e7..15db402552c1 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -129,6 +129,10 @@ properties:
           - enum:
               - mediatek,mt8135-evbp1
           - const: mediatek,mt8135
+      - items:
+          - enum:
+              - amazon,biscuit
+          - const: mediatek,mt8163
       - items:
           - enum:
               - mediatek,mt8167-pumpkin

-- 
2.56.0


