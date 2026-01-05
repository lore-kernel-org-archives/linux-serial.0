Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D753312828;
	Mon,  5 Jan 2026 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580878; cv=none; b=EDXbNlD/9BUOrHZo48VUlsQu9KXOwJ4mzND9fk3sXgfZ39B2NCWZb50ZdDo1VZwP7s9Wm1Tgk6GXyNIahJ2VjbkqQbshazfR14a6DyzLQ81yXQW19L0KS6nK8MCS236Ma/S+WVLonqANwAmyzbKh0Dqe+U6UjcOa4wRiSixZAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580878; c=relaxed/simple;
	bh=W3VmypK5QmSXALLjdf/Aa2MtOXluqCzul9xTCXjUqrk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjRkfsrhxGhi6y99/Ga0UkZQon+0Fr9WwS1EpbUecXN4nVsu2eUoHxdGo0yC/V7atdPfP6TIoaRcOo6MKs5R3IfUV9E1MzAmtWimUu3z7L5orPrWevi4QzXKb1MJu8PLj4qjHqUj44alwVOjsfCV27PG308IVf41DN99S38vtnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AQpmvQGz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AQpmvQGz"
X-UUID: fbf73c8ce9df11f08a742f2735aaa5e5-20260105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iLcEgivO67/cJ6mzNXBkswo7rrMtv/QRBM7nPIN2wA4=;
	b=AQpmvQGzeI44nlr2k5HYjnbwxhKNG7Qh0DVKCLaDy4Y8760Oo2a2kAPb8KLrZ29X1ST97NPxRE0fmAQhM1Qw0Cj74n3P18cbJuddRwpBnkSpS88FcGRmj5lKhEC4AFsCijUmkKo/kE5bKc8HOMfoOBc8eA/dU+kONyEaHhYiNWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:0b24837d-a146-40ce-9382-892d8ae77233,IP:0,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:5047765,CLOUDID:1e2d24c7-8a73-4871-aac2-7b886d064f36,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:2,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fbf73c8ce9df11f08a742f2735aaa5e5-20260105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <zhiyong.tao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 504711488; Mon, 05 Jan 2026 10:41:06 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 10:41:05 +0800
Received: from mediatek.com (10.233.130.16) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 5 Jan 2026 10:41:05 +0800
Received: by mediatek.com (Postfix, from userid 10007317)
	id 05CC1200CD; Mon,  5 Jan 2026 10:41:05 +0800 (CST)
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <jirislaby@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <zhiyong.tao@mediatek.com>,
	<fred2599@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Digits_Upstream_Group@mediatek.com>,
	<liguo.zhang@mediatek.com>, <Vasanth.Reddy@mediatek.com>
Subject: [PATCH 0/1] Mediatek uart patch 
Date: Mon, 5 Jan 2026 10:39:54 +0800
Message-ID: <20260105024103.2027085-1-zhiyong.tao@mediatek.com>
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

Zhiyong.Tao (1):
  MEDIATEK: serial: 8250_mtk: Add ACPI support

 drivers/tty/serial/8250/8250_mtk.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--
2.45.2

