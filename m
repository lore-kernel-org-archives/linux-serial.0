Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CA19CCEC;
	Wed,  2 Apr 2025 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743624412; cv=none; b=Nn4MiXgW2RNey4PUbE6KtNYa5cfabk+0knTuw0gyTFubMZlTp1uMXS7PR7yGeEZ3hwMUt/Y28N65MBiCEHE83LW1C+/9k0sP2CBoLS9pfj2VF8ILWFTbJcrSWlTCbm/q7DKnDJ/TfaTT/AkwcVLbMBGBtBf2A9edNPZgML57QjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743624412; c=relaxed/simple;
	bh=f/Q4xAZfGvAdUDrGQRiYcPUjCly7WY5LZ0EpRlr3Zys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k2M+fRcnwxICnSL70/Xu1drA2WdS9KjOlnYze9mh5YP4AHYd7NWmUw6Ry49n9byRoK/qT9U6EqcCVXuLu39OfPqdFZY7yLkF+oynRheLDKXxftJ8Hllva+/eL8E5hcRYC+IBNQaz80bXJoym2EjhLSMdZ/ttRMGMI6nhaqYXpFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MtnDxe0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MtnDxe0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C61C4CEDD;
	Wed,  2 Apr 2025 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743624411;
	bh=f/Q4xAZfGvAdUDrGQRiYcPUjCly7WY5LZ0EpRlr3Zys=;
	h=Date:From:To:Cc:Subject:From;
	b=MtnDxe0YC4ImotN30Hlv5YlXbg1MFA+wRWOcKZN5rQkpYU4mA9E3cvkKWQ2GlTuE1
	 TmN0C2wMi90WQB+2PeewObOJJYO9/Q1X6PiWxn99jvUr4KNQSPiOagAyoB0imTpgbb
	 UbL+r1DaZhCJtmbxPZz9wQbZA4njuW5EBi31upeg=
Date: Wed, 2 Apr 2025 21:05:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver updates for 6.15-rc1
Message-ID: <Z-2YhB7c0rxT5ldr@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.15-rc1

for you to fetch changes up to 9f8fe348ac9544f6855f82565e754bf085d81f88:

  tty: serial: fsl_lpuart: Fix unused variable 'sport' build warning (2025-03-24 06:27:10 -0700)

----------------------------------------------------------------
TTY/Serial driver updates for 6.15-rc1

Here is the big set of serial and tty driver updates for 6.15-rc1.
Include in here are the following:
  - more great tty layer cleanups from Jiri.  Someday this will be done,
    but that's not going to be any year soon...
  - kdb debug driver reverts to fix a reported issue
  - lots of .dts binding updates for different devices with serial
    devices
  - lots of tiny updates and tweaks and a few bugfixes for different
    serial drivers.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexis Lothoré (1):
      serial: mctrl_gpio: split disable_ms into sync and no_sync APIs

Andy Shevchenko (5):
      serial: mpc52xx_uart: Remove legacy PM hook
      serial: pch_uart: Remove legacy PM hook
      serial: 8250_dw: Drop unneeded NULL checks in dw8250_quirks()
      serial: 8250_dw: Call dw8250_quirks() conditionally
      serial: 8250_dw: Comment possible corner cases in serial_out() implementation

Arnd Bergmann (1):
      tty: serial: pl011: remove incorrect of_match_ptr annotation

Benjamin Larsson (2):
      dt-bindings: serial: 8250: Add Airoha compatibles
      serial: Airoha SoC UART and HSUART support

Cameron Williams (2):
      tty: serial: 8250: Add some more device IDs
      tty: serial: 8250: Add Brainboxes XC devices

Chaitanya Vadrevu (1):
      serial: 8250: add driver for NI UARTs

Charles Han (1):
      serial: icom: fix code format problems

Cheick Traore (1):
      serial: stm32: do not deassert RS485 RTS GPIO prematurely

Claudiu Beznea (1):
      serial: sh-sci: Update the suspend/resume support

Douglas Anderson (3):
      Revert "tty/serial: Add kgdb_nmi driver"
      Revert "kdb: Implement disable_nmi command"
      Revert "kernel/debug: Mask KGDB NMI upon entry"

