Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D9404BC4;
	Tue, 25 Aug 2026 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787668082; cv=none; b=aZHztbrrfghNe8jXjOEtUqAN9xg68hn6Z45voiaXw5MONK0Nwe+yma3Qf+jhro3UzVoko5DxL1aYbHyKoi9eqT0sOG6ef3U7WWP+TFN7ixIQTlNIL57cnyTX3QVQKhnDIGBI86oQZKmeIbHAf1EWOi3NuYuf6inNDyQImAwHsGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787668082; c=relaxed/simple;
	bh=zUoi02lEWw5502PwfY+29ekthFYveoeIf0/OVAM46SU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b4LVfxgiIv6n0/pI3r71Y+y4G9tCF59Ph1dWoy7DIk56IJ/p02ViHqN6LaidJnBV1TKx4VqQ4IqG0ITzatqqAe3Obi7XNAkcImt76eyhKxo5QpvqYkoA6M5uSLAB2kEr6RmIL7lpVKqDcyfJumwrO68r0F3mEKELShMv4qus4JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNQtB43i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNQtB43i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6BA1F000E9;
	Tue, 25 Aug 2026 14:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787668081;
	bh=Sf1j2gff94PNeENqlWOFnn4DxjwbCKByNyForIAvdds=;
	h=Date:From:To:Cc:Subject;
	b=cNQtB43i6ji5vTRERNEkh8w3wTlxte72rWXp070o1bQlMt7+N/M9nw+Si5aHQTgHN
	 NxkjTzs61tuUS4vJNAy4ZmdniPIrkismd1WXCtO0LO4dNOLlYfDKPCoOrQBOWN41pE
	 u/cxOcUtwFCTAuij8ZeodliNNeDocOrKG93wyNFg=
Date: Tue, 25 Aug 2026 16:27:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 7.3-rc1
Message-ID: <ao2masQJ22TNPd12@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.3-rc1

for you to fetch changes up to 8b0b29fdcb47907ae0296b8fe829e918e05e300f:

  serial: imx: serialize imx_uart_ports[] lifetime (2026-08-03 16:54:10 +0200)

----------------------------------------------------------------
TTY / Serial driver updates for 7.3-rc1

Here is the "big" set of tty and serial driver updates for 7.3-rc1.  Not
really all that much happened this development cycle for this subsystem,
changes in here are:
  - removal of the ipwireless driver as it's no longer used or needed
  - new 8250_mxpcie driver added
  - qcom serial driver updates and additions
  - vt mode validation addition
  - lots of other small serial driver updates and additions

All of these have been in linux-next for weeks with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (1):
      serdev: acpi: Free resource list at appropriate time

Aniket Randive (1):
      serial: qcom_geni: Disable closing_wait for console to prevent shutdown timeout

Arnd Bergmann (1):
      serial: 8250: handle ixp4xx register endianness correctly

Bartosz Golaszewski (1):
      serial: 8250_exar: use platform_device_register_full()

Bjorn Andersson (2):
      serial: qcom-geni: Convert console to nbcon
      serial: qcom-geni: Keep FIFO RX active during console TX

Carlo Caione (2):
      arm64: dts: mediatek: alias all enabled serial ports
      serial: 8250_mtk: honor DT serial aliases

Crescent Hsieh (14):
      serial: 8250: split Moxa PCIe serial board support out of 8250_pci
      serial: 8250: add Moxa MUEx50 UART port type
      serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger levels
      serial: 8250_mxpcie: enable automatic RTS/CTS flow control
      serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
      serial: 8250_mxpcie: add custom handle_irq callback
      serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
      serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
      serial: 8250_mxpcie: support serial interface mode switching
      serial: 8250: allow low-level drivers to override break control
      serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
      serial: 8250: allow UART drivers to override rx_trig_bytes handling
      serial: 8250_mxpcie: introduce per-port private data structure
      serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL

