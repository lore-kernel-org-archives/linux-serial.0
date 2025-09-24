Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14092FE570;
	Wed, 24 Sep 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728278; cv=none; b=RTUzFBVpoQlR7I4ljWhC/RRiKhfKd55d8G0tEdyPwrH8GK4QdbGVszzeagob0HlDWcy6qkegTCWtlr6j5BHS1OaqeStL9OZscSGe9hWObAf1J0Foilbk2eQBoEgqBLQIGOqEnZbmtWy7n4mmr1we6mBWEFsP03jomoVay5WflM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728278; c=relaxed/simple;
	bh=VQ4K3mbYDF7RCOQuQTRrICrxJ9EawHCBs0QoYZtZhZ4=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=HUyldvlmZ/Rt0b0s2+r5cp0LOiqxaZBEykz59ROFqu0vFIL72N8c9IqF/LM8NQ6jKGankH9TcgmCKNCFUPxMt5GgXIkHLGt88z7NQINFjoLDJPImeSxJsZoxZQhwWI3rzkIEjonrwmmt0CGOw6qttPaR6/JNDP9673JBCXiwra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Zk3UtJK2; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Zk3UtJK2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=SI53DqfwOlhDf1zYe8DxLPZIvnq90SSUoK0E9Zs7Q4Q=; b=Zk3UtJK2CZZ2CyChO0DC2umTV5
	Gk49CIMJ5bszcPsgPKSthIGPgsGetGOltwCfNxipOpGPmHdUcQsNmXE8ZaojNZ3fMN7yhqItMnjpP
	NN6EQrdDAgL9u8nVPFlPM1UJkKFk12XyS2AG8d8O4xP1z+pwDCuF/OOaxVM1T8Jof01A=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RYx-0000RT-U2; Wed, 24 Sep 2025 11:37:48 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org
Date: Wed, 24 Sep 2025 11:37:26 -0400
Message-Id: <20250924153740.806444-2-hugo@hugovil.com>
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
Subject: [PATCH 01/15] serial: sc16is7xx: remove useless enable of enhanced features
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit 43c51bb573aa ("sc16is7xx: make sure device is in suspend once
probed") permanently enabled access to the enhanced features in
sc16is7xx_probe(), and it is never disabled after that.

Therefore, remove useless re-enable of enhanced features in
sc16is7xx_set_baud().

Fixes: 43c51bb573aa ("sc16is7xx: make sure device is in suspend once probed")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
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
-- 
2.39.5