Dr. David Alan Gilbert (2):
      tty/ldsem: Remove unused ldsem_down_write_trylock
      serial: mctrl_gpio: Remove unused mctrl_gpio_free

Frank Li (1):
      dt-bindings: serial: fsl-lpuart: support i.MX94

Geert Uytterhoeven (1):
      serial: sh-sci: Save and restore more registers

Greg Kroah-Hartman (3):
      Revert "serial: Airoha SoC UART and HSUART support"
      Revert "dt-bindings: serial: 8250: Add Airoha compatibles"
      Merge 6.14-rc3 into tty-next

J. Neuschäfer (1):
      dt-bindings: serial: Allow fsl,ns16550 with broken FIFOs

Jiri Slaby (SUSE) (31):
      tty: convert "TTY Struct Flags" to an enum
      tty: audit: do not use N_TTY_BUF_SIZE
      tty: caif: do not use N_TTY_BUF_SIZE
      tty: move N_TTY_BUF_SIZE to n_tty
      tty: n_tty: use uint for space returned by tty_write_room()
      tty: n_tty: simplify process_output()
      tty: n_tty: clean up process_output_block()
      tty: n_tty: drop n_tty_trace()
      tty: n_tty: extract n_tty_continue_cookie() from n_tty_read()
      tty: n_tty: extract n_tty_wait_for_input()
      tty: n_tty: move more_to_be_read to the end of n_tty_read()
      tty: tty_driver: move TTY macros to the top
      tty: tty_driver: convert "TTY Driver Flags" to an enum
      tty: tty_driver: document both {,__}tty_alloc_driver() properly
      tty: tty_driver: introduce TTY driver sub/types enums
      tty: serdev: drop serdev_controller_ops::write_room()
      tty: mmc: sdio: use bool for cts and remove parentheses
      tty: moxa: drop version dump to logs
      tty: moxa: drop ISA support
      tty: moxa: carve out special ioctls and extra tty_port
      tty: srmcons: fix retval from srmcons_init()
      tty: staging/greybus: pass tty_driver flags to tty_alloc_driver()
      tty: sunsu: drop serial_{in,out}p()
      tty: sunsu: remove unused serial_icr_read()
      serial: remove redundant tty_port_link_device()
      serial: pass struct uart_state to uart_line_info()
      serial: 8250: use serial_port_in/out() helpers
      serial: 8250_rsa: simplify rsa8250_{request/release}_resource()
      serial: 8250_port: do not use goto for UPQ_NO_TXEN_TEST code flow
      serial: 8250_port: simplify serial8250_request_std_resource()
      serial: switch change_irq and change_port to bool in uart_set_info()

John Keeping (1):
      serial: 8250_dma: terminate correct DMA in tx_dma_flush()

Kartik Rajput (2):
      dt-bindings: serial: Add bindings for nvidia,tegra264-utc
      serial: tegra-utc: Add driver for Tegra UART Trace Controller (UTC)

Kaustabh Chakraborty (1):
      dt-bindings: serial: samsung: add exynos7870-uart compatible

Kever Yang (1):
      dt-bindings: serial: snps-dw-apb-uart: Add support for rk3562

Manikanta Guntupalli (1):
      dt-bindings: serial: pl011: Add optional power-domains property

Nam Cao (6):
      serial: xilinx_uartps: Use helper function hrtimer_update_function()
      serial: 8250: Switch to use hrtimer_setup()
      serial: amba-pl011: Switch to use hrtimer_setup()
      serial: imx: Switch to use hrtimer_setup()
      serial: sh-sci: Switch to use hrtimer_setup()
      serial: xilinx_uartps: Switch to use hrtimer_setup()

Sherry Sun (6):
      tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
      tty: serial: fsl_lpuart: Use u32 and u8 for register variables
      tty: serial: fsl_lpuart: use port struct directly to simply code
      tty: serial: fsl_lpuart: rename register variables more specifically
      tty: serial: lpuart: only disable CTS instead of overwriting the whole UARTMODIR register
      tty: serial: fsl_lpuart: Fix unused variable 'sport' build warning

Simon Horman (1):
      tty: caif: removed unused function debugfs_tx()

Stefan Wahren (1):
      tty: serial: fsl_lpuart: Make interrupt name distinct

Toshiyuki Sato (1):
      serial: amba-pl011: Implement nbcon console

