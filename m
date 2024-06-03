Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599C12FF71;
	Mon,  3 Jun 2024 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428396; cv=none; b=TUs3BPFVlgIK1hzYbE6iY/u24/4QXpXSOrpmqLFOIuGEeIWTUIFXIMxAyCSGQZLNqA+wOGznk0q4NNPKOaQpgcxUnqzdoos4PcqMuucREEzUpQopTNzHLVrYAQSrQfGuesmYTuPK+U8F84tO4HBXn8f0bIpSTllfUUsvSqvBpJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428396; c=relaxed/simple;
	bh=JCmpgMiGgIyv7XnOdg2rf7zHPVYaPivGVJaMkoyZHGU=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=u5ZTlsxejOUKgZVSBd1THxCH1w2OwwxYzZ46QtRhrYCGqvZJg5zegXg3PxAcqnYGC1AI/eqlWNQS2dJzE+16arpBz2dq/LQnnFx/rdhGbnsLA0pji4bA4JBCNvb090PJ+xNyHXfMV/1kM4OW4hAZjrvaL0tWjz70Pk7IVLCelGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=OikmosAw; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="OikmosAw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=4DlPd6ZxkfmBXAbzJO+INo9sFI8HWNVTBaTEg++gh/E=; b=OikmosAwt236m0i5UK4x2hdMyt
	3Eslc5HwZ37tnXozBOayvCWJCxKaFncbsityaH8T3mJ1J27AyOHgRVkH2KKByosBQe7dNzBRLwMTo
	ufGcSt63LNyHS3f8Mp+jnVSt9t+ig+btnrAiJ6mPHEm3NuNZZk4Hy/G4r5tbFucl3jX4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:34112 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1sE9Zt-0000dO-4e; Mon, 03 Jun 2024 11:26:29 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com
Date: Mon,  3 Jun 2024 11:25:59 -0400
Message-Id: <20240603152601.3689319-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
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
Subject: [PATCH 0/2] serial: sc16is7xx: Kconfig fixes after I2C/SPI driver split
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings some Kconfig fixes to the sc16is7xx driver. These fixes
are related to the I2C/SPI driver split:

https://lore.kernel.org/all/20240430090333.5c5f029553cabcdf699310cb@hugovil.com/

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the change on a SC16is7xx using I2C interface, as my custom
board is only using SPI.

Thank you.

Hugo Villeneuve (2):
  serial: sc16is7xx: rename Kconfig CONFIG_SERIAL_SC16IS7XX_CORE
  serial: sc16is7xx: re-add Kconfig SPI or I2C dependency

 drivers/tty/serial/Kconfig  | 3 ++-
 drivers/tty/serial/Makefile | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
2.39.2

