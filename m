Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB424BD03;
	Mon, 28 Jul 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717436; cv=none; b=KQTl/97K94Qsb6JXLOYQg77wl0SQatSHOW4zIsac/WE4cyMYSBMGr17MqdrMEe+Zo1X2miQ8qbcyN6jCA3yIQ3ssOG2sIixv3dkB/j3J2Gi/9vXFXuqq0P6yAmMUe4JRtsgFFhBkB8m8IL/O19l64SgtxKAegMx/SPxl5ztRtas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717436; c=relaxed/simple;
	bh=UpfLfyz2FGwl4AaV13bqIck27LH2eOFyLASKUpZVdoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KDWDIzdy2rXODMliHEt+2AmBbXcR9mhmAg3BIjPBgIn1+l78DwXHBGl78mTrq9NSAdNvm4oOFt1t9Pg+JhRu73w2tqu2jY0l541kXRGk60WXajLVUHeU0G20HJeeLtKkSaql1GKuQ82MoeQOrAOk9YVk+Ag0wfQ10uC5uQidpeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHZJq9mc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHZJq9mc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5FFC4CEE7;
	Mon, 28 Jul 2025 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753717435;
	bh=UpfLfyz2FGwl4AaV13bqIck27LH2eOFyLASKUpZVdoA=;
	h=Date:From:To:Cc:Subject:From;
	b=oHZJq9mcKNAMcPgn9pFIdp2munD4zGHq7TKeATmDs3oOmQwmdUml+9XK0ZdKLuFbL
	 sLbRxVsZ3YMf77U5Q4EVEgyubbEmVjBAfPv0fJF/pKJKh8NG6v5/3duErT7v9xhA8+
	 01rtWlbJUC3fU8XAW6Slgbe5teB7yaIce6IzQk50=
Date: Mon, 28 Jul 2025 17:43:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver updates for 6.17-rc1
Message-ID: <aIeauLNt3kwvH2TM@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.17-rc1

for you to fetch changes up to 57b4ca42359c63ad61548431c184a7d63efbd0b9:

  dt-bindings: serial: snps-dw-apb-uart: Allow use of a power-domain (2025-07-24 11:41:01 +0200)

----------------------------------------------------------------
TTY / Serial driver update for 6.17-rc1

Here is the big set of TTY and Serial driver updates for 6.17-rc1.
Included in here is the following types of changes:
  - another cleanup round from Jiri for the 8250 serial driver and some
    other tty drivers, things are slowly getting better with our apis
    thanks to this work.  This touched many tty drivers all over the
    tree.
  - qcom_geni_serial driver update for new platforms and devices
  - 8250 quirk handling fixups
  - dt serial binding updates for different boards/platforms
  - other minor cleanups and fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (3):
      serial: 8250: Move CE4100 quirks to a module under 8250 driver
      serial: 8520_ce4100: Reuse mem_serial_in() in ce4100_mem_serial_in()
      serial: 8250_ce4100: Fix CONFIG_SERIAL_8250=n build

Anup Kulkarni (1):
      serial: qcom-geni: Enable support for half-duplex mode

Chaitanya Vadrevu (2):
      serial: 8250_ni: Fix build warning
      serial: 8250_ni: Reorder local variables

Christophe JAILLET (1):
      tty: serial: fsl_lpuart: Constify struct lpuart_soc_data

Dr. David Alan Gilbert (1):
      serial: Remove unused uart_get_console

Frank Li (1):
      dt-bindings: serial: 8250: allow clock 'uartclk' and 'reg' for nxp,lpc1850-uart

Geert Uytterhoeven (1):
      serial: sh-sci: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

Greg Kroah-Hartman (2):
      Merge 6.16-rc4 into tty-next
      Merge tag 'v6.16-rc7' into tty-next

Ivaylo Ivanov (1):
      dt-bindings: serial: samsung: add samsung,exynos2200-uart compatible

