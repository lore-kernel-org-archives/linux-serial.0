Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D87311C1B;
	Fri, 17 Apr 2026 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437636; cv=none; b=RgKW9Au3UY9sFg5nf59/BKNpW2QBkgwyceq5O6QiB/VI0J6M95Yx2bFI2mQMUyMVATJa6p0TGv51+P8Q/OG1rOnB377NzRmpBYRFphZJhkzsyFDMmiQWMeknPkDKSD0+rJlX3GEBWdC5mKp8Rti8e/dhJw0h16s6tSrvijm/Ssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437636; c=relaxed/simple;
	bh=kY7UuLOXJqNHhd8TlOjTgCVHd7nQGl5XJeQ3F2Wz8X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khkJzhuR9UWL8VT5+JIIN6NNYfNaPuAeQHqi8sYKwl0OrOMG7Oi7sjnq7rdygWFy9PLqurEWxAjHJpEDaAdtE/88zPgEj1QJkD+LHqEpTB52TH1l1+lXp4qRyv2F9ibYDYG1QmZz0osWc1xlS/4kFxEU0k07Fw66UquS1AyGhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=PeFHkOJf; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="PeFHkOJf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:MIME-Version:
	Subject:Date:From:subject:date:message-id:reply-to;
	bh=9tic9WMN1uLlZw0Uqah/+Q0/FRTkYJROicLvqRMAgU0=; b=PeFHkOJfUjDmLmTyVOHSDU9KHZ
	g9CRGaOXuix/bdbqitu/MYKBVLIQ1dTkijuU/ygtggouzgdRrYCdnuVeA4VBqFyQxU2aQAK8mnPAs
	oNk8RxsNlMY/6NZe1KN5UHkA/2GUJAX4XEbpgse28IBhJ9BwIl1hjaXjVG7NOf4ZBg6I=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZn-000000006G1-3Ow7;
	Fri, 17 Apr 2026 10:53:48 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Date: Fri, 17 Apr 2026 10:53:35 -0400
Subject: [PATCH 08/10] serial: max310x: allow driver to be built with SPI
 or I2C
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-max310x-2-v1-8-b424e105ecac@dimonoff.com>
References: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
In-Reply-To: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If SPI is disabled, the max310x driver cannot be selected. Allow driver to
be selected if either I2C or SPI is set.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9aa61c93d7bc6d164b9c493f140477b793ca8afe..296fa20340bd59196f7d1394687edac10fc73adf 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -321,7 +321,7 @@ config SERIAL_MAX3100
 
 config SERIAL_MAX310X
 	tristate "MAX310X support"
-	depends on SPI_MASTER
+	depends on SPI_MASTER || I2C
 	select SERIAL_CORE
 	select REGMAP_SPI if SPI_MASTER
 	select REGMAP_I2C if I2C

-- 
2.47.3

