Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC343C4361B
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 10:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C52722202
	for <linux-serial@archiver.kernel.org>; Tue, 15 Dec 2020 10:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgLOKRq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Dec 2020 05:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgLOKRG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Dec 2020 05:17:06 -0500
Date:   Tue, 15 Dec 2020 11:17:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608027385;
        bh=EfMxzYEL0azsDXInSzG0G5MfS+uNuiw4Qon1u4vG234=;
        h=From:To:Cc:Subject:From;
        b=wrqWSYufpU5+sz9Wvz+5iBSWe5DR/btQLMmcFxWMnjd6VLAojgpKU8Pu9v0UPHSWy
         fBuT/LzAqGq8b0riSPUkvrYF0LAx9WGzzp2zcs7Wh3G00HEo83H0VY5z1RQ+Kok0JG
         amTBBOjoZjEDV5+0x5sye6wMPbInzbgRmCeCzN4c=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial changes for 5.11-rc1
Message-ID: <X9iNOFPXMb4IrJDX@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.11-rc1

for you to fetch changes up to c3ae3dc896fab5524f9b20f547e72e4b892d8d8e:

  serial: 8250_pci: Drop bogus __refdata annotation (2020-12-11 17:17:50 +0100)

----------------------------------------------------------------
TTY/Serial patches for 5.11-rc1

Here is the "large" set of tty and serial patches for 5.11-rc1.

Nothing major at all, some cleanups and some driver removals, always a
nice sign:
  - build warning cleanups
  - vt locking and logic unwinding and cleanups
  - tiny serial driver fixes and updates
  - removal of the synclink serial driver as it's no longer needed
  - removal of dead termiox code

All of this has been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Sverdlin (2):
      tty: serial: uartlite: Support probe deferral
      serial: 8250_omap: Avoid FIFO corruption caused by MDR1 access

Alexey Kardashevskiy (1):
      serial_core: Check for port state when tty is in error state

Andy Shevchenko (5):
      serial: max310x: Make use of device properties
      serial: max310x: Use devm_clk_get_optional() to get the input clock
      vt: keyboard, use BIT() macro instead of open coded variants
      vt: keyboard, replace numbers with \r, \n where appropriate
      vt: keyboard, make use of assign_bit() API

Clement Smith (1):
      tty : serial: jsm: Fixed file by adding spacing

Fabio Estevam (5):
      serial: imx: Remove unused platform data support
      serial: imx: Remove unused .id_table support
      serial: mxs-auart: Remove unneeded platform_device_id
      serial: imx: Remove unneeded of_device_get_match_data() NULL check
      serial: imx: Move imx_uart_probe_dt() content into probe()

Geert Uytterhoeven (1):
      serial: 8250_pci: Drop bogus __refdata annotation

Greg Kroah-Hartman (4):
      Merge 5.10-rc2 into tty-next
      Merge 5.10-rc3 into tty-next
      Merge 5.10-rc5 into tty-next
      Merge 5.10-rc7 into tty-next

Jann Horn (1):
      tty: Remove dead termiox code

Jiri Slaby (17):
      vt: keyboard, remove ctrl_alt_del declaration
      vt: keyboard, include linux/spinlock.h
      vt: keyboard, sort includes
      vt: keyboard, sort key types by their number
      vt: keyboard, clean up max_vals
      vt: keyboard, extract vt_kdgkbent and vt_kdskbent
      vt: keyboard, union perm checks in vt_do_kdsk_ioctl
      vt: keyboard, use DECLARE_BITMAP for key_down
      vt: keyboard, use bool for rep
      vt: keyboard, rename i to kb_func in vt_do_kdgkb_ioctl
      vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl
      vt: keyboard, extract and simplify vt_kdskbsent
      vt: keyboard, remove unneeded func_* declarations
      vt: keyboard, union perm checks in vt_do_kdgkb_ioctl
      vt: keyboard, make HW_RAW a function
      vt: keyboard, use find_next_bit in kbd_match
      vt: keyboard, use tty_insert_flip_string in puts_queue

Johan Hovold (4):
      earlycon: simplify earlycon-table implementation
      earlycon: drop semicolon from earlycon macro
      tty: use assign_bit() in port-flag accessors
      tty: use const parameters in port-flag accessors

Kevin Hilman (1):
      tty: serial: meson: enable console as module

