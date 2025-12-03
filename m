Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582902F83C3;
	Wed,  3 Dec 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764770382; cv=none; b=s8r+UMfOqhCiNBBaRIgQllVMMeD2eT3LDi6N2h9Nno4toZCYoBe4vuN2+m6QFw9516Sk6f4FWMhIOm88MGKmYTll4RGiJdcr6BgaYds3PVTXYxhxNdUfuUXljLoaAlbKUXXF2dqsYOcA/JDsMTXGeoTRPHeHWT9O/Ld8SctcZWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764770382; c=relaxed/simple;
	bh=Coa8HH2Y80U+8oDJEeTZktMM2J7wD1YAwBHcYUfHBB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSjnsRdCqJKBghs+W/rAh3kUG6wRMR7rrVfHjJwp3zakvq+/aurtHOfeINkFupbdmorm3vhyUFo63gzxofnlT18qixbE5HCG8LNKSEpMqPHaB7r8keq86I8GTcYCDIE5vsnhP6+T+7+bAW2K13NB8ZBdWEYqsMdOLwvp0WLS8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KpmnDXL7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KpmnDXL7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1764770378;
	bh=Coa8HH2Y80U+8oDJEeTZktMM2J7wD1YAwBHcYUfHBB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KpmnDXL7Oy0frt5g96fb4XsIU0VNv2JEJk+Mz9zETt3l5ZdyuXGAQFZ8njVdXA8Vs
	 ABRLoMLd4bjzqrukfipOqP96qmy/PIzYJvTt9nBMxJyURTmYtRUV0HSPVgXpVs4zmE
	 9Mcv61a+Yh0guVw/G8snxj7itv190JRVji/59Ml09pBvbxJfk/Kkz9zBeWgoKsYkzf
	 wlv8fcxvilSF6XLVjwaSdW08H0gCYw55iLF6bsPPqNFRuiDyNHcTOECZtoGwYTrQ74
	 NvJ6h+Ry/ivq1GvDCgcnOeK7YwTxBoeDauWNvkr88vn6KOnzNzIpFFIQOPHrf0qxGF
	 5uwKwgFt5Iizg==
Received: from yukiji.home (amontpellier-657-1-116-247.w83-113.abo.wanadoo.fr [83.113.51.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CB0E917E0330;
	Wed,  3 Dec 2025 14:59:37 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 03 Dec 2025 14:59:26 +0100
Subject: [PATCH 1/4] dt-bindings: serial: mediatek,uart: Add compatible for
 MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-add-mediatek-genio-520-720-evk-v1-1-df794b2a30ae@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764770376; l=995;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Coa8HH2Y80U+8oDJEeTZktMM2J7wD1YAwBHcYUfHBB8=;
 b=Y5mQykRO/xlACP/ELaAg9N2ySD3XHV5tyS3bTSZsebFcO5XddKxaH5zW6fA+n5tekkPqfDTaq
 a3LpGtHPgTVAoTnSGq89TU0B58HRMoJmSfz5AhwHH01EiOHcsClyTCi
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a compatible string for the MT8189 SoC.
The UART IPs in this chip are fully compatible with the one found in
MT6577 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0d4ae309d28350fd54b6f9b4e731e..3f0f4aea0a4c0ef11055ddd08ba71d045e7fa519 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -47,6 +47,7 @@ properties:
               - mediatek,mt8183-uart
               - mediatek,mt8186-uart
               - mediatek,mt8188-uart
+              - mediatek,mt8189-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
               - mediatek,mt8365-uart

-- 
2.52.0

