Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888943;
	b=rHrOO4YONi3eawZoCQBI1USp+lcXHFCdjUGdAfZWw7gjcC+njTwyIGs1twqrWOBr4xRY
	 HKeK9mWz17KPA9FcxBPWVXRCBIyeTys7yw3Z/IRPlkmMAJNjSkAkyJ+KDChiclja6BJWg
	 Rogyc7d6FMdiL6JIe/DflDXvay0n6ef0i0Zf77QhSLNsCh8P6uHYhPhzMm+jaoAv4MxK5
	 wyBFr+Lsg3git2annv9IrXUfK76AIdP+VB3MNPwC3xUnZzUHuLTX01gOI304IjJUHaETN
	 EzUC5iGuWBPOJNkrHBb8RvAaCv+r3s9or6MMhRXATp5eNxH9qoEq7xxjGL4tbsSalFg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888943;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xyv5QiQC/fJR9Hi5C+KlTYMrVRwfl8cUX06VGdm38e0=;
	b=i8RMjl0J3pYR/G7NxNzS3k5RTTZYRL0h34fD9f2xcFnQUrJTenAEAbJvHT0nmVPOWjnJ
	 td580fSH0Ifi4rUomOpoVKFmrEDv0yNA7MWcsTMiYpsLdL5yN3GszsEVKlseDzVczqLaD
	 h7LoKRhQILSaY8idoq9+0GAZCSt2SA30KJIPlY0KXaJV9GtrxLNPaedojvVgHpHq4yJX1
	 O4HKteyw4eO8UVxPQSnZ3/L61OUqq2M54Lx2obTGcnjaejEM+qqrlVbYadHwPCN4wsRN/
	 tid+ojsDZvZKJG+408Fc/pgU61M6W2nfWJm+7LPtCfqIJzktzGxZrocP6OPG/d3BmuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ei9BOE0m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D42606A31B;
	Thu,  5 Nov 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ei9BOE0m
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793888943;
	b=gCqvips0I34xCkLj3W0MVdoo2XPTwv4wEmnJOtGa9NmPbjDLJpDsaP74mLjX5d+NEpY7
	 4tfFpwqwJ99QMS/vdMunL4MJUUA+24xYiFsHWf9lCKw0lzEIpfpWftB3LRkUFA863vpUu
	 foiOreb8HY778X5iCZPy5jniE0M24ukYFX9kUEZP2PMd6ENlUc8duxBHoMWI7nzovD1Su
	 Z6HZOgXsilOIeiWImnBVAkpAG+dUcZsYDExoKcLUq1RZNbn8pgVK3uhvj3FVMdM0QoHM4
	 wm8Iu3GjNwlR3QCOUhEWN7eZb2QwCf0cBc1wzmU2wbADAWLl72tyINoYXtfspH20vRQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793888943;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xyv5QiQC/fJR9Hi5C+KlTYMrVRwfl8cUX06VGdm38e0=;
	b=0uXEvwztY7fGRAnREyfc+YqO5czKejdz0QGy9pgeQFXDsQIDmlcuCcWBwikRYR7rqGp9
	 yHHmnCbkmJ/Hf+0RWeL4UePIwGdO7LQZQ9JD0ncfR8EpkZpb5JjZ5blm7+YXQBmn+muNz
	 /fH/0J4trfpFUjf1HjIKPvnqDmRMzfACZq0OWWsy2cLIOet71pbtQVAlKJOSZqDYfSDj7
	 iqoUBOSj8T4pl72Dea/Kifr07BGhMOcQ3hFLvvtR+gBgR4zwqECRoE1hKkBBrtHokFEyv
	 hljMlzPn80o4+WHXwUlpkMRgMXS/jC8sg0VTrF96JDNsQTE36ochxRj0rKJKM/arolw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B01381F000C1;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888943;
	bh=xyv5QiQC/fJR9Hi5C+KlTYMrVRwfl8cUX06VGdm38e0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ei9BOE0mZ1H3E+5eZaJZjM2Z08TSMXaU432FQKSDeblHJRQOtJiF+Xxf5qBS859IV
	 h6gtROO5BLaN77SHrsaJfvtAtpwzK+qq2VNExHXWZvtv2OSwohllBVLKSrm0Gzm4Y7
	 vBudnY15PFRRkopf0C24Bjl4f9O6KU3cGZpByjm8d50mnFpdwG0dv/LDMBEphobjxu
	 U6MNLmMbdH8ao0t/u3nF+qfSCnVFLcg6cOXyRpElcR+9RDEpPkqhQ4CFKq1nV8Dmzm
	 UfBU9V8iogSxj1YGaGYIvCzBlz9J4iOeZJzqqIY6oVJN6Mxeehfx8tEl7NJ+vqdcqD
	 92JBkalcpgjWQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 23D45472A3;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Thu, 05 Nov 2026 14:28:46 +0000
Subject: [PATCH v2 1/6] dt-bindings: arm: mediatek: Add MT8163 Amazon Echo
 Dot (2016)
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
Message-Id: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-1-e68d7d428f99@protonmail.ch>
References: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
In-Reply-To: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-0-e68d7d428f99@protonmail.ch>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sean Wang <sean.wang@mediatek.com>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-serial@vger.kernel.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793888941; l=964;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=68O/KFoEd8IiZ5hJEtL4JTCzMFkMQ0kQN5eapp9a42s=;
 b=wcE3Nn99jWzv7w1Dm9Rw94NFLpd/08GdQen1Di6JhiiMKBMGhEhqLbZz5u/In/9+1LTkJhft+
 0JHPerJVhL2AGcHe9vgNkx/oB0AJh3go+C+huLixrbfd7m2PN+ysRIj
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch
Content-Transfer-Encoding: 7bit

From: Ben Grisdale <bengris32@protonmail.ch>

Add compatible strings for the MediaTek MT8163 SoC and the Amazon Echo
Dot (2nd generation, 2016), codenamed "biscuit".

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


