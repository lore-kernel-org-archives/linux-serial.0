Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1A293C5F;
	Fri, 18 Jul 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825405; cv=none; b=QzgIgptQPtuurSXzQ+gi5H5EC4hpCunbuuOb+DpoIoEr0hmhkUtVCmOjyZkzb5qg0yrZ09zDiKGn4NWI79Ax/s2pinUcSnaJ3KfMuCVMmbEAvsHuILyLB9LhNP6pWOTorvcOnPF3pcRYDzy0HKUrT47hxt2/eDXd8YsS9B19+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825405; c=relaxed/simple;
	bh=SqSKIIDe8+ekOixpXTHdiPd6Dmh8yHLhYEXFnIva5mQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q1DpUsHJD/1pLZ9bPLFMJan06y9qrnbZGgFzIE/1zYJdoiAqW+KmnZ2/3ZkWWpXCA6hjIKhW7yU1OtnoEInLSIxZUOYX2OyVmgz4H47JWQs+gA1PNvoAkX6mPU5RuI/3E0/tI+iKbQsWzx6tVho/ktAraeg8seUw9oFD5SCELpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Jk8zhgCv; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Jk8zhgCv"
X-UUID: b921ee4863ac11f08b7dc59d57013e23-20250718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=A6rZxWvUrLHvB9zwv8UA0/M5AxIV4dTh7M6ayj7bVKA=;
	b=Jk8zhgCvEr/EsCw0SiD2otgRtnQnm0vZJrpkkskEv7wVsUlBXt/e05bq089lP4CAQUWKgMrBGF7NK3pvDeTgI62kI0kr4yjXKcV1Vjbd/Z/2lQ0IqCd6QA+DZtvOsGd9fj7nKBdZKrat9SZb90X9fa5ftdTdN7ix7xwfvTtgTOo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:edb9f155-a626-454a-a3d9-5c3b33e331a7,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:78272673-f565-4a89-86be-304708e7ad47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b921ee4863ac11f08b7dc59d57013e23-20250718
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <sirius.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1409325406; Fri, 18 Jul 2025 15:56:34 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
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
	<xavier.chang@mediatek.com>, Sirius Wang <sirius.wang@mediatek.com>
Subject: [PATCH v5 0/3] Add mt8189 dts evaluation board and Makefile
Date: Fri, 18 Jul 2025 15:56:23 +0800
Message-ID: <20250718075630.644870-1-sirius.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

We add basic chip support for Mediatek MT8189 on evaluation board.

In this series, we also add dt-bindings document definition for MT8189.

This series is based on tag: next-20250717

Changs in v5:
 - remove unused cpu-dile-state definition.
 - change memory size in "reg" property which if filled in by bootloader.

Changs in v4:
 - Correct cpu-idle-states.
 - Change the "reg" property name of the "memory" node in the
   device tree source (DTS) to lowercase.

Changs in v3:
 - Move ulposc and ulposc3 before cpu nodes.
 - Refactor cpu-map to a single cluster0.
 - Change cpu nodes name from medium core to big core.
 - Move psci before timer nodes.

Changs in v2:
 - Fix warning issues for make CHECK_DTBS=y.
 - Add mediatek,uart.yaml document.


Sirius Wang (3):
  dt-bindings: arm: Add compatible for MediaTek MT8189
  dt-bindings: serial: mediatek,uart: Add compatible for MT8189
  arm64: dts: mt8189: Add mt8189 dts evaluation board and Mafefile

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../bindings/serial/mediatek,uart.yaml        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 arch/arm64/boot/dts/mediatek/mt8189-evb.dts   |  20 +
 arch/arm64/boot/dts/mediatek/mt8189.dtsi      | 375 ++++++++++++++++++
 5 files changed, 401 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189.dtsi

-- 
2.45.2

