Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8654B1E45;
	Thu,  8 May 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746686163; cv=none; b=Ii2HazqKRVceNCMkBqvsG/OgEGEW6OVysSOKAkg5gDMQdiQJAkOamOHWSZCraiGhEJcWje65y9Cd4BW30RBCyjAoQ8Lrr9ZhJfJphYmqQjffujflMSi3f/LUbh4z5/+Uk9PsRi+4xgcIqe6cB8X5lNN8MeOCnDTTVi/uJJkW+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746686163; c=relaxed/simple;
	bh=nUybPfIJN8nxlB8+l3za+c+gQiaPurdscHuMFvr6DO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+H+wti3uKbf6jYp5FsaKDzraDxlKU8AQ+lXYxHPD5x/+HLZ6vlxuqJ1vZwYXAQ9A7LHAg3O3meKx+zA8bjF1jcZx4Mcv65+A0kdBIAf+xDxLz7IMeW6YdaKmkL5YpKkUt+X25I3Ktx8s1A5ODQB6XCvq5ImxUYmv0g82FciGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QUSjx8Qj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QUSjx8Qj"
X-UUID: afc9ab5a2bd611f082f7f7ac98dee637-20250508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J+k3hUUer1eheTQ5q4p0oNapEKv+llZFBmeNNNPE+z8=;
	b=QUSjx8QjXcBcFbUTnvERCNfWsHaaNBXDTfH9tym/UjrcKYbdyAT2x5jM24bnAZaM5TtMJzjstypTPEq+3yRTZCarzsnqNL/Kq2mnVDYT39HiR1e1aFg3npD2QmJyK9DJqwNTvg20jfioLHJDrD9W7P6JRETyVwthCp0/9SnzHhY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:e1517d43-1ca9-400d-bc5d-0844d04bcae6,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:b0b96c80-1eec-4f76-b81b-944fecd9abcd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: afc9ab5a2bd611f082f7f7ac98dee637-20250508
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2036067457; Thu, 08 May 2025 14:35:52 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 8 May 2025 14:35:50 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 8 May 2025 14:35:50 +0800
From: Sirius Wang <sirius.wang@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wenst@chromium.org>,
	<xavier.chang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: Add compatible for MediaTek MT8189
Date: Thu, 8 May 2025 14:35:40 +0800
Message-ID: <20250508063546.289115-2-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250508063546.289115-1-sirius.wang@mediatek.com>
References: <20250508063546.289115-1-sirius.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This commit adds dt-binding documentation for the MediaTek MT8189
reference board.

Signed-off-by: Sirius Wang <sirius.wang@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index fa1646bc0bac..05e827076a7f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -372,6 +372,10 @@ properties:
           - enum:
               - mediatek,mt8188-evb
           - const: mediatek,mt8188
+      - items:
+          - enum:
+              - mediatek,mt8189-evb
+          - const: mediatek,mt8189
       - description: Google Hayato
         items:
           - const: google,hayato-rev1
-- 
2.45.2

