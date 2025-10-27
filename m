Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007C830FC2C;
	Mon, 27 Oct 2025 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575421; cv=none; b=e6ias3BN53jjYudAmzpw+EMkIIRupK5/W5/eUy5/uZ8sH8ftjCQz5sCcdYA6BVGrTfHlwrfGxqytW+FgYLMLNzKOIuZCt4nvc6sMb0m4xDPosdHnZfJNMxYqymf92ysTKwGfalgDVRprvfpbQT5c3SvaIgLMZ3tcYCU5TlOlMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575421; c=relaxed/simple;
	bh=GCQy5NT/ubzrUMsnsLWKJUqAzFWNFZxLFuUUWhKDNjM=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=MI7at9TUH9o7huLYYxN4eSIGzv2pqc7ZMN97gSH32niujP+mCszjrYoSTuvx1g/lDMp9o52MLBJlYPoCbeskVKyKIFw1TchZmbMrqS2ORtDRo6EpcGR+aquaYuBSgzDFiKE+Bl/N3OmNGy1eHp1IyZ8LkI96yc3EM2GLQkT5d+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=rKJKOGP2; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="rKJKOGP2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=0t5o0gJzkUuCKY+o8R4Qgk/Wlxo2O4/jULe6c6ciClI=; b=rKJKOGP2sNfvT3rZe6r9dquhzH
	qerrDWcAGsr/EUfOnXzij+KQ3jnouDaejNEbq1PR7KZGdr9/wja/1PfrVfHttBHv1S128tN+8rEdM
	qWjRgeN1ph6ibz4s7fGeCay93/oVvlc1OnR8t3gcse8IyYusLRr/pymf3+6DALXqNo4k=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEk-0007wg-Ll; Mon, 27 Oct 2025 10:30:18 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:56 -0400
Message-Id: <20251027142957.1032073-15-hugo@hugovil.com>
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
Subject: [PATCH v3 14/14] serial: sc16is7xx: add comments for lock requirements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Indicate why lock needs to be asserted when accessing
MSR register, as this is not immediately obvious when looking at this
register in the device datasheet.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 4898b4235d0da..1fd64a47341d8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -499,10 +499,10 @@ EXPORT_SYMBOL_GPL(sc16is762_devtype);
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
@@ -711,6 +711,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 	unsigned long flags;
 	unsigned int status, changed;
 
+	/* Lock required as MSR address is shared with TCR and XOFF1. */
 	lockdep_assert_held_once(&one->lock);
 
 	status = sc16is7xx_get_hwmctrl(port);
-- 
2.39.5

