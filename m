Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0554293460;
	Mon, 12 May 2025 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747050864; cv=none; b=pYvkzHu7/apiz9ccAqR14mmxd1zqLVKVVWg2cdwjj/qZZ593+BJIVInkZkTj/LkXu2yHczCJe4/hRCQovKnydFQeecMRJ+WOF+VGRhJUyA1Z50iSYAWtohPad39DELxwaQNakG6pt/A7pnW8t4mvbBnIc3irVIevZen4Ri8arYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747050864; c=relaxed/simple;
	bh=nK7PIqlBFsQIMmKook3MdxZKJmWErLmya08ExpgM1ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UsMSSimapEkON8vXlWuVqWLnkYrJR/cLwvECg0K3Py7AnPvGvwtcwH3htd0pPdJe3wPhGakBzIUaKzqiS84EafMLGR8N4r3I7p09nU3PcOrq3d/dI3NeIt6GenxWTztHI3i8auTuaDPEkQv7XaolQrCjXNbLYsDoTSpyCpCsa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IVTrF/B7; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IVTrF/B7"
X-UUID: d372e1442f2711f082f7f7ac98dee637-20250512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JzR3NkQ2NJIx5O5Q119lnGbLJrIVpzi/qat5rrANbkI=;
	b=IVTrF/B7thVJkBz8F2BMbvyLT+n1LbrWLKwT24nTCGGeVHd17/3I2e90rnlmFHc6WSH42G7tD5KJLVMB5adtNESP5i2ZWKOFNYsgouJiqQGcKWAzgBmWlqbn1jGpaP9cKHCuqeiEovT8Xsg48CqzL8+OCkdFMe+n5EiCgaOktrk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:03d3eb28-d78a-4993-b21e-405e5dca1fbc,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f0b09db7-5e6b-4d0f-a080-a5e9cb36bea6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d372e1442f2711f082f7f7ac98dee637-20250512
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 590835690; Mon, 12 May 2025 19:54:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 12 May 2025 19:54:11 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 12 May 2025 19:54:11 +0800
From: Sirius Wang <sirius.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wenst@chromium.org>,
	<xavier.chang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>, Conor
 Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: serial: mediatek,uart: Add compatible for MT8189
Date: Mon, 12 May 2025 19:53:49 +0800
Message-ID: <20250512115355.923342-3-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250512115355.923342-1-sirius.wang@mediatek.com>
References: <20250512115355.923342-1-sirius.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible string for serial on MT8189 SoC.

Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index c55d9a0efa19..fabc22d47cb3 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -46,6 +46,7 @@ properties:
               - mediatek,mt8183-uart
               - mediatek,mt8186-uart
               - mediatek,mt8188-uart
+              - mediatek,mt8189-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
               - mediatek,mt8365-uart
-- 
2.45.2

