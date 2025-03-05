Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B941FA243;
	Wed,  5 Mar 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163868; cv=none; b=o0/HKdsoz6aSQa7Fcm33RIwWLqmdcviJM/IBEyfYXKZoGg1MSYFkgSgMFNCHp5AZLD3k6lehkcI2KQOcr2HJyhOapweFzFz+8362FTjrvDulsgqHt7u/vD6+v2rmbo9+GrUiKEssPfhgS2BTzyqUX57ZpjNM2v85Klm2kpBWf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163868; c=relaxed/simple;
	bh=G/2LRvSdFV1KLPBOfS6d9E5XGInmRkmFV9qxg+lKJrc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ei131nX3oof3cId+Q2Nn9dZqueUxM0LyHn6WYI9MwyVLkMVq132zN4lUF/TVa5WCfdST7JLHRWYRNyy8okWk+qO38bxRd0B6MmCzSoLUYHGfm/8wMCZo/WE1cNO2dgsNqibiFe3rH7F+1JPixDAG9KLoXCMTNU0o+vP8Y4n0yjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201620.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202503051637325088;
        Wed, 05 Mar 2025 16:37:32 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 jtjnmail201620.home.langchao.com (10.100.2.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 16:37:31 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 16:37:31 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, "Charles
 Han" <hanchunchao@inspur.com>
Subject: [PATCH] serial: icom: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 16:37:29 +0800
Message-ID: <20250305083729.6090-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305163732967b1f9ca6dd3fe80e566ea3b3ab0f4f
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/tty/serial/icom.c:1768 icom_probe() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/tty/serial/icom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 29e42831df39..6779d8ea1487 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1764,11 +1764,11 @@ static int icom_probe(struct pci_dev *dev,
 		goto probe_exit1;
 	}
 
-	 /* save off irq and request irq line */
-	 retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
-	 if (retval) {
-		  goto probe_exit2;
-	 }
+	/* save off irq and request irq line */
+	retval = request_irq(dev->irq, icom_interrupt,
+			IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
+	if (retval)
+		goto probe_exit2;
 
 	retval = icom_load_ports(icom_adapter);
 
-- 
2.43.0

