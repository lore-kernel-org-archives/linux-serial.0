Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077015478D;
	Sun, 19 Apr 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776606881; cv=none; b=CWsIo3hEq4jpts3Rz8oVgEpQTFPbFDiHP9Yy2SnBUBCtUnzfGjJcEvAb/ADpIt9YRV3FNntCNbX2W6INWHJwSWXf7+jI0CjVReBXvWP0Swj1bWHfISd8CeqMuSgffLD9tsixI40Uhd1YpfrdYj/B1Mvxt5mhKrjroemIcVH/dbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776606881; c=relaxed/simple;
	bh=MFJekb5qPpRK7aw18HO5t0RI/5g38hnAcAmjXaJAlqk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mqm/4aEkf0WYWaezFRSzOnfRTVMBAgzdiZ5xr4rm0jrbYx+Ik522Q3o8IXGQ0RIrDZXlN+D+gqQ4fbThzARF2Zqp5ZlO+5fvVly8Z/zBgIgkQin1ImAcgUgDnSo0JT39zfmAI7AmUDNFMYNlJuExDPfnRzuTM06cvrTC3ARSWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c/jOlLxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c/jOlLxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EE7C2BCAF;
	Sun, 19 Apr 2026 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776606880;
	bh=MFJekb5qPpRK7aw18HO5t0RI/5g38hnAcAmjXaJAlqk=;
	h=Date:From:To:Cc:Subject:From;
	b=c/jOlLxSmb+Obu1aWZtSc2x6u1F9x4OpIXhCddUAfFdvEE5hy1CbOrnD43BdnORjw
	 Y1RQ/FyJizHzglEn6yGwL3TzutFxip/Vdd1C2WY7TZYf5eqDK5ocj+I1d49g2KQ5Fp
	 zpA6a0MIFaK9X30Samqr7bz9MTztwKQr2OVFxxs8=
Date: Sun, 19 Apr 2026 15:54:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 7.1-rc1
Message-ID: <aeTena-xiaqaffDG@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-7.1-rc1

for you to fetch changes up to a1a81aef99e853dec84241d701fbf587d713eb5b:

  tty: serial: ip22zilog: Fix section mispatch warning (2026-04-02 15:59:56 +0200)

----------------------------------------------------------------
TTY/Serial changes for 7.1-rc1

Here is the set of tty and serial driver changes for 7.1-rc1.

Not much here this cycle, biggest thing is the removal of an old driver
that never got any actual hardware support (esp32), and the second try
to moving the tty ports to their own workqueues (first try was in
7.0-rc1 but was reverted due to problems.)

Otherwise it's just a small set of driver updates and some vt modifier
key enhancements.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alyssa Milburn (1):
      tty: serial: samsung_tty: avoid dev_dbg deadlock

Andy Shevchenko (2):
      serial: 8250_port: Drop duplicate NULL check
      serial: xilinx_uartps: Drop unused include

Anup Kulkarni (1):
      serial: qcom-geni: Fix RTS behavior with flow control

Biju Das (2):
      dt-bindings: serial: renesas,rsci: Document RZ/G3L SoC
      serial: sh-sci: Add support for RZ/G3L RSCI

Brian Masney (1):
      serial: pic32_uart: allow driver to be compiled on all architectures with COMPILE_TEST

Fabio Estevam (1):
      dt-bindings: serial: snps-dw-apb-uart: Add RV1103B compatible

Francesco Lavra (1):
      serial: tegra: remove Kconfig dependency on APB DMA controller

Greg Kroah-Hartman (1):
      Merge 7.0-rc5 into tty-next

Jason Andryuk (1):
      hvc/xen: Check console connection flag

Julian Braha (1):
      serial: remove drivers for espressif esp32

Kartik Rajput (4):
      serial: amba-pl011: Introduce skip_ibrd_fbrd vendor flag
      serial: amba-pl011: Introduce set_uartclk_rate vendor flag
      serial: amba-pl011: Add Tegra264 UART support
      serial: amba-pl011: Respect DMA controller's copy_align requirement

Kathiravan Thirumoorthy (1):
      serial: qcom-geni: drop stray newline format specifier

Kexin Sun (1):
      tty: atmel_serial: update outdated reference to atmel_tasklet_func()

Michael Walle (1):
      tty: serial: 8250: Add SystemBase Multi I/O cards

