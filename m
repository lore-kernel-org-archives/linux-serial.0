Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1848A233937;
	Thu, 16 Jul 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236107; cv=none; b=ENwkEXg53EVXdgOxYzbGky22rZN5GApt0ENGaVyzJ8Qkcbg6lxBfmC/bjsAn2N8gq7ouujnwFWeyc2tCI/pQfQAo/p8jz8wfmls8GYbTwrfuaC3hcjMCis4WE247RdqOf9Cv5SlnLiHCUD9zG9nIzcoLQjpEZJdVKz6aS+sVMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236107; c=relaxed/simple;
	bh=rtGkXQexkYv9ZmQtD+3zWF0NUNOe9RB2B8crxulao9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+7hmZtHY5hKdC4Q5k04JP2zLOVcQ2rJXtzdhvjZzGIKtpW3UHNkSXHYTA9jphwaKi2IgCvba79gM8mT4f2GAZXNy8aEKmAuePNGatPeS7g95H9jDGSf5zvtlW30ayD3Xyfrs1naIxyWxod/7uaWTpkyXJjwhR1HncNPBtgWmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Eq5KPGTo; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Eq5KPGTo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=VCC/qc2nJRIPHa4QMA3MLvQ+dzby8MDD0oDkuZVuXqA=; b=Eq5KPGTotP00OPVx14H87+ky8U
	lEBaEZqF7ueJkDMY+GwulgNKKT7YbS0VblPKEoBjeRLPqk2l5XnKUMJUiGGeUmJolbiD1MfOu9lvE
	m3eNkZ/CLhrzno056nC0ahQDbaM31jAw8NfRi6uKOj+avzny/jvaEUjct2xTDKm0PoV8=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wkTJX-000000007iG-1u9o;
	Thu, 16 Jul 2026 17:08:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jon Ringle <jringle@gridpoint.com>
Cc: hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH] serial: sc16is7xx: implement gpio get_direction() callback
Date: Thu, 16 Jul 2026 17:08:09 -0400
Message-ID: <20260716210813.2582826-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

It's strongly recommended for GPIO drivers to always implement the
.get_direction() callback - even when the direction is tracked in
software. The GPIO core emits a warning when the callback is missing
and a user reads the direction of a line, e.g. via
/sys/kernel/debug/gpio.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Inspired by a similar patch for max310x: commit a483b1a91b33
("serial: max310x: implement gpio_chip::get_direction()").
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 2498f9da2bf77..943be318de410 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1273,6 +1273,17 @@ static int sc16is7xx_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	return 0;
 }
 
+static int sc16is7xx_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct sc16is7xx_port *s = gpiochip_get_data(chip);
+	struct uart_port *port = &s->p[0].port;
+	unsigned int val;
+
+	val = sc16is7xx_port_read(port, SC16IS7XX_IODIR_REG);
+
+	return val & BIT(offset) ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
+}
+
 static int sc16is7xx_gpio_direction_input(struct gpio_chip *chip,
 					  unsigned offset)
 {
@@ -1350,6 +1361,7 @@ static int sc16is7xx_setup_gpio_chip(struct sc16is7xx_port *s)
 	s->gpio.parent		 = dev;
 	s->gpio.label		 = dev_name(dev);
 	s->gpio.init_valid_mask	 = sc16is7xx_gpio_init_valid_mask;
+	s->gpio.get_direction	 = sc16is7xx_gpio_get_direction;
 	s->gpio.direction_input	 = sc16is7xx_gpio_direction_input;
 	s->gpio.get		 = sc16is7xx_gpio_get;
 	s->gpio.direction_output = sc16is7xx_gpio_direction_output;

base-commit: da7b5fd4e17f8e44c5590f2d603c01d499f056e6
-- 
2.47.3

