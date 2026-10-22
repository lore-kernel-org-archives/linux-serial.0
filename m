Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677187;
	b=tg7P2U4lxPMMzYtdKN08rhUxsO7wmewGk2BhH1SGfS/EXBaBbn01jpJha30G54i2ERET
	 KET/Rn07hY7/TevNFGV7vcLvy70v4TLwQDsm1Q8+mTngamuETbHhjnicwk4oc/sVVRfN1
	 LTWbJ171jExDY0sI3UdCHlDOfJ5TQrTUDBVuNJob+BvCW9jivZiqNRuWuajvJ5l2CQCr3
	 ngMZxcpZATG2Mlu0A5j8+fxCYEw7RjUnH7xI12wx0EOeGIZX6t5dO7WApdD7fuNh0uE+y
	 3xXWvb7bhzH38f0UFwlBya+hONAPBfPsYGAgBbcbqKwq6L26fyRWhBk62TQ8k85c6/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677187;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=rA7gxUL9eHb/Wehu22XwKglTsNUkAP7+310aScn9f4I=;
	b=okjRc52tgGLd8WfCc1qDpeJ0YU5mL2guKLT1rWi5hTvZbAg8JZFByMw+fydnW0fpD0+T
	 O/4gLc1/LPFU7pkctksHGCzSChUOSxMctdyUYgaI7wiAeqdGL2jokxekj7VmtrB3sFAMJ
	 hiQOPT++aXM6cSKhY2ETMNzPoFoIv/Sgqzaw8DiypLCI63HjhjRg/ETrxcePEoEGFBeBC
	 Z5g9usqVbVWoVSHt8amphspp0SlvEjOy/bk4Bhkt266yNmicWVR9lDNMMDQgSsK84Su+o
	 ja+rrrozUsUCVoiKpMdSSdNq2W5WLt71p2/6KD4QdSKgomNiuMRFofhBr3PSLBoLuIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tKHtb8K3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE62606A31E;
	Thu, 22 Oct 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=tKHtb8K3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562471F000C1;
	Thu, 22 Oct 2026 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792677187;
	bh=rA7gxUL9eHb/Wehu22XwKglTsNUkAP7+310aScn9f4I=;
	h=Date:From:To:Cc:Subject;
	b=tKHtb8K3ADcUa5Q34Jfq15UH3UCPKRhqIqEN965ux+lWC7lmyvVCOXeZQ23OOMc7i
	 /9FZ+XeJ14UT/q/sXw6KAW6mRLMTd4wI1UlHxMnDRrx3JzMFT/99nu25MC5FyLAChi
	 vYGaKEh3IypUajArkVPcDSp33d70303vkJJM/17M=
Date: Thu, 22 Oct 2026 15:50:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 7.4-rc1
Message-ID: <atoUj_wOHwHCqwdS@kroah.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.4-rc1

for you to fetch changes up to 1184f87e2790e8af9be3116f608d2e86b4792d7d:

  tty: hvc: dcc: Detect JTAG connection only on CPU core 0 (2026-10-14 17:40:30 +0200)

----------------------------------------------------------------
TTY/Serial driver updates for 7.4-rc1

Here is the "big" set of tty and serial driver updates for 7.4-rc1.
It's not really all that big, it's been kind of quiet in this area of
the tree this development cycle in relation to other parts of the tree.
But still, included in here are:
  - 8250 port updates and fixes
  - 8250 driver cleanups by Jiri
  - deletion of the obsolete moxa driver (making this pull request
    remove more lines than added!)
  - different serial driver updates for dma and other reported issues

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      serial: 8250_port: Remove redundant pm_runtime_mark_last_busy() call
      serial: 8250_port: properly handle runtime PM in IRQ

Aniket Randive (2):
      serial: qcom-geni: Fix port_ida handling for console and probe errors
      serial: qcom-geni: Avoid double-free of PM domain list

Benjamin Larsson (1):
      dt-bindings: serial: 8250: Add Airoha compatibles

Christian Marangi (2):
      dt-bindings: serial: 8250: Reorganize compatible to single enum
      serial: 8250: Add Airoha SoC UART and HSUART support