Nicolas Pitre (3):
      vt: add modifier support to cursor keys
      vt: add KT_CSI keysym type for modifier-aware CSI sequences
      vt: add fallback to plain map for modifier-aware key types

Peter Maydell (1):
      serial: amba-pl011: Enable UART in earlycon setup

Qingfang Deng (1):
      tty: constify tty_ldisc_ops

Randy Dunlap (2):
      tty: hvc_iucv: fix off-by-one in number of supported devices
      serdev: serdev.h: clean up kernel-doc comments

Ravi Rama (1):
      serial: 8250_fintek: Add support for F81214E

Robert Marko (1):
      dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart

Robin Gong (1):
      tty: serial: imx: keep dma request disabled before dma transfer setup

Ronan Pigott (1):
      vt: support ITU-T T.416 color subparameters

Rong Zhang (2):
      dt-bindings: serial: 8250: Add Loongson 3A4000 uart compatible
      serial: 8250: loongson: Enable building on MIPS Loongson64

Thomas Bogendoerfer (1):
      tty: serial: ip22zilog: Fix section mispatch warning

Xianwei Zhao (1):
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for A9

Xin Zhao (1):
      tty: tty_port: add workqueue to flip TTY buffer

Zhaoyang Yu (1):
      serial: auart: check clk_enable() return in console write

 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../bindings/serial/amlogic,meson-uart.yaml        |   1 +
 .../bindings/serial/atmel,at91-usart.yaml          |   1 +
 .../devicetree/bindings/serial/renesas,rsci.yaml   |  26 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 drivers/tty/hvc/hvc_iucv.c                         |   2 +-
 drivers/tty/hvc/hvc_xen.c                          |   3 +
 drivers/tty/pty.c                                  |  12 +-
 drivers/tty/serial/8250/8250_core.c                |   2 +-
 drivers/tty/serial/8250/8250_fintek.c              |  10 +-
 drivers/tty/serial/8250/8250_pci.c                 |  51 ++
 drivers/tty/serial/8250/8250_port.c                |   4 +-
 drivers/tty/serial/8250/Kconfig                    |   9 +-
 drivers/tty/serial/Kconfig                         |  33 +-
 drivers/tty/serial/Makefile                        |   2 -
 drivers/tty/serial/amba-pl011.c                    | 153 +++-
 drivers/tty/serial/apbuart.c                       |   2 +-
 drivers/tty/serial/atmel_serial.c                  |   2 +-
 drivers/tty/serial/dz.c                            |   2 +-
 drivers/tty/serial/esp32_acm.c                     | 459 ------------
 drivers/tty/serial/esp32_uart.c                    | 779 ---------------------
 drivers/tty/serial/imx.c                           |   7 +-
 drivers/tty/serial/ip22zilog.c                     |   4 +-
 drivers/tty/serial/mxs-auart.c                     |   3 +-
 drivers/tty/serial/qcom_geni_serial.c              |  21 +-
 drivers/tty/serial/rsci.c                          |  13 +
 drivers/tty/serial/rsci.h                          |   1 +
 drivers/tty/serial/samsung_tty.c                   |  10 +-
 drivers/tty/serial/sh-sci-common.h                 |   1 +
 drivers/tty/serial/sh-sci.c                        |  14 +-
 drivers/tty/serial/xilinx_uartps.c                 |   1 -
 drivers/tty/serial/zs.c                            |   2 +-
 drivers/tty/tty_buffer.c                           |  15 +-
 drivers/tty/tty_io.c                               |  25 +-
 drivers/tty/tty_ldisc.c                            |  16 +-
 drivers/tty/tty_port.c                             |  22 +
 drivers/tty/vt/keyboard.c                          |  80 ++-
 drivers/tty/vt/vt.c                                |  48 +-
 include/linux/serdev.h                             |   9 +-
 include/linux/tty_buffer.h                         |   1 +
 include/linux/tty_driver.h                         |   7 +
 include/linux/tty_ldisc.h                          |   6 +-
 include/linux/tty_port.h                           |  13 +
 include/uapi/linux/keyboard.h                      |  29 +
 include/xen/interface/io/console.h                 |  13 +
 45 files changed, 550 insertions(+), 1366 deletions(-)
 delete mode 100644 drivers/tty/serial/esp32_acm.c
 delete mode 100644 drivers/tty/serial/esp32_uart.c