Jiri Slaby (SUSE) (41):
      tty: introduce and use tty_port_tty_vhangup() helper
      powerpc/legacy_serial: cache serial port and info in add_legacy_port()
      powerpc/legacy_serial: use %pa for phys_addr_t prints
      m68k: remove unneeded tty includes
      powerpc/powermac: remove unneeded tty includes
      tty: vt: use sane types for userspace API
      tty: vt: use _IO() to define ioctl numbers
      serial: 8250: sanitize uart_port::serial_{in,out}() types
      serial: 8250: remove CONFIG_SERIAL_8250_RSA inline macros from code
      serial: 8250: invert conditions in RSA functions
      serial: 8250: put RSA functions to their namespace
      serial: 8250: move RSA functions to 8250_rsa.c
      serial: 8250: extract serial8250_startup_special()
      serial: 8250: extract serial8250_set_TRG_levels()
      serial: 8250: extract serial8250_THRE_test()
      serial: 8250: extract serial8250_initialize()
      serial: 8250: extract serial8250_clear_interrupts()
      serial: 8250: extract serial8250_set_mini()
      serial: 8250: extract serial8250_set_trigger_for_slow_speed()
      serial: 8250: extract serial8250_set_afe()
      serial: 8250: extract serial8250_set_errors_and_ignores
      serial: 8250: extract serial8250_set_ier()
      serial: 8250: extract serial8250_set_efr()
      serial: 8250: extract serial8250_set_fcr()
      serial: 8250: lcr compute cleanup
      serial: 8250: drop unused frac from serial8250_do_get_divisor()
      serial: 8250: extract serial_get_or_create_irq_info()
      serial: 8250: remove debug prints from ISR
      serial: 8250: drop DEBUG_AUTOCONF() macro
      serial: 8250: invert serial8250_register_8250_port() CIR condition
      serial: 8250: invert condition to avoid a goto label
      serial: 8250: use hashtable
      serial: 8250_omap: use uart_port pointer when available
      serial: 8250: export RSA functions
      serial: ce4100: fix build after serial_in/out() changes
      serial: ce4100: clean up serial_in/out() hooks
      serial: 8250: extract serial8250_init_mctrl()
      serial: 8250: extract serial8250_iir_txen_test()
      serial: 8250: rename lsr_TEMT, iir_NOINT to lowercase
      serial: 8250: document doubled "type == PORT_8250_CIR" check
      tty: fix tty_port_tty_*hangup() kernel-doc

Jonas Karlman (1):
      dt-bindings: serial: snps-dw-apb-uart: Allow use of a power-domain

Joseph Tilahun (1):
      tty: serial: fix print format specifiers

Jyothi Kumar Seerapu (1):
      serial: qcom-geni: Add support for 8 Mbps baud rate

Kuninori Morimoto (1):
      serial: sh-sci: Add R-Car Gen5 support

Lad Prabhakar (4):
      dt-bindings: serial: renesas,rsci: Document RZ/N2H support
      dt-bindings: serial: rsci: Update maintainer entry
      serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in sci_shutdown()
      dt-bindings: serial: renesas: Document RZ/V2N SCIF

Max Shevchenko (1):
      dt-bindings: serial: mediatek,uart: add MT6572

Mikulas Patocka (1):
      tty: omit need_resched() before cond_resched()

Myrrh Periwinkle (2):
      vt: keyboard: Don't process Unicode characters in K_OFF mode
      vt: defkeymap: Map keycodes above 127 to K_HOLE

Nghia Nguyen (1):
      dt-bindings: serial: sh-sci: Document r8a78000 bindings

Nikunj Kela (2):
      dt-bindings: serial: describe SA8255p
      dt-bindings: qcom: geni-se: describe SA8255p

Praveen Talari (6):
      soc: qcom: geni-se: Enable QUPs on SA8255p Qualcomm platforms
      serial: qcom-geni: move resource initialization to separate function
      serial: qcom-geni: move resource control logic to separate functions
      serial: qcom-geni: move clock-rate logic to separate function
      serial: qcom-geni: Enable PM runtime for serial driver
      serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms

Thierry Bultel (3):
      dt-bindings: serial: renesas,rsci: Add optional secondary clock input
      serial: sh-sci: Use private port ID
      serial: sh-sci: Add support for RZ/T2H SCI

