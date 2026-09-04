Received: from out28-51.mail.aliyun.com (out28-51.mail.aliyun.com [115.124.28.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410044163B;
	Fri,  4 Sep 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519190; cv=none; b=L94z/IUpqErYB8+ioYRbQm83aLXQmDWwwhn0rMS+wzcTVErVczaXoQxeFn5SxQCNkF2L/jhA5qocNYXpzrYUajE4G4OafhGZnt8A3X3wikU4oGPZ92kLyNeL/Kco8mC5WUezoJkEK0SmgJKRnMQ7Tv80mnKd6NUuTgDSM2GVg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519190; c=relaxed/simple;
	bh=UES4d6Ul/udUygdSylbzBo8Ned2g4SOuh609jnO+2js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVMWFRi0F4Ki8Hmp1OwdlHdBDH9xPlul5zKEkdRCAnXGvr9jEg3RUYKZ6gZCHwbf0qNs4iWjHe8oh5UbyqblQiCDA29C6FYTR2JTOaypaJlDPUe1bn6Wx4sdE03KcD1pE4PzD+l/zWHJuOkF49+oYXlXFD5o5OmUYmnoe8tViRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn; spf=pass smtp.mailfrom=edatec.cn; arc=none smtp.client-ip=115.124.28.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edatec.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edatec.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07445505|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0213499-5.18625e-05-0.978598;FP=10070350980939663607|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=zjzhao@edatec.cn;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.j5V0J0._1788519166;
Received: from LAPTOP-VQRD5F43.hs.edatec.cn(mailfrom:zjzhao@edatec.cn fp:SMTPD_---.j5V0J0._1788519166 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 18:52:46 +0800
From: zjzhao <zjzhao@edatec.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	zjzhao <zjzhao@edatec.cn>
Subject: [PATCH v3 0/2] WK2xxx SPI to UART bridge driver
Date: Fri,  4 Sep 2026 18:52:41 +0800
Message-ID: <20260904105243.120769-1-zjzhao@edatec.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904093341.100826-1-zjzhao@edatec.cn>
References: <20260904093341.100826-1-zjzhao@edatec.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds a driver for the WK2xxx SPI-to-UART bridge ICs
(WK2124, WK2132, WK2168, WK2202 and WK2204) by WKmic (Chengdu Weikai
Microelectronics), together with a DT binding and the "wkmic" vendor
prefix.

Why a new driver instead of extending an existing one is briefly
explained below the changelog.

Changes in v3 (addresses the Sashiko AI review on [PATCH v2]):

- probe: register all ports before requesting the threaded IRQ, and
  reset the chip / disable every sub-UART first, so an early interrupt
  can never reach a port whose ->state is not set up yet
- remove: unregister the ports (each open port is shut down, disabling
  its sub-UART) before freeing the IRQ, so no late IRQ or queued worker
  can target a port that is being torn down
- handle_tx: do not return right after sending x_char; pending xmit
  FIFO data is drained and the TX trigger is re-armed below, so it
  cannot be stranded until the next start_tx().  x_char is snapshot
  under the port lock
- polling: the shared poll loop is started/stopped under a per-device
  poll_lock and poll_proc stops re-queuing itself once the last port is
  closed, closing a race that could permanently stop polling
- SPI buffers: spi_tx/spi_rx are cache-line aligned and fifo_read()/
  fifo_write() take reg_lock before touching them
- clock-frequency: a zero value is rejected in probe and calc_divisor()
  guards against a zero baud rate
- set_termios: read_status_mask/ignore_status_mask/status are published
  under the port lock

Items that were reported but intentionally kept as-is, because they
mirror the merged sc16is7xx/max310x drivers:

- handle_tx() reads the transmit kfifo without port->lock: the TX path
  is serialized by tx_lock and the kfifo is single-producer/
  single-consumer between the serial core and this driver, exactly like
  sc16is7xx_handle_tx()
- icount updates in the RX/TX paths are done without port->lock, the
  same as sc16is7xx/max310x and the 8250 receive path

The WK2xxx uses a proprietary register map and a custom SPI protocol
(channel number and a page-select bit are encoded in the SPI command
byte, plus dedicated FIFO burst commands).  It has no modem-control
registers and supports 8 data bits only, so it cannot be folded into the
16550-style sc16is7xx/max310x drivers without degrading a more capable
shared layer.  Following the kernel's own precedent (sc16is7xx and
max310x are separate drivers although sc16is7xx is derived from
max310x), a dedicated driver is the appropriate model.

Tested on Raspberry Pi boards (EDATEC IPC1200 with WK2132 on SPI0 and
SBC2300 with WK2204 on SPI1); loopback TX/RX tests pass.  v3 was
re-verified on SBC2300 (SPI1/WK2204, kernel 6.18.39): all four ports
register and open, multi-port termios churn and repeated module
load/unload cycles are clean.  The RX data path is unchanged since the
loopback runs.

zjzhao (2):
  serial: wk2xxx: Add WK2xxx SPI UART driver
  dt-bindings: serial: Document WK2xxx SPI UART bindings

 .../bindings/serial/wkmic,wk2xxx.yaml         |  115 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 drivers/tty/serial/Kconfig                    |   17 +
 drivers/tty/serial/Makefile                   |    1 +
 drivers/tty/serial/wk2xxx.c                   | 1401 +++++++++++++++++
 include/uapi/linux/serial_core.h              |    3 +
 6 files changed, 1539 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/wkmic,wk2xxx.yaml
 create mode 100644 drivers/tty/serial/wk2xxx.c

-- 
2.43.0

