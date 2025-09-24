Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5D43128C4;
	Wed, 24 Sep 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728283; cv=none; b=RyFDrTWdMvGWVcO2joxItyK/RTjk10pkXa6+sz/uZandWBU5gD3tjVddor6wrzuaa1pcWIERyEBM3qxKEkFNPy+FtkIux20olEk55BZEDejcMmcPacstAznmAw4t4CXYG+b/Ul7qvzOtaBqtMoYKoMKpb5OvLnrJ8I5wPlZbNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728283; c=relaxed/simple;
	bh=N7We2kb2VuhXFVH+zyKTRWZpX4UXSxbXlzPJw38tSx4=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=IjAt1fRlFnRBe/dx0izJWfi2053jo8DRGrcM630xw1iBDFiVlAdIUQEdMFofZicyVL9bLuNqUAQehjL6RJsIGXOkvoPi2aHTn9nt4WB3PMpYNKu4kjoLCwhE38GyeeXypw+HSFxwM6PPKAM7Me6AKhMUkw8E/w2airUTq4T6Hlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=eX0Dmqgg; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="eX0Dmqgg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=RwrrQfNlnhkN7H5MSrcN8Hn+U5qwYA1ZOtzfaRM276I=; b=eX0DmqggDrBG4COUNoyzDI0NSd
	VjX5lrUn5EqvOVUUPeSHIs4MM000HL3roB/qNxpfq6zjjKjHo1HqKoy5En6V3K+FqLCI0zQgb15EM
	Ti37F+vS7OceqNzBRAjJCDW05dsN1TZbotN01JnNvTZMkedI1qsU53q0gMXfcVoJILG4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RZ9-0000RT-HI; Wed, 24 Sep 2025 11:37:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:38 -0400
Message-Id: <20250924153740.806444-14-hugo@hugovil.com>
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
Subject: [PATCH 13/15] serial: sc16is7xx: change incorrect indentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Change incorrect indentation level introduced in commit 9eb90d57b55a
("sc16is7xx: Add flag to activate IrDA mode").

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9d04d665ec9ab..31d43fc857187 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1181,7 +1181,7 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_IRDA_BIT,
 			      one->irda_mode ?
-				SC16IS7XX_MCR_IRDA_BIT : 0);
+			      SC16IS7XX_MCR_IRDA_BIT : 0);
 
 	/* Enable the Rx and Tx FIFO */
 	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG,
-- 
2.39.5

