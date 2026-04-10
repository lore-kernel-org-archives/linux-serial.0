Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE4347BDB;
	Fri, 10 Apr 2026 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812918; cv=none; b=uG+k/xmcyRtA/O/T8oXyXMuqy/4644efPWlcZMOUOpS5KSIbao6X/rgt4RduJ6vWj5+kCp/RHcYnPXigEn1iLmU9tSEOQHbOcoqMwyVgWLKOR6DZ9aHfGYN/NiGPe5SkW28CvJoRaBHfpViEy77F4RsLPUTKQnVAsSsFpy+DnQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812918; c=relaxed/simple;
	bh=nPDxLLy07wPJdci7VYpChh+tbI9p7q+EvgM2zcTPH8M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4wbJbmQawPIiObwOYyVVVW1SzIF+lFcaFI7oR3vfztiweMc8y89hvK/5vBQjOAqH0IasS/UJOCb9RGaYRS4fBt3Vzxl3IBp3ROfLpntwoKlBIfh9hs/qNuzy6yh+IAEYNVyJhahuvh1mmsPRhGCURyKNSKnAkxyaBbaTZliCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b370ed4e34be11f1aa26b74ffac11d73-20260410
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f554c3cf-e961-4dd4-bb44-8991495b806a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:b33bc3f1d49ba40b46313457234842af,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b370ed4e34be11f1aa26b74ffac11d73-20260410
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 153981629; Fri, 10 Apr 2026 17:21:48 +0800
From: zenghongling <zenghongling@kylinos.cn>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	wsa+renesas@sang-engineering.com,
	thierry.bultel.yh@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	zhongling0719@126.com,
	zenghongling <zenghongling@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] serial: sh-sci: fix memory region release in error path
Date: Fri, 10 Apr 2026 17:21:43 +0800
Message-Id: <20260410092143.30971-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sci_request_port() function uses request_mem_region() to reserve
I/O memory, but in the error path when sci_remap_port() fails, it
incorrectly calls release_resource() instead of release_mem_region().

This mismatch can cause resource accounting issues. Fix it by using
the correct release function, consistent with sci_release_port().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: zenghongling <zenghongling@kylinos.cn>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd7486315338..9e619db27237 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3024,7 +3024,7 @@ int sci_request_port(struct uart_port *port)
 
 	ret = sci_remap_port(port);
 	if (unlikely(ret != 0)) {
-		release_resource(res);
+		release_mem_region(port->mapbase, sport->reg_size);
 		return ret;
 	}
 
-- 
2.25.1

