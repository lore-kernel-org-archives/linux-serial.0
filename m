Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C53DBB7;
	Fri, 31 May 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.23.86.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151179; cv=none; b=J9wROk9KdZ2Tb+mSkFtKf/k3Yx6dP7d+CqBLub8FYABolsCUG/bb72ZGp0lR8PJFYOZBXOYY9pymVdhz5yGEX+RigYoaxFqFdGq8u8N9NzYvHHJIS5j95w+OgfC+ncPICwD/FdrPMb1/RuusuWRqHNGMlOxRD7ifHYu295kAM2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151179; c=relaxed/simple;
	bh=PTMlr5w/6kBEWcOKgHe858k6nFFyhwJ1CCKOVUOJ9kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sY8t9+DIcQIAZ79rC28Gwpqk9MB8VxR7sX50Ql60bm4m6TI6yRLxEMNBwMPnVJqZqoukWWkMiOVGiC6rlfPfRq44dn/uRA8JUsM87JgLzf8EqpxcMnKcCPny20UPcCEII9KebqeSgmc5Fd65WtHGvYWY5kRWuF/L4We5KMQYBhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org; spf=pass smtp.mailfrom=zonque.org; arc=none smtp.client-ip=46.23.86.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zonque.org
Received: from hq-00595.fritz.box (unknown [178.19.214.146])
	by mail.bugwerft.de (Postfix) with ESMTPSA id 0B8D52806FF;
	Fri, 31 May 2024 10:20:06 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: gregkh@linuxfoundation.org,
	hvilleneuve@dimonoff.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>
Subject: [PATCH] serial: sc16is7xx: set driver name
Date: Fri, 31 May 2024 12:19:59 +0200
Message-ID: <20240531101959.181457-1-daniel@zonque.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the drv_name field of the driver struct so that the tty core
registers a procfs entry for it. This is useful for debugging.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index bf0065d1c8e9..308edbacda7b 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -351,6 +351,7 @@ static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
 	.driver_name    = SC16IS7XX_NAME,
 	.dev_name	= "ttySC",
+	.driver_name	= SC16IS7XX_NAME,
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
-- 
2.45.1

