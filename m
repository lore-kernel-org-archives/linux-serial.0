Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6312FF8B;
	Mon,  3 Jun 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428396; cv=none; b=lo6gjX0yLb/p/WSlExGiQvaT4fGIwMSJZwi7ztG9X0b5BP3uMxdnXP/UeZ96+0wL0P0JdMFIB+7sdhAAyuhULEB1+2YpW+TlThZYQTQhpbp3okRWOJp/mzAxXmGWnWXhSUE6+O1bzKDkIyZUNQM75/ABIGmhJBQe2G78+TofFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428396; c=relaxed/simple;
	bh=hemM1xK4V65JYXlqaL6Dvmk7jlD7S8+rGTEbYCdC8wA=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=Cc2ZuyxgjavKInmMd2H62Qu42lDMsr9Ntqmvo6YGwBhP/nnkrnVlE4lP28GW5a1fu+an9VL9V1Yd4Pnm65B8Fsrx4yor19O9s7xle1iPB6pYo1OMMy8QS6B8E8+A1YRqtL9qV387mzmvME1vzzcQjlLLmY844QqcEXEL4ObEx2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=KKY604Bd; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="KKY604Bd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=YERgIKa31OwTvOw6ExZsKEEYGREdgNimEx5DJ4xhUrQ=; b=KKY604Bd+2ixESfpBD0iXSnd+7
	0NwbZUZR3pSG62D8ZdKqB/1FbknxE+F9gRa3FI0cnr999yQIla2Odz7tayM23XXVKkpZk1Y0qV6C+
	jhZ6DCyo64+c8d5rBNDN/jGQOoyw/tq6pdCTUYYtnHMjmi9uCLi+p+dM15D00wzI2dvo=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:34112 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sE9Zv-0000dO-Gr; Mon, 03 Jun 2024 11:26:31 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon,  3 Jun 2024 11:26:01 -0400
Message-Id: <20240603152601.3689319-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603152601.3689319-1-hugo@hugovil.com>
References: <20240603152601.3689319-1-hugo@hugovil.com>
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
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 2/2] serial: sc16is7xx: re-add Kconfig SPI or I2C dependency
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit d49216438139
("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
removed Kconfig SPI_MASTER or I2C dependency for SERIAL_SC16IS7XX (core).
This removal was done because I inadvertently misinterpreted some review
comments.

Because of that, the driver question now pops up if both I2C and
SPI_MASTER are disabled.

Re-add Kconfig SPI_MASTER or I2C dependency to fix the problem.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: d49216438139 ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2a0da35c0ef8..28e4beeabf8f 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1025,6 +1025,7 @@ config SERIAL_SCCNXP_CONSOLE
 
 config SERIAL_SC16IS7XX
 	tristate "NXP SC16IS7xx UART support"
+	depends on SPI_MASTER || I2C
 	select SERIAL_CORE
 	select SERIAL_SC16IS7XX_SPI if SPI_MASTER
 	select SERIAL_SC16IS7XX_I2C if I2C
-- 
2.39.2

