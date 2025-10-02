Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FE3C1F;
	Thu,  2 Oct 2025 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417073; cv=none; b=mFK+EJoKqLXlT+FqHV3WpAz/ulCBqL/RyelGiazft+1R9K879ql74qIEIyupdZxLMfcmsui82QrqJl0jGzEOm51m/FvsYcNnGRxGBlbCe0ee7EsV/9lM3IKbflm434TAp3tqpdxP5LPYUoOIQiyWadG3b0U0ln9bA4lTy8UK/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417073; c=relaxed/simple;
	bh=QTdYORm3Ar5449orCUvpuyQ/EEELMgXHqxN9Y6MQxWs=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=mZAdTvnjVmFtUKwinXnDwKxdqJZ1nz716pOLf3JuVZG+gfxtBRmnX3nNAUD5xz7Sk1zNi6q7sdrTIYVR0utTa1NWWkAY9s0VnguTRHwlDzKng6N41CmL2MAhyVExQcwBNxYy9YrNclJtrRxuvBMDbGPjyXpyvSZ0ZrAYikryI5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=HAc9n0sN; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="HAc9n0sN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Nh2cTwNgEe/lYYJk+cy3OBnV4tfGoYgLU0GsiudsnzQ=; b=HAc9n0sNyrGoqy6SjemJLqMKPn
	ecbf1MlcUDDCWEXbmJzhwaGdRlGPCARxPKVvW2b4L3288fqyiH14xotZY+7e+bFEewCUHMkKTL6kN
	bwT6jrKoHXH5w/5s2PFGEW594KSw4PHbqR5aXi+dJv4ymi7QULgQlvaHDoLcdJObfYRc=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4Kkg-0005hy-Cd; Thu, 02 Oct 2025 10:57:50 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu,  2 Oct 2025 10:57:31 -0400
Message-Id: <20251002145738.3250272-9-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002145738.3250272-1-hugo@hugovil.com>
References: <20251002145738.3250272-1-hugo@hugovil.com>
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
Subject: [PATCH v2 08/15] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

SPR shares the same address space as TLR and XOFF2. If SPR or TLR were to
be used eventually, this could lead to incorrect read value from the cache.

Prevent this potential bug by declaring SPR/TLR/XOFF2 as volatile.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ce2a0967ffdf4..281cbb2274e50 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -546,6 +546,7 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IIR_REG:
 	case SC16IS7XX_LSR_REG:
 	case SC16IS7XX_MSR_REG:
+	case SC16IS7XX_SPR_REG: /* Shared address space with TLR & XOFF2 */
 	case SC16IS7XX_TXLVL_REG:
 	case SC16IS7XX_RXLVL_REG:
 	case SC16IS7XX_IOSTATE_REG:
-- 
2.39.5

