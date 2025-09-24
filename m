Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EBE311C0C;
	Wed, 24 Sep 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728282; cv=none; b=ADwjpztBZqed8qCaulvOvOgob/El0+M+jmDjim9SbAsHPgjGpsuyi5rwoG98gKwif2yxbp0n62vg+8beqjyw4AVtWQUh5ENkM2J5Twlwo4hd8Da086pmGuok+zj6ynxVL+fUaqiCnTx8HjKkepuZAttPnsjU6Nn3rjl4PUoV9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728282; c=relaxed/simple;
	bh=Nh7aBr5KYkQBsAqKOi50IdV/Xi0XD+m/VjeNMRt6v7U=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=jqBhu43a0ZPJrY7cN2oYNmWOtgP+R1Q5fT7nl+vOn6g34KYkUClEwqKu9joXYU4Gif938uJHq5p5n+o/8GMz+YqtH0iYtMtRw8Y/ldj8Io20UfXl+bqY1ORYjwdlhKCXmszWVDICMX08K3bqYddOKeUVzq4LA2UcvvRZDggUIJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QykmPj/x; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QykmPj/x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Lljoat6sYacBPvhSLf9rEDVbXVSpJG4w9X7ZqtrWvYk=; b=QykmPj/xj6AGzk3irdM6SDET8v
	JwokjD7ojlnPf7EhjHHotAdH+frKH/KpoVN2b7FriemI1tR9qfG9jOFfbAlrrUo4POc4c5IPGSrc9
	bFELSP/KBVeOCM0Bn6LzY3MUdh5jxYsz141VN8o0Xz5o/x5Nvh0NQgwHf4dcv9HL/8uE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ2-0000RT-Iw; Wed, 24 Sep 2025 11:37:52 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:31 -0400
Message-Id: <20250924153740.806444-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924153740.806444-1-hugo@hugovil.com>
References: <20250924153740.806444-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 06/15] serial: sc16is7xx: use dev_err_probe() instead of dev_err()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

This simplifies code and standardizes the error output.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7af09535a1563..4384804a4e228 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1528,10 +1528,9 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
-	if (!s) {
-		dev_err(dev, "Error allocating port structure\n");
-		return -ENOMEM;
-	}
+	if (!s)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Error allocating port structure\n");
 
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
-- 
2.39.5

