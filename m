Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B71CA89;
	Tue, 19 Dec 2023 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xb4NbYgN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=eAovb+UcCr8c4+yXpiGUDUECK8pQrI3Ofw2ziL8xaHg=; b=xb4NbYgNCU3y5gAWSAmZIKnYEA
	mxGt9n6Mq740/FU1jviVnXzo7T+ziUKk9/z07smCh+nR9TaaLoZGGv3UE5jHqPpkhBhQk7K8Gc3Zj
	2+IGINBIdLTNN0FmjmOnbkUZfHVO207RCm3g7ws2TgkSFNqB3wPLcdDZTStMp/uGcw0s=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkV-0007Ao-SB; Tue, 19 Dec 2023 12:19:20 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 12:18:57 -0500
Message-Id: <20231219171903.3530985-14-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 13/18] serial: sc16is7xx: use in_range() for DT properties bound checks
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Improve code readability and efficiency by using in_range() when checking
device tree properties bound.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 133538f91390..29089b11f6f1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
@@ -1398,7 +1399,7 @@ static void sc16is7xx_setup_irda_ports(struct sc16is7xx_port *s)
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "irda-mode-ports");
-	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
+	if (!in_range(count, 0, SC16IS7XX_MAX_PORTS + 1))
 		return;
 
 	ret = device_property_read_u32_array(dev, "irda-mode-ports",
@@ -1425,7 +1426,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 	struct device *dev = s->p[0].port.dev;
 
 	count = device_property_count_u32(dev, "nxp,modem-control-line-ports");
-	if (count < 0 || count > SC16IS7XX_MAX_PORTS)
+	if (!in_range(count, 0, SC16IS7XX_MAX_PORTS + 1))
 		return 0;
 
 	ret = device_property_read_u32_array(dev, "nxp,modem-control-line-ports",
-- 
2.39.2