Cui GaoSheng (1):
      serial: core: fix NULL/dangling port_dev on failed re-register

Danish Khateeb (1):
      serial: 8250: Fix section mismatch with CONFIG_MODULES=n

David Heidelberg (1):
      serial: qcom-geni: power the console back up on system resume

Dmitry Sinyavin (1):
      serial: msm: select PM_OPP

Ferry Toth (1):
      Revert "serial: 8250_port: Drop duplicate NULL check"

Frank Li (3):
      serial: use dmaengine_get_dma_device() instead of chan->device->dev
      serial: amba-pl011: use dmaengine public API instead of raw ops
      tty: serial: pch_uart: use dmaengine_submit() instead of ->tx_submit()

Geert Uytterhoeven (2):
      dt-bindings: serial: renesas,hscif: Increase number of DMA channels to 6
      dt-bindings: serial: renesas,scif: Increase number of DMA channels to 6

Greg Kroah-Hartman (2):
      tty: moxa: remove driver.
      Merge 7.3-rc6 into tty-next

Greg Ungerer (1):
      serial: mcf: update author email address

Hemanth Selam (2):
      tty: serial: fix typo "inteface" in comment
      tty: serial: fix typo "satify" in comment

Hengyu Liang (1):
      serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports

Hugo Villeneuve (1):
      serial: sc16is7xx: declare MCR and IER as volatile registers

Ibrahim Abdelkader (1):
      serdev: ttyport: Clear serport->tty after freeing

Igor Putko (1):
      serial: core: shut down initialized port on removal

Jan Čermák (1):
      serial: 8250_bcm2835aux: Add support for RTS/CTS auto flow control

Jiannan Du (1):
      tty: hvc: dcc: Detect JTAG connection only on CPU core 0

Jiri Slaby (SUSE) (6):
      serial: 8250: drop err label from serial8250_register_8250_port()
      serial: 8250_exar: remove useless void * casts
      serial: 8250_exar: store the GPIO platform device in struct exar8250
      serial: 8250_lpss: do not touch uninitialized line in ehl_serial_exit()
      serial: 8250_omap: set priv->line before enabling the IRQ
      serial: 8250: make port operations work on struct uart_8250_port

Jisheng Zhang (1):
      dt-bindings: serial: snps-dw-apb-uart: Add Synaptics sl2610 uart

Karl Mehltretter (1):
      serial: ma35d1: Do not force-enable an unselected console

Kees Cook (1):
      vt: keyboard: Allocate new_map with ARRAY_SIZE()

Li Jun (1):
      tty: atmel: Replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS

Linmao Li (3):
      serial: 8250_mxpcie: set the driver data before registering ports
      serial: 8250_mxpcie: only unregister the ports that were registered
      serial: 8250_mxpcie: take the line settings from the new termios

Malathi A (2):
      serial: 8250_uniphier: Use devm_clk_get_enabled()
      serial: 8250_uniphier: Use dev_err_probe() in probe error paths

Martin Fuzzey (1):
      serial: sc16is7xx: fix data corruption due to unexpected xon/xoff

Mike Rapoport (Microsoft) (3):
      tty: port: replace get_zeroed_page() with kzalloc()
      serial: core: replace get_zeroed_page() with kzalloc()
      tty: hvcs: replace __get_free_page() with kmalloc()

Moteen Shah (2):
      dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
      serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read

Myeonghun Pak (1):
      serial: sh-sci: Unregister UART on sysfs setup failure

Nathan Chancellor (1):
      serial: 8250_mid: Add missing module namespace import for SERIAL_8250

Nicolai Buchwitz (3):
      serial: amba-pl011: honour delay_rts_before_send for every write
      serial: amba-pl011: keep transmitter enabled when disabling RS485
      serial: amba-pl011: drive the bus during break in RS485 mode

Peng Fan (2):
      tty: serial: fsl_lpuart: use dmaengine_get_dma_device() for DMA mapping
      tty: use assign_bit() where applicable

Praveen Talari (1):
      serial: qcom-geni: Drop unsafe rx_buf realloc from setup_fifos()

