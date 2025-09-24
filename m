Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51958C11;
	Wed, 24 Sep 2025 15:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728277; cv=none; b=HfEk7POe1+PzdWQ1fhWtnw3qqxViI0X6TXgE5mLud0t8n2yiOBg2YdK5FDk3+YuxeSmgkGModxXWdRETuoIlOYdDnl34AcX1PSE+jBt20quC+UJmNVYfMVM68jqOS2518duzRlY/qhBpC7PbQ8Q1ClSBFGVEbsEsE36TQ4J0wQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728277; c=relaxed/simple;
	bh=NI0Qo+2hZhljC816l7D68Hu7QYF+UqFiu3YDhPtrtlU=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=JIqx2am0MKgQZOeXm4l2i9i/eE2G0iTl9C0TBal9fP2lLx27xfmFQJbad5iVDFaahxmTFM1NzroiN0wAp44NBWSql9sALXbBk3ksbm65r21NNAPB2kgW0edYheriFq2BBkAXKVskDeVgUHq6QQIxAEo0ICKkgcIxY4gPtb1Kj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=fFAp+eZ2; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="fFAp+eZ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=aU+7mQJb8BuoOLFxdhxn9k0n9jz6i4RX+KpHqDj7JEU=; b=fFAp+eZ2bl71k3WF/ojiJ7xivq
	hCVgYOQrxmxO8/oPxwmA1fxr3N7POjJleZ0Xe0BkIA4tu8nKM9GFd3yVQ355Es2bC5jiDH7dMC9Hg
	FAYXULjCRNc6n/AssNd6wtsB8Dd45eAwOobyQPJhK0ADpjU61pjVWEgv/DUHMxWMJltE=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:51978 helo=localhost.localdomain)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v1RYw-0000RT-Ro; Wed, 24 Sep 2025 11:37:47 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Wed, 24 Sep 2025 11:37:25 -0400
Message-Id: <20250924153740.806444-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
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
Subject: [PATCH 00/15] serial: sc16is7xx: register access fixes and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings some fixes and improvements to the register
accesses for the sc16is7xx driver.

It also adds some minor improvements, and cleanups to uniformize code
style accross the driver.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the change on a SC16is7xx using I2C interface, as my custom
board is only using SPI.

Thank you.

Hugo Villeneuve (15):
  serial: sc16is7xx: remove useless enable of enhanced features
  serial: sc16is7xx: rename LCR macros to better reflect usage
  serial: sc16is7xx: rename EFR mutex with generic name
  serial: sc16is7xx: define common register access function
  serial: sc16is7xx: use guards for simple mutex locks
  serial: sc16is7xx: use dev_err_probe() instead of dev_err()
  serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
  serial: sc16is7xx: move port/channel init to separate function
  serial: sc16is7xx: Kconfig: allow building with COMPILE_TEST
  serial: sc16is7xx: use KBUILD_MODNAME
  serial: sc16is7xx: remove empty line
  serial: sc16is7xx: add missing space between macro args (checkpatch)
  serial: sc16is7xx: change incorrect indentation
  serial: sc16is7xx: reformat comments
  serial: sc16is7xx: add/improve comments

 drivers/tty/serial/Kconfig         |   2 +-
 drivers/tty/serial/sc16is7xx.c     | 275 ++++++++++++++---------------
 drivers/tty/serial/sc16is7xx.h     |   1 -
 drivers/tty/serial/sc16is7xx_i2c.c |   4 +-
 drivers/tty/serial/sc16is7xx_spi.c |   4 +-
 5 files changed, 139 insertions(+), 147 deletions(-)


base-commit: f4abab350840d58d69814c6993736f03ac27df83
-- 
2.39.5

