Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C71A5B8B;
	Mon, 27 Oct 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575413; cv=none; b=RR26lf15/tUhV/S5N3KkkXrRDPVlYyHBm0VdXJUc73lv7owJehTUTc0mFrzN5jZoOlMcrgfjneC+0e8rU3ggEWY2CTNeKIw8kcBKWRk4lyonOvTeuyJtDTSTak1qF5bgabHrJSGs35lkk0t65LndzkoVb1BBMqvMcSTSaKNJ5Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575413; c=relaxed/simple;
	bh=u6Lx9QF35BQSo458PLEIGbTD/o5v3/ya3P+BZHwKBfM=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=Hyx0w+nibNTJe2T99j/WKtCO9QVkUCcwd9ORiQwtCNpTinzPUpLkZfIwRghHnBBwQR1cd+7QIlco6tkeX6nbhs7hgk154My9HoQx0w/hoSZW9U3jxoXyTIzYPUDmlHoQmDZ1oQ6BPEZQW1xCK9+W7B04NJ916Pywb2rcjqucxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=VYG/NZ8F; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="VYG/NZ8F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=04i7Sp88FFJOPgnn3H/zi1ltQiHU4cbmVZhpQuluM14=; b=VYG/NZ8FitvQIRfXeImNqW+7Pf
	FkBsvhvSv6TAb4WuKwjZiL70hebs3Ie0lFpsjwGTMr+2Ilit2Mwa0TGxsoTeBA2CDswPKX5Rh1MfI
	8Dsd8hpaT/GsDFey8hUy5by6suB+I1eu5v2nVK1aQj12Q5mx6Wj7ofp1m4HQ/lOOkvQM=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEW-0007wg-Gc; Mon, 27 Oct 2025 10:30:04 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:46 -0400
Message-Id: <20251027142957.1032073-5-hugo@hugovil.com>
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
Subject: [PATCH v3 04/14] serial: sc16is7xx: remove unnecessary pointer cast
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

There is no need to cast from a void * pointer, so remove this cast.

Also remove empty line inavertently added in commit d5078509c8b0
("serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()") and
change variables order to follow reversed xmas tree.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 72e4c4f80f7f5..335695d0e7aa7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -837,10 +837,9 @@ static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
 {
+	struct sc16is7xx_port *s = dev_id;
 	bool keep_polling;
 
-	struct sc16is7xx_port *s = (struct sc16is7xx_port *)dev_id;
-
 	do {
 		int i;
 
-- 
2.39.5