Laurent Vivier (1):
      tty: goldfish: use __raw_writel()/__raw_readl()

Lee Jones (35):
      tty: serdev: core: Remove unused variable 'dummy'
      tty: serdev: core: Provide missing description for 'owner'
      tty: tty_baudrate: Add missing description for 'tty'
      tty: tty_io: Move 'tty_sysctl_init's prototype to shared space
      tty: tty_buffer: Add missing description for 'limit'
      tty: tty_port: Demote obvious abuse of kernel-doc formatting
      tty: tty_jobctrl: Add missing function parameter descriptions
      tty: vt: consolemap: Demote weakly documented function header
      tty: n_tty: Add 2 missing parameter descriptions
      tty: serial: jsm: jsm_cls: Remove unused variable 'discard'
      tty: tty_io: Fix some kernel-doc issues
      tty: serial: 8250: serial_cs: Remove unused/unchecked variable 'err'
      tty: tty_audit: Demote non-conformant kernel-doc headers
      tty: pty: Provide descriptions for the 'file' parameters
      tty: serial: amba-pl011: Mark 'sbsa_uart_acpi_match' as __maybe_unused
      tty: n_gsm: Demote obvious abuse of kernel-doc and supply other missing docss
      tty: serial: lpc32xx_hs: Remove unused variable 'tmp'
      tty: serial: msm_serial: Remove set but unused variable 'status'
      tty: serial: ifx6x60: Fix function documentation headers
      tty: serial: xilinx_uartps: Supply description for missing member 'cts_override'
      tty: synclink_gt: Demote one kernel-doc header and repair another
      tty: serial: serial-tegra: Struct headers should start with 'struct <name>'
      tty: serial: sifive: Struct headers should start with 'struct <name>'
      tty: synclinkmp: Add missing description for function param 'txqueue'
      tty: serial: stm32-usart: Remove set but unused 'cookie' variables
      tty: tty_ldisc: Supply missing description for 'tty_ldisc_get's 'tty' param
      tty: serial: serial-tegra: Provide some missing struct member descriptions
      tty: hvc: hvc_vio: Staticify function invoked only by reference
      tty: hvc: hvc_opal: Staticify function invoked by reference
      tty: synclink: Provide missing description for 'hdlcdev_tx_timeout's 'txqueue' param
      tty: Remove redundant synclink driver
      tty: Remove redundant synclinkmp driver
      tty: serial: 8250: 8250_port: Move prototypes to shared location
      tty: serial: pmac_zilog: Remove unused disposable variable 'garbage'
      tty: tty_ldisc: Fix some kernel-doc related misdemeanours

Liu Xiang (1):
      tty: serial: linflexuart: Remove unnecessary '|' operation and add error count

Mingrui Ren (1):
      tty/serial/imx: Enable TXEN bit in imx_poll_init().

Rafał Miłecki (1):
      tty: serial: bcm63xx: lower driver dependencies

Rikard Falkeborn (1):
      tty: serial: msm_serial: Constify msm_uart_pops

Thomas Bogendoerfer (1):
      tty: serial: remove pnx8xxx uart driver

Tom Rix (1):
      tty: nozomi: remove unneeded break

Vignesh Raghavendra (4):
      serial: 8250: 8250_omap: Disable RX interrupt after DMA enable
      dt-bindings: serial: 8250_omap: Add compatible for UART controller on AM64 SoC
      serial: 8250: 8250_omap: Fix possible array out of bounds access
      serial: 8250: 8250_omap: Fix unused variable warning

Yan.Gao (1):
      tty: Fix whitespace inconsistencies in vt_io_ioctl

Yash Shah (1):
      dt-bindings: serial: Update DT binding docs to support SiFive FU740 SoC

Yoshihiro Shimoda (1):
      dt-bindings: serial: renesas,scif: Document r8a779a0 bindings

YueHaibing (1):
      serial: mctrl_gpio: Fix passing zero to 'ERR_PTR' warning

