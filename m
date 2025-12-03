Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC62F8BC5;
	Wed,  3 Dec 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770382; cv=none; b=i/ZBK8Ei5zcCmGVqbRKi56tgbmnMWnDfUPGWRPJh0sXXSx00Ex4/lL7sAw8iF/b9PLXXXXVNOatgEluopPYDMECQ7Ca9fq4QOPWy0l3y4hFZB5wcupy+266f9SJMon99iwnEEZc8bmooAUP1oDVsrfj/X5jQOPLcwRlf1Ngc21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770382; c=relaxed/simple;
	bh=7hzRBQrL67XVTnHZ8d374O2SexVHFXVB/Bjw6Nbx9nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F7n8ckAzeB2WmsSGQ1uLlHXfmDSUC6ZJy5F3FHIGO720Khc8Gc7I4IJQl0xVDtWdnZMzvldcvBQqIzFrt8kaBgFNjbhX+MxoHGxuxBdVT6sv4Wy8rr99h2Q0zyjOT7QYQMx4tWCi82hImN7ywJ22owIp64UFdN3t+9PainErWPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KhLOpnSt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KhLOpnSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764770379;
	bh=7hzRBQrL67XVTnHZ8d374O2SexVHFXVB/Bjw6Nbx9nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KhLOpnStngnUxUrufyqXHUMHMh6UrCr3kHIHt9jbHNYwonnEuynOCxIki8b4LEEmX
	 RqWUG2T7rL7a/eeo7judgC9UzNAmyT8B50rzDuvscNlTmo+6SDjy+pq24s1gzwkb1P
	 jkYD4ewqffpkZoa8WX9LuPN45X5mEApvo7CoELT7Y6DITaLd4jsXxm2A3xEQFfledI
	 IlciKhjUWLTMzaMZLEzN6fKa59gjMegnpUEeKYm5+1mg1ovSjgo3cCtSvMyGBv3QQm
	 jF3407HK+3bbj8eWgjFYueWJFYBJ8JnnXdTYrqGPf3xatRhaiVFUXfH/JgGyljuQE8
	 CytLkhBbrxX7w==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8ED6117E0F03;
	Wed,  3 Dec 2025 14:59:38 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 03 Dec 2025 14:59:27 +0100
Subject: [PATCH 2/4] dt-bindings: arm: mediatek: add compatibles for
 Mediatek Genio 520/720-EVK boards
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-add-mediatek-genio-520-720-evk-v1-2-df794b2a30ae@collabora.com>
References: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
In-Reply-To: <20251203-add-mediatek-genio-520-720-evk-v1-0-df794b2a30ae@collabora.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764770376; l=1484;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=7hzRBQrL67XVTnHZ8d374O2SexVHFXVB/Bjw6Nbx9nw=;
 b=Ls128W34lagmawLiu3VvhhIoqo2YDImPp7hy4hg1vqBrmNCg/1wbpxuamUV8qJKShVKi5k+eO
 VRzxSWU8J9jDCfZORxpB+Clxft1mE1/I7I3SCDwiAM8AtL9TUsxKVKX
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible strings for the Mediatek Genio 520-EVK (based on
MT8371 SoC) and Mediatek Genio 720-EVK (based on MT8391 SoC) boards.
MT8391 and MT8371 SoC are less powerful variants of MT8189 SoC,
with identical hardware register maps.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 718d732174b9e3974b1a1bf827f48a347dae741f..9adb3c461796e2b176561db755d7d5131c8951d7 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -442,12 +442,22 @@ properties:
               - mediatek,mt8370-evk
           - const: mediatek,mt8370
           - const: mediatek,mt8188
+      - items:
+          - enum:
+              - mediatek,mt8371-evk
+          - const: mediatek,mt8371
+          - const: mediatek,mt8189
       - items:
           - enum:
               - grinn,genio-700-sbc
               - mediatek,mt8390-evk
           - const: mediatek,mt8390
           - const: mediatek,mt8188
+      - items:
+          - enum:
+              - mediatek,mt8391-evk
+          - const: mediatek,mt8391
+          - const: mediatek,mt8189
       - items:
           - enum:
               - kontron,3-5-sbc-i1200

-- 
2.52.0

