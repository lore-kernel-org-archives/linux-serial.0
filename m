Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB6242D62;
	Mon, 27 Oct 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575410; cv=none; b=r847LeVr75Uy6crD7/h5Zn1wod91jBgdVobTtBdm4X3iQmr064ExjptBA+MEr1yJZMCbzgbH6Yus9BePNi3EJN72Yvf6wZ1Zk4z79KprMIO6Xr4JMdC/RScITnTHDfOA1oJ7rey18TSSOSK9/Ptt+LwUbjVpeeiXHhFfPQDuS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575410; c=relaxed/simple;
	bh=s2g6vT0oH2OvFkS2Epbp7abu2H5DMhv0EDGrCB6XNaI=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=EvEJ0gIdif5MSbmMYKVl6/IMhQktYkPlwRR+1gMmE2QDaam9N9ZhPD3W0nMLizC6q3jYhDveaXhiU6CBZpxqEL2Myy3HuJsUqmnYFsRQlvfxTPA/UaSoRWgfz1nkUakbGLKLyES/4k8B8GKtPnvVXYJOViHKv8cXJJVe5H1UGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=Yap+wVLn; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Yap+wVLn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=CZQRXzSOtbffBNu99447ZOxKExqm883zzc2D7w/q56M=; b=Yap+wVLnpJhNtG9s3Hu+l3SP99
	UrkGFDN1ZSZucKJuw0Fs7qI7X8d2RPGEYDyjOcePb+qp6i2ALB5gKQ93UqNQ3UCQIx2amvWkiaf9+
	iEWCENBPsAflDf6pHhsTHZvRHYWVxacnXS5stVeZcPBHRC0dk80guSzA/Kxj1M3MhriE=;
Received: from [70.80.174.168] (port=45472 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vDOER-0007wg-D4; Mon, 27 Oct 2025 10:29:59 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 27 Oct 2025 10:29:42 -0400
Message-Id: <20251027142957.1032073-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
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
Subject: [PATCH v3 00/14] serial: sc16is7xx: register access fixes and improvements
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

Link: [v1] https://lore.kernel.org/linux-serial/20250924153740.806444-1-hugo@hugovil.com/raw
Link: [v2] https://lore.kernel.org/linux-serial/20251002145738.3250272-1-hugo@hugovil.com/raw

Changes for V3:
- Removed patch "serial: sc16is7xx: remove useless enable of enhanced features"
  which was sent separately to facilitate stable backporting

Changes for V2:
- Patch "change incorrect indentation": move to same line and reword (suggested
  by Maarten Brock)
- remove superfluous rc variable (suggested by Jiri Slaby)
- replace guard with scoped_guard() in sc16is7xx_ms_proc()
  (suggested by Jiri Slaby)
- Patch "use dev_err_probe() instead of dev_err()": remove original dev_err()
  line and reword (suggested by Jiri Slaby)
- Patch "remove empty line": remove useless cast and reorder variables
  for reverse xmas tree (suggested by Jiri Slaby)
- Simplify to_sc16is7xx_one() macro
- Reformat some multi-line comments up to 100 columns (suggested by Jiri Slaby)
- Remove typo cleanup from patch "add/improve comments" and move to patch
  "reformat comments to improve readability"

Hugo Villeneuve (14):
  serial: sc16is7xx: rename LCR macros to better reflect usage
  serial: sc16is7xx: rename EFR mutex with generic name
  serial: sc16is7xx: define common register access function
  serial: sc16is7xx: remove unnecessary pointer cast
  serial: sc16is7xx: use guards for simple mutex locks
  serial: sc16is7xx: drop -ENOMEM error message
  serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
  serial: sc16is7xx: move port/channel init to separate function
  serial: sc16is7xx: simplify to_sc16is7xx_one() with a single parameter
  serial: sc16is7xx: Kconfig: allow building with COMPILE_TEST
  serial: sc16is7xx: use KBUILD_MODNAME
  serial: sc16is7xx: change conditional operator indentation
  serial: sc16is7xx: reformat comments to improve readability
  serial: sc16is7xx: add comments for lock requirements

 drivers/tty/serial/Kconfig         |   2 +-
 drivers/tty/serial/sc16is7xx.c     | 413 +++++++++++++----------------
 drivers/tty/serial/sc16is7xx.h     |   1 -
 drivers/tty/serial/sc16is7xx_i2c.c |   4 +-
 drivers/tty/serial/sc16is7xx_spi.c |   4 +-
 5 files changed, 187 insertions(+), 237 deletions(-)


base-commit: 4e68ae36422e85ec1a86aded26a211319649426d
-- 
2.39.5

