Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB69D372042;
	Wed,  1 Jul 2026 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923794; cv=none; b=CkXc7s9Ri9ZJySO4fUawNXyjvnpMjF0VSgxEAdUTDSwwhO/0vmU2XoUbFIWiB7styGZHn3VymhBChUqSILvHJn/1iuyWrkQO+5yHE49xHBxR0jnc8PkDCSpphrU0ZhtbZWX9LE2TKjurvZ9xm0csEPz+IhFCIkIox2fGGgMG9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923794; c=relaxed/simple;
	bh=TkdNd+UM1kxWuv7MwsIu8de873TDJw/wfTZ4TUm/G1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JApxRXtY/Q+5FdVPkOTZlF+l+fSbI2cNrzwW9Pertd8nltE/0+xxI93dzOePjx6CIZMxAwN1tgVrlfo+AobSdalJ8wOgmn2nHuMLa9Xsg9ISk9Mdxr40tlM5A++esuD9Rx86k6I52LpZhJ/eUu67BdQ9yTlyRY0my73N17NaTRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lMegUmqQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lMegUmqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782923790;
	bh=TkdNd+UM1kxWuv7MwsIu8de873TDJw/wfTZ4TUm/G1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lMegUmqQv3k/gBeRqNmZCL429M4BPfnw25Lwrw+brUsyykdwzKIaxYy+bu8uHiKWz
	 n6IZbNclydFqSPo71jFxsjncm5hI6lvgby/V3dwfX3Zoz4O1Xktr6YdnXDdEpWXkdZ
	 Rps508P90zRhUP7fg1gu+bnfI4ernAFYiuRv+0OIusLFPqIn0HGaLKbwR3e886pVDS
	 ffaVT0oPr74v37M+ejZoFF/6i3dLv0jJeXmplwpEVYq+6bDt1iIPxMYOSMYXfFGkoC
	 D9SqHPhC4Wvd71IgjW+fOzUmpnbHxKJO4aD7xoAmSCu5G4Bh5mENH6TTAemFS7nOyB
	 t9b5xK51kUKWA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5926E17E0D72;
	Wed,  1 Jul 2026 18:36:29 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 18:35:20 +0200
Subject: [PATCH v2 2/4] dt-bindings: arm: mediatek: add Mediatek Genio
 520/720-EVK boards
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-add-mediatek-genio-520-720-evk-v2-2-19d5da4ef984@collabora.com>
References: <20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com>
In-Reply-To: <20260701-add-mediatek-genio-520-720-evk-v2-0-19d5da4ef984@collabora.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782923787; l=1540;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=TkdNd+UM1kxWuv7MwsIu8de873TDJw/wfTZ4TUm/G1o=;
 b=HM+q6wzeUBq6NnEMQuShX1Ctas9iIuMKj5N6nxjO+bp+15E4aouMO4aVDHCc7oA5tevxiws0f
 yYmZOAiR6P8CQrwvYc7L/pHF6int56J3/x4eMJ9OggzRMTUWOcbEcww
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible strings for the Mediatek Genio 520-EVK (based on
MT8371 SoC) and Mediatek Genio 720-EVK (based on MT8391 SoC) boards.
MT8391 and MT8371 SoC are less powerful variants of MT8189 SoC,
with identical hardware register maps.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 382d0eb4d0af..1dd32219f68f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -443,6 +443,11 @@ properties:
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
               - ezurio,mt8390-tungsten-smarc
@@ -450,6 +455,11 @@ properties:
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
2.54.0

