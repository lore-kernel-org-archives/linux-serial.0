Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04C82BE03D;
	Fri, 18 Jul 2025 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825408; cv=none; b=h5bgLHb6GdiKfpPYfoSuMEbTgsUm+nFhOpsa4aV/5pSW8g8MDXi2bSst+zvHwnX9MFa+CnLU8P+Be7EM7aAzZ/O8lqyYVHIGU7qXRsmh1Ogg/tuQmdTQevovXcp1f/jEwKqgLadvFLwB0CRfVYi8u8sVJ2sWYlnnoSPM2pky/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825408; c=relaxed/simple;
	bh=7Ju6plKMJMc0zJ4PWMDTZGyvZyNEEJ9TALEk+Pw7ChY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVrqw58o3n8nSycw7L2a9XUk28yG3xUBzbvDwHhpjZxWDBy4mfXZCpR+woZ1bCThkd22gJ1Mdope7wDNp+uMcQCkn4EnshNWbqQDAa+AxNP0DnynF1ahZvt1A+mbTwstnyiMrxm2EQqPIiVvU27M/NKMAe4m5IdLXLhZ6VoKmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eimLsBBW; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eimLsBBW"
X-UUID: b91d747663ac11f0b33aeb1e7f16c2b6-20250718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qTk3CaUjrlXYE6puZpLxm2dSmQaEjt3CJufwyvSfla8=;
	b=eimLsBBW4eVYE5QfIHz/MtN1Ty0na+aiKLW0DxysUfFQ5GI0+vYwEtI3hHO0HO8L3IAhuVeQKaYLpvBfJRrj86KXYlgss/RZoux22ehLkF38ZKhGnZkps2ZhkKPm08/IfKRn4e5rGmx9Qckiznh+xmT+aQZfLaav4grCQGXaEJg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:6027e87f-2e8d-4308-865b-627e3e09f7e8,IP:0,UR
	L:0,TC:0,Content:45,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:45
X-CID-META: VersionHash:9eb4ff7,CLOUDID:c793eb0e-6968-429c-a74d-a1cce2b698bd,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:3|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b91d747663ac11f0b33aeb1e7f16c2b6-20250718
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1821469000; Fri, 18 Jul 2025 15:56:33 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 18 Jul 2025 15:56:32 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 18 Jul 2025 15:56:32 +0800
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
Subject: [PATCH v5 2/3] dt-bindings: serial: mediatek,uart: Add compatible for MT8189
Date: Fri, 18 Jul 2025 15:56:25 +0800
Message-ID: <20250718075630.644870-3-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250718075630.644870-1-sirius.wang@mediatek.com>
References: <20250718075630.644870-1-sirius.wang@mediatek.com>
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
2.45.2