Rosen Penev (2):
      serial: 8250: Add Armada 38x earlycon support
      serial: hvc: use modern IRQ acquisition API

Shawn Lin (1):
      tty: serial: move sdio_uart from mmc/core to tty/serial

Steffen Dirkwinkel (1):
      serial: 8250_dw: Add device HID for AMDI0021 AMD UART controller

Swark Yang (1):
      dt-bindings: serial: Document Axiado AX3005 UART

Tapio Reijonen (9):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: fix breaks not reaching the wire in RS485 mode
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: fix RS485 delays being programmed as bit-times
      serial: max310x: don't power down the port mid-transmission on close
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: schedule tx_work directly from the IRQ handler
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

Tate Whiteberg (2):
      serial: 8250: export and rename wait_for_xmitr()
      serial: 8250_mid: wait for LSR tx empty before setting termios

Thorsten Blum (2):
      serial: core: Use isdigit() in uart_parse_options()
      serial: earlycon: Use isdigit() in earlycon_init()

Tim Douglas (2):
      serial: pmac_zilog: push received data to the port that received it
      serial: pmac_zilog: report received breaks

Uwe Kleine-König (1):
      serial: tegra-tcu: Make use of dev_err_probe() in .probe()

Uwe Kleine-König (The Capable Hub) (8):
      serial: 8250_pci: Catch up on new pci_device_id entry without named initializer
      serial: txx9: Drop noop probe function and dangerous remove callback
      serial: txx9: Drop usage of uart_match_port()
      serial: 8250: Make uart_match_port() a 8250 specific function
      serial: 8250: Simplify serial8250_match_port()
      serial: 8250: Fix corner case for port matching
      serial: 8250: hub6: Add cleanup code
      serial: 8250: pnp: Annotate init and exit functions for conditional discarding

Viken Dadhaniya (2):
      soc: qcom: geni-se: Correct QUP Core ICC vote constants
      tty: serial: qcom_geni_serial: Keep console RX functional after deep idle

Xiaochun Li (1):
      serial: core: Fix a potential NULL pointer dereference in uart_parse_earlycon()

Yicong Yang (1):
      serial: 8250_dw: Prefer SRBR in bogus RX timeout workaround if available

Zongmin Zhou (1):
      serial: sifive: fix off-by-one in console port bounds check

