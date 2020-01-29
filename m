Return-Path: <SRS0=su8x=3S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55CC33CB2
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535672071E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580292864;
	bh=ozx3ZifGHZwtk45mZavhYeJn3LgaG+SmvZd8VODo5eE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qOPOe91BlRW+jDRfBAQfYAa1wSozV9iY5eAefEk9OBXg77ESIPwXqomJNqKRLg0z0
	 GR9DVpIfqTLKyR/LRemOjETmFxC+xSxhT6XZHT+h6taRXerOX9tI2p2Rz2FoD7I5Xc
	 Hr/Tdvfn0tCUWvsXW/iV7GJBBaFdK1MRGGzwKuz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgA2KOY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:14:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2KOX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jan 2020 05:14:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D5820716;
        Wed, 29 Jan 2020 10:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580292863;
        bh=ozx3ZifGHZwtk45mZavhYeJn3LgaG+SmvZd8VODo5eE=;
        h=Date:From:To:Cc:Subject:From;
        b=TsrF3QqEEmtR9HvTL/UgzGtOpGYLOfYujRS0NDTkGyoJFFWcIQ+KU49zETI1AZcMM
         h447EFfa+/TxpCODC6GzXu1Bw0kMUMr0zgE6yrRKFxsEpB+q+UNoy5R0+8huldQwfU
         MXPBwcCnFo5zWX/FIROygDUJr+TrMuNdnlKgNGrc=
Date:   Wed, 29 Jan 2020 11:14:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver patches for 5.6-rc1
Message-ID: <20200129101420.GA3858344@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.6-rc1

for you to fetch changes up to 85f4c95172d606dd66f7ee1fa50c45a245535ffd:

  tty: n_hdlc: Use flexible-array member and struct_size() helper (2020-01-23 19:22:49 +0100)

----------------------------------------------------------------
TTY/Serial driver updates for 5.6-rc1

Here are the big set of tty and serial driver updates for 5.6-rc1

