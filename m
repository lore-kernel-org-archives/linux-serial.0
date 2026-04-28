Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713044508F9;
	Tue, 28 Apr 2026 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777398877; cv=none; b=XZrMb+XlmrKC5tWHnirkbxD8YaXkrsE7bZ8Bx/8Bze+GYzaJXDQA8PYiyK1FGubaXxdK9ObzfrxZ3pN+h0D75tBYrUs4sdh3TmIkHqj0+YAfWZ2cVOGCIShGk7n3U0pojULg9JxHkczWagNahbTdX0db0ZrX6xyt8pVPtgbtzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777398877; c=relaxed/simple;
	bh=Z4kVu4ZSkfovuLtJ7bSjdUugB1Iv9DkzryGF6USkUCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uzA9EQ4jizGfss84g0jOatKZbBbRWBjlv1owRrSZGt+vY/E52NBb/LeXqnWcjza4is/lzd7VW41D/D+oCQ0z5Qvx3me8w9vt9Z8tb2WKMOHSDT1/5bVtLcspfo96dApXDceY9fGl3AJv0eNpoexmS4evvZxhKPrwyLMx409Za3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=yaBTHCif; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="yaBTHCif"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:From:subject:date:message-id:reply-to;
	bh=BQZZ/PmLAtq/3uvjYH9OEd0/l8P8THdLXhLgPsDpjME=; b=yaBTHCifFl+CN9ZujNlBuGrcCQ
	oyuXIdnir3oGIM2UdFt/L/5pFq19wV6eu4Ggby5V30Obf/xlIFUVViikuXCI35o1IlhIFsWFQ+R58
	PXCM62Q+GqR2PZpRYJLcWiUpivvM2G2C8wu+zMYf+Z1nCPebWCEymdW6lHixFR0bshdw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wHmdf-000000004cz-1x6Q;
	Tue, 28 Apr 2026 13:54:27 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH v2 00/15] serial: add new I/O type for SPI and I2C bus
 devices
Date: Tue, 28 Apr 2026 13:53:46 -0400
Message-Id: <20260428-tty-upio-v2-0-01c1857cf761@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACv08GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3ZKSSt3Sgsx8XUvjRGNTg0STFDPLRCWg8oKi1LTMCrBR0bG1tQC
 rb+biWgAAAA==
X-Change-ID: 20260428-tty-upio-93a350a4d69a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, ilpo.jarvinen@linux.intel.com, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

Hello,
this patch series add a new I/O type for serial devices on a SPI/I2C bus,
and a few related cleanups/improvements.

These changes are based on a suggestion [1] made by Ilpo Järvinen during
past sc16is7xx driver patches review.

The first patches make use of uart_iotype_*() functions to simplify and
cleanup the UART report functions.

This cleanup sets the stage to avoid displaying irrelevant MMIO or legacy
I/O information for serial devices on I2C or SPI busses when we add the new
UPIO_BUS type.

The patch "serial: uniformize serial port I/O infos display" is more of an
RFC as an attempt to uniformize the display of I/O informations. If deemed
usefull/appropriate, it can be reworked and integrasted with previous
patches.

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
confirm there is no regression (also with earlycon):
  dmesg -t | grep "MMIO"
    earlycon: scif0 at MMIO 0x000000001004b800 (options '115200n8')
    1004b800.serial: ttySC0 at MMIO 0x000000001004b800 (irq = 35, base_baud = 0) is a scif
    1004bc00.serial: ttySC1 at MMIO 0x000000001004bc00 (irq = 40, base_baud = 0) is a scif

Maybe some of the patches could be merged together, but for now I decided
to keep them separate to help the review process.

Thank you.

[1] https://lore.kernel.org/lkml/2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com/raw

Link: [v1] https://lore.kernel.org/all/20260423-tty-upio-v1-0-baf82d3b86d1@dimonoff.com/

Changes for v2:
- Replace snprintf with scnprintf (Ilpo)
- Fix alignment of : to ? (Ilpo)
- Move hub6 match port to 8250_hub6.c (Ilpo)
- earlycon: use uart_iotype_*()
- 8250_rsa: use uart_iotype_*()
- 8250_port: use uart_iotype_*() in serial_port_out_sync()
- simplified uart_line_info() even more and remove intermediate mmio
  variable
- Split and rename patch serial: core: prevent irrelevant I/O infos display
  for UPIO_BUS to serial: core: use uart_iotype_*() to simplify
  uart_report_port() and moved before UPIO_BUS patch.
- Add a new patch to implement a function to uniformize the display
  of I/O infos for uart_report_port(), uart_line_info() and
  earlycon_print_info(). If accepted could be better integrated/merged with
  the next series submission. If not, can simply be dropped.
- Add patch for uart_regiowidth_to_iotype()

---
Hugo Villeneuve (15):
      serial: 8250_hub6: add hub6_match_port()
      serial: core: add uart_iotype_mmio/legacy_io helper functions
      serial: core: use uart_iotype_*() to simplify uart_match_port()
      serial: core: use uart_iotype_*() to simplify uart_line_info()
      serial: core: replace snprintf with more robust scnprintf
      serial: core: fix indentation/alignment
      serial: core: use uart_iotype_*() to simplify uart_report_port()
      serial: earlycon: use uart_iotype_*() to simplify code
      serial: 8250: use uart_iotype_*() to simplify code
      serial: 8250_rsa: use uart_iotype_*() to simplify code
      serial: core: add new I/O type for SPI and I2C bus devices
      serial: sc16is7xx: use new UPIO_BUS as iotype
      serial: max310x: use new UPIO_BUS as iotype
      serial: max3100: use new UPIO_BUS as iotype
      serial: uniformize serial port I/O infos display

 drivers/tty/serial/8250/8250.h      |   7 ++
 drivers/tty/serial/8250/8250_hub6.c |   6 ++
 drivers/tty/serial/8250/8250_port.c |  43 ++---------
 drivers/tty/serial/8250/8250_rsa.c  |  40 +++++------
 drivers/tty/serial/earlycon.c       |  17 ++---
 drivers/tty/serial/max3100.c        |   1 +
 drivers/tty/serial/max310x.c        |   9 +--
 drivers/tty/serial/sc16is7xx.c      |   9 +--
 drivers/tty/serial/serial_core.c    | 137 ++++++++++++++++++++++--------------
 include/linux/serial_core.h         |   6 ++
 include/uapi/linux/serial.h         |   1 +
 11 files changed, 137 insertions(+), 139 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260428-tty-upio-93a350a4d69a

Best regards,
-- 
Hugo Villeneuve <hvilleneuve@dimonoff.com>

