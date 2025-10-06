Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30723283FE5;
	Mon,  6 Oct 2025 14:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760444; cv=none; b=ZPoAUr3oXltYr/cNElEX/pd4qJl8zVBJGrlXzrUDFmbvE//c6+OhwTCBtD9bl4TiAvJ04qSjHJM7cAfqlmQxiCdcRkvdl2B5yfEnBJKf5U40NmvN3aDohLyZ+H90VH4DRMMAxy3otr0vzjNAQ+78Y1D73N4QpakzZhfHZvWB34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760444; c=relaxed/simple;
	bh=QIMmn3T1KZwC2RE6BCze3N2hdjHyG2Jh9yg8h/UTYNY=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=RPtL8K4HYYt+S6E8dkJY4zTZpraGqP2EF1uSQ17no7Ht/6z7E0W0yFpk9JXhFTE+P1KynhCuq+LuxjA0LtFtKEuZOUpDdJ9DGqOkOrs6hXOWGv9MTW4HhNtQ0q/FKZhtKP2JEs700C/SrOZN+Mq5i7jjRioOhaQ24ecU74tyx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=K0U5KjLr; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="K0U5KjLr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=TnVJr+G/negDbYh0moPGGK3iRnZJniEtGgGzi4aX6LM=; b=K0U5KjLrODA2ObH+Tcb0KQI4oV
	azRNBcN10YUqpgP3lfhloObhkjWNiYX0rPJJLR43/foAoQha7OjWtflX3Ia5uy3yZaLtnEsfCmMdu
	+T051hypB4Et+RYwmxOs7yRkLKsE43nLF0HVMoWIrnGWSSo6W6Qf48cyjWXUW2+IYCoM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42564 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v5m4n-0007jX-Uq; Mon, 06 Oct 2025 10:20:35 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Florian Vallee <fvallee@eukrea.fr>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Date: Mon,  6 Oct 2025 10:20:02 -0400
Message-Id: <20251006142002.177475-1-hugo@hugovil.com>
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
Subject: [PATCH] serial: sc16is7xx: remove useless enable of enhanced features
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit 43c51bb573aa ("sc16is7xx: make sure device is in suspend once
probed") permanently enabled access to the enhanced features in
sc16is7xx_probe(), and it is never disabled after that.

Therefore, remove re-enable of enhanced features in
sc16is7xx_set_baud(). This eliminates a potential useless read + write
cycle each time the baud rate is reconfigured.

Fixes: 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
This patch was originally part of this series:
https://lore.kernel.org/linux-serial/20251002145738.3250272-1-hugo@hugovil.com/raw
and it is now separate as suggested by Greg to facilitate stable backporting.
---
 drivers/tty/serial/sc16is7xx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1a2c4c14f6aac..c7435595dce13 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -588,13 +588,6 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= prescaler;
 	}
 
-	/* Enable enhanced features */
-	sc16is7xx_efr_lock(port);
-	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_ENABLE_BIT,
-			      SC16IS7XX_EFR_ENABLE_BIT);
-	sc16is7xx_efr_unlock(port);
-
 	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,

base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
-- 
2.39.5

