Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9E151991;
	Thu,  2 Oct 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417080; cv=none; b=S9XGpbKTuuGBFVnrB8HgQjTjTS3d2x0rHggYOAI+pAiBgPnkhnIXM2i3XcxYMIDkDWB00T0S2dxxTK35aOMTPEI4dtH4dt0zxYNo+NrWzfWaGGVoOZgjx1tB7+E7q3NkSLm3g0fVpdBEd/sGm7LHId5zJ3yYNX7GbVZgpNEL01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417080; c=relaxed/simple;
	bh=IjWZQxRbwm3maIX9Lg6a1zU954crPBEZ9m4lKowfbvk=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=FSv17xGflitpOKmvwUPE/yT/UNppjrPOyOn9MGjRHuR6Zr5FZgL59OmXrON/9ORjEeiGtzici3RbyEpuglnhfZ9kQETtnpkmSc0WqyGBrbVrDaMTt/LVnouVaNSOGN2Weut5OHf6mKIzSISTdv6VV5cd6EhaEBmpolWm/IOAPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=nNxo1B2S; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="nNxo1B2S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=HdJyQ9WrvZzcCFahMYHp01Ira5K/dlNq8lQwchzPxxI=; b=nNxo1B2SKoOhFMBt3SCsuLIVua
	La73H8DKxwZNY+XtvJJl3wUtoWpSm029AIMZwFqQNHfGc7wS8BBZxED/73Ao2j/Nsg/AbNtz/xJfZ
	DDoznZRGyS903P2hiCbv31/TWNiFqKx6+Q7sodK9toq4A3dJMzMMYsXDiNHSIzaE6KbA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4Kkm-0005hy-3Q; Thu, 02 Oct 2025 10:57:56 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu,  2 Oct 2025 10:57:36 -0400
Message-Id: <20251002145738.3250272-14-hugo@hugovil.com>
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
Subject: [PATCH v2 13/15] serial: sc16is7xx: change conditional operator indentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move "?" conditional operator all on same line to improve readability.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 644f4e9233dbc..3faf821b8b89d 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1180,8 +1180,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 	/* This bit must be written with LCR[7] = 0 */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_IRDA_BIT,
-			      one->irda_mode ?
-				SC16IS7XX_MCR_IRDA_BIT : 0);
+			      one->irda_mode ? SC16IS7XX_MCR_IRDA_BIT : 0);
 
 	/* Enable the Rx and Tx FIFO */
 	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
-- 
2.39.5

