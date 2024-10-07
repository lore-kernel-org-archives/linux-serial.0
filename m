Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2801DACB0;
	Mon,  7 Oct 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318534; cv=none; b=evkqXND1V4sADDURzLwgxe/WwWbV+PQuNUkzTbHzpDpn3gQYg+H2dXlH2JG1riDr3e652V9DDJwOLE6ri45AFmrKRe6W7deYogsDzMpyZH8Xi5/h8hgtCO564FrmdC25sR3CZEXfzrXPSXdavAkcLucAf9hgHKefWbWiuW+/t0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318534; c=relaxed/simple;
	bh=rVbwsO5KaljigcpRJZKzwIeX9VBoFVelJZKeKGjXHx4=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=t1nDtuXOapUwpoHxznlOVjiAmC1yOPUftGu50H3BapGobPSG4V0y9IGeesYhLhIrWVPT6ZxM25CYLdLImkeLRP6GcIJkFK74cVKHnXPAphVZep6gTTy2Lw2X6u/OoIzymuPEqIufF6zqa5AE4SRK3AyzF0TZpAO/WpLxBDEujVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=YDO2iA6g; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="YDO2iA6g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=HuoxMRjaBLuwT/6a6tcDA3Z2nPuOO6xI46MVrCuOTSA=; b=YDO2iA6gdbHg2eqfSXbziS5ANH
	vSNpteSdbC55nia3sUcTGp8veZpMrx6+NyA3GVxgcjoUWlvF00tZ+WSdyS/Y0I8pvR8XGWAK1L00V
	N+KyWCFE4HWOVqXhxTvAqSudelMIEOLsW9fXpYt9q5seZHH8BA/6i73OffUrxqMUOZMQ=;
Received: from [70.80.174.168] (port=45258 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sxqb8-0006qO-JR; Mon, 07 Oct 2024 12:28:39 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com,
	andriy.shevchenko@linux.intel.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Konstantin Pugin <ria.freelander@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Date: Mon,  7 Oct 2024 12:27:15 -0400
Message-Id: <20241007162716.3122912-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
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
Subject: [PATCH] serial: sc16is7xx: announce support for SER_RS485_RTS_ON_SEND
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

When specifying flag SER_RS485_RTS_ON_SEND in RS485 configuration,
we get the following warning after commit 4afeced55baa ("serial: core:
fix sanitizing check for RTS settings"):

    invalid RTS setting, using RTS_AFTER_SEND instead

This results in SER_RS485_RTS_AFTER_SEND being set and the
driver always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT,
which breaks some hardware using these chips.

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, so fix
this by announcing support for RTS_ON_SEND.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Suggested-by: Konstantin Pugin <ria.freelander@gmail.com>
Link: https://lore.kernel.org/lkml/20240422133219.2710061-2-ria.freelander@gmail.com
---

This patch was part of a series to add support for a new EXAR variant by
Konstantin, but the final version was never submitted. I need this patch
for a new revision of our board which has reverse RTS signal compared to the
old revision.
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ad88a33a504f..9d0c971e49f5 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1473,7 +1473,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 }
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };

base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
-- 
2.39.5

