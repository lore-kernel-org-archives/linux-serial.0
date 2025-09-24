Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC825195FE8;
	Wed, 24 Sep 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728279; cv=none; b=Wgh9DDqLgg5e2fqXoNNqBshurifpjhG/Ve2OVwSv/RL7AMpr3beMgAT5MUcsohzuztkp5mEtiW7YQQz+x35pRbEzVq+CWW5KjV+L8SvCWtd44W/EwPCKBlsuwF3X1+BZH4Rnm8eXAkD9RdMi0gQU4JDhumw0BpJZNKqdupA6YG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728279; c=relaxed/simple;
	bh=vRBGm9s/dyL+mafpUYppZ1yooY3Npezr9ZaoASLiS50=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=ppAbLkHgqIpKDU9J2Fc9M5AaaCZPONx0g9XvanFyeRANrZEfhxyUrnvmdODzoq++HY5DfNHkaRhdl3YDPfyVNQv5f61bsvUKLJ0L75HZh4E5ImxBdkeYvMxtKC+VZMh9X3I4wo5dcyLutE3bDmVUGh+dETH4sGmwlsBCPj62lEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=BMYn6OoY; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="BMYn6OoY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=9stedbZ0oenGDNSu79soTv0x9oOzbagK1AmdZRDf5wY=; b=BMYn6OoY6Qt/32ngxI7AiQCDmF
	ovYryixkD0QK9lncWW7PxJ4g8bOMUQKdN7mV9foxhftshZiwd2R5lYGZ1xp2xKRVV8mdxM0gZZ110
	cLaeTYJiNgH/OsSFRp/I2oIteKWlOPRksc9sUHTSPqr5y+IykeviWUdbTO3XNIr8YtZY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RYy-0000RT-Md; Wed, 24 Sep 2025 11:37:49 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:27 -0400
Message-Id: <20250924153740.806444-3-hugo@hugovil.com>
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
Subject: [PATCH 02/15] serial: sc16is7xx: rename LCR macros to better reflect usage
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

There is no reference to CONF_MODE_A or CONF_MODE_B in the manufacturer's
datasheet.

Rename register set configuration macros for the LCR register, to better
show their intended usage to select either the Special register set, or the
Enhanced register set.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index c7435595dce13..330d95446f1d7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -149,10 +149,12 @@
 #define SC16IS7XX_LCR_WORD_LEN_6	(0x01)
 #define SC16IS7XX_LCR_WORD_LEN_7	(0x02)
 #define SC16IS7XX_LCR_WORD_LEN_8	(0x03)
-#define SC16IS7XX_LCR_CONF_MODE_A	SC16IS7XX_LCR_DLAB_BIT /* Special
-								* reg set */
-#define SC16IS7XX_LCR_CONF_MODE_B	0xBF                   /* Enhanced
-								* reg set */
+#define SC16IS7XX_LCR_REG_SET_SPECIAL	SC16IS7XX_LCR_DLAB_BIT /* Special
+								* reg set
+								*/
+#define SC16IS7XX_LCR_REG_SET_ENHANCED	0xBF                   /* Enhanced
+								* reg set
+								*/
 
 /* MCR register bits */
 #define SC16IS7XX_MCR_DTR_BIT		BIT(0)   /* DTR complement
@@ -442,7 +444,7 @@ static void sc16is7xx_efr_lock(struct uart_port *port)
 	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 
 	/* Enable access to Enhanced register set */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_CONF_MODE_B);
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, SC16IS7XX_LCR_REG_SET_ENHANCED);
 
 	/* Disable cache updates when writing to EFR registers */
 	regcache_cache_bypass(one->regmap, true);
@@ -598,7 +600,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_A);
+			     SC16IS7XX_LCR_REG_SET_SPECIAL);
 
 	/* Write the new divisor */
 	regcache_cache_bypass(one->regmap, true);
@@ -1650,7 +1652,7 @@ int sc16is7xx_probe(struct device *dev, const struct sc16is7xx_devtype *devtype,
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
-				     SC16IS7XX_LCR_CONF_MODE_B);
+				     SC16IS7XX_LCR_REG_SET_ENHANCED);
 
 		regcache_cache_bypass(regmaps[i], true);
 
-- 
2.39.5

