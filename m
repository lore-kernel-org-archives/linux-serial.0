Return-Path: <SRS0=U7OZ=5Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17F4C43331
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 07:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABB420748
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 07:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585639911;
	bh=/JZZkfYmXHqyOMjXNgFAnIoa3aqO4SlIh1PBTihhhyM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rGqIFh0lsrk9Kv7E0gES/rYIRe2dhgARVoZoB9foAjYkwDWynzucJMMuLOQqmeYlq
	 /GGtHZgOsOWLaxa2D2Pv5H0la9hBxMGKRhXE5L41vbGFKmBKgXiqvkp9idtNwziPb7
	 T40jaTKyoIGnaUt3Tn8wq6u+V6i4NsN7N9uv8yDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCaHbu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:31:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgCaHbu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Mar 2020 03:31:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 416172072A;
        Tue, 31 Mar 2020 07:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585639909;
        bh=/JZZkfYmXHqyOMjXNgFAnIoa3aqO4SlIh1PBTihhhyM=;
        h=Date:From:To:Cc:Subject:From;
        b=f6qP1iehsLzIz8AckYxSyoWMr50Q1AKcVLKA+IZ1IqO3GMGCT3iqGKmmA8jzsW/MM
         3EisAKYPv90EL80nTqFWWToHgMklHT9s6nstbyf1MVDNxzQdz0o/YCQRhsYiOX2FCn
         4AANPQ+p17tEkhzYS6FKHHmiGJo5rMz5If7savpk=
Date:   Tue, 31 Mar 2020 09:31:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver patches for 5.7-rc1
Message-ID: <20200331073140.GA855734@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.7-rc1

for you to fetch changes up to 8d5b305484e8a3216eeb700ed6c6de870306adbd:

  serial: 8250: Optimize irq enable after console write (2020-03-27 15:45:54 +0100)

----------------------------------------------------------------
TTY/Serial patches for 5.7-rc1

Here is the big set of TTY / Serial patches for 5.7-rc1

Lots of console fixups and reworking in here, serial core tweaks
(doesn't that ever get old, why are we still creating new serial
devices?), serial driver updates, line-protocol driver updates, and some
vt cleanups and fixes included in here as well.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexandre Belloni (2):
      tty: serial: efm32: fix spelling mistake "reserverd" -> "reserved"
      tty: nozomi: fix spelling mistake "reserverd" -> "reserved"

Andy Shevchenko (24):
      kgdboc: Use for_each_console() helper
      console: Don't perform test for CON_BRL flag
      console: Drop double check for console_drivers being non-NULL
      console: Use for_each_console() helper in unregister_console()
      console: Drop misleading comment
      console: Avoid positive return code from unregister_console()
      console: Don't notify user space when unregister non-listed console
      console: Introduce ->exit() callback
      serial: core: Introduce uart_console_enabled() helper
      serial: core: Consolidate spin lock initialization code
      serial: core: use octal permissions on module param
      serial: core: Switch to use DEVICE_ATTR_RO()
      serial: 8250_port: Switch to use DEVICE_ATTR_RW()
      serial: 8250_port: Use dev_*() instead of pr_*()
      serial: 8250_lpss: Add ->setup() for Elkhart Lake ports
      serial: pic32_uart: Use uart_console() helper
      tty/serial: atmel: Use uart_console() helper
      serial: core: Use string length for SysRq magic sequence
      serial: core: Print escaped SysRq Magic sequence if enabled
      serial: core: Use uart_console() helper in SysRq code
      serial: core: Refactor uart_unlock_and_check_sysrq()
      serial: core: Allow detach and attach serial device for console
      serial: 8250_port: Don't use power management for kernel console
      serial: 8250_port: Disable DMA operations for kernel console

Changqi Hu (1):
      serial: 8250-mtk: modify mtk uart power and clock management

Christophe JAILLET (1):
      tty: serial: Kconfig: Fix a typo

Chunyan Zhang (7):
      arm64: change ARCH_SPRD Kconfig to tristate
      tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD
      serial: sprd: check console via stdout-path in addition
      serial: sprd: remove __init from sprd_console_setup
      serial: sprd: getting port index via serial aliases only
      serial: sprd: remove redundant sprd_port cleanup
      tty: serial: make SERIAL_SPRD depend on COMMON_CLK

Daniel Golle (1):
      serial: ar933x_uart: add RS485 support

Dmitry Safonov (3):
      sysctl/sysrq: Remove __sysrq_enabled copy
      serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
      serial/sysrq: Add a help-string for MAGIC_SYSRQ_SERIAL_SEQUENCE

