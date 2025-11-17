Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176F1531C8;
	Mon, 17 Nov 2025 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350905; cv=none; b=ghEOlIkgJZwSrpycjdd+xbyeFk0gV1ZOUNRaXZ8SNDNWYJpEozqmpkKmGdArpmhyRzCH1PklWbu5lAIkvhEX4YGjPEJRybP+B4qll4PkR18xbPxs60b8oo+JuKcQEyLZoOPkA+xhh21dUadfZnhsJgawQmeOSg1fyMo2xPBL+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350905; c=relaxed/simple;
	bh=Lk2pH9TSHCcnmYB2Z9Ul4FodUvxmkXiKY38/P8qXQRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Npk78eYSMsXQV2SEblM8c60gPciFWqjY3WhpEiw5lvABJFiZzd944CwjrWZA8hChHqqPebmXeqiufp5P/1C3f5cuopzaqlSwVA2a6KagfU1Gs97M236r/dA06/7Pjuuf97xPcX3+7S/Zepk81hvySyQN+Kpgjo1ThJLIO9CS/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YUbkxlww; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YUbkxlww"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fO
	yhD15l3U6yyj3mFNLBN7qZI49WAdkBHQH7VjJuveE=; b=YUbkxlwwhJnkpiWBOf
	5W0SVq/hwJ0X035Km577Uj6HBiTd6QU/g1htXMc1Gpn6F1eT5DuwpDG+FSCHWyGT
	5Qov+MKKfQfwmlr8dzk3IWSWYa9Uw97gm44j7WWFfA3jBAoCHQevDTIuj043hvU9
	MdwZwqS0IvEhR6ww4FnK4fhck=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_21imRppmg86Aw--.2462S2;
	Mon, 17 Nov 2025 11:41:23 +0800 (CST)
From: "jempty.liang" <imntjempty@163.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	"jempty.liang" <imntjempty@163.com>
Subject: [PATCH] serial: 8250-of: Fix style issues in 8250_of.c
Date: Mon, 17 Nov 2025 03:41:17 +0000
Message-Id: <20251117034117.55588-1-imntjempty@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_21imRppmg86Aw--.2462S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr48Gr4fJr1kJFy8trW3trb_yoW3Xrg_Ca
	1DursrurZayF1qyF13Jas8urySk3WqvF4xZ3Wvvr9xA3s8Ar4DuryvvwnrZws8WwsrAFy5
	CrsrWr13Zr98WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUX4S5UUUUU==
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/xtbBcwMJAWkal4UoNwABsH

This patch resolves the warning "sizeof *port should be sizeof(*port)"
detected by checkpatch.pl.

Signed-off-by: jempty.liang <imntjempty@163.com>
---
 drivers/tty/serial/8250/8250_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index d178b6c54ea1..9799356b65f7 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -95,7 +95,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	u32 spd;
 	int ret;
 
-	memset(port, 0, sizeof *port);
+	memset(port, 0, sizeof(*port));
 
 	pm_runtime_enable(&ofdev->dev);
 	pm_runtime_get_sync(&ofdev->dev);
-- 
2.25.1

