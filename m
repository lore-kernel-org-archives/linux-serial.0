Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB012FB0B;
	Mon,  3 Jun 2024 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428396; cv=none; b=jdjUsr9JTqBWUtDFv16LjecL8VId5lMzL5raKrcc2XE1s67jQe7oFLh9cGfuv1STT8apGZnCgeAl4Go/Khpx80IKxs4wDjcqkJ67hUaBkng/t7FRNP96XhHWPgZ7FWwsID1KOPe5RTF3UyioN4/5YJollcNa5mEclMnPMct0hFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428396; c=relaxed/simple;
	bh=wwoE058iMBVD1kOqaV65txl/L9mXcbQdTteqH1Np/u4=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=CyLsUH/3m8fBPmamHF+SayaD8m5qea5eImliuHH4AkEmmByvyiZ1PTx3kmPmlejq2j2g+u6c+afoz76QFhqw3tZiJkI3gc6OQl32aYb5W0U4Dk/hC3b1aP6Lu9WtipD7LQCa0GVaWCUGIKclE7mKw0i2uyQeJriLeigNeedcLJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=D9SF5Efa; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="D9SF5Efa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=cnPxg46vIGsnzaCwnceBileM7ZObeyNg/esumF2EXeQ=; b=D9SF5EfaB6tywSSOhZ6kfYjYVQ
	oGL60fShHfB58Fn91Gb7Of2I5OuthIfYjNoZYrakTO5j0+rNE1eNzOexAM911zH2Zl7UAZhnM06zN
	N7taTCogWmQtbf+3I/5Pu0tKbwX/7R79dFLW1gXR0Sp/sRovP4W1dPJS/NnvK/wHrRMk=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:34112 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sE9Zu-0000dO-8c; Mon, 03 Jun 2024 11:26:30 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon,  3 Jun 2024 11:26:00 -0400
Message-Id: <20240603152601.3689319-2-hugo@hugovil.com>
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
Subject: [PATCH 1/2] serial: sc16is7xx: rename Kconfig CONFIG_SERIAL_SC16IS7XX_CORE
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit d49216438139
("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
renamed SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX. This means that some
configs should have been updated when I submitted the original patch, but
unfortunately they were not. Geert mentioned for example:
    arch/mips/configs/cu1??0-neo_defconfig

Rename SERIAL_SC16IS7XX to SERIAL_SC16IS7XX_CORE so that existing configs
will still work correctly.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: d49216438139 ("serial: sc16is7xx: split into core and I2C/SPI parts (core)")
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/Kconfig  | 2 +-
 drivers/tty/serial/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4fdd7857ef4d..2a0da35c0ef8 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1023,7 +1023,7 @@ config SERIAL_SCCNXP_CONSOLE
 	help
 	  Support for console on SCCNXP serial ports.
 
-config SERIAL_SC16IS7XX_CORE
+config SERIAL_SC16IS7XX
 	tristate "NXP SC16IS7xx UART support"
 	select SERIAL_CORE
 	select SERIAL_SC16IS7XX_SPI if SPI_MASTER
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index faa45f2b8bb0..6ff74f0a9530 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -75,7 +75,7 @@ obj-$(CONFIG_SERIAL_SA1100)		+= sa1100.o
 obj-$(CONFIG_SERIAL_SAMSUNG)		+= samsung_tty.o
 obj-$(CONFIG_SERIAL_SB1250_DUART)	+= sb1250-duart.o
 obj-$(CONFIG_SERIAL_SCCNXP)		+= sccnxp.o
-obj-$(CONFIG_SERIAL_SC16IS7XX_CORE)	+= sc16is7xx.o
+obj-$(CONFIG_SERIAL_SC16IS7XX)		+= sc16is7xx.o
 obj-$(CONFIG_SERIAL_SC16IS7XX_SPI)	+= sc16is7xx_spi.o
 obj-$(CONFIG_SERIAL_SC16IS7XX_I2C)	+= sc16is7xx_i2c.o
 obj-$(CONFIG_SERIAL_SH_SCI)		+= sh-sci.o
-- 
2.39.2

