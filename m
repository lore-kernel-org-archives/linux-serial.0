Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF6F1A0BC6;
	Tue,  3 Sep 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369813; cv=none; b=KI8ixufGDNBWqgHsdzOuo5vGoz3qynPVwrCr7GLS1pHr+ZRJYioj0/AcVXCFORBsIeAqEvqRjToatfmdGE0Jcutil9sfFn9qZ+gdnTYTxJq1JFvPU953FO6IlmlaIF9EWs8jhol7bB2aMYBQFtz8pe/+ClZ6IasTn+LnWI97iPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369813; c=relaxed/simple;
	bh=7kmLVIo6tp7hcvb5Fw3xz+I9xC6iI5wAxxu9XgPDtAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q35xHzMo82T1tRVeSAUsXwOZBVRqmtWIXqu6fPV0rSHMDUQ8ymP0goGl77dBcs3xB6VRZsx0YF8H6H4aH0eyQ23I4vUR68k6oI6f/BUyCtrehXmPXxIh8e8q4nvEpt99YSs6Uxey6rdn/i69BLRO7XioBdAR668dlXkiIJ8X1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WymXF2nfYz2CcBb;
	Tue,  3 Sep 2024 21:23:09 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 9263B180019;
	Tue,  3 Sep 2024 21:23:28 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 3 Sep
 2024 21:23:28 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
CC: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <andi.shyti@linux.intel.com>,
	<andriy.shevchenko@linux.intel.com>, <u.kleine-koenig@pengutronix.de>,
	<florian.fainelli@broadcom.com>, <liaochen4@huawei.com>, <tglx@linutronix.de>
Subject: [PATCH -next] serial: 8250_aspeed_vuart: Enable module autoloading
Date: Tue, 3 Sep 2024 13:15:03 +0000
Message-ID: <20240903131503.961178-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded based
on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 53d8eee9b1c8..25c201cfb91e 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -561,6 +561,7 @@ static const struct of_device_id aspeed_vuart_table[] = {
 	{ .compatible = "aspeed,ast2500-vuart" },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, aspeed_vuart_table);
 
 static struct platform_driver aspeed_vuart_driver = {
 	.driver = {
-- 
2.34.1

