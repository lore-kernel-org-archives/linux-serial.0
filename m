Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFAD42376B;
	Thu, 24 Sep 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239189; cv=none; b=sx0BPkQmFxJYI/eWQiCoQlkLvZzbWVJs3DW4vjJhz7lYFO8qaUaN5gHqUrV+C9NMaBElma9XtnIMKxRVxdE+lO16cCQkffg974gGlY1wcDEUWPPqMxdt/E4ik6VNX2NQQOOVr9K/z/a6hQH0mqPUCuUFiTMdqxbGA+r2vla1Km4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239189; c=relaxed/simple;
	bh=RlbXQftjDrzhO20EJi3wz+0Try3sBhIBS8ovCMKw7j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaLz6pJMmgnmWfiso8iYusMf32X4hBD12abcsheiK41wTDrS8oXeH9wjsBtNLwHIkIt9q2Vq2nE3vvIRk8d15Qs6TZCgwcpfUQQgfLafS0cj530XZhoY2GZr/gysUpl+Z5DQh+wcYItYgXaZTENskWZYGqZzPHPCOU1bglCcrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DqDrNBNq; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DqDrNBNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790239186;
	bh=RlbXQftjDrzhO20EJi3wz+0Try3sBhIBS8ovCMKw7j8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DqDrNBNqqOoOSbolYQM4mPRjpKncTUZpLrwN7rg2N8Zses4Ffci2UPINvfSJyq0hB
	 Q8YaQB+QLfbUNa62CEw6pURcNpsIF8lPYHSlKspC6vvm9W1w0VGivn16lrDymCbL9s
	 /YWROhRHnwfELTHugfPXFYi0iMxOIi+CFSFj2ScaIyLn9R6d5hO/VG+v7vCGUt58Ft
	 J20RnxmhnqzrZGll2klvHdARHa43WZtnfhIAwTNN2kqYelK/rlLhCp3OhN4xZjGMFY
	 vDlMMkbceOGUTZykCLD6W3zmAAoOajFtfD/0GWN0z0tP9JZBGpz88gayY8VlBEMv74
	 4cy5BruxToqig==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 92F0B17E0A66;
	Thu, 24 Sep 2026 10:39:45 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 10:38:11 +0200
Subject: [PATCH v3 2/4] dt-bindings: arm: mediatek: add Mediatek Genio
 520/720-EVK boards
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-add-mediatek-genio-520-720-evk-v3-2-2ec5c80677d4@collabora.com>
References: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
In-Reply-To: <20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239184; l=1623;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=RlbXQftjDrzhO20EJi3wz+0Try3sBhIBS8ovCMKw7j8=;
 b=Nc52S+/1q1xqeNFDx2eJFz9ixwipZS+krqdFKd/Acfp34dz95IJeVEqpNR64YlL94l9/k5hE7
 2oc+wG1Z092DD3wEkVRtV0rU1ETejwLzxtF/Pt8oVAuTqe+RN/ZCVeM
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible strings for the Mediatek Genio 520-EVK (based on
MT8371 SoC) and Mediatek Genio 720-EVK (based on MT8391 SoC) boards.
MT8391 and MT8371 SoC are less powerful variants of MT8189 SoC,
with identical hardware register maps.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 180e6e4948e7..5a4779d9b06c 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -444,6 +444,11 @@ properties:
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
@@ -451,6 +456,11 @@ properties:
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
2.55.0

