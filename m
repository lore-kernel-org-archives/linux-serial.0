Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8B2472BE;
	Wed, 16 Apr 2025 12:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804966; cv=none; b=uYsmX+5EFGMi2HsCyCF97GBvrsLUNyyFDGgBleDuzhZmnnRO9SxIgfJNgvCKoN1zZoJqBJOPkeSStCEUjw7jS8duAIJX7P8C1Z+MkAXJTYy0pwOf0mzvJGuLny/dAIF5ti99TjaPTgEtXONM3GdVM9m40upRBkc3wWKoJZvxZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804966; c=relaxed/simple;
	bh=Hv3UVjNR1RDcGhnznCYyaIgzVAYJBu1yjNcbNUYluO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Owrco7oL/vHS8vUw1lS2/0kw5FPMKo5OB65QfZAn34o5nKzD9GaMJt6t1tpyrPmuKTQPBfpcBbrn2ALmuCK9wTLDmwAq78jM+UsIeFTHKqrBy92IRlZK5JOyuBJAhkH7b1T8k4A1tcU5GKleTsTe/b0mZxdjcn/18Yokos4lsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IipcR+wC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IipcR+wC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744804963;
	bh=Hv3UVjNR1RDcGhnznCYyaIgzVAYJBu1yjNcbNUYluO8=;
	h=From:To:Cc:Subject:Date:From;
	b=IipcR+wCUlnrzntXCJbTAoewVyL43rK6RGsvZaZD+2qFtERDEq+iVU0k0zq0d5Qgk
	 fyc0ur+v3Dxj6rk6IMPhoeizr0eVwPM4Jer3Pt6cyynAiyQHv0YE466TDMVOrMMEFj
	 UWP73wqAf9zZAG18TaCzXfKAZWxiUMcxCHdBIEEjUPEy9ONXpXAq1qOcIR7nzYLTUa
	 V/mwhGGK/dQ/zNQgiUMEJFEazNMfqEY2mdC3KUAVgx7uSOUHrm/xXs/c3bQmtAoP9c
	 1BwwSLvFeBONE+ssLIqzDLHItoVJs87+7c4DWRO/AhIQJCPmmNYjUantea5PLAOtQ6
	 bjTUe00kq2HAA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9A7C717E3624;
	Wed, 16 Apr 2025 14:02:42 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] dt-bindings: serial: mediatek,uart: Add compatible for MT6893
Date: Wed, 16 Apr 2025 14:02:41 +0200
Message-ID: <20250416120241.147925-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the MediaTek Dimensity 1200 (MT6893)
SoC, which UART IPs are fully compatible with MT6577.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index 1b02f0b197ff..c55d9a0efa19 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -33,6 +33,7 @@ properties:
               - mediatek,mt6779-uart
               - mediatek,mt6795-uart
               - mediatek,mt6797-uart
+              - mediatek,mt6893-uart
               - mediatek,mt7622-uart
               - mediatek,mt7623-uart
               - mediatek,mt7629-uart
-- 
2.49.0

