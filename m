Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FD019006B;
	Thu,  2 Oct 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417077; cv=none; b=FKsj4e2qWSpXB7kvyP863rPtkAxqujt98UAOqwHxkWWRvoZSsCV2UjevIgYgQqDHqCgf+6EC/ygoEyyf47GqhnKAHc6rXIuZ53fYaL7P6zCSyKRoGVAq0PwpjJvZu4OqYGNLmqBfVM5v1NDgVAy4eE/a/c3vlbnDcvz3s02Qyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417077; c=relaxed/simple;
	bh=/59pzaIpo3hxjYrwoqRQB9pU18sg+2ce7TE+GucMtQ4=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=ZOI+meTYYoDX3jv8tgTgJ7/Gr3w7RACdqGP070KCm8bP4vFaYkwbyPYnYv2uA+shwacpc27AM61pEONozXJo/Y84x4ZuzHYNOTOq6UNjEmKwuGoOtio6BL1kQ/Ex44ZqosxR/goZwENO/Y4T5uCE6LPEIP5EJVy9DFk/9VXMDeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=C/V1Y4qq; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="C/V1Y4qq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=N0EipVfeJiCRsPTWh7G7K2zw8aa4aDpHL9PXk/Hc5Xg=; b=C/V1Y4qqd0TMBxDoiFEK+bQqhk
	ywEGouaWNA3uGjVq/KAnLnLniQrsK5hSnCp8m9vM43XAbH5bcbC886nQ4lZTVTHkang22L/U2vLT5
	mXPTAfirDlPGYbTY3wqAXBnmcbZjbYfubEzo8MAvTO9dsUZga/oC9iOMDoAh3zTOUM54=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4Kkj-0005hy-F5; Thu, 02 Oct 2025 10:57:54 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu,  2 Oct 2025 10:57:34 -0400
Message-Id: <20251002145738.3250272-12-hugo@hugovil.com>
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
Subject: [PATCH v2 11/15] serial: sc16is7xx: Kconfig: allow building with COMPILE_TEST
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add COMPILE_TEST as an option to allow test building the driver.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/all/20240604083159.d984dd08741396ea4ca46418@hugovil.com/raw
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 8523ccfb364dd..9a90654dccd78 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1044,7 +1044,7 @@ config SERIAL_SCCNXP_CONSOLE
 
 config SERIAL_SC16IS7XX
 	tristate "NXP SC16IS7xx UART support"
-	depends on SPI_MASTER || I2C
+	depends on SPI_MASTER || I2C || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_SC16IS7XX_SPI if SPI_MASTER
 	select SERIAL_SC16IS7XX_I2C if I2C
-- 
2.39.5

