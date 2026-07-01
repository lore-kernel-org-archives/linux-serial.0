Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF7371D00;
	Wed,  1 Jul 2026 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923794; cv=none; b=gc7nAZ+STLnpTsSiJCyjlN+s8ulfs2r5qG++yS/SriGqqGLCBbxJboJ6qGM7DYZFwsDb+EPik3BB7IQ0PzPa92WyNEOgWx0ExynGZjvvl0wnzS2E7sPKH5Jfk38V5TCNFESkjobn7jzLV6znPZjMJgggYKqMNAUcQ9jEJpwULN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923794; c=relaxed/simple;
	bh=5ihOjXMhiw1eMT8WEGagj+g3YULfrVIuO8TU9nVMXX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZf4T+tNb55h7PARSg5jNNW2G23ugYjpskmsnyAaS19xDDWbxyLAflBJJVuWsfrY/Ip72ZWWp+mrncMTDJ7EaQ8otclC3n3gK2WGHcC6uXG9bHMb2THacTucYqSrgUFCM78TKdB0mWpESjG1lKI3pML4B+fKMBAln7syBGzfy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=psMf9Yan; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="psMf9Yan"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782923789;
	bh=5ihOjXMhiw1eMT8WEGagj+g3YULfrVIuO8TU9nVMXX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=psMf9YanVWUts91Uh5Atc4Og/x+rX4dm56rh41XZWtY2Pb4Oq4R1HNq+n9AZev7vW
	 B4Afftm8Xgv1RncNYdxl16t+BnTIN0Q7m5N0L8IjyGw05CwqH1NGu+AjXDl0M4G8nR
	 rIY/hL2x4pBqfKYuO15cixVF6RPk8Cz/qQaiMJWKuL3ZKQ7a9GO/f/YnQ/cktZ5VVN
	 J6wqeUoY3IWi/USCDT/LI6UV6l/TGJ74A3X4a4fB7KWKkZDQ/YMQiD9q4PhrU2C/Zk
	 nTniD//+vg73rP5SUMKBLOQignekakEUefMPoOZaE7pOSTM6tU4dtflUWByTRVfa10
	 /oO2WZWTFA9yg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 53BDB17E05DE;
	Wed,  1 Jul 2026 18:36:28 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 18:35:19 +0200
Subject: [PATCH v2 1/4] dt-bindings: serial: mediatek,uart: Add compatible
 for MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-add-mediatek-genio-520-720-evk-v2-1-19d5da4ef984@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782923787; l=1009;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=5ihOjXMhiw1eMT8WEGagj+g3YULfrVIuO8TU9nVMXX0=;
 b=3DphN/rwspOIJWv/SxkQxuEL5iIHUc4G5Qq7vODX+m6nZf/lTM4MGBhWMC/l3yKFDltPlKSXc
 VGnzgb7vzzPCc8kXCVbP8ZrmrQdZevhyQieAgMztuUGAGL6qyO543oq
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a compatible string for the MT8189 SoC.
The UART IPs in this chip are fully compatible with the one found in
MT6577 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 5bd8a8853ae0..3f0f4aea0a4c 100644
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
2.54.0

