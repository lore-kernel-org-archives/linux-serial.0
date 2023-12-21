Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224779476;
	Thu, 21 Dec 2023 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zMCNLWRH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=erjmsDZRhrWnaUKZ8qETR02HqNmxBDRKhVazGRk6Y6c=; b=zMCNLWRH1QBvIOWMSl5ucZv1DI
	OIr0CLz2DSqWjjJKTKBAzopDz3H+yHH0wybHv9e9wmzSugawY6VGj8ZLH0Z7uFuLfGhJTGfRnxB4A
	klxmadOeZDUji8CZIc5d5fj+NphUD5SH1cfsCWUUfh2KzbuaWRYAae4h//gUCPRmqlHo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJR-00025W-KB; Thu, 21 Dec 2023 18:18:46 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Dec 2023 18:18:18 -0500
Message-Id: <20231221231823.2327894-12-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221231823.2327894-1-hugo@hugovil.com>
References: <20231221231823.2327894-1-hugo@hugovil.com>
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
Subject: [PATCH v2 11/16] serial: sc16is7xx: add explicit return for some switch default cases
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Allows to simplify code by removing the break statement in the default
switch/case in some functions.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 6181cc6f934b..da862b8efcbe 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -460,10 +460,8 @@ static bool sc16is7xx_regmap_volatile(struct device *dev, unsigned int reg)
 	case SC16IS7XX_IOCONTROL_REG:
 		return true;
 	default:
-		break;
+		return false;
 	}
-
-	return false;
 }
 
 static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
@@ -472,10 +470,8 @@ static bool sc16is7xx_regmap_precious(struct device *dev, unsigned int reg)
 	case SC16IS7XX_RHR_REG:
 		return true;
 	default:
-		break;
+		return false;
 	}
-
-	return false;
 }
 
 static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
-- 
2.39.2