David Laight (1):
      drivers/tty/serial/kgdboc: Use strscpy() to copy strings into arrays

Douglas Anderson (1):
      dt-bindings: serial: snps-dw-apb-uart: Add "google,lga-uart"

Fushuai Wang (2):
      serial: 8250: Clear CON_PRINTBUFFER on port re-registration
      Revert "serial: 8250: Clear CON_PRINTBUFFER on port re-registration"

Greg Kroah-Hartman (3):
      Merge 7.2-rc3 into tty-next
      Revert "serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown"
      Merge 7.2-rc5 into tty-next

Guangshuo Li (1):
      serial: qcom-geni: do not advance stale DMA completions

Haoxiang Li (1):
      tty: serial: pch_uart: add check for pci_get_slot()

Hugo Villeneuve (17):
      serial: 8250_hub6: add hub6_match_port()
      serial: core: add uart_iotype_mmio/io helper functions
      serial: core: use uart_iotype_*() to simplify uart_match_port()
      serial: uniformize serial port I/O infos display
      serial: 8250: use uart_iotype_*() to simplify code
      serial: 8250_rsa: use uart_iotype_*() to simplify code
      serial: core: add new I/O type for SPI and I2C bus devices
      serial: sc16is7xx: use new UPIO_BUS as iotype
      serial: max310x: use new UPIO_BUS as iotype
      serial: max3100: use new UPIO_BUS as iotype
      serial: 8250_hub6: add missing include for hub6_match_port()
      serial: 8250: fix compile error with hub6_match_port() when compiled as a module
      serial: core: display 32 for MEM32 and MEM32BE UPIO types
      serial: max310x: remove always included kconfig.h
      serial: 8250: remove always included kconfig.h
      serial: rsci: remove check for zero baud rate from uart_get_baud_rate()
      serial: sh-sci: remove check for zero baud rate from uart_get_baud_rate()

Jiri Slaby (SUSE) (4):
      goldfish: remove unused gf_write_dma_addr()
      tty: goldfish: drop unused goldfish_tty::opencount
      tty: goldfish: move gf_write_ptr() to tty/goldfish.c
      tty: goldfish: use guard() for locks

John Ogness (2):
      serial: 8250: Switch to nbcon console, take 2
      Revert "serial: 8250: drop lockdep annotation from serial8250_clear_IER()"

John de la Garza (2):
      tty: tty_jobctrl: use guard()s in tiocspgrp()
      tty: tty_jobctrl: use guard() in tiocgsid()

Karl Mehltretter (8):
      tty: hvc: restrict HVC_DCC to ARMv6+ and ARM64
      serial: amba-pl011: unprepare console clock on unregister
      serial: amba-pl011: keep console clock enabled for atomic writes
      serial: core: do fallible allocations before the console can be registered
      serial: core: clear freed pointers on uart_register_driver() failure
      tty: skip cdev_del() when no cdev is registered
      tty: clear cdev pointer after cdev_add() failure
      serial: imx: serialize imx_uart_ports[] lifetime

Mike Rapoport (Microsoft) (4):
      serial: pch: replace __get_free_page() with kmalloc()
      tty: amiserial: replace get_zeroed_page() with kzalloc()
      tty: serial: men_z135_uart: replace __get_free_page() with kmalloc()
      vc_screen: replace __get_free_pages() with kmalloc()

Pan Chuang (5):
      serial: 8250_bcm7271: Remove redundant dev_err_probe()
      serial: imx: Remove redundant dev_err()
      serial: mvebu-uart: Remove redundant dev_err()
      serial: mctrl_gpio: Remove redundant dev_err()
      serial: sprd: Remove redundant dev_err()

Pei Xiao (1):
      serial: bcm63xx-uart: silence false positive coccinelle warning on clk_put

