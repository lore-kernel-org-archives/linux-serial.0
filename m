Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="zx/1HOWJ"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36576B7;
	Mon, 11 Dec 2023 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=UjY/SqcnuoIIZGPSigiloYYgE/ckdvncJIsQwgfXK6g=; b=zx/1HOWJu3dwD3NF7YrNWIMhn2
	l9FAXqfehcRlbwCGdiEaOMjBBSS4omjqOlxNGQ8bj/0fnFYJfdLdCNQrpM1ZSIYQPhxILMm1dp1iZ
	48CQ+S74gPSiXF4taNAQY+eVkN1+RxYJlHD4+8Rx76Kh68ee/HMwS51lSXe1KiVfVM+k=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56730 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjqx-0003yC-Kn; Mon, 11 Dec 2023 12:14:00 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com,
	tomasz.mon@camlingroup.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	stable@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Dec 2023 12:13:48 -0500
Message-Id: <20231211171353.2901416-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211171353.2901416-1-hugo@hugovil.com>
References: <20231211171353.2901416-1-hugo@hugovil.com>
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
Subject: [PATCH v2 1/6] serial: sc16is7xx: remove wasteful static buffer in sc16is7xx_regmap_name()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Using a static buffer inside sc16is7xx_regmap_name() was a convenient and
simple way to set the regmap name without having to allocate and free a
buffer each time it is called. The drawback is that the static buffer
wastes memory for nothing once regmap is fully initialized.

Remove static buffer and use constant strings instead.

This also avoids a truncation warning when using "%d" or "%u" in snprintf
which was flagged by kernel test robot.

Fixes: 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
Cc: stable@vger.kernel.org # 6.1.x: 3837a03 serial: sc16is7xx: improve regmap debugfs by using one regmap per port
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9cb503169a48..8d1de4982b65 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1708,13 +1708,15 @@ static struct regmap_config regcfg = {
 	.max_register = SC16IS7XX_EFCR_REG,
 };
 
-static const char *sc16is7xx_regmap_name(unsigned int port_id)
+static const char *sc16is7xx_regmap_name(u8 port_id)
 {
-	static char buf[6];
-
-	snprintf(buf, sizeof(buf), "port%d", port_id);
-
-	return buf;
+	switch (port_id) {
+	case 0:	return "port0";
+	case 1:	return "port1";
+	default:
+		WARN_ON(true);
+		return NULL;
+	}
 }
 
 static unsigned int sc16is7xx_regmap_port_mask(unsigned int port_id)
-- 
2.39.2

