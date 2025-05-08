Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3062A1E2834;
	Thu,  8 May 2025 06:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746687065; cv=none; b=LlQAJfO7KLzBLyHkOBIgpKaJUz/WwCozkCGB7EC727DVRGih8uYiu4YiOBfedf5R31dj1cNv7SL/1pTCFPT+5yAeO2Sc7MaLjYgagWNovQkCWfwTSbzorp2vX69taWqUxYjS5jenszCCVXYmhwmFvtmlA/KCP+gK2RI9gNQjZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746687065; c=relaxed/simple;
	bh=FkCdo7dAcSglYXbqVuPv5hsRPFSMgOq/XkJVA5QHE4A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CXxiavkUU4gzWI8FIP6MaS6bbM8kxT3V1Yw65VM/GeZ+vo1fctRAmEKIhqEZ+gCz/t56EcHFnLGS5qKJdJ87avlTUWD1UwO1NBzy1BdePx8x9q3hPrey6nkORZR6zy3F8hwrliao/43CkVIzDn3t0TJRgdN/sp40nr+Rpztr1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VES4WW4z; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VES4WW4z"
X-UUID: ae7e35362bd611f0813e4fe1310efc19-20250508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Su047Sppq7uONa06M+w7gzfsschD6RdoQtcrFCukfYw=;
	b=VES4WW4z7xtxgHfyKEgiMu8SAx9vkSSZzsGt4JUIelVvY+eR58Yj4nLT5f7eedfXsHDndVzKKw5jsADFq17nKf3fXRitSG+yHRkyiTavc4OF4sKcgMiUqxuSwFy/mBdc/Mc8MorzQUtGztSgEU0kzdlJoKVVaoPLq64ABycsMfA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a8fab142-f430-486e-abb6-4ef52518307f,IP:0,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-30
X-CID-META: VersionHash:0ef645f,CLOUDID:10b2bae0-512b-41ef-ab70-9303a9a81417,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:2,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ae7e35362bd611f0813e4fe1310efc19-20250508
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 225392350; Thu, 08 May 2025 14:35:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 8 May 2025 14:35:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 8 May 2025 14:35:48 +0800
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
Subject: [PATCH v2 0/3] Add mt8189 dts evalution board and Makefile
Date: Thu, 8 May 2025 14:35:39 +0800
Message-ID: <20250508063546.289115-1-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

We add basic chip support for Mediatek MT8189 on evalution board.

In this series, we also add dt-bindings document definition for MT8189.

This series is based on tag: next-20250507

Changs in v2:
 - Fix warning issues for make CHECK_DTBS=y
 - Add mediatek,uart.yaml document

Sirius Wang (3):
  dt-bindings: arm: Add compatible for MediaTek MT8189
  dt-bindings: serial: mediatek,uart: Add compatible for MT8189
  arm64: dts: mt8189: Add mt8189 dts evaluation board and Mafefile

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../bindings/serial/mediatek,uart.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8189-evb.dts   |  20 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi      | 430 ++++++++++++++++++
 5 files changed, 456 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi

-- 
2.45.2