Zhang Qilong (1):
      serial: 8250-mtk: Fix reference leak in mtk8250_probe

 .../devicetree/bindings/serial/omap_serial.txt     |    1 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |    1 +
 .../devicetree/bindings/serial/sifive-serial.yaml  |    4 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    2 -
 drivers/of/fdt.c                                   |    7 +-
 drivers/tty/Kconfig                                |   27 -
 drivers/tty/Makefile                               |    2 -
 drivers/tty/goldfish.c                             |   18 +-
 drivers/tty/hvc/hvc_opal.c                         |    2 +-
 drivers/tty/hvc/hvc_vio.c                          |    2 +-
 drivers/tty/n_gsm.c                                |    4 +-
 drivers/tty/n_tty.c                                |    2 +
 drivers/tty/nozomi.c                               |    5 +-
 drivers/tty/pty.c                                  |    2 +
 drivers/tty/serdev/core.c                          |    6 +-
 drivers/tty/serial/8250/8250_early.c               |    3 -
 drivers/tty/serial/8250/8250_mtk.c                 |   13 +-
 drivers/tty/serial/8250/8250_omap.c                |   48 +-
 drivers/tty/serial/8250/8250_pci.c                 |    2 +-
 drivers/tty/serial/8250/serial_cs.c                |    9 +-
 drivers/tty/serial/Kconfig                         |   20 +-
 drivers/tty/serial/Makefile                        |    1 -
 drivers/tty/serial/amba-pl011.c                    |    2 +-
 drivers/tty/serial/earlycon.c                      |    6 +-
 drivers/tty/serial/fsl_linflexuart.c               |   19 +-
 drivers/tty/serial/ifx6x60.c                       |    3 +-
 drivers/tty/serial/imx.c                           |  115 +-
 drivers/tty/serial/jsm/jsm_cls.c                   |    4 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |    2 +-
 drivers/tty/serial/lpc32xx_hs.c                    |    3 +-
 drivers/tty/serial/max310x.c                       |   57 +-
 drivers/tty/serial/meson_uart.c                    |    8 +-
 drivers/tty/serial/msm_serial.c                    |    5 +-
 drivers/tty/serial/mxs-auart.c                     |   21 +-
 drivers/tty/serial/pmac_zilog.h                    |    8 +-
 drivers/tty/serial/pnx8xxx_uart.c                  |  858 ---
 drivers/tty/serial/serial-tegra.c                  |    7 +-
 drivers/tty/serial/serial_core.c                   |    4 +
 drivers/tty/serial/serial_mctrl_gpio.c             |    2 +-
 drivers/tty/serial/sifive.c                        |    3 +-
 drivers/tty/serial/stm32-usart.c                   |    6 +-
 drivers/tty/serial/uartlite.c                      |    4 +-
 drivers/tty/serial/xilinx_uartps.c                 |    1 +
 drivers/tty/synclink.c                             | 7898 --------------------
 drivers/tty/synclink_gt.c                          |    3 +-
 drivers/tty/synclinkmp.c                           | 5579 --------------
 drivers/tty/tty_audit.c                            |   12 +-
 drivers/tty/tty_baudrate.c                         |    1 +
 drivers/tty/tty_buffer.c                           |    1 +
 drivers/tty/tty_io.c                               |   12 +-
 drivers/tty/tty_ioctl.c                            |   61 +-
 drivers/tty/tty_jobctrl.c                          |    3 +
 drivers/tty/tty_ldisc.c                            |   11 +-
 drivers/tty/tty_port.c                             |    4 +-
 drivers/tty/vt/consolemap.c                        |    3 +-
 drivers/tty/vt/keyboard.c                          |  464 +-
 drivers/tty/vt/vt_ioctl.c                          |    4 +-
 include/linux/goldfish.h                           |    8 +-
 include/linux/kbd_kern.h                           |    3 -
 include/linux/platform_data/serial-imx.h           |   15 -
 include/linux/serial_8250.h                        |    5 +
 include/linux/serial_core.h                        |   20 +-
 include/linux/serial_pnx8xxx.h                     |   67 -
 include/linux/tty.h                                |   44 +-
 include/linux/tty_driver.h                         |    9 -
 include/uapi/linux/keyboard.h                      |    2 +-
 include/uapi/linux/serial_core.h                   |    2 -
 67 files changed, 464 insertions(+), 15086 deletions(-)
 delete mode 100644 drivers/tty/serial/pnx8xxx_uart.c
 delete mode 100644 drivers/tty/synclink.c
 delete mode 100644 drivers/tty/synclinkmp.c
 delete mode 100644 include/linux/platform_data/serial-imx.h
 delete mode 100644 include/linux/serial_pnx8xxx.h
