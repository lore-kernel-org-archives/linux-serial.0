Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AB58F4A;
	Sun,  7 Dec 2025 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765068370; cv=none; b=Sd4zAPw0reX9RCL+yT7+4TA3tZDN8Ddti2YF2wckqcgFN2GytT19WhWdxYJ3kkBonIlPY26/8JzxRYjq47bvOf5TuG6c/i1QDO+e6bw8tEcSNzyX8EXxqJec4TJTK0nXerNZE+O6WyrdUn5o4u77+KoNRNL7MHySpatl+L9DTF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765068370; c=relaxed/simple;
	bh=ttQXivXyir3fWJzBZ4NuNXvxzgrHaLzxWz1vIpM364o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uBFBr/Ge1BLOb7tvChJKFgpolWSjN4MNzLQJhkTXV+z3hqrHeeVwflBGgTATcIqZO2yKkqby33M5k0SWu0QK5jwr05yEGit7iJ4keds00nhnjYCsG8kSGcRRMmSU0WDWQ7HIXwaGVr140a5bnVWLkXsVaaBlcotKQqgcaNVTd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xOUpnXK3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xOUpnXK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88353C4CEF5;
	Sun,  7 Dec 2025 00:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765068367;
	bh=ttQXivXyir3fWJzBZ4NuNXvxzgrHaLzxWz1vIpM364o=;
	h=Date:From:To:Cc:Subject:From;
	b=xOUpnXK3fa45MphVV/nHuxNCcXhZsh/HlPWM0fCQtPE8IXFnjq+dWDxLyZZDbUkLT
	 p4KYetLGhTyJQ2eHwuGzI9MWoACFRH7R+gpF6jUMCQhMNrnYORWBsbXqU2rbF+EmtV
	 n4++Nnrh9r2V7m7lpvbMnLqMjx611tb0Tbqjtdj0=
Date: Sun, 7 Dec 2025 09:46:05 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 6.19-rc1
Message-ID: <aTTOTbUu7dkL07S3@kroah.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.19-rc1

for you to fetch changes up to 75a9f4c54770f062f4b3813a83667452b326dda3:

  serial: sh-sci: Fix deadlock during RSCI FIFO overrun error (2025-11-26 13:15:28 +0100)

----------------------------------------------------------------
TTY/Serial changes for 6.19-rc1

Here is the big set of tty/serial driver changes for 6.19-rc1.  Nothing
major at all, just small constant churn to make the tty layer "cleaner"
as well as serial driver updates and even a new test added!  Included in
here are:
  - More tty/serial cleanups from Jiri
  - tty tiocsti test added to hopefully ensure we don't regress in this
    area again
  - sc16is7xx driver updates
  - imx serial driver updates
  - 8250 driver updates
  - new hardware device ids added
  - other minor serial/tty driver cleanups and tweaks

All of these have been in linux-next for a while with no reported issues
other than a merge-conflict that you will have when you merge into your
tree (should be simple to resolve, just delete the code on both sides
of the merge).

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhinav Saxena (1):
      selftests/tty: add TIOCSTI test suite

Andy Shevchenko (1):
      serial: mux: Fix kernel doc for mux_poll()

Biju Das (2):
      dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
      serial: sh-sci: Fix deadlock during RSCI FIFO overrun error

Binbin Zhou (3):
      dt-bindings: serial: 8250: Add Loongson uart compatible
      serial: 8250: Add Loongson uart driver support
      LoongArch: dts: Add uart new compatible string

David Laight (1):
      drivers/tty/vt: use umin() instead of min_t(u16, ...) for row/col limits

Florian Eckert (1):
      serial: 8250_pcilib: Replace deprecated PCI functions

Gerhard Engleder (2):
      serial: Keep rs485 settings for devices without firmware node
      serial: 8250: add driver for KEBA UART

Gopi Krishna Menon (1):
      selftests: tty: add tty_tiocsti_test to .gitignore

Greg Kroah-Hartman (1):
      Merge 6.18-rc3 into tty-next

Haotian Zhang (1):
      serial: icom: Convert PCIBIOS_* return codes to errnos

Heiko Stuebner (1):
      dt-bindings: serial: snps-dw-apb-uart: Add support for rk3506

