Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4311FFC56;
	Wed,  5 Mar 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168294; cv=none; b=n0XkazxEn2+P23LLx4cLi8eO1bjOaPPCjy1oDQaas4a5nSdHFPnnKY1cNj/1C4Go57TWDpjGWRfma6xqwxyb+xfseMT8cUV+aAijeT8E/NQn0BxvfO7bFs57luvQyG8zVE6Yr0kgczYxKevcclPh9BP3ZvslMSQjbN1Axx2RgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168294; c=relaxed/simple;
	bh=wjPSc8nhYA182GOXzh/ESW1weUphliOkkBMIuZmr8yM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d8bLqmUO/UYBdJ0tWTI4uTZDBG9PHYDmfk+cgNfzyeKCEKgp2LhpYddoI/IRyb390tIsv20YcS1A+K7SwwPyau3MyHaZAH2aq8bQBZ4bO4uAeXo60eb5wEw8a0g4Y+Ohdt0/G3YBfcV1vS1skpRjJ/SyRDeCs2gYbCtJNRc81No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201601.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202503051751237924;
        Wed, 05 Mar 2025 17:51:23 +0800
Received: from locahost.localdomain (10.94.19.225) by
 jtjnmail201601.home.langchao.com (10.100.2.1) with Microsoft SMTP Server id
 15.1.2507.39; Wed, 5 Mar 2025 17:51:22 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>, Charles
 Han <hanchunchao@inspur.com>
Subject: [PATCH v2] serial: icom: fix code format problems
Date: Wed, 5 Mar 2025 17:51:20 +0800
Message-ID: <20250305095120.7518-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305083729.6090-1-hanchunchao@inspur.com>
References: <20250305083729.6090-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025305175123414863d4b862e0e5c1e81e8dd76cf7e6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
drivers/tty/serial/icom.c:1768 icom_probe() warn: inconsistent indenting

Removed that useless (void *), the code would fit on a single 100c line
Removed  '{' and '}'.

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/tty/serial/icom.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 29e42831df39..7fb995a8490e 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -1764,11 +1764,10 @@ static int icom_probe(struct pci_dev *dev,
 		goto probe_exit1;
 	}
 
-	 /* save off irq and request irq line */
-	 retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
-	 if (retval) {
-		  goto probe_exit2;
-	 }
+	/* save off irq and request irq line */
+	retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, icom_adapter);
+	if (retval)
+		goto probe_exit2;
 
 	retval = icom_load_ports(icom_adapter);
 
-- 
2.43.0

