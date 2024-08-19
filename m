Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CE166F0D;
	Mon, 19 Aug 2024 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068431; cv=none; b=Kf3E8F9sruKgQkDoe6GSc3E6v0EoH2HyjhaApCx1flGMv0ojPb1+K3iUGE3lmuS7HfNAmr1wVokH4DnovqCVD28SsYmufOP7G2o9NjxSo/osRS25vb2HLTJKt+m9ew7wR6uSZH+0K/JkDbP70/K66ctXcbmh0xC48hOeCmMi6l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068431; c=relaxed/simple;
	bh=pVHw3YjeIM1CpMxRaacRYwjp63n+Kas4J98/Z7viNMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHxkQKmo4uf3CRNf4eCz2L3yrdaUoF2y7Bv2sFS/pGhKI1H1zinh+StoBW6tfB2HGMc73Gk7hVAFO8zV2Im9lTQMDRx/X5uI99amP5LWl0vGzq1xSUUmEzUmvbYcip3TW5gWXymDHW9RMnF42sBLNxjItgEWc6HDlJHR6XFRLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WnW8J5d1Kz1j6gG;
	Mon, 19 Aug 2024 19:48:48 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 1955718001B;
	Mon, 19 Aug 2024 19:53:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 19 Aug
 2024 19:53:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<michal.simek@amd.com>, <manikanta.guntupalli@amd.com>,
	<u.kleine-koenig@pengutronix.de>, <john.ogness@linutronix.de>,
	<julien.malik@unseenlabs.fr>, <tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 8/8] serial: xilinx_uartps: Make cdns_rs485_supported static
Date: Mon, 19 Aug 2024 20:01:07 +0800
Message-ID: <20240819120107.3884973-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sparse tool complains as follows:

drivers/tty/serial/xilinx_uartps.c:222:21: warning:
	symbol 'cdns_rs485_supported' was not declared. Should it be static?

This symbol is not used outside xilinx_uartps.c, so marks it static.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2acfcea403ce..777392914819 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -219,7 +219,7 @@ struct cdns_platform_data {
 	u32 quirks;
 };
 
-struct serial_rs485 cdns_rs485_supported = {
+static struct serial_rs485 cdns_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
 		 SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
-- 
2.34.1