Douglas Anderson (2):
      tty: serial: qcom_geni_serial: No need to stop tx/rx on UART shutdown
      tty: serial: qcom_geni_serial: Don't try to manually disable the console

Eric Biggers (4):
      vt: drop redundant might_sleep() in do_con_write()
      vt: vt_ioctl: remove unnecessary console allocation checks
      vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
      vt: vt_ioctl: fix use-after-free in vt_in_use()

Geert Uytterhoeven (1):
      Revert "tty: serial: samsung_tty: build it for any platform"

George Hilliard (2):
      dt-bindings: serial: document fsl,inverted-tx and -rx options
      tty: imx serial: Implement support for reversing TX and RX polarity

Greg Kroah-Hartman (6):
      tty: serial: samsung_tty: build it for any platform
      tty: serial: samsung_tty: remove SERIAL_SAMSUNG_DEBUG
      Merge 5.6-rc3 into tty-next
      Merge 5.6-rc5 into tty-next
      Merge branch 'for-5.7-console-exit' of git://git.kernel.org/.../pmladek/printk into tty-next
      Merge 5.6-rc7 into tty-next

Gustavo A. R. Silva (4):
      tty/serial: 8250_exar: Replace zero-length array with flexible-array member
      tty: n_gsm: Replace zero-length array with flexible-array member
      serial: sc16is7xx: Replace zero-length array with flexible-array member
      serial: 8250_pci: Replace zero-length array with flexible-array member

Jeff Brasen (1):
      serial: 8250_tegra: Create Tegra specific 8250 driver

