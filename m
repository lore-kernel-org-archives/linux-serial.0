Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F1441F5D1;
	Thu, 24 Sep 2026 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239190; cv=none; b=oD/JywBaV894k78hwiDFh9NgeoCGoZjvuTjclbOksmSgWOeN4yyfkkqLZPEV7Vn2ABzeQx6iMagviH79I7TH5a66wv7+77fGzqlICg69BYvER4HJ2WcvQc45S7H6bY05SPjHSPJ46TSUBm8lsO0JwV4cjzukSfc9nqeScDHRvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239190; c=relaxed/simple;
	bh=cYUK43iCiJs1BaFfQJGKkrofjMlF4tYb1uCWfFvnQQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UrX2c+AV1p8IvEmOrVsemwHaGfYBIR317nRAkdq05ts37tnYhNjS0CE3ASl7KAZd1RGWM1Oa1gxmvIeKxex1VEZNv8Mra07QaTcrWsezIKyLxUZVZPnOrOLeeuNM7+TeIFEI4moRKJKWR1EICXITk7hK7hLEC/tEo1dmf2dX4C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E0NkFkTj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E0NkFkTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790239185;
	bh=cYUK43iCiJs1BaFfQJGKkrofjMlF4tYb1uCWfFvnQQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E0NkFkTjKqABup8bv4dOW2l0ikzso12hKqPe8u4AbHjEccje5N8kD0maFXCI0fWxy
	 KQy9dduaDLs0yo3A+IU+wg/0axzr6qe76A+nynOw+sL5lLJxvpd+bZK6nyNTKHRIrU
	 EwHMtUH28pFuSCqGghf4azgybLK0cpVqpTMRhBlZUlyDwtOyw/8XsEpwIrROvHPmU/
	 lce9qoqT1MelxHSqGKRn7TzLzvJy8BQ6c3Xwe4sais7P8Rv6xI5oIfV4kjz2bZBkVH
	 vMzHw1t16F8Kv3D5oG5c6hm5jFYvdBPe4Ku+DPYnxSXMzMgZH6XAcBjLpdG03MIxkc
	 IuQjNAzdfw1tA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E308717E089A;
	Thu, 24 Sep 2026 10:39:44 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 10:38:10 +0200
Subject: [PATCH v3 1/4] dt-bindings: serial: mediatek,uart: Add compatible
 for MT8189 SoC
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-add-mediatek-genio-520-720-evk-v3-1-2ec5c80677d4@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790239184; l=1092;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=cYUK43iCiJs1BaFfQJGKkrofjMlF4tYb1uCWfFvnQQ0=;
 b=KiYuTMYZjTfU3jPelSHVM26FXdg1+kQzsEmORvAr1crEPpxvJNmNX9bR1bTGK09xy3XQrr+5J
 sQ28fMGgW09D4DSkQdcI5gsoE0Pr+Ewzkx3uAYZ9A9nZ/yqsjXl8IAd
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add a compatible string for the MT8189 SoC.
The UART IPs in this chip are fully compatible with the one found in
MT6577 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.55.0

