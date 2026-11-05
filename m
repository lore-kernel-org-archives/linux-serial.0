Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793888944;
	b=Pm3jZh3XouVeqIkJY5K0zaEA93idxwOIjg3vmU7XcR6qQ1EfQnBpejnoL5vD2k6S489C
	 C1wZN5FjGzw5gBFcPqEgyVYYBxWG7ye3uECTIj3BbqZm40cepojT5M/KQAVF8YrQSMSeY
	 U0V2Pj1JaeZPn58YI4MN4LHZppZpdwdm0QN1LahGCDuwOnXONCGMNiQbG4jGXQrrZW2lX
	 ty0ABvPJNY8H0yiiDZ1MJ5F6NY8Ue3fpR4/SXvfxFvsK4vZlrYkyJUZLzcxAQibydCvKS
	 mJ2c8nPzh0lC3z3u8RtJQv4eDEnGV6FnRRqaYNOtjQqVUG4nHqO1SlKa+LwfGg2U0XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888944;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=44kYm3cMamSiUZFxE+BEUwzeZQ7tUcCdKQf2cQnVgyU=;
	b=RnMPt/cM1OHb6DqVnrFous2Rm0xaR8Q4SRUGbAtuoo17e4kvOghc1wRRV8b5Fyhn7Y4D
	 5/M3yuW9KltaID3VgRlQKny3XMp6g8ByeZMxS2aJdcMdA/kIU/m63Cz1fuN7FvtyTbEXM
	 pFvwKXPWu1AOKNSKgLvAbt6IHxu2khMZNTQmfHZsUWA0xruFs6I7vjD10K5dpJ/Fq0001
	 vOhIm4dfDqHhxX1z4qQ1zRPvznVKQ93BWvpMvCQbEgniHPc2dN+81ZDjxt0Loe/ETFpGX
	 DYn5vuKLS8bOd+mGEJwefgCd0GWpjseM1Ek8dJJVOJQF7X4zTbd3eum9LHM7SaayoaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPpF2xX5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A3606A338;
	Thu,  5 Nov 2026 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPpF2xX5
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793888944;
	b=XkdpSthdJikgjyyqV99a2ujgAQ8/JaqnDH49SabBORwWR2iW/8qmhA118c0Wlm89c9yx
	 QC+HDP2kofT197WV75+7VjXuBzFhBfuDjyzJhuhkQSt0k4CNw8qyUedvLPAHe+92Dr3O6
	 aOYnsatsWhs2sePtvxO/L0GX4Zj373BPWE6YNukNnsqNxGQqCflzfWExD/bZdJUhpx1E7
	 gQo9Xv70gghrfJUpHuOuvh/gkp8EFhigjhKVbCro4zzvVLBTES2JLzt+rHQPq5KI4T6fM
	 HlA6b+gBIZn6aU78QP61Nyjv6e5NyZI7oahdVucQzzUB51gixkbTjjpaSBb5aQc2Nkw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793888944;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=44kYm3cMamSiUZFxE+BEUwzeZQ7tUcCdKQf2cQnVgyU=;
	b=OUj0MYhUhxIt0+HJ7r8IxGKtn/NEHuX9CJ26fSAhbvzs7uept2gMFOrVqW/m57aC/DC8
	 pEICnpDFFqRkz3yro+kj/gmaYM61ycvZx6TQzarGju/6E6wNwOe8xakb1tecRBIpBFI/5
	 9I188XD/SEVLGVQ4GXDDEmaFe6o8RapX5S9+2576rcIoM9HgfLBKDkJcaTWbRSYklDZ8Y
	 OaA/Yu62fMLtXYE5r+AYI8u9F3mn6X3ELyaQ6T8mbm3nwCTZ5Z/vCOIub4lrTwFChG4Jj
	 AzOswLBssN0F9DWdW3kUArThr8rf/xAFXSGSAIplGrN13nuNMfuZCSoVotsR/q/HzcQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B04321F00A02;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888944;
	bh=44kYm3cMamSiUZFxE+BEUwzeZQ7tUcCdKQf2cQnVgyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JPpF2xX5F1GN7VbJdM843Rh9j9QvkMT76ouB2xbVTqS6KOqcNikPyvLT4d+AxyO9D
	 xr8IKabRqadufQF+eDTLXW48PpTa/esCvu7WhxYNke2bIsw6IbTJIYqYU/S0V9WKKy
	 lStAl4dzSDHkb08+1AVeG00Hzplae07dXTYr3iD1d27uQc873fwoVKDsPF0w/4cL7R
	 7X5opK4U7KGteNizrzdR4KDUNbvFkt15euRjiWMqJ4PLmyHTiALnf8L92Cmf3S25L8
	 rzlwFaHoKQETjzp/QMM3uuNK7IH67dMvbz2QoaHXuyizOm9vkZKHt/iMqm9fqmXNvH
	 R+lw3tBN4t1JQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32FB5472BB;
	Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
From: Ben Grisdale via B4 Relay <devnull+bengris32.protonmail.ch@kernel.org>
Date: Thu, 05 Nov 2026 14:28:47 +0000
Subject: [PATCH v2 2/6] dt-bindings: interrupt-controller:
 mediatek,mt6577-sysirq: Add MT8163
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
Message-Id: <20261105-arm64-initial-support-for-mediatek-mt8163-soc-v2-2-e68d7d428f99@protonmail.ch>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793888941; l=1127;
 i=bengris32@protonmail.ch; s=20261018; h=from:subject:message-id;
 bh=YmOoaDonDykZh2DS2Iw3bOtz/E4ZR22DTEuMIE8WsZs=;
 b=/EAniOMmosS1fSz/G4a8d3ap1Sxp+UliIw6zDqKXbw+YeUQbaX2iLfGL7Q/qU3YBOIGuBA0ov
 1bmSNbhnItoDrp+JejZbddPkxUfyLMB1Tk47Bz34JNj8GRLFt9BPtsY
X-Developer-Key: i=bengris32@protonmail.ch; a=ed25519;
 pk=4ewFRC2yNph/tXokHVzIDlgOA9Hxecf1AlBuD4eOnaU=
X-Endpoint-Received: by B4 Relay for bengris32@protonmail.ch/20261018 with
 auth_id=1233
X-Original-From: Ben Grisdale <bengris32@protonmail.ch>
Reply-To: bengris32@protonmail.ch
Content-Transfer-Encoding: 7bit

From: Ben Grisdale <bengris32@protonmail.ch>

Add a compatible string for the SYSIRQ interrupt polarity controller on
the MediaTek MT8163 SoC, which is compatible with the MT6577 SYSIRQ.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ben Grisdale <bengris32@protonmail.ch>
---
 .../devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
index b94fc3cec175..9d2fc15fc81d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mt6577-sysirq.yaml
@@ -36,6 +36,7 @@ properties:
               - mediatek,mt7629-sysirq
               - mediatek,mt8127-sysirq
               - mediatek,mt8135-sysirq
+              - mediatek,mt8163-sysirq
               - mediatek,mt8173-sysirq
               - mediatek,mt8183-sysirq
               - mediatek,mt8365-sysirq

-- 
2.56.0


