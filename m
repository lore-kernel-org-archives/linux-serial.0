Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755624A7C6;
	Thu, 16 Jan 2025 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736999629; cv=none; b=TsPZjGvcUWghWqQkfW8MaOT7WXPJ0Ijml6kaSLimADqiyrPvve/5Cy2U9Jh/SrJ02l0AiVSzIGx81OCL5vwCSBkoUQsUg1Hb8CsVQ0R+KdFe+CyAZzPgIoURgaHIs0DUK24Y/jVmmt3XeA97ojC7cQXnI13CPCDhFKwE0fZVFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736999629; c=relaxed/simple;
	bh=jjMEsmKQiawwAUyvuLhdXyoFe4hHzqwq8GdDaeS9hlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thoLOzLno0F761I/2a9ntlxuDWOyyj8YlAnPMyvfFapq1AKniOZDxqYZnCpO5MmemNCLRwD5qQfXaf5vyuV3LtFYpa38h1YgY0cUmKb6g7vYAANAWLxPzLBzyY+g4FzQ0e1koFEi6n0KF2iqXhvvC2qeLPmzlWUxS70i2qw+pTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aqEClj3+; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aqEClj3+"
X-UUID: 79e1401ed3bd11efbd192953cf12861f-20250116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KV2UcpCXP3xjFpNUJT9QubQUi+SFkhGjluhGdlfUmis=;
	b=aqEClj3+WIs1VAIiI64m4KyqBPdCvlwRscqVVIG5i9c/1IbTpDlaq/PTqyg/dt+L6PW7wS6g3rtrBxVDp3x0n/LVemI1yK+EtS6x8P3JahM1fLLGNFTBEowsWR+cH7CPk0snIv4+J8t9ZinQp5+76zvaqzb84ZnAVQg0IPnoB3Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:65723298-2edc-423e-9809-a3d437cb61da,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:393df637-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 79e1401ed3bd11efbd192953cf12861f-20250116
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <yenchia.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 553038266; Thu, 16 Jan 2025 11:53:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 16 Jan 2025 11:53:40 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 16 Jan 2025 11:53:40 +0800
From: Yenchia Chen <yenchia.chen@mediatek.com>
To: <jirislaby@kernel.org>
CC: <angelogioacchino.delregno@collabora.com>, <gregkh@linuxfoundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-serial@vger.kernel.org>,
	<matthias.bgg@gmail.com>, <tbergstrom@nvidia.com>, <treapking@chromium.org>,
	<u.kleine-koenig@baylibre.com>, <yenchia.chen@mediatek.com>,
	<yj.chiang@mediatek.com>, <yujiaoliang@vivo.com>
Subject: Re: [PATCH] serial: 8250_mtk: Add ACPI support
Date: Thu, 16 Jan 2025 11:53:38 +0800
Message-ID: <20250116035340.3838407-1-yenchia.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ac3f0efe-c197-4279-9b73-5d7dd3f300fc@kernel.org>
References: <ac3f0efe-c197-4279-9b73-5d7dd3f300fc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

> Wait, ::set_termios() is NOT optional.=0D
=0D
Got it, will put it back in next version.=0D
=0D
> This is a magic constant. Define a macro for this. Hint: 26 * HZ_PER_MHZ.=
=0D
> Is it not/cannot it be part of the acpi table? What does MTKI0511 look li=
ke?=0D
=0D
Currently clock settings are not included in ACPI table,  so using fixed cl=
ock here.=0D
=0D
We'd like to change the flow as shown below to remove the dependency on the=
 ACPI device:=0D
=0D
	uart.port.set_termios =3D mtk8250_set_termios;=0D
	uart.port.uartclk =3D clk_get_rate(data->uart_clk);=0D
+	if (!uart.port.uartclk)=0D
+		uart.port.uartclk =3D 26 * HZ_PER_MZ;=0D
=0D
> Why is this only for non-ACPI devices?=0D
=0D
In ACPI devices, these registers are inaccessible due to some related setti=
ngs not being configured.=0D
=0D