Included in here are:
	- dummy_con cleanups (touches lots of arch code)
	- sysrq logic cleanups (touches lots of serial drivers)
	- samsung driver fixes (wasn't really being built)
	- conmakeshash move to tty subdir out of scripts
	- lots of small tty/serial driver updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Akash Asthana (2):
      tty: serial: qcom_geni_serial: Wakeup IRQ cleanup
      tty: serial: qcom_geni_serial: Move loopback support to TIOCM_LOOP

Andy Shevchenko (2):
      tty: baudrate: Synchronise baud_table[] and baud_bits[]
      tty: baudrate: SPARC supports few more baud rates

Arvind Sankar (23):
      console/dummycon: Remove bogus depends on from DUMMY_CONSOLE
      vt: Initialize conswitchp to dummy_con if unset
      arch/alpha/setup: Drop dummy_con initialization
      arch/arc/setup: Drop dummy_con initialization
      arch/arm/setup: Drop dummy_con initialization
      arch/arm64/setup: Drop dummy_con initialization
      arch/csky/setup: Drop dummy_con initialization
      arch/ia64/setup: Drop dummy_con initialization
      arch/m68k/setup: Drop dummy_con initialization
      arch/microblaze/setup: Drop dummy_con initialization
      arch/mips/setup: Drop dummy_con initialization
      arch/nds32/setup: Drop dummy_con initialization
      arch/nios2/setup: Drop dummy_con initialization
      arch/openrisc/setup: Drop dummy_con initialization
      arch/parisc/setup: Drop dummy_con initialization
      arch/powerpc/setup: Drop dummy_con initialization
      arch/riscv/setup: Drop dummy_con initialization
      arch/s390/setup: Drop dummy_con initialization
      arch/sh/setup: Drop dummy_con initialization
      arch/sparc/setup: Drop dummy_con initialization
      arch/unicore32/setup: Drop dummy_con initialization
      arch/x86/setup: Drop dummy_con initialization
      arch/xtensa/setup: Drop dummy_con initialization

Chen Wandun (1):
      tty: serial: samsung: remove variable 'ufstat' set but not used

Codrin.Ciubotariu@microchip.com (1):
      tty/serial: atmel: RS485 & ISO7816: wait for TXRDY before sending data

Colin Ian King (1):
      serial: ucc_uart: remove redundant assignment to pointer bdp

David Engraf (1):
      tty/serial: atmel: fix out of range clock divider handling

Dmitry Osipenko (2):
      tty: serial: tegra: Activate RX DMA transfer by request
      tty: serial: tegra: Optimize DMA buffer synchronization

Dmitry Safonov (55):
      sysrq: Remove sysrq_handler_registered
      serial: Move sysrq members above
      serial_core: Un-ifdef sysrq SUPPORT_SYSRQ
      tty/serial: Migrate aspeed_vuart to use has_sysrq
      tty/serial: Migrate 8250_fsl to use has_sysrq
      tty/serial: Migrate bcm63xx_uart to use has_sysrq
      tty/serial: Migrate 8250_omap to use has_sysrq
      tty/serial: Migrate 8250_port to use has_sysrq
      tty/serial: Migrate amba-pl01* to use has_sysrq
      tty/serial: Migrate apbuart to use has_sysrq
      tty/serial: Migrate arc_uart to use has_sysrq
      tty/serial: Migrate atmel_serial to use has_sysrq
      tty/serial: Migrate clps711x to use has_sysrq
      tty/serial: Migrate cpm_uart to use has_sysrq
      tty/serial: Migrate dz to use has_sysrq
      tty/serial: Migrate efm32-uart to use has_sysrq
      tty/serial: Migrate fsl_linflexuart to use has_sysrq
      tty/serial: Migrate fsl_lpuart to use has_sysrq
      tty/serial: Migrate imx to use has_sysrq
      tty/serial: Migrate ip22zilog to use has_sysrq
      tty/serial: Migrate meson_uart to use has_sysrq
      tty/serial: Migrate milbeaut_usio to use has_sysrq
      tty/serial: Migrate mpc52xx_uart to use has_sysrq
      tty/serial: mpc52xx_uart: Don't zero port->sysrq
      tty/serial: Migrate msm_serial to use has_sysrq
      tty/serial: Migrate mux to use has_sysrq
      tty/serial: Migrate mxs-auart to use has_sysrq
      tty/serial: Migrate omap-serial to use has_sysrq
      tty/serial: Migrate pch_uart to use has_sysrq
      tty/serial: pmac_zilog: Don't check port->sysrq
      tty/serial: Migrate pmac_zilog to use has_sysrq
      tty/serial: Migrate pnx8xxx_uart to use has_sysrq
      tty/serial: Migrate pxa to use has_sysrq
      tty/serial: Migrate qcom_geni_serial to use has_sysrq
      tty/serial: Migrate sa1100 to use has_sysrq
      tty/serial: Migrate sb1250-duart to use has_sysrq
      tty/serial: Migrate sccnxp to use has_sysrq
      tty/serial: Migrate serial_txx9 to use has_sysrq
      tty/serial: Migrate sh-sci to use has_sysrq
      tty/serial: Migrate sprd_serial to use has_sysrq
      tty/serial: Migrate st-asc to use has_sysrq
      tty/serial: Migrate stm32-usart to use has_sysrq
      tty/serial: Migrate sunhv to use has_sysrq
      tty/serial: Migrate sunsab to use has_sysrq
      tty/serial: Migrate sunsu to use has_sysrq
      tty/serial: Migrate samsung_tty to use has_sysrq
      tty/serial: Migrate sunzilog to use has_sysrq
      tty/serial: ucc_uart: Remove ifdef SUPPORT_SYSRQ
      tty/serial: Migrate vr41xx_siu to use has_sysrq
      tty/serial: Migrate vt8500_serial to use has_sysrq
      tty/serial: Migrate xilinx_uartps to use has_sysrq
      tty/serial: Migrate zs to use has_sysrq
      serial_core: Remove SUPPORT_SYSRQ ifdeffery
      serial_core: Move sysrq functions from header file
      serial_core: Remove unused member in uart_port

Dmitry Torokhov (1):
      tty: st-asc: switch to using devm_gpiod_get()

Greg Kroah-Hartman (15):
      tty: serial: samsung: allow driver to be built by anyone
      tty: serial: samsung_tty: fix build warning
      tty: serial: samsung.h: fix up minor comment issues
      tty: serial: samsung.h: remove reset_port callback from struct s3c24xx_uart_info
      tty: serial: samsung_tty: delete samsung.h
      tty: serial: samsung_tty: drop unneded dbg() calls
      tty: serial: samsung_tty: use standard debugging macros
      tty: serial: samsung_tty: use 'unsigned int' not 'unsigned'
      tty: serial: samsung_tty: fix up minor comment formatting
      tty: serial: samsung_tty: fix blank line checkpatch warning
      tty: serial: samsung_tty: do not abuse the struct uart_port unused fields
      Revert "tty/serial: atmel: fix out of range clock divider handling"
      tty: serial: 21285: stop using the unused[] variable from struct uart_port
      Merge 5.5-rc3 into tty-next
      Merge 5.5-rc6 into tty-next

Gustavo A. R. Silva (1):
      tty: n_hdlc: Use flexible-array member and struct_size() helper

Johan Hovold (1):
      Revert "serdev: simplify Makefile"

John Stultz (2):
      tty: serial_core: Export uart_console_device so it can be used by modules
      tty: serial: Kconfig: Allow SERIAL_QCOM_GENI_CONSOLE to be enabled if SERIAL_QCOM_GENI is a module

Josh Triplett (1):
      serial: 8250: Support disabling mdelay-filled probes of 16550A variants

Julien Masson (1):
      tty: serial: meson_uart: Add support for kernel debugger

Krzysztof Kozlowski (1):
      serial: samsung: Rename Exynos to lowercase

Laurentiu Tudor (1):
      MAINTAINERS: Add myself as maintainer of ehv_bytechan tty driver

Loic Poulain (1):
      tty: serial: msm_serial: RX SW/FIFO mode fallback

Lukas Wunner (7):
      vt: Delete comment referencing non-existent unbind_con_driver()
      vt: Correct comment documenting do_take_over_console()
      serial: 8250_bcm2835aux: Fix line mismatch on driver unbind
      serial: 8250_bcm2835aux: Suppress register_port error on -EPROBE_DEFER
      serial: 8250_bcm2835aux: Allocate uart_8250_port on stack
      serial: 8250_bcm2835aux: Use generic remapping code
      serial: 8250_bcm2835aux: Document struct bcm2835aux_data

Maarten Brock (3):
      serial: xilinx_uartps: Let get_mctrl return status
      serial: xilinx_uartps: set_termios sets flowcontrol
      serial: xilinx_uartps: set_mctrl sets RTS and DTR

Masahiro Yamada (1):
      tty: vt: move conmakehash to drivers/tty/vt/ from scripts/

Nathan Chancellor (2):
      tty: synclinkmp: Adjust indentation in several functions
      tty: synclink_gt: Adjust indentation in several functions

Peng Fan (3):
      tty: serial: fsl_lpuart: drop EARLYCON_DECLARE
      tty: serial: fsl_lpuart: support UPIO_MEM32 for lpuart32
      tty: serial: fsl_lpuart: drop earlycon entry for i.MX8QXP

Phil Elwell (1):
      serial: 8250_bcm2835aux: Suppress clk_get error on -EPROBE_DEFER

Shubhrajyoti Datta (1):
      tty: pl011: Add suspend resume support

Uwe Kleine-König (4):
      serdev: simplify Makefile
      serdev: make use of printk extension %pe for better error messages
      tty: drop useless variable initialisation in tty_kopen()
      serial: imx: fix a race condition in receive path

Xiongfeng Wang (2):
      tty: omap-serial: remove set but unused variable
      tty: serial: amba-pl011: remove set but unused variable

Zheng Bin (4):
      tty: synclink_gt: use true,false for bool variable
      tty/serial: kgdb_nmi: use true,false for bool variable
      tty/serial: atmel: use true,false for bool variable
      tty/serial: 8250_exar: use true,false for bool variable

Zhenzhong Duan (1):
      ttyprintk: fix a potential deadlock in interrupt context issue

 MAINTAINERS                                 |   6 +
 arch/alpha/kernel/setup.c                   |   2 -
 arch/arc/kernel/setup.c                     |   4 -
 arch/arm/kernel/setup.c                     |   2 -
 arch/arm64/kernel/setup.c                   |   3 -
 arch/csky/kernel/setup.c                    |   4 -
 arch/ia64/kernel/setup.c                    |   3 -
 arch/m68k/kernel/setup_mm.c                 |   4 -
 arch/m68k/kernel/setup_no.c                 |   4 -
 arch/m68k/sun3x/config.c                    |   1 -
 arch/microblaze/kernel/setup.c              |   4 -
 arch/mips/kernel/setup.c                    |   2 -
 arch/nds32/kernel/setup.c                   |   5 -
 arch/nios2/kernel/setup.c                   |   4 -
 arch/openrisc/kernel/setup.c                |   5 -
 arch/parisc/kernel/setup.c                  |   4 -
 arch/powerpc/kernel/legacy_serial.c         |   4 +-
 arch/powerpc/kernel/setup-common.c          |   3 -
 arch/powerpc/platforms/cell/setup.c         |   3 -
 arch/powerpc/platforms/maple/setup.c        |   3 -
 arch/powerpc/platforms/pasemi/setup.c       |   4 -
 arch/powerpc/platforms/ps3/setup.c          |   4 -
 arch/riscv/kernel/setup.c                   |   4 -
 arch/s390/kernel/setup.c                    |   2 -
 arch/sh/kernel/setup.c                      |   4 -
 arch/sparc/kernel/setup_32.c                |   4 -
 arch/sparc/kernel/setup_64.c                |   4 -
 arch/unicore32/kernel/setup.c               |   2 -
 arch/x86/kernel/setup.c                     |   2 -
 arch/xtensa/kernel/setup.c                  |   2 -
 drivers/char/ttyprintk.c                    |  15 +-
 drivers/tty/n_hdlc.c                        |  11 +-
 drivers/tty/serdev/core.c                   |  14 +-
 drivers/tty/serial/21285.c                  |  55 ++++-
 drivers/tty/serial/8250/8250_aspeed_vuart.c |   5 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c   |  50 ++---
 drivers/tty/serial/8250/8250_core.c         |   1 +
 drivers/tty/serial/8250/8250_exar.c         |   6 +-
 drivers/tty/serial/8250/8250_fsl.c          |   4 -
 drivers/tty/serial/8250/8250_of.c           |   4 +-
 drivers/tty/serial/8250/8250_omap.c         |   5 +-
 drivers/tty/serial/8250/8250_port.c         |   8 +-
 drivers/tty/serial/8250/Kconfig             |  10 +
 drivers/tty/serial/Kconfig                  |   4 +-
 drivers/tty/serial/amba-pl010.c             |   5 +-
 drivers/tty/serial/amba-pl011.c             |  13 +-
 drivers/tty/serial/apbuart.c                |   5 +-
 drivers/tty/serial/arc_uart.c               |   5 +-
 drivers/tty/serial/atmel_serial.c           |  41 ++--
 drivers/tty/serial/bcm63xx_uart.c           |   5 +-
 drivers/tty/serial/clps711x.c               |   5 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |   9 +-
 drivers/tty/serial/dz.c                     |   5 +-
 drivers/tty/serial/efm32-uart.c             |   5 +-
 drivers/tty/serial/fsl_linflexuart.c        |   8 +-
 drivers/tty/serial/fsl_lpuart.c             |  16 +-
 drivers/tty/serial/imx.c                    |  58 +++--
 drivers/tty/serial/ip22zilog.c              |   7 +-
 drivers/tty/serial/kgdb_nmi.c               |   4 +-
 drivers/tty/serial/meson_uart.c             |  70 ++++++-
 drivers/tty/serial/milbeaut_usio.c          |   5 +-
 drivers/tty/serial/mpc52xx_uart.c           |  11 +-
 drivers/tty/serial/msm_serial.c             |  23 +-
 drivers/tty/serial/mux.c                    |   5 +-
 drivers/tty/serial/mxs-auart.c              |   5 +-
 drivers/tty/serial/omap-serial.c            |  12 +-
 drivers/tty/serial/pch_uart.c               |  12 +-
 drivers/tty/serial/pmac_zilog.c             |   5 +-
 drivers/tty/serial/pnx8xxx_uart.c           |   7 +-
 drivers/tty/serial/pxa.c                    |   5 +-
 drivers/tty/serial/qcom_geni_serial.c       | 128 +++++------
 drivers/tty/serial/sa1100.c                 |   7 +-
 drivers/tty/serial/samsung.h                | 147 -------------
 drivers/tty/serial/samsung_tty.c            | 315 ++++++++++++++++++----------
 drivers/tty/serial/sb1250-duart.c           |   5 +-
 drivers/tty/serial/sccnxp.c                 |   5 +-
 drivers/tty/serial/serial-tegra.c           |  94 +++++----
 drivers/tty/serial/serial_core.c            |  84 ++++++++
 drivers/tty/serial/serial_txx9.c            |   5 +-
 drivers/tty/serial/sh-sci.c                 |  10 +-
 drivers/tty/serial/sprd_serial.c            |   5 +-
 drivers/tty/serial/st-asc.c                 |  17 +-
 drivers/tty/serial/stm32-usart.c            |   5 +-
 drivers/tty/serial/sunhv.c                  |   5 +-
 drivers/tty/serial/sunsab.c                 |   5 +-
 drivers/tty/serial/sunsu.c                  |   5 +-
 drivers/tty/serial/sunzilog.c               |   6 +-
 drivers/tty/serial/ucc_uart.c               |   4 -
 drivers/tty/serial/vr41xx_siu.c             |   5 +-
 drivers/tty/serial/vt8500_serial.c          |   5 +-
 drivers/tty/serial/xilinx_uartps.c          |  51 +++--
 drivers/tty/serial/zs.c                     |   5 +-
 drivers/tty/synclink_gt.c                   |  20 +-
 drivers/tty/synclinkmp.c                    |  24 +--
 drivers/tty/sysrq.c                         |   9 +-
 drivers/tty/tty_baudrate.c                  |  28 ++-
 drivers/tty/tty_io.c                        |   2 +-
 drivers/tty/vt/.gitignore                   |   1 +
 drivers/tty/vt/Makefile                     |   6 +-
 {scripts => drivers/tty/vt}/conmakehash.c   |   0
 drivers/tty/vt/vt.c                         |   8 +-
 drivers/video/console/Kconfig               |   1 -
 include/linux/serial_8250.h                 |   1 +
 include/linux/serial_core.h                 |  91 +-------
 scripts/.gitignore                          |   1 -
 scripts/Makefile                            |   3 -
 106 files changed, 824 insertions(+), 934 deletions(-)
 delete mode 100644 drivers/tty/serial/samsung.h
 rename {scripts => drivers/tty/vt}/conmakehash.c (100%)
