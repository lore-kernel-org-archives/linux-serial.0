Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154436B05;
	Tue, 19 Dec 2023 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="TP8HLyeo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=pCFiEl099gN+IaylTnT0hoDSq03Y5bym/mkoj8GjOYI=; b=TP8HLyeol5TfMC88pf3h1hOSLC
	yEkaZd4yEfGOhmzwIyuRi+z0hb5vv7YXuVdrc6AhmLa2X+GOHEZEE1iB0v7FBP0PxUVq/VDnsvGPQ
	L8ja3zYXACIDVEhUy7YN5fT2JWrr042x+f3ELPiva32fXV8TxZaQ29dkVXpLijHFpGpM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkX-0007Ao-3F; Tue, 19 Dec 2023 12:19:21 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 12:18:58 -0500
Message-Id: <20231219171903.3530985-15-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 14/18] serial: sc16is7xx: drop unneeded MODULE_ALIAS
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The MODULE_DEVICE_TABLE already creates the proper aliases for the
SPI driver.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 29089b11f6f1..a9e44e5ef713 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1793,8 +1793,6 @@ static struct spi_driver sc16is7xx_spi_uart_driver = {
 	.remove		= sc16is7xx_spi_remove,
 	.id_table	= sc16is7xx_spi_id_table,
 };
-
-MODULE_ALIAS("spi:sc16is7xx");
 #endif
 
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
-- 
2.39.2

