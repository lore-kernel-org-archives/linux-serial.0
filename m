Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034337D13E;
	Mon, 13 Apr 2026 04:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053316; cv=none; b=ShcoMj+qjb/T+uwgNjCtx0ohRX/H9Y0sWLAwlwT9jQ4ToxxgUtV1GjkCmVMg6RWJu3WLCD7Pg0KuMrqZIDjFSqrVfNXP+37TEreXitnEFiP0AmFDOoDnRMdzs1eQZ6epeRLS47nGIwc13CHBXrg9DxYzH6D1vNnhhlP/jgyv5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053316; c=relaxed/simple;
	bh=5btr4n73BQQDiAlidk4BdZv5icchqaWMylTldMevDNk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pfEbv62H1PdEZzyyxDqdkvxIXntTkrKJd8XLhCGO40pqlqwc8uN+csAR64w8663S4x/2pdu6Vr7dT3Ygb/Ei/U+LLAJ6rx0Es9Ez36Ptd74K0FM0pXXHfA5YxF4YLJegXKzUY8v2xDQk6kJLuxN1mQSiWifr07QfLYmixadrtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 637c7f6a36ee11f1aa26b74ffac11d73-20260413
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:875aab67-be6c-4dce-8110-260cebc6257b,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b52c9200804ddd4cc9fd6c075059099f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 637c7f6a36ee11f1aa26b74ffac11d73-20260413
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2024812756; Mon, 13 Apr 2026 12:08:12 +0800
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
	Hongling Zeng <zenghongling@kylinos.cn>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v1] serial: sh-sci: fix memory region release in error path
Date: Mon, 13 Apr 2026 12:08:07 +0800
Message-Id: <20260413040807.40546-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongling Zeng <zenghongling@kylinos.cn>

The sci_request_port() function uses request_mem_region() to reserve
I/O memory, but in the error path when sci_remap_port() fails, it
incorrectly calls release_resource() instead of release_mem_region().

This mismatch can cause resource accounting issues. Fix it by using
the correct release function, consistent with sci_release_port().

Fixes: 2667bd6673eb ("serial: 8250_port: simplify serial8250_request_std_resource()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202604032356.SzEjYkBC-lkp@intel.com/
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

---
Change in v1:
  - Fix the commit message and change name
---
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