Praveen Talari (11):
      serial: qcom-geni: trace: Drop redundant len field from geni_serial_data
      serial: qcom-geni: Pre-map RX DMA buffer at probe to avoid sleep-in-atomic
      serial: qcom-geni: add force suspend/resume to system sleep callbacks
      serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver
      serial: qcom_geni: Add shutdown callback to quiesce hardware on reboot
      serial: qcom_geni: Add panic notifier to stop UART on panic
      serial: qcom-geni: remove .pm callback, use runtime PM in startup/shutdown
      serial: qcom-geni: Use common GENI resource initialisation helpers
      serial: qcom-geni: Use resources helper APIs in runtime PM functions
      serial: qcom-geni: Use geni_se_set_perf_level() for baud rate perf level

Qingfang Deng (1):
      tty: remove the ipwireless driver

Rahul Bukte (1):
      serial: 8250: force synchronous probe for the ISA and PNP drivers

Rosen Penev (2):
      tty: serial: mpc52xx_uart: add bounds check for psc_num array index
      serial: cpm_uart: replace irq_of_parse_and_map with platform_get_irq

Simon Glass (1):
      dt-bindings: serial: snps-dw-apb-uart: Add RV1106 compatible

Tapio Reijonen (3):
      serial: max310x: register GPIO controller before adding UART ports
      dt-bindings: serial: maxim,max310x: describe per-channel rs485 subnodes
      serial: max310x: honour rs485 properties from per-channel DT subnode

Uwe Kleine-König (The Capable Hub) (3):
      serial: 8250_exar: Consistently define pci_device_ids using named initializers
      tty: serial: rp2: Use named initializer for pci_device_id::driver_data
      serial: 8250_pnp: Use named initializers for pnp_device_id array

Wang Zihan (1):
      vt: add mode validation in vt_setactivate

Yu-Che Hsieh (1):
      dt-bindings: serial: 8250: Add Aspeed AST2600 and AST2700 uart compatible

