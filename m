Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C7311592;
	Thu, 23 Apr 2026 06:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776925433; cv=none; b=s9Uqi53Si7qlLAnbIBbmPnFzRCqvIGg1IkGsdodDm5vijuehvon3bEN8IPf47OVZvFNAkOCQ/E3I4myJl3V9m3ob+Vy/TXMpVWu1yqJsNX8WhDwW1aielLXOc4ZDwUJfa3YBbPCZEKmPfOmqAKWxP4ou6iNjOiZthgS8aUKAwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776925433; c=relaxed/simple;
	bh=LXpOjLcBVGjSPoY/M5nH6CkzKGAFbVu83vo10DVJRg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGqonkezSiv5gouf86s77aC3LnFmBHdr+5qELdFhjlZmIfmGsrRoTwl8xwZvGvEzVsJF+5gIywHfKDw2UrzGRUoZZxrCiDaCQp9hChNooUIShH8sDEanWASlN18eJV/aShNxp7Qsap85ySI7jTqT1QhUm9t6MWXEizM5Orkg2mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qRpw/Zt3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qRpw/Zt3"
X-UUID: fd1f14163edc11f19781c1a04af40193-20260423
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BH47Z0hf+ClG7AafYvP2SIgZhj0LIH9kRTWMoKYWfe4=;
	b=qRpw/Zt3OE/uvW+agtgx86pUTGnU/fN90Ef7YS94dKVOthNFQhzVOGTrYZ6VxX5W0Jvrr7hUN/fq0414/B4sbGpIMFKkvkPVNZDsN2vwKbfGPgtekWFkVXYoTq2LUOPwVD6fqLNJQXeIICm09x/spBd2xDLKyYbhSU5lefDBy4E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2bfa1f30-9a1f-4482-b3b5-eadc30c4cb82,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9163c88f-6df4-4a3d-a7a4-fbdc42d669ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|865|888|898,TC:-5,Content:0|
	15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fd1f14163edc11f19781c1a04af40193-20260423
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <mtk07317@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 643341762; Thu, 23 Apr 2026 14:23:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 23 Apr 2026 14:23:47 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Thu, 23 Apr 2026 14:23:47 +0800
Received: by mediatek.com (Postfix, from userid 10007317)
	id 3C36E200C6; Thu, 23 Apr 2026 14:23:47 +0800 (CST)
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Digits_Upstream_Group@mediatek.com>,
	<zhiyong.tao@mediatek.com>, <liguo.zhang@mediatek.com>,
	<Vasanth.Reddy@mediatek.com>
Subject: [PATCH v2 0/1] Mediatek uart patch 
Date: Thu, 23 Apr 2026 14:22:44 +0800
Message-ID: <20260423062345.2473300-1-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This series includes 1 patch:
Add ACPI support on 8250_mtk driver

Changes in patch v2:
1)Change pacth name from 'zhiyong.tao<zhiyong.tao@mediatek.com>'
  to 'Zhiyong Tao <zhiyong.tao@mediatek.com>'.
2)Resend the UART upstream patch based on the latest Linux
  kernel version(from 'tag: next-20251118' to 'tag: next-20260417').

There is no code change compare to v1.

Zhiyong Tao (1):
  MEDIATEK: serial: 8250_mtk: Add ACPI support

 drivers/tty/serial/8250/8250_mtk.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--
2.45.2


