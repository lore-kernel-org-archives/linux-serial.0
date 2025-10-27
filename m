Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D202C11FA;
	Mon, 27 Oct 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575410; cv=none; b=SLmYjZLzH+64NO136o8KjQQQ7A3lQy/RmNwA9r6HySbd0AmkVQBsQ3TyeUkbLAeSsrcGrA+cFNOmOgZvDAjQPkus6cZTcJ1k57rJDpS4gOE9LzamlBlYgZQ1BpMxD08CfLPgGx1a8m/Lx3VrizVCG3cYhMDxCJ0YHsFjd+h9Ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575410; c=relaxed/simple;
	bh=alnAlEaa3VhrHS5fE/2q3E8Q4I3DCkMJzv3wETeAjd4=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=dF8KkszagRpM7ePrSRn4yctHDPtZViC8a+bZIGSrDn1uUGbMDGGjWcn14POp28U0NkUN6jzCBt0VwiDKGFd49wxQYjdZBtAgxQwwogYQ+T3DQi7nCG6kXmuL7YvKyqfJFdk7TdsvnxPBRCToVUug8M6PawQRXrVF+wsJpIbc2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Yz3Xgf8n; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Yz3Xgf8n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=uHg8PKvTJuxb1S+SGCKDBR4VebV7fuq1HHKPiPau62Y=; b=Yz3Xgf8ngSnIWBtBNSv1H1ILpa
	78mTkMkfo3FG2lSL3+gQFyNH36FcJOZJJucz0edKL8cLSQtYdlNalacLPJo45ZnWxaINgw3FUCA22
	vCJeVbBMc/i9lrnPgSgJ4XUUH93pb3jF1sgHRUxyqfm8YQd/n6GkZCV44dbGCaXzCUAY=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEZ-0007wg-8K; Mon, 27 Oct 2025 10:30:07 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:48 -0400
Message-Id: <20251027142957.1032073-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027142957.1032073-1-hugo@hugovil.com>
References: <20251027142957.1032073-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v3 06/14] serial: sc16is7xx: drop -ENOMEM error message
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Core already prints detailed error messages on ENOMEM errors and drivers
should avoid repeating it.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1acf5be03d489..ce2a0967ffdf4 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1527,10 +1527,8 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
-	if (!s) {
-		dev_err(dev, "Error allocating port structure\n");
+	if (!s)
 		return -ENOMEM;
-	}
 
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
-- 
2.39.5