Yuho Choi (1):
      serial: ma35d1: Fix OF node reference leaks in console init

 Documentation/devicetree/bindings/serial/8250.yaml |    8 +-
 .../devicetree/bindings/serial/maxim,max310x.yaml  |   92 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |    2 +
 MAINTAINERS                                        |    6 -
 .../boot/dts/mediatek/mt6795-sony-xperia-m5.dts    |    1 +
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |    1 +
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |    2 +
 arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts       |    2 +
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |    1 +
 .../boot/dts/mediatek/mt8192-asurada-hayato-r1.dts |    4 +
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts       |    1 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        |    2 +
 .../boot/dts/mediatek/mt8390-genio-common.dtsi     |    2 +
 .../boot/dts/mediatek/mt8390-grinn-genio-sbc.dtsi  |    2 +
 .../boot/dts/mediatek/mt8390-tungsten-smarc.dtsi   |    2 +
 .../boot/dts/mediatek/mt8395-genio-common.dtsi     |    1 +
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 drivers/tty/Kconfig                                |    9 -
 drivers/tty/Makefile                               |    2 -
 drivers/tty/amiserial.c                            |   14 +-
 drivers/tty/goldfish.c                             |   23 +-
 drivers/tty/hvc/Kconfig                            |    2 +-
 drivers/tty/ipwireless/Makefile                    |    9 -
 drivers/tty/ipwireless/hardware.c                  | 1770 --------------------
 drivers/tty/ipwireless/hardware.h                  |   63 -
 drivers/tty/ipwireless/main.c                      |  356 ----
 drivers/tty/ipwireless/main.h                      |   66 -
 drivers/tty/ipwireless/network.c                   |  517 ------
 drivers/tty/ipwireless/network.h                   |   54 -
 drivers/tty/ipwireless/setup_protocol.h            |  109 --
 drivers/tty/ipwireless/tty.c                       |  627 -------
 drivers/tty/ipwireless/tty.h                       |   46 -
 drivers/tty/serdev/core.c                          |    4 +-
 drivers/tty/serial/8250/8250.h                     |   11 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |    4 +-
 drivers/tty/serial/8250/8250_core.c                |   71 +-
 drivers/tty/serial/8250/8250_dw.c                  |    2 +-
 drivers/tty/serial/8250/8250_early.c               |   19 +-
 drivers/tty/serial/8250/8250_exar.c                |   53 +-
 drivers/tty/serial/8250/8250_hub6.c                |    8 +
 drivers/tty/serial/8250/8250_mtk.c                 |    7 +-
 drivers/tty/serial/8250/8250_mxpcie.c              |  627 +++++++
 drivers/tty/serial/8250/8250_of.c                  |   12 +
 drivers/tty/serial/8250/8250_pci.c                 |  245 +--
 drivers/tty/serial/8250/8250_platform.c            |    1 +
 drivers/tty/serial/8250/8250_pnp.c                 |  309 ++--
 drivers/tty/serial/8250/8250_port.c                |  321 +++-
 drivers/tty/serial/8250/8250_rsa.c                 |   40 +-
 drivers/tty/serial/8250/Kconfig                    |   10 +
 drivers/tty/serial/8250/Makefile                   |    1 +
 drivers/tty/serial/amba-pl011.c                    |   48 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   11 +-
 drivers/tty/serial/cpm_uart.c                      |    9 +-
 drivers/tty/serial/earlycon.c                      |   17 +-
 drivers/tty/serial/imx.c                           |   39 +-
 drivers/tty/serial/kgdboc.c                        |    2 +-
 drivers/tty/serial/ma35d1_serial.c                 |   12 +-
 drivers/tty/serial/max3100.c                       |    1 +
 drivers/tty/serial/max310x.c                       |  101 +-
 drivers/tty/serial/men_z135_uart.c                 |    7 +-
 drivers/tty/serial/mpc52xx_uart.c                  |    8 +
 drivers/tty/serial/mvebu-uart.c                    |   12 +-
 drivers/tty/serial/pch_uart.c                      |   11 +-
 drivers/tty/serial/qcom_geni_serial.c              |  660 +++++---
 drivers/tty/serial/rp2.c                           |    2 +-
 drivers/tty/serial/rsci.c                          |    3 -
 drivers/tty/serial/sc16is7xx.c                     |    9 +-
 drivers/tty/serial/serial_core.c                   |  167 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |    3 -
 drivers/tty/serial/sh-sci.c                        |    2 -
 drivers/tty/serial/sprd_serial.c                   |    5 +-
 drivers/tty/tty_io.c                               |    6 +-
 drivers/tty/tty_jobctrl.c                          |   41 +-
 drivers/tty/vt/vc_screen.c                         |    6 +-
 drivers/tty/vt/vt_ioctl.c                          |    2 +
 include/linux/goldfish.h                           |   24 -
 include/linux/serial_8250.h                        |   17 +-
 include/linux/serial_core.h                        |    9 +
 include/trace/events/qcom_geni_serial.h            |    7 +-
 include/uapi/linux/serial.h                        |    1 +
 include/uapi/linux/serial_core.h                   |    3 +
 81 files changed, 2061 insertions(+), 4726 deletions(-)
 delete mode 100644 drivers/tty/ipwireless/Makefile
 delete mode 100644 drivers/tty/ipwireless/hardware.c
 delete mode 100644 drivers/tty/ipwireless/hardware.h
 delete mode 100644 drivers/tty/ipwireless/main.c
 delete mode 100644 drivers/tty/ipwireless/main.h
 delete mode 100644 drivers/tty/ipwireless/network.c
 delete mode 100644 drivers/tty/ipwireless/network.h
 delete mode 100644 drivers/tty/ipwireless/setup_protocol.h
 delete mode 100644 drivers/tty/ipwireless/tty.c
 delete mode 100644 drivers/tty/ipwireless/tty.h
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c