bui duc phuc (1):
      serial: qcom-geni: Propagate errors from optional IRQ lookup

 Documentation/admin-guide/devices.txt              |   13 +-
 Documentation/devicetree/bindings/serial/8250.yaml |   32 +-
 .../devicetree/bindings/serial/cdns,uart.yaml      |    1 +
 .../devicetree/bindings/serial/renesas,hscif.yaml  |    4 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |    4 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   13 +-
 Documentation/driver-api/serial/driver.rst         |    2 +-
 MAINTAINERS                                        |    2 +-
 drivers/acpi/acpi_apd.c                            |    1 +
 drivers/mmc/core/Kconfig                           |    7 -
 drivers/mmc/core/Makefile                          |    1 -
 drivers/ptp/ptp_ocp.c                              |   36 +-
 drivers/tty/Kconfig                                |   10 -
 drivers/tty/Makefile                               |    1 -
 drivers/tty/hvc/hvc_dcc.c                          |   30 +-
 drivers/tty/hvc/hvc_opal.c                         |   11 +-
 drivers/tty/hvc/hvcs.c                             |    6 +-
 drivers/tty/moxa.c                                 | 2136 --------------------
 drivers/tty/pty.c                                  |    5 +-
 drivers/tty/serdev/serdev-ttyport.c                |    2 +
 drivers/tty/serial/8250/8250.h                     |   17 +-
 drivers/tty/serial/8250/8250_acorn.c               |    5 +-
 drivers/tty/serial/8250/8250_airoha.c              |  178 ++
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   13 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  187 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   33 +-
 drivers/tty/serial/8250/8250_core.c                |  153 +-
 drivers/tty/serial/8250/8250_dfl.c                 |   22 +-
 drivers/tty/serial/8250/8250_dma.c                 |   29 +-
 drivers/tty/serial/8250/8250_dw.c                  |   32 +-
 drivers/tty/serial/8250/8250_dwlib.c               |    5 +
 drivers/tty/serial/8250/8250_dwlib.h               |    7 +-
 drivers/tty/serial/8250/8250_early.c               |    1 +
 drivers/tty/serial/8250/8250_em.c                  |   26 +-
 drivers/tty/serial/8250/8250_exar.c                |   59 +-
 drivers/tty/serial/8250/8250_fsl.c                 |   24 +-
 drivers/tty/serial/8250/8250_hp300.c               |   27 +-
 drivers/tty/serial/8250/8250_hub6.c                |   11 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   11 +-
 drivers/tty/serial/8250/8250_ioc3.c                |   26 +-
 drivers/tty/serial/8250/8250_keba.c                |   13 +-
 drivers/tty/serial/8250/8250_loongson.c            |   20 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |   11 +-
 drivers/tty/serial/8250/8250_lpss.c                |   17 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |   14 +-
 drivers/tty/serial/8250/8250_mid.c                 |   29 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   19 +-
 drivers/tty/serial/8250/8250_mxpcie.c              |   43 +-
 drivers/tty/serial/8250/8250_ni.c                  |   12 +-
 drivers/tty/serial/8250/8250_of.c                  |   25 +-
 drivers/tty/serial/8250/8250_omap.c                |   45 +-
 drivers/tty/serial/8250/8250_parisc.c              |   14 +-
 drivers/tty/serial/8250/8250_pci.c                 |   23 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c            |   41 +-
 drivers/tty/serial/8250/8250_pericom.c             |   15 +-
 drivers/tty/serial/8250/8250_platform.c            |   32 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   23 +-
 drivers/tty/serial/8250/8250_port.c                |   50 +-
 drivers/tty/serial/8250/8250_pxa.c                 |   17 +-
 drivers/tty/serial/8250/8250_tegra.c               |   20 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   43 +-
 drivers/tty/serial/8250/Kconfig                    |   15 +-
 drivers/tty/serial/8250/Makefile                   |    3 +-
 drivers/tty/serial/8250/serial_cs.c                |   15 +-
 drivers/tty/serial/Kconfig                         |   11 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/amba-pl011.c                    |  123 +-
 drivers/tty/serial/arc_uart.c                      |    2 +-
 drivers/tty/serial/atmel_serial.c                  |    8 +-
 drivers/tty/serial/earlycon.c                      |   10 +-
 drivers/tty/serial/fsl_lpuart.c                    |   18 +-
 drivers/tty/serial/kgdboc.c                        |    2 +-
 drivers/tty/serial/ma35d1_serial.c                 |    2 +-
 drivers/tty/serial/max310x.c                       |  632 +++++-
 drivers/tty/serial/mcf.c                           |    4 +-
 drivers/tty/serial/pch_uart.c                      |    4 +-
 drivers/tty/serial/pmac_zilog.c                    |    5 +-
 drivers/tty/serial/qcom_geni_serial.c              |   49 +-
 drivers/tty/serial/samsung_tty.c                   |   27 +-
 drivers/tty/serial/sc16is7xx.c                     |    4 +-
 drivers/{mmc/core => tty/serial}/sdio_uart.c       |    0
 drivers/tty/serial/serial_core.c                   |   70 +-
 drivers/tty/serial/serial_txx9.c                   |   62 +-
 drivers/tty/serial/sh-sci.c                        |   22 +-
 drivers/tty/serial/sifive.c                        |    2 +-
 drivers/tty/serial/tegra-tcu.c                     |   22 +-
 drivers/tty/sysrq.c                                |    5 +-
 drivers/tty/tty_port.c                             |    8 +-
 drivers/tty/vt/keyboard.c                          |    4 +-
 include/linux/serial_8250.h                        |    8 +-
 include/linux/serial_core.h                        |    2 -
 include/linux/soc/qcom/geni-se.h                   |   12 +-
 92 files changed, 1862 insertions(+), 2999 deletions(-)
 delete mode 100644 drivers/tty/moxa.c
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c
 rename drivers/{mmc/core => tty/serial}/sdio_uart.c (100%)
