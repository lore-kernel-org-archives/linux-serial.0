Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B10E7A20A;
	Thu, 21 Dec 2023 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="klF4EmqZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=SlEM2rILNAZB6YQdLheCmIbuxLDabci7Ac0z9IGXTaQ=; b=klF4EmqZJ/0h/Jllt+P6EP6jBp
	V9teL5n0n6y3tkt+wq97vD5KbOH7dKFP0LGISHmt+NZDR4wCQh7ubp7MmvKVVD4z4fia0lteo8NjS
	LZ0YMfIX7nYJIArX/a07L2BEytgrkrIUpDN5pXVbaoz9wXOFQHHRCCJpw3YSOEEjV8PE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJO-00025W-S0; Thu, 21 Dec 2023 18:18:43 -0500
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 21 Dec 2023 18:18:16 -0500
Message-Id: <20231221231823.2327894-10-hugo@hugovil.com>
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
Subject: [PATCH v2 09/16] serial: sc16is7xx: add driver name to struct uart_driver
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Make sure that the driver name is displayed instead of "unknown" when
displaying the driver infos:

Before:
    grep ttySC /proc/tty/drivers
    unknown              /dev/ttySC    243 0-7 serial

After:
    grep ttySC /proc/tty/drivers
    sc16is7xx            /dev/ttySC    243 0-7 serial

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e7f3184a70a1..b73fac209f1e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -351,6 +351,7 @@ static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
 
 static struct uart_driver sc16is7xx_uart = {
 	.owner		= THIS_MODULE,
+	.driver_name    = SC16IS7XX_NAME,
 	.dev_name	= "ttySC",
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
-- 
2.39.2