Wenhua Lin (1):
      dt-bindings: serial: Add a new compatible string for UMS9632

Wolfram Sang (1):
      dt-bindings: serial: snps-dw-apb-uart: document RZ/N1 binding without DMA

 Documentation/devicetree/bindings/serial/8250.yaml |   2 +-
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   1 +
 .../bindings/serial/nvidia,tegra264-utc.yaml       |  73 +++
 .../devicetree/bindings/serial/pl011.yaml          |   3 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   4 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |  21 +
 .../devicetree/bindings/serial/sprd-uart.yaml      |   9 +-
 Documentation/driver-api/serial/driver.rst         |   4 +-
 Documentation/driver-api/tty/tty_driver.rst        |   4 +-
 Documentation/driver-api/tty/tty_struct.rst        |   2 +-
 MAINTAINERS                                        |   6 +
 arch/alpha/kernel/srmcons.c                        |  56 +-
 drivers/mmc/core/sdio_uart.c                       |   2 +-
 drivers/net/caif/caif_serial.c                     |  16 +-
 drivers/staging/greybus/uart.c                     |   4 +-
 drivers/tty/Kconfig                                |   2 +-
 drivers/tty/moxa.c                                 | 251 +--------
 drivers/tty/n_tty.c                                | 212 ++++---
 drivers/tty/serdev/core.c                          |  11 -
 drivers/tty/serdev/serdev-ttyport.c                |   9 -
 drivers/tty/serial/8250/8250_bcm7271.c             |   3 +-
 drivers/tty/serial/8250/8250_dma.c                 |   2 +-
 drivers/tty/serial/8250/8250_dw.c                  |  73 ++-
 drivers/tty/serial/8250/8250_fsl.c                 |   8 +-
 drivers/tty/serial/8250/8250_ni.c                  | 461 +++++++++++++++
 drivers/tty/serial/8250/8250_omap.c                |   2 +-
 drivers/tty/serial/8250/8250_pci.c                 |  46 ++
 drivers/tty/serial/8250/8250_port.c                |  71 +--
 drivers/tty/serial/8250/8250_rsa.c                 |  21 +-
 drivers/tty/serial/8250/Kconfig                    |  13 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/Kconfig                         |  42 +-
 drivers/tty/serial/Makefile                        |   2 +-
 drivers/tty/serial/amba-pl011.c                    | 158 ++++--
 drivers/tty/serial/atmel_serial.c                  |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    | 489 ++++++++--------
 drivers/tty/serial/icom.c                          |   9 +-
 drivers/tty/serial/imx.c                           |  10 +-
 drivers/tty/serial/kgdb_nmi.c                      | 280 ---------
 drivers/tty/serial/kgdboc.c                        |   8 -
 drivers/tty/serial/ma35d1_serial.c                 |   2 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   1 -
 drivers/tty/serial/pch_uart.c                      |   1 -
 drivers/tty/serial/serial_core.c                   |  10 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |  62 +-
 drivers/tty/serial/serial_mctrl_gpio.h             |  33 +-
 drivers/tty/serial/sh-sci.c                        | 101 +++-
 drivers/tty/serial/stm32-usart.c                   |   6 +-
 drivers/tty/serial/sunsu.c                         | 178 +++---
 drivers/tty/serial/tegra-utc.c                     | 625 +++++++++++++++++++++
 drivers/tty/serial/xilinx_uartps.c                 |   8 +-
 drivers/tty/tty_audit.c                            |  10 +-
 drivers/tty/tty_io.c                               |   8 +-
 drivers/tty/tty_ldsem.c                            |  17 -
 include/linux/kgdb.h                               |  11 -
 include/linux/serdev.h                             |   6 -
 include/linux/tty.h                                |  53 +-
 include/linux/tty_driver.h                         | 180 +++---
 include/linux/tty_ldisc.h                          |   1 -
 kernel/debug/debug_core.c                          |  14 +-
 kernel/debug/kdb/kdb_main.c                        |  37 --
 61 files changed, 2257 insertions(+), 1500 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra264-utc.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ni.c
 delete mode 100644 drivers/tty/serial/kgdb_nmi.c
 create mode 100644 drivers/tty/serial/tegra-utc.c
