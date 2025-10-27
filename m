Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D24279DCC;
	Mon, 27 Oct 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575409; cv=none; b=cCs3JXEAISBxiOspuwKQ0CLZPzg/xegFfM8Lte2VFQCOa3IDJchWdI+JgU+RZYD905sAqZC95EyUKU9ooH6cu6CmRvIBlTp20jtGgEjJkVZUUNa4f98CvWJBZ+rDAa4ummGWsFxd+vp6yA/btjAVbjBYZ4A0H1RRr9plJwU+00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575409; c=relaxed/simple;
	bh=vRBGm9s/dyL+mafpUYppZ1yooY3Npezr9ZaoASLiS50=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=n+7bgKkkK2RuElcppKWljVTutBWULw0zxQA+Joj4zhZc/R8jrvH/T5kPHMOXz6w7Pku0jV2sQSEjTNePJKmoFohowiIqSGGz83gQtNjgTfK2kV3ylERNn3wzs/vdMgG7ER0ykIlobddbel28JriKVAhngLNCCp+sbM5WIitqtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=L8gOJ8vK; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="L8gOJ8vK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=9stedbZ0oenGDNSu79soTv0x9oOzbagK1AmdZRDf5wY=; b=L8gOJ8vKm/i5l7+Df1FadJceek
	EMvP6p123RtMMQOVgVZdQQBYEhCbIPxrgdUfKo9znzr/yl2/Hp7XNHzKJZWwfvEkw+4YtRvhrcTMW
	J4T6DcjjKDkbB/cZFnDWzluKpQjy0U/rbkmtzwuiaI2rGT2hFsKuJQMoBbhl9SEL9nUc=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOES-0007wg-Jd; Mon, 27 Oct 2025 10:30:00 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:43 -0400
Message-Id: <20251027142957.1032073-2-hugo@hugovil.com>
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
Subject: [PATCH v3 01/14] serial: sc16is7xx: rename LCR macros to better reflect usage
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