Hugo Villeneuve (14):
      serial: sc16is7xx: rename LCR macros to better reflect usage
      serial: sc16is7xx: rename EFR mutex with generic name
      serial: sc16is7xx: define common register access function
      serial: sc16is7xx: remove unnecessary pointer cast
      serial: sc16is7xx: use guards for simple mutex locks
      serial: sc16is7xx: drop -ENOMEM error message
      serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
      serial: sc16is7xx: move port/channel init to separate function
      serial: sc16is7xx: simplify to_sc16is7xx_one() with a single parameter
      serial: sc16is7xx: Kconfig: allow building with COMPILE_TEST
      serial: sc16is7xx: use KBUILD_MODNAME
      serial: sc16is7xx: change conditional operator indentation
      serial: sc16is7xx: reformat comments to improve readability
      serial: sc16is7xx: add comments for lock requirements

Ivaylo Ivanov (1):
      dt-bindings: serial: samsung: add samsung,exynos8890-uart compatible

Jiri Slaby (SUSE) (16):
      tty: pty: use guard()s
      tty: n_tty: use guard()s
      tty: n_hdlc: simplify return from n_hdlc_tty_ioctl()
      tty: n_hdlc: use guard()s
      tty: moxa: use guard()s
      tty: vt/keyboard: use __free()
      tty: vt/keyboard: simplify returns from vt_do_kbkeycode_ioctl()
      tty: vt/keyboard: use guard()s
      serial: serial_core: simplify uart_ioctl() returns
      serial: serial_core: use guard()s
      tty: vt: do not open code DIV_ROUND_UP()
      serial: xilinx_uartps: drop cdns_uart::cdns_uart_driver
      serial: drop SERIAL_8250_DEPRECATED_OPTIONS
      serial: 8250: move skip_txen_test to core
      serial: 8250: make share_irqs local to 8250_platform
      serial: 8250_platform: simplify IRQF_SHARED handling

Kriish Sharma (1):
      tty: document @dlci parameter in gsm_modem_send_initial_msc

Lad Prabhakar (2):
      serial: sh-sci: Sort include files alphabetically
      serial: sh-sci: Merge sh-sci.h into sh-sci.c

Magne Bruno (1):
      serial: add support of CPCI cards

Marco Crivellari (1):
      tty: replace use of system_unbound_wq with system_dfl_wq

Praveen Talari (2):
      serial: qcom-geni: Enable PM runtime for serial driver
      serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms

Ravi Patel (1):
      dt-bindings: serial: samsung: Add compatible for ARTPEC-9 SoC

Sam Protsenko (1):
      tty: serial: samsung: Declare earlycon for Exynos850

Sherry Sun (3):
      tty: serial: fsl_lpuart: Add missing wakeup event reporting
      tty: serial: imx: Only configure the wake register when device is set as wakeup source
      tty: serial: imx: Add missing wakeup event reporting

Sven Eckelmann (1):
      serial: ar933x: Add polling support

Wenhua Lin (1):
      serial: sprd: Return -EPROBE_DEFER when uart clock is not ready

