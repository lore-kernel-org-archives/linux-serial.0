Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082593148AF;
	Wed, 24 Sep 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728285; cv=none; b=crO5MX4ZVhgxN4GuUUqKTXC4autEJIacc5VNdkHKrGii8YP7Cf/vbSM0ZWocYs8pcTk40oRc3Uz08CKLP3WtXBXaN3EIMifhLS7J3lhhJgvJtA6KRfyoBbCI22a/XGZoVdWRnIlYvtfJXAFxR31niuep9uatMQa5UQLjQkZwhwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728285; c=relaxed/simple;
	bh=YbWJgC67kyN9zpskAusizW5T9F9lBZcWEV+qLGl9EwI=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=rvLLKCnsk6z8ssVnE5OGkXkMvC0yhzaEZXZb1ICrqXnqU5EmHhdw6x6H3n5C5iLTkAEa3jyY04g/YGm13gV/d2HwBeb38G8ygx5x7+tvZA0gllBVlciCs6delnF/E8jgjSymstlXBO2KI3WJqWB1l528VGFTY/lgAITXd+DLHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=rwXZ522d; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="rwXZ522d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=uSpLHXat2jMGBVLTbF5QQfMKAVtoAVNqQ3YP6QhxNYc=; b=rwXZ522deZwQlLT3/mc86qVPkS
	GNLeAATsU16xcQMYVHymgJc2HTt4Uj6p/ZnoRExZcdEAzBu5ZRw1/9tRRldpaMIUaGNfZ9h/2aPaM
	O40QG6Wg4OANldXqvPwcXsogxTeGpUkHjbQwzJkeJ0n8s7lPJDtE/rbiAYJdOYxBDFvc=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZB-0000RT-7O; Wed, 24 Sep 2025 11:38:01 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:40 -0400
Message-Id: <20250924153740.806444-16-hugo@hugovil.com>
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
Subject: [PATCH 15/15] serial: sc16is7xx: add/improve comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Indicate why lock needs to be asserted when accessing
MSR register, as this is not immediately obvious when looking at this
register in the device datasheet.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b3fbe9459303a..09f03edf0e5cb 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -164,7 +164,7 @@
 						  * - only on 75x/76x
 						  */
 #define SC16IS7XX_MCR_RTS_BIT		BIT(1)   /* RTS complement */
-#define SC16IS7XX_MCR_TCRTLR_BIT	BIT(2)   /* TCR/TLR register enable */
+#define SC16IS7XX_MCR_TCRTLR_BIT	BIT(2)   /* TCR/TLR registers enable */
 #define SC16IS7XX_MCR_LOOP_BIT		BIT(4)   /* Enable loopback test mode */
 #define SC16IS7XX_MCR_XONANY_BIT	BIT(5)   /* Enable Xon Any
 						  * - write enabled
@@ -545,10 +545,10 @@ EXPORT_SYMBOL_GPL(sc16is762_devtype);
 static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case SC16IS7XX_RHR_REG:
-	case SC16IS7XX_IIR_REG:
-	case SC16IS7XX_LSR_REG:
-	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_RHR_REG: /* Shared address space with THR & DLL */
+	case SC16IS7XX_IIR_REG: /* Shared address space with FCR & EFR */
+	case SC16IS7XX_LSR_REG: /* Shared address space with XON2 */
+	case SC16IS7XX_MSR_REG: /* Shared address space with TCR & XOFF1 */
 	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
@@ -757,6 +757,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
+	/* Lock required as MSR address is shared with TCR and XOFF1. */
 	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
-- 
2.39.5