Jiri Slaby (49):
      n_tty: check printk arguments for n_tty_trace
      n_gsm: drop unneeded gsm_dlci->fifo field
      n_gsm: introduce enum gsm_dlci_state
      n_gsm: introduce enum gsm_dlci_mode
      n_gsm: introduce enum gsm_mux_state
      n_gsm: add missing __user annotations
      n_gsm: add missing \n to prints
      n_gsm: switch dead to bool
      n_gsm: switch throttled to bool
      n_gsm: switch constipated to bool
      n_gsm: switch escape to bool
      n_hdlc: remove tracing debug prints
      n_hdlc: remove unused macros
      n_hdlc: convert debuglevel use to pr_debug
      n_hdlc: put init/exit strings directly to prints
      n_hdlc: cleanup messages during registration
      n_hdlc: use clamp() for maxframe
      n_hdlc: simplify freeing of buffer list
      n_hdlc: invert conditions in n_hdlc_tty_close and n_hdlc_tty_poll
      n_hdlc: remove unused flags
      n_hdlc: remove unused backup_tty
      n_hdlc: expand tty2n_hdlc macro
      n_hdlc: inline n_hdlc_release
      n_hdlc: remove cached tty
      n_hdlc: remove checking of n_hdlc
      n_hdlc: add helper for buffers allocation
      n_hdlc: move tty_ldisc_ops to the bottom
      n_hdlc: switch tbusy and woke_up to bools
      n_hdlc: remove unneeded ifdef
      n_hdlc: use __func__ and pr_ print helpers
      n_hdlc: remove useless whitespace at line wraps
      n_hdlc: remove spaces between function name and (
      n_hdlc: add missing spaces after commas
      n_hdlc: fix whitespace around binary operators
      n_hdlc: wrap a comment properly
      vt: selection, introduce vc_is_sel
      vt: ioctl, switch VT_IS_IN_USE and VT_BUSY to inlines
      vt: selection, remove 2 local variables from set_selection_kernel
      vt: selection, localize use_unicode
      vt: selection, create struct from console selection globals
      vt: switch vt_dont_switch to bool
      vt: vt_kern.h, remove extern from functions
      vt: selection, remove redeclaration of poke_blanked_console
      vt: selection, indent switch-case properly
      vt: selection, fix double lock introduced by a merge
      tty: n_hdlc, remove FILE and LINE from pr_debug
      vt: use min() to limit intervals
      vt: selection, use rounddown() for start/endline computation
      vt: indent switch-case in setterm_command properly

Kees Cook (1):
      n_tty: Distribute switch variables for initialization

Lanqing Liu (1):
      serial: sprd: Fix a dereference warning

Linus Walleij (5):
      tty: serial: atmel_serial: Drop GPIO includes
      tty: serial: lantiq: Drop GPIO include
      tty: serial: cpm_uart: Convert to use GPIO descriptors
      tty: serial: ifx6x60: Use helper variable for dev
      tty: serial: ifx6x60: Convert to GPIO descriptors

Lubomir Rintel (8):
      serial: 8250_pxa: avoid autodetecting the port type
      ARM: dts: pxa*: Don't redeclare phandle references
      ARM: dts: pxa*: Fix serial port names
      ARM: dts: pxa*: Make the serial ports compatible with xscale-uart
      ARM: dts: mmp2-brownstone: Don't redeclare phandle references
      ARM: dts: mmp*: Fix serial port names
      ARM: dts: mmp*: Make the serial ports compatible with xscale-uart
      ARM: dts: tango4: Make /serial compatible with ns16550a

Lukas Wunner (10):
      serial: 8250: Don't touch RTS modem control while in rs485 mode
      serial: 8250: Support rs485 devicetree properties
      serial: 8250: Deduplicate ->rs485_config() callback
      serial: 8250: Sanitize rs485 config harder
      serial: 8250: Deduplicate rs485 active_timer assignment
      serial: 8250: Generalize rs485 software emulation
      serial: 8250_bcm2835aux: Support rs485 software emulation
      serial: 8250: Support console on software emulated rs485 ports
      serial: 8250: Fix rs485 delay after console write
      serial: 8250: Optimize irq enable after console write

Matthias Brugger (1):
      serial: 8250_early: Add earlycon for BCM2835 aux uart

Michael Walle (9):
      serial: earlycon: prefer EARLYCON_DECLARE() variant
      tty: serial: fsl_lpuart: fix DMA operation when using IOMMU
      tty: serial: fsl_lpuart: fix DMA mapping
      tty: serial: fsl_lpuart: add LS1028A support
      tty: serial: fsl_lpuart: add LS1028A earlycon support
      dt-bindings: serial: lpuart: add ls1028a compatibility
      arm64: dts: ls1028a: add missing LPUART nodes
      tty: serial: fsl_lpuart: move dma_request_chan()
      tty: serial: fsl_lpuart: fix return value checking

Nishad Kamdar (3):
      tty: serial: Use the correct style for SPDX License Identifier
      tty: hvc: Use the correct style for SPDX License Identifier
      tty: n_tracesink: Use the correct style for SPDX License Identifier

Palmer Dabbelt (1):
      tty: sifive: Finish transmission before changing the clock

Peter Ujfalusi (2):
      serial: 8250_omap: Fix sleeping function called from invalid context during probe
      serial: 8250: 8250_omap: Move locking out from __dma_rx_do_complete()

Raviteja Narayanam (2):
      serial: uartps: Remove unconditional wait inside set_termios
      serial: uartps: Add TACTIVE check in cdns_uart_tx_empty function

Roja Rani Yarubandi (1):
      tty: serial: qcom_geni_serial: Fix GPIO swapping with workaround

Serge Semin (1):
      tty: mips_ejtag_fdc: Mark expected switch fall-through

Takashi Iwai (2):
      tty: serial: pch_uart: Use scnprintf() for avoiding potential buffer overflow
      tty: nozomi: Use scnprintf() for avoiding potential buffer overflow

Uwe Kleine-König (1):
      serial: omap: drop unused dt-bindings header

Vignesh Raghavendra (7):
      serial: 8250_port: Don't service RX FIFO if throttled
      serial: 8250: 8250_omap: Fix throttle to call stop_rx()
      serial: 8250: 8250_omap: Terminate DMA before pushing data on RX timeout
      serial: 8250: 8250_omap: Account for data in flight during DMA teardown
      serial: 8250: 8250_omap: Extend driver data to pass FIFO trigger info
      serial: 8250: 8250_omap: Work around errata causing spurious IRQs with DMA
      serial: 8250: 8250_omap: Add DMA support for UARTs on K3 SoCs

Vincent Chen (1):
      tty: serial: Add CONSOLE_POLL support to SiFive UART

satya priya (1):
      tty: serial: qcom_geni_serial: Allocate port->rx_fifo buffer in probe

 Documentation/ABI/testing/sysfs-tty                |   7 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   4 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |  10 +-
 arch/arm/boot/dts/mmp2-brownstone.dts              | 332 +++++++------
 arch/arm/boot/dts/mmp2.dtsi                        |  16 +-
 arch/arm/boot/dts/mmp3.dtsi                        |  16 +-
 arch/arm/boot/dts/pxa168-aspenite.dts              |  24 +-
 arch/arm/boot/dts/pxa168.dtsi                      |  15 +-
 arch/arm/boot/dts/pxa910-dkb.dts                   | 286 ++++++-----
 arch/arm/boot/dts/pxa910.dtsi                      |  15 +-
 arch/arm/boot/dts/tango4-common.dtsi               |   2 +-
 arch/arm64/Kconfig.platforms                       |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  73 +++
 drivers/accessibility/braille/braille_console.c    |   4 -
 drivers/tty/hvc/hvc_console.h                      |   2 +-
 drivers/tty/mips_ejtag_fdc.c                       |   1 +
 drivers/tty/n_gsm.c                                | 140 +++---
 drivers/tty/n_hdlc.c                               | 549 +++++++--------------
 drivers/tty/n_tracesink.h                          |   2 +-
 drivers/tty/n_tty.c                                |   6 +-
 drivers/tty/nozomi.c                               |  69 ++-
 drivers/tty/serial/8250/8250.h                     |   6 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  80 ++-
 drivers/tty/serial/8250/8250_core.c                |  15 +-
 drivers/tty/serial/8250/8250_dwlib.h               |   2 +-
 drivers/tty/serial/8250/8250_exar.c                |   2 +-
 drivers/tty/serial/8250/8250_lpss.c                |   6 +
 drivers/tty/serial/8250/8250_mtk.c                 |  50 +-
 drivers/tty/serial/8250/8250_of.c                  |  67 +--
 drivers/tty/serial/8250/8250_omap.c                | 263 +++++++---
 drivers/tty/serial/8250/8250_pci.c                 |   2 +-
 drivers/tty/serial/8250/8250_port.c                | 238 ++++++---
 drivers/tty/serial/8250/8250_pxa.c                 |   2 +-
 drivers/tty/serial/8250/8250_tegra.c               | 198 ++++++++
 drivers/tty/serial/8250/Kconfig                    |   9 +
 drivers/tty/serial/8250/Makefile                   |   1 +
 drivers/tty/serial/Kconfig                         |  14 +-
 drivers/tty/serial/ar933x_uart.c                   | 113 ++++-
 drivers/tty/serial/atmel_serial.c                  |  23 +-
 drivers/tty/serial/atmel_serial.h                  |   2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |   6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  48 +-
 drivers/tty/serial/earlycon.c                      |  11 +
 drivers/tty/serial/efm32-uart.c                    |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    | 228 ++++++---
 drivers/tty/serial/icom.h                          |   2 +-
 drivers/tty/serial/ifx6x60.c                       | 195 +++-----
 drivers/tty/serial/ifx6x60.h                       |  15 +-
 drivers/tty/serial/imx.c                           |  44 +-
 drivers/tty/serial/jsm/jsm.h                       |   2 +-
 drivers/tty/serial/kgdboc.c                        |   4 +-
 drivers/tty/serial/lantiq.c                        |   1 -
 drivers/tty/serial/omap-serial.c                   |   2 -
 drivers/tty/serial/pch_uart.c                      |  22 +-
 drivers/tty/serial/pic32_uart.c                    |   8 +-
 drivers/tty/serial/pic32_uart.h                    |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |  59 ++-
 drivers/tty/serial/sc16is7xx.c                     |   2 +-
 drivers/tty/serial/serial_core.c                   | 266 +++++++---
 drivers/tty/serial/serial_mctrl_gpio.h             |   2 +-
 drivers/tty/serial/sifive.c                        |  55 ++-
 drivers/tty/serial/sirfsoc_uart.h                  |   2 +-
 drivers/tty/serial/sprd_serial.c                   |  48 +-
 drivers/tty/serial/stm32-usart.h                   |   2 +-
 drivers/tty/serial/timbuart.h                      |   2 +-
 drivers/tty/serial/xilinx_uartps.c                 |  20 +-
 drivers/tty/sysrq.c                                |  12 +
 drivers/tty/vt/selection.c                         | 199 ++++----
 drivers/tty/vt/vt.c                                | 152 +++---
 drivers/tty/vt/vt_ioctl.c                          |  75 +--
 include/linux/console.h                            |   1 +
 include/linux/selection.h                          |   4 +-
 include/linux/serial_8250.h                        |   4 +
 include/linux/serial_core.h                        |   4 +-
 include/linux/spi/ifx_modem.h                      |   5 -
 include/linux/sysrq.h                              |   7 +
 include/linux/vt_kern.h                            |  64 +--
 kernel/printk/printk.c                             |  49 +-
 kernel/sysctl.c                                    |  41 +-
 lib/Kconfig.debug                                  |  10 +
 80 files changed, 2552 insertions(+), 1793 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_tegra.c