jempty.liang (1):
      serial: 8250-of: Fix style issues in 8250_of.c

 Documentation/devicetree/bindings/serial/8250.yaml |  14 +
 .../devicetree/bindings/serial/renesas,rsci.yaml   |   2 -
 .../devicetree/bindings/serial/samsung_uart.yaml   |   2 +
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 arch/arm/configs/aspeed_g4_defconfig               |   1 -
 arch/arm/configs/aspeed_g5_defconfig               |   1 -
 arch/arm/configs/hisi_defconfig                    |   1 -
 arch/arm/configs/lpc18xx_defconfig                 |   1 -
 arch/arm/configs/shmobile_defconfig                |   1 -
 arch/loongarch/boot/dts/loongson-2k0500.dtsi       |   2 +-
 arch/loongarch/boot/dts/loongson-2k1000.dtsi       |   2 +-
 arch/loongarch/boot/dts/loongson-2k2000.dtsi       |   2 +-
 arch/mips/configs/bcm47xx_defconfig                |   1 -
 arch/mips/configs/bmips_stb_defconfig              |   1 -
 arch/mips/configs/gcw0_defconfig                   |   1 -
 arch/nios2/configs/10m50_defconfig                 |   1 -
 arch/parisc/configs/generic-32bit_defconfig        |   1 -
 arch/parisc/configs/generic-64bit_defconfig        |   1 -
 arch/powerpc/configs/44x/akebono_defconfig         |   1 -
 arch/powerpc/configs/microwatt_defconfig           |   1 -
 arch/riscv/configs/nommu_virt_defconfig            |   1 -
 arch/xtensa/configs/audio_kc705_defconfig          |   1 -
 arch/xtensa/configs/generic_kc705_defconfig        |   1 -
 arch/xtensa/configs/nommu_kc705_defconfig          |   1 -
 arch/xtensa/configs/smp_lx200_defconfig            |   1 -
 arch/xtensa/configs/xip_kc705_defconfig            |   1 -
 drivers/tty/moxa.c                                 | 165 +++---
 drivers/tty/n_gsm.c                                |   2 +-
 drivers/tty/n_hdlc.c                               |  79 +--
 drivers/tty/n_tty.c                                | 107 ++--
 drivers/tty/pty.c                                  | 103 ++--
 drivers/tty/serial/8250/8250.h                     |   9 -
 drivers/tty/serial/8250/8250_core.c                |   4 +
 drivers/tty/serial/8250/8250_dw.c                  |   4 +-
 drivers/tty/serial/8250/8250_exar.c                |   4 +-
 drivers/tty/serial/8250/8250_keba.c                | 280 +++++++++
 drivers/tty/serial/8250/8250_loongson.c            | 238 ++++++++
 drivers/tty/serial/8250/8250_of.c                  |   2 +-
 drivers/tty/serial/8250/8250_pci.c                 |  47 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c            |  10 +-
 drivers/tty/serial/8250/8250_pcilib.c              |   7 +-
 drivers/tty/serial/8250/8250_pcilib.h              |   2 +-
 drivers/tty/serial/8250/8250_platform.c            |  55 +-
 drivers/tty/serial/8250/8250_rsa.c                 |  24 -
 drivers/tty/serial/8250/Kconfig                    |  40 +-
 drivers/tty/serial/8250/Makefile                   |   2 +
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/ar933x_uart.c                   |  62 ++
 drivers/tty/serial/fsl_lpuart.c                    |   8 +
 drivers/tty/serial/icom.c                          |   1 +
 drivers/tty/serial/imx.c                           |  24 +-
 drivers/tty/serial/mux.c                           |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              | 178 +++++-
 drivers/tty/serial/samsung_tty.c                   |   2 +
 drivers/tty/serial/sc16is7xx.c                     | 413 ++++++-------
 drivers/tty/serial/sc16is7xx.h                     |   1 -
 drivers/tty/serial/sc16is7xx_i2c.c                 |   4 +-
 drivers/tty/serial/sc16is7xx_spi.c                 |   4 +-
 drivers/tty/serial/serial_core.c                   | 178 +++---
 drivers/tty/serial/sh-sci.c                        | 196 ++++++-
 drivers/tty/serial/sh-sci.h                        | 178 ------
 drivers/tty/serial/sprd_serial.c                   |   6 +
 drivers/tty/serial/xilinx_uartps.c                 |  15 +-
 drivers/tty/tty_buffer.c                           |   8 +-
 drivers/tty/vt/keyboard.c                          | 318 ++++------
 drivers/tty/vt/selection.c                         |   9 +-
 drivers/tty/vt/vt.c                                |   4 +-
 tools/testing/selftests/tty/.gitignore             |   1 +
 tools/testing/selftests/tty/Makefile               |   6 +-
 tools/testing/selftests/tty/config                 |   1 +
 tools/testing/selftests/tty/tty_tiocsti_test.c     | 650 +++++++++++++++++++++
 71 files changed, 2338 insertions(+), 1161 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_keba.c
 create mode 100644 drivers/tty/serial/8250/8250_loongson.c
 delete mode 100644 drivers/tty/serial/sh-sci.h
 create mode 100644 tools/testing/selftests/tty/config
 create mode 100644 tools/testing/selftests/tty/tty_tiocsti_test.c
