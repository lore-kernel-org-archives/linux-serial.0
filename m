Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A52C17A8;
	Mon, 27 Oct 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575412; cv=none; b=nLZq5Xs3S32DItuIB31WoSSx+U2jDs1gtjqO4szAnIFxn2Bkc7GhKD2yjp1Udp4otJxHsXoQuUR26yd3tfmkh5QE4SRMIxmChEyjRd172XrjxvsE3ySo4B7HbAd1oLav/HW/8wb48z4J+IMEakAcnv4uUqZwk2VHfFCLgO8AulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575412; c=relaxed/simple;
	bh=QTdYORm3Ar5449orCUvpuyQ/EEELMgXHqxN9Y6MQxWs=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=PAHCrv59nyXuP6ohhItfVKxLPwPW/2Pd4XWGm3+wvcGdk82XsXTzfUb/RyQsHVG2L0eLHe2hXWc5nn+Fcssx6OwHL+YVK1ihlc+BFH+3S/gcWN0rmRBphfxb/O7mm3bZ7IIryHENqKQ9j1jSlJtvdcNKjpzWRk8Sxlf4gmizcn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=KAySNo8R; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="KAySNo8R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=Nh2cTwNgEe/lYYJk+cy3OBnV4tfGoYgLU0GsiudsnzQ=; b=KAySNo8R8znrH7LmDI2DdnSSZY
	+w1cgE+1z/zY7X6153U0QSs63PYr9dDfCXzYwTfl35/6UJizsqcfEW7a+25emW6nBrXq4Ml/WnSkq
	rM8PUQhhMowOzH1CAzIelRE8xrwRjNDIqZG0SB3dC4BEyHJXJUjTn3DwvGQbTi3Fs86Q=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEa-0007wg-Lt; Mon, 27 Oct 2025 10:30:08 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:49 -0400
Message-Id: <20251027142957.1032073-8-hugo@hugovil.com>
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
Subject: [PATCH v3 07/14] serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
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

