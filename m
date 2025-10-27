Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7030CD8E;
	Mon, 27 Oct 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575416; cv=none; b=ICa3ryqpyQuRxDuf7w75Vptku6f8kvxoFZeOgGU5DwFKH8YEalOFzQlSi8jxZ0mPx+94AHSH/rVPa7h37qj4utR0YSUMOnF/3/Mn4sLDNFNL8oqqDDkOZhcVdz5OQlu3uXgBqqqkp+bjQXSDPRvZ6A1FW8ZXapfIBe+sh5QTd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575416; c=relaxed/simple;
	bh=u8d5fcb1l5Z5hZsebKhnGEDW8xld2i5ktsnJGjIE/4g=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=D4hIE1A90LFao2dskMQYICulcEyhecuaiaNYsUN/ijb7kGEjNIi2ST9ugyqfQjEND9WlgXC603764VmhCESeOMziPU/tsVsz/smUxiL2IebXpxheP0soWrM//XGDLWmWV4fpNT9h/+qzjZpJ9ALWIJZRq6z+/XitfQHh5sH7TVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=QUlbyS5E; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="QUlbyS5E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=glceJJKK0EC0hS8gftwxgnSmUA78N5fSAVbKEkjvPT4=; b=QUlbyS5EZYZEfGpgTZf+04tQ16
	9/M2jD4FJaKYTKR1g+hhQ4RcvG4qwxXrqrliuNAaOneLturznOZr5Kv3lvfYcOuNdLs5gdV/pFIsi
	NVE9NnsBO3UjBPxVf+C76NuIyXyfbjoz9D8hVpZKgAXj7WMJHJ6jXdnwrjLdoZyRsVqg=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOEe-0007wg-Sw; Mon, 27 Oct 2025 10:30:13 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Oct 2025 10:29:52 -0400
Message-Id: <20251027142957.1032073-11-hugo@hugovil.com>
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
Subject: [PATCH v3 10/14] serial: sc16is7xx: Kconfig: allow building with COMPILE_TEST
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
index 282116765e648..59221cce0028f 100644
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

