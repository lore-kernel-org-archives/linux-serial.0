Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A42F361F;
	Thu, 23 Apr 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975320; cv=none; b=lc4ULhvfDpG88vBI4GxJYe8+FD2FgsFdB42ssvZ512pLGGOwAYRx1MwRkmRSe5JEvXWOagHINg+xhvGFemklkVHnnjTWdy3Rcws2d2XiWjNuf9JadIp8P+AZYododjkgOIZrR77TjRDxItat9IOkNenYDYJ6SYqZW48D6WBJFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975320; c=relaxed/simple;
	bh=MhvCYHKuPkKoSIeyY+odOW/AC2uvnKrYsdnlcT81CJc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qWzpaQL1VH5qkGDzJP3IuINYCa9+g9d/mt8TqqHemG1Ezauohv6PARj9dYTEoDBz8OE5fSDMR6Mx66FmGA6PVY8kAoMPrCbTvr6wTJVW8klg6toEjPqmsj/gyA0qQTcq9H/IWP0LhKnEj7+KDHycxk+FWlkzniLZny7ZGSvv6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=aQvYEGTU; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="aQvYEGTU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:From:subject:date:message-id:reply-to;
	bh=264AxmAOvvaGpTcRs6WMaY79ManG4+FOWXRj3eQiNFE=; b=aQvYEGTUlP+a9SqK4i3Ty9C0bY
	5CoqnG/kCOZWR6OKUrhaVFdXSWL6HxoPHZtnTd7i+rP0NIoA/b8M5G8ucCI53InbLMuyqvJvKCP1g
	Ox9IKNXzT+M9IXcE482dwWRDy+P3I1LEji3NAuhH1cln0WYJjpEtytP/hEFNW6kKkGn4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wG0S3-000000002qN-1SKn;
	Thu, 23 Apr 2026 16:15:07 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH 0/9] serial: add new I/O type for SPI and I2C bus devices
Date: Thu, 23 Apr 2026 16:15:00 -0400
Message-Id: <20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMR96mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNj3ZKSSt3Sgsx83WSLJDOzRINEU0vjVCWg8oKi1LTMCrBR0bG1tQB
 2N/ldWgAAAA==
X-Change-ID: 20260423-tty-upio-c8b66a0a593e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

Hello,
this patch series add a new I/O type for serial devices on a SPI/I2C bus.

These changes are based on a suggestion [1] made by Ilpo Järvinen during
past sc16is7xx driver patches review.

I decided to use UPIO_BUS/SERIAL_IO_BUS names but maybe other names would
be more appropriate:
   UPIO_SBUS   / SERIAL_IO_SBUS
   UPIO_SERBUS / SERIAL_IO_SERBUS
   UPIO_EXT    / SERIAL_IO_EXT
   UPIO_CUSTOM / SERIAL_IO_CUSTOM
   UPIO_REGMAP / SERIAL_IO_REGMAP  /* Maybe not always true in future? */
   ...

Tested on a imx6 board with two SC16is752 using SPI mode, and a dummy
device-tree entry for a MAX3100:
  dmesg -t | grep "base_baud"
    2020000.serial: ttymxc0 at MMIO 0x2020000 (irq = 197, base_baud = 5000000) is a IMX
    21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq = 198, base_baud = 5000000) is a IMX
    spi1.0: ttySC0 (irq = 165, base_baud = 1500000) is a SC16IS752
    spi1.0: ttySC1 (irq = 165, base_baud = 1500000) is a SC16IS752
    spi3.0: ttySC2 (irq = 37, base_baud = 1500000) is a SC16IS752
    spi3.0: ttySC3 (irq = 37, base_baud = 1500000) is a SC16IS752
    spi3.1: ttyMAX0 (irq = 0, base_baud = 0) is a MAX3100
Note that before these patches, max3100 silently failed in uart_configure_port()
because membase/iobase/mapbase were zero.

For max310x and SC16is7xx in i2c mode, tested only that driver is properly
registered by using i2c-stub.

Also tested on a custom board with a Renesas RZ/G2L cpu (sh-sci driver) to
confirm there is no regression:
  dmesg -t | grep "base_baud"
    1004b800.serial: ttySC0 at MMIO 0x1004b800 (irq = 35, base_baud = 0) is a scif
    1004bc00.serial: ttySC1 at MMIO 0x1004bc00 (irq = 40, base_baud = 0) is a scif

Maybe some of the patches could be merged together, but for now I decided
to keep them separate to help the review process.

Thank you.

[1] https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com/raw

---
Hugo Villeneuve (9):
      serial: core: add uart_iotype_mmio/legacy_io helper functions
      serial: core: use uart_iotype_*() to simplify code
      serial: 8250: use uart_iotype_*() to simplify code
      serial: core: fix indentation/alignment
      serial: core: add new I/O type for SPI and I2C bus devices
      serial: core: prevent irrelevant I/O infos display for UPIO_BUS
      serial: sc16is7xx: use new UPIO_BUS as iotype
      serial: max310x: use new UPIO_BUS as iotype
      serial: max3100: use new UPIO_BUS as iotype

 drivers/tty/serial/8250/8250_port.c |  33 ++--------
 drivers/tty/serial/max3100.c        |   1 +
 drivers/tty/serial/max310x.c        |   9 +--
 drivers/tty/serial/sc16is7xx.c      |   9 +--
 drivers/tty/serial/serial_core.c    | 121 ++++++++++++++++++++----------------
 include/linux/serial_core.h         |   5 ++
 include/uapi/linux/serial.h         |   1 +
 7 files changed, 83 insertions(+), 96 deletions(-)
---
base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
change-id: 20260423-tty-upio-c8b66a0a593e

Best regards,
-- 
Hugo Villeneuve <hvilleneuve@dimonoff.com>

