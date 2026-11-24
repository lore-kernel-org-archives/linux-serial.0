Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795488501;
	b=YeimQyFnvbeI6G3F1/i0hgoDLyeDubUJHVm42elZ+WO+ACYkoXItIdK9gSTQrazQVgLZ
	 fyKtelv3/EoqkBcbxNFFRO7+kI7SIq1GjpO6yyT9HoY0ooAk7MTf5DBmpv/5pFddFEHEf
	 +B/FoIPCVpgFL5SnyUi9G8OikNmOyLQZEYqctaZkSvcTCjNih+SAvG3F7OeW0jeBq54Qx
	 lcQR5zPj5OVyUvhbK6RFdPHpjoA63X6L2BSgdAYl7H7ZXiU/kTMLn9g15V8Mvz0W5d2kx
	 TyPgorwP+cXzIvbmKEAjVuI1NiAKY+0Y5mWzMpS/2YTZHxn8hIkfpnLmDvp2F+LMuNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795488501;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gSlhVMrHKcU/qOQJ0zOmbPCCq8E5yqXKSvaxRXdmCto=;
	b=sZ9+JdmqZXJxbcNka1krCyqDIGzwexKWt2VE+Vleutjogw2KX2XBip6CvHtA/tbRaeql
	 scgMYDf1BOthOyrVnZaPw9deEBuNYmZWbGKGQBotUITDAD/qR9Leni8buVt3AJVSUPR7b
	 odXKi/u/G7Smyyw+cWGTf5Lw2EyEDzsWcVrCjnB7Q3OjcXg17lywuGVJFI9I+EMUHv7r8
	 8sUvvGBFrKq0uBBX9gRRopI/q8x+HeEQFR5tgVLOxPyVoap4jXty9eH/1+bFurxNhKQi3
	 aRIBVqWrYfQhZEXkwPx5+/0ALJm8J4cgBwcWAhjLpQuGJtXiuhf7BzN8VBY5oWfiq/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3A2606A31E;
	Tue, 24 Nov 2026 02:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3A2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7ea534c0e7b111f19a56ed5b684f684d-20261124
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:3c093e59-60d6-4673-8742-02a69f15615b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:7db8b62,CLOUDID:09287dc18e05006869466b218a6b2857,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50|99,EDM:5,IP
	:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7ea534c0e7b111f19a56ed5b684f684d-20261124
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengyu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 499285219; Tue, 24 Nov 2026 10:48:14 +0800
From: Yu Peng <pengyu@kylinos.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Ronan Pigott <ronan@rjp.ie>,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yu Peng <pengyu@kylinos.cn>
Subject: [PATCH v2 0/2] vt/vgacon: Skip blanked hardware scroll and fix VESA blanking
Date: Tue, 24 Nov 2026 10:48:09 +0800
Message-ID: <20261124024811.305592-1-pengyu@kylinos.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split v1 [1] into two independent patches as requested by Helge Deller,
ordered so patch 1 fixes blanked scrolling before patch 2 switches
direct VESA blanking to vc->vc_screenbuf.

[1] https://lore.kernel.org/all/20261123101151.414436-1-pengyu@kylinos.cn/

Yu Peng (2):
  vt: Skip hardware scrolling while blanked
  vgacon: Switch to screenbuf on direct VESA blanking

 drivers/tty/vt/vt.c            | 7 ++++---
 drivers/video/console/vgacon.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.43.0

