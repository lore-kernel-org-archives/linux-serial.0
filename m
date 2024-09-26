Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6D1AED24;
	Thu, 26 Sep 2024 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346170; cv=none; b=DV0T/hT1HujuMugMT+IOfU1FC94X/RbRQEt9SpCGdn9CDpxy/axG6LQP0ma3T0wfiKf96fAZOdZXkeckHE++5eKye+0+EAtO0CVreTm1lRzI4+0A5Id9JpSzvCbz8rUKoElgNfF5k7BOVtmepjJ3U2+6OCjHr1dzcyNddlPHM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346170; c=relaxed/simple;
	bh=ApStDj/Esr86SDM7qKUkCjmQCHLicFoSdvEL5DXnaIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kpy/lK7pbyrhIUoefPNhqHWcRXV4K2F5jPKOf2NmgP2NDKPQLaEyWHojjOicyrP82WoNRMrrsq2ZpvSSDTo1e1Y7cK77CYIRYG9UWkMt2DcZzebjx79gIZ2Q904JkxpvKqG8rxejaRy4MDHSVvlQtizHG+xiBBdsbTJ8GVoobfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Npu/bshD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Npu/bshD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341EEC4CED0;
	Thu, 26 Sep 2024 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727346170;
	bh=ApStDj/Esr86SDM7qKUkCjmQCHLicFoSdvEL5DXnaIk=;
	h=Date:From:To:Cc:Subject:From;
	b=Npu/bshDR9E7sfM6xcY8XnID5yIHMGqa++B7v+rpyUFw93P7i+G8+BUsYGftx4GJv
	 lTSjoJJqshgcYAvzk2LRKzYPSAzx63kGFfKlYxZFGDC04oqJBBOmeywTt52zOwBNQ7
	 l7Oa8/55Hjg17IHGQaUOG0zNJztDlkO98XeFgM9E=
Date: Thu, 26 Sep 2024 12:22:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver updates for 6.12-rc1
Message-ID: <ZvU19s7TVsFsLgas@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.12-rc1

for you to fetch changes up to 5ed771f174726ae879945d4f148a9005ac909cb7:

  tty: serial: samsung: Fix serial rx on Apple A7-A9 (2024-09-11 15:47:13 +0200)

----------------------------------------------------------------
TTY/Serial driver update for 6.12-rc1

Here is the "big" set of tty/serial driver updates for 6.12-rc1.

Nothing major in here, just nice forward progress in the slow cleanup of
the serial apis, and lots of other driver updates and fixes.

Included in here are:
  - serial api updates from Jiri to make things more uniform and sane
  - 8250_platform driver cleanups
  - samsung serial driver fixes and updates
  - qcom-geni serial driver fixes from Johan for the bizarre UART engine
    that that chip seems to have.  Hopefully it's in a better state now,
    but hardware designers still seem to come up with more ways to make
    broken UARTS 40+ years after this all should have finished.
  - sc16is7xx driver updates
  - omap 8250 driver updates
  - 8250_bcm2835aux driver updates
  - a few new serial driver bindings added
  - other serial minor driver updates

All of these have been in linux-next for a long time with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
André Draszik (4):
      dt-bindings: serial: samsung: avoid duplicating permitted clock-names
      dt-bindings: serial: samsung: fix maxItems for gs101
      tty: serial: samsung_tty: drop unused argument to irq handlers
      tty: serial: samsung_tty: cast the interrupt's void *id just once

Andy Shevchenko (8):
      serial: 8250_platform: Remove duplicate mapping
      serial: 8250_platform: Don't shadow error from serial8250_register_8250_port()
      serial: 8250_platform: Use same check for ACPI in the whole driver
      serial: 8250_platform: Tidy up ACPI ID table
      serial: 8250_platform: Switch to use platform_get_mem_or_io()
      serial: 8250_platform: Refactor serial8250_probe()
      serial: 8250_platform: Unify comment style
      serial: 8250_bcm2835aux: Switch to DEFINE_SIMPLE_DEV_PM_OPS()

Arnd Bergmann (2):
      serial: 8250_platform: remove ACPI_PTR() annotation
      serial: 8250_platform: fix uart_8250_port initializer

Chen Ni (2):
      mxser: convert comma to semicolon
      tty: hvc: convert comma to semicolon

Douglas Anderson (3):
      soc: qcom: geni-se: add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
      serial: qcom-geni: fix arg types for qcom_geni_serial_poll_bit()
      serial: qcom-geni: introduce qcom_geni_serial_poll_bitfield()

Ferry Toth (1):
      tty: serial: 8250_dma: use sgl with 2 nents to take care of buffer wrap

Florian Fainelli (1):
      tty: rp2: Fix reset with non forgiving PCIe host bridges

Greg Kroah-Hartman (2):
      Merge 6.11-rc3 into tty-next
      Merge 6.11-rc4 into tty-next

Jinjie Ruan (1):
      serial: xilinx_uartps: Make cdns_rs485_supported static