WangYuli (1):
      serial: 8250_dw: Fix typo "notifer"

Yixun Lan (1):
      dt-bindings: serial: 8250: spacemit: set clocks property as required

Yunhui Cui (1):
      serial: 8250: fix panic due to PSLVERR

 Documentation/devicetree/bindings/serial/8250.yaml |  45 +-
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../bindings/serial/qcom,sa8255p-geni-uart.yaml    |  69 ++
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   7 +
 .../devicetree/bindings/serial/renesas,rsci.yaml   |  27 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |   8 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   4 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |   3 +
 .../soc/qcom/qcom,sa8255p-geni-se-qup.yaml         | 107 +++
 Documentation/driver-api/serial/driver.rst         |   7 +-
 Documentation/driver-api/tty/tty_port.rst          |   5 +-
 arch/m68k/amiga/config.c                           |   2 -
 arch/m68k/apollo/config.c                          |   2 -
 arch/m68k/atari/config.c                           |   1 -
 arch/m68k/mac/config.c                             |   2 -
 arch/m68k/q40/config.c                             |   2 -
 arch/powerpc/kernel/legacy_serial.c                |  60 +-
 arch/powerpc/platforms/powermac/setup.c            |   2 -
 arch/x86/include/asm/ce4100.h                      |   6 +
 arch/x86/platform/ce4100/ce4100.c                  |  95 ---
 drivers/isdn/capi/capi.c                           |   8 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  13 +-
 drivers/staging/greybus/uart.c                     |   7 +-
 drivers/tty/serial/8250/8250.h                     |   8 +
 drivers/tty/serial/8250/8250_ce4100.c              |  93 +++
 drivers/tty/serial/8250/8250_core.c                | 318 ++++----
 drivers/tty/serial/8250/8250_dw.c                  |  36 +-
 drivers/tty/serial/8250/8250_em.c                  |   4 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   8 +-
 drivers/tty/serial/8250/8250_ioc3.c                |   4 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |   2 +-
 drivers/tty/serial/8250/8250_ni.c                  |  56 +-
 drivers/tty/serial/8250/8250_omap.c                |  53 +-
 drivers/tty/serial/8250/8250_pci.c                 |   6 +-
 drivers/tty/serial/8250/8250_port.c                | 832 ++++++++++-----------
 drivers/tty/serial/8250/8250_rsa.c                 |  96 +++
 drivers/tty/serial/8250/8250_rt288x.c              |   4 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   4 +-
 drivers/tty/serial/8250/Makefile                   |   3 +
 drivers/tty/serial/Kconfig                         |   7 +
 drivers/tty/serial/Makefile                        |   1 +
 drivers/tty/serial/fsl_lpuart.c                    |   8 +-
 drivers/tty/serial/qcom_geni_serial.c              | 395 ++++++++--
 drivers/tty/serial/rsci.c                          | 480 ++++++++++++
 drivers/tty/serial/rsci.h                          |  10 +
 drivers/tty/serial/serial_core.c                   |  78 +-
 drivers/tty/serial/sh-sci-common.h                 |   8 +
 drivers/tty/serial/sh-sci.c                        | 223 +++---
 drivers/tty/tty_buffer.c                           |   3 +-
 drivers/tty/tty_port.c                             |  17 +-
 drivers/tty/vt/defkeymap.c_shipped                 | 112 +++
 drivers/tty/vt/keyboard.c                          |   2 +-
 drivers/usb/class/cdc-acm.c                        |   7 +-
 drivers/usb/serial/usb-serial.c                    |   7 +-
 include/linux/serial_8250.h                        |   4 +-
 include/linux/serial_core.h                        |   6 +-
 include/linux/tty_port.h                           |  21 +-
 include/uapi/linux/vt.h                            |  78 +-
 net/bluetooth/rfcomm/tty.c                         |   7 +-
 59 files changed, 2331 insertions(+), 1153 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,sa8255p-geni-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,sa8255p-geni-se-qup.yaml
 create mode 100644 drivers/tty/serial/8250/8250_ce4100.c
 create mode 100644 drivers/tty/serial/rsci.c
 create mode 100644 drivers/tty/serial/rsci.h
