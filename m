Received: from mail-m1285.netease.com (mail-m1285.netease.com [103.209.128.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1318641;
	Fri, 20 Sep 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726857216; cv=none; b=LGrArfTafX+yPmDSOwX+Y3h8/ZW5oF6gJcoa6MQGvy/0N6g7reXE3f9vKZy3AhzkEIjwKVJVCmY84yWL5LniFQOs1Rofgq6XHVHUtm+QrGDYTcqVNyamah2c3Y8utE08sNYyOzht7v1W5TT6f3xdNoJqdBU3kAj7mGf+QmVNR/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726857216; c=relaxed/simple;
	bh=yGZXUz2v1QNo2ub79hyWPTRmEYozPxbY2e/WfIQgOcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H5sEUM5MuT33xo2GcY/5cXv0lkK8Z6seIGtviZ4pMBv2ajDIi7zr3zHhG+Kfd920SPsBoKGjqnjlPROewd0ZmHyFFd2z/pTtG9vsVtD552gxGkxmA+/F98hK/bzxezdz5KngWixLHpZKix8K7lkzRAwLQQY2CD4WFi+pTJzkFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=PUgVhxha; arc=none smtp.client-ip=103.209.128.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="PUgVhxha"
DKIM-Signature: a=rsa-sha256;
	b=PUgVhxha4zZAds+bsvN3i4C3Biw2MbXZSz/sfjOl7y7v1EcleUrSf/V3LIPxSqKj7qia+vHhx/f6Ea8Bc7gnm2siXEaV3MOg3BxeRM78WsYznfryOp2p0wtyy/oozZ9ZNc+5t4IER9oo1rfZrQTOnHtEnqVhWO//eiw0FdWTMIs=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=qW5v6wPUIgQYUeAA1yQclbci/Ld3I4Wcubm7RccTIHw=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [223.64.68.38])
	by smtp.qiye.163.com (Hmail) with ESMTPA id F33B64C0635;
	Fri, 20 Sep 2024 13:34:34 +0800 (CST)
From: Yanteng Si <siyanteng@cqsoftware.com.cn>
To: linux@armlinux.org.uk,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	alan@linux.intel.com
Cc: bartosz.golaszewski@linaro.org,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	u.kleine-koenig@pengutronix.de,
	mengdewei@cqsoftware.com.cn,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	si.yanteng@linux.dev,
	Yanteng Si <siyanteng@cqsoftware.com.cn>
Subject: [PATCH] serial: clean up uart_info
Date: Fri, 20 Sep 2024 13:34:23 +0800
Message-Id: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
X-Mailer: git-send-email 2.31.4
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR4dVkgeQ01CQk9CSkseS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlJSUhVTU9VTUNVSENZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVU
	tZBg++
X-HM-Tid: 0a920deccc1509d7kunmf33b64c0635
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46SRw4DjI0IwEfFUIOTDwK
	SBQwCw9VSlVKTElNQ0pLT0xNS0NPVTMWGhIXVQgSAhoVDx4VHDsYCggUHQ8MGgkeVRgUFlUYFUVZ
	V1kSC1lBWUlJSFVNT1VNQ1VIQ1lXWQgBWUFJS0tKNwY+

Since commit ebd2c8f6d2ec ("serial: kill off uart_info") has
removed uart_info, the uart_info declaration looks lonely,
let it go.

Signed-off-by: Yanteng Si <siyanteng@cqsoftware.com.cn>
---
 include/linux/platform_data/sa11x0-serial.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/platform_data/sa11x0-serial.h b/include/linux/platform_data/sa11x0-serial.h
index 8b79ab08af45..a88096bc74e4 100644
--- a/include/linux/platform_data/sa11x0-serial.h
+++ b/include/linux/platform_data/sa11x0-serial.h
@@ -10,7 +10,6 @@
 #define SA11X0_SERIAL_H
 
 struct uart_port;
-struct uart_info;
 
 /*
  * This is a temporary structure for registering these
-- 
2.31.4