Jiri Slaby (SUSE) (15):
      tty: simplify tty_dev_name_to_number() using guard(mutex)
      serial: protect uart_port_dtr_rts() in uart_shutdown() too
      serial: don't use uninitialized value in uart_poll_init()
      serial: remove quot_frac from serial8250_do_set_divisor()
      serial: use guards for simple mutex locks
      mxser: remove stale comment
      mxser: remove doubled sets of close times
      xhci: dbgtty: remove kfifo_out() wrapper
      xhci: dbgtty: use kfifo from tty_port struct
      mctp: serial: propagage new tty types
      6pack: remove sixpack::rbuff
      6pack: drop sixpack::mtu
      6pack: drop sixpack::buffsize
      6pack: remove global strings
      6pack: propagage new tty types

Jisheng Zhang (2):
      serial: 8250: move mmp|pxa uart earlycon code
      serial: 8250_early: add xscale earlycon support

Johan Hovold (5):
      serial: qcom-geni: fix fifo polling timeout
      serial: qcom-geni: fix false console tx restart
      serial: qcom-geni: fix console corruption
      serial: qcom-geni: disable interrupts during console writes
      serial: qcom-geni: fix polled console corruption

Lech Perczak (3):
      serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
      serial: sc16is7xx: fix copy-paste errors in EFR_SWFLOWx_BIT constants
      serial: sc16is7xx: convert bitmask definitions to use BIT() macro

Liao Chen (1):
      serial: 8250_aspeed_vuart: Enable module autoloading

Markus Schneider-Pargmann (5):
      dt-bindings: serial: 8250_omap: Add wakeup-source property
      serial: 8250: omap: Remove unused wakeups_enabled
      serial: 8250: omap: Cleanup on error in request_irq
      serial: 8250: omap: Set wakeup capable, do not enable
      serial: 8250: omap: Parse DT wakeup-source proerty

Nick Chan (3):
      tty: serial: samsung: Use bit manipulation macros for APPLE_S5L_*
      tty: serial: samsung: Fix A7-A11 serial earlycon SError
      tty: serial: samsung: Fix serial rx on Apple A7-A9

Oliver Rhodes (1):
      dt-bindings: serial: renesas: Document RZ/G2M v3.0 (r8a774a3) scif

Rafał Miłecki (2):
      dt-bindings: serial: mediatek,uart: add MT7981
      arm64: dts: mediatek: mt7981: add UART controllers

Raphael Gallais-Pou (1):
      serial: st-asc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()

Rob Herring (Arm) (1):
      serdev: Use of_property_present()

Stefan Wahren (2):
      serial: 8250_bcm2835aux: add PM suspend/resume support
      serial: 8250_bcm2835aux: Fix clock imbalance in PM resume

Sunil V L (1):
      serial: 8250_platform: Enable generic 16550A platform devices

Varshini Rajendran (1):
      dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.

 .../devicetree/bindings/serial/8250_omap.yaml      |   1 +
 .../bindings/serial/atmel,at91-usart.yaml          |   9 +-
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |  70 ++++++--
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi          |  33 ++++
 drivers/net/hamradio/6pack.c                       |  60 +++----
 drivers/net/mctp/mctp-serial.c                     |  23 +--
 drivers/tty/hvc/hvsi_lib.c                         |   2 +-
 drivers/tty/mxser.c                                |   7 +-
 drivers/tty/serdev/core.c                          |   2 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   1 +
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  47 ++++++
 drivers/tty/serial/8250/8250_dma.c                 |  19 ++-
 drivers/tty/serial/8250/8250_dwlib.c               |   2 +-
 drivers/tty/serial/8250/8250_early.c               |  11 ++
 drivers/tty/serial/8250/8250_exar.c                |   2 +-
 drivers/tty/serial/8250/8250_omap.c                |  10 +-
 drivers/tty/serial/8250/8250_pci.c                 |   2 +-
 drivers/tty/serial/8250/8250_platform.c            | 122 ++++++++++++--
 drivers/tty/serial/8250/8250_port.c                |   4 +-
 drivers/tty/serial/8250/8250_pxa.c                 |  16 --
 drivers/tty/serial/qcom_geni_serial.c              | 133 ++++++++-------
 drivers/tty/serial/rp2.c                           |   2 +-
 drivers/tty/serial/samsung_tty.c                   |  51 +++---
 drivers/tty/serial/sc16is7xx.c                     | 183 +++++++++++----------
 drivers/tty/serial/serial_core.c                   | 142 +++++++---------
 drivers/tty/serial/st-asc.c                        |  10 +-
 drivers/tty/serial/xilinx_uartps.c                 |   2 +-
 drivers/tty/tty_io.c                               |  11 +-
 drivers/usb/host/xhci-dbgcap.h                     |   1 -
 drivers/usb/host/xhci-dbgtty.c                     |  30 +---
 include/linux/serial_8250.h                        |   2 +-
 include/linux/serial_s3c.h                         |  24 +--
 include/linux/soc/qcom/geni-se.h                   |   9 +
 35 files changed, 621 insertions(+), 424 deletions(-)
