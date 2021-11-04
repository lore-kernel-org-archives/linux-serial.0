Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6BC433EF
	for <linux-serial@archiver.kernel.org>; Thu,  4 Nov 2021 13:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E71E611C9
	for <linux-serial@archiver.kernel.org>; Thu,  4 Nov 2021 13:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhKDNSW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 4 Nov 2021 09:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhKDNSW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 4 Nov 2021 09:18:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F68A61058;
        Thu,  4 Nov 2021 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636031744;
        bh=7a5X9UtXJ9AoZNGKe0XXtyHZwXGJn7mproECQZghc00=;
        h=Date:From:To:Cc:Subject:From;
        b=Y66elOgkMjALDsPhaf4kJcRsXKfpHznqLoz7QgOzz4fxnDGHGb/8lW8pjFq5VVTRd
         Wl643StFoWJDhtAc8TOqVMmm2SHHISBeIRv+U5pUpFfoRFT8UCoM+uGY+wxjc4fnFq
         oVyLFvml8WCJtOBRL2eS/G4WU0MRCKVBHlKK5p3U=
Date:   Thu, 4 Nov 2021 14:15:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 5.16-rc1
Message-ID: <YYPc/XfSYP1n5UbV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.16-rc1

for you to fetch changes up to cc8d7b4aea79df7cb45b74f9bc5b8a8bd2ed4c07:

  tty: Fix extra "not" in TTY_DRIVER_REAL_RAW description (2021-10-30 11:02:00 +0200)

----------------------------------------------------------------
TTY / Serial driver update for 5.16-rc1

Here is the big set of tty and serial driver updates for 5.16-rc1.

Nothing major in here at all, just lots of tiny serial and tty driver
updates for various reported things, and some good cleanups.  These
include:
	- more good tty api cleanups from Jiri
	- stm32 serial driver updates
	- softlockup fix for non-preempt systems under high serial load
	- rpmsg serial driver update
	- 8250 drivers updates and fixes
	- n_gsm line discipline fixes and updates as people are finally
	  starting to use it.

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aman Kumar (1):
      serial: 8250_lpss: Enable PSE UART Auto Flow Control

Andreas Kemnade (1):
      dt-bindings: serial: 8250_omap: allow serdev subnodes

Andy Shevchenko (14):
      serial: 8250_dw: Drop wrong use of ACPI_PTR()
      serial: 8250_dw: Re-use temporary variable for of_node
      serial: 8250_dw: Fix the trivial typo in the comment
      serial: 8250_lpss: Extract dw8250_do_set_termios() for common use
      serial: 8250_pci: Refactor the loop in pci_ite887x_init()
      serial: 8250_pci: Get rid of redundant 'else' keyword
      serial: 8250_pci: Replace dev_*() by pci_*() macros
      serial: 8250_pci: Replace custom pci_match_id() implementation
      serial: 8250_pci: Remove empty stub pci_quatech_exit()
      tty: rpmsg: Assign returned id to a local variable
      tty: rpmsg: Unify variable used to keep an error code
      tty: rpmsg: Use dev_err_probe() in ->probe()
      tty: rpmsg: Add pr_fmt() to prefix messages
      tty: rpmsg: Define tty name via constant string literal

Anssi Hannula (2):
      serial: xilinx_uartps: Fix race condition causing stuck TX
      tty: Fix extra "not" in TTY_DRIVER_REAL_RAW description

Arnaud Pouliquen (2):
      rpmsg: core: add API to get MTU
      tty: add rpmsg driver

Chunyan Zhang (1):
      dt-bindings: serial: Add a new compatible string for UMS512

Claudiu Beznea (1):
      tty: serial: atmel: use macros instead of hardcoded values

Colin Ian King (1):
      serial: sifive: set pointer to NULL rather than 0.

Dan Carpenter (1):
      tty: n_gsm: clean up indenting in gsm_queue()

David Heidelberg (1):
      dt-bindings: serial: uartlite: drop $ref for -bits property

Erwan Le Ray (6):
      serial: stm32: re-introduce an irq flag condition in usart_receive_chars
      serial: stm32: rework RX over DMA
      serial: stm32: update throttle and unthrottle ops for dma mode
      serial: stm32: rework RX dma initialization and release
      serial: stm32: terminate / restart DMA transfer at suspend / resume
      serial: stm32: push DMA RX data before suspending

Francesco Dolcini (1):
      serial: imx: disable console clocks on unregister

Geert Uytterhoeven (4):
      serial: 8250_fsl: Move fsl8250_data to ACPI section
      serial: 8250: SERIAL_8250_EM should depend on ARCH_RENESAS
      serial: sunzilog: Mark sunzilog_putchar() __maybe_unused
      serial: cpm_uart: Protect udbg definitions by CONFIG_SERIAL_CPM_CONSOLE

Greg Kroah-Hartman (4):
      Merge 5.15-rc3 into tty-next
      Merge 5.15-rc6 into tty-next
      Revert "virtio-console: remove unnecessary kmemdup()"
      Revert "tty: hvc: pass DMA capable memory to put_chars()"

Guanghui Feng (1):
      tty: tty_buffer: Fix the softlockup issue in flush_to_ldisc

Jiri Slaby (14):
      tty: moxa: merge moxa.h into moxa.c
      tty: unexport tty_ldisc_release
      tty: remove flags from struct tty_ldisc_ops
      tty: remove extern from functions in tty headers
      tty: make tty_ldisc_ops::hangup return void
      tty: remove file from tty_mode_ioctl
      tty: remove file from n_tty_ioctl_helper
      mxser: restore baud rate if its setting fails
      mxser: simplify condition in mxser_receive_chars_new
      mxser: make mxser_port::ldisc_stop_rx a bool
      mxser: simplify FCR computation in mxser_change_speed()
      mxser: move FIFO clearing to mxser_disable_and_clear_FIFO()
      mxser: don't read from UART_FCR
      mxser: store FCR state in mxser_port::FCR

Johan Hovold (4):
      Revert "serial: 8250: Fix reporting real baudrate value in c_ospeed field"
      serial: 8250: fix racy uartclk update
      serial: 8250: rename unlock labels
      serial: 8250_dw: drop bogus uartclk optimisation

Krzysztof Kozlowski (2):
      serial: 8250: remove duplicated BRI0A49 and BDP3336 entries
      tty: serial: samsung: describe driver in KConfig

Len Baker (1):
      serial: 8250_pci: Prefer struct_size over open coded arithmetic

Oskari Pirhonen (1):
      tty/sysrq: More intuitive Shift handling

Pali Rohár (3):
      tty: baudrate: Explicit usage of B0 for encoding input baudrate
      serial: core: Fix initializing and restoring termios speed
      serial: 8250: Fix reporting real baudrate value in c_ospeed field

Rafał Miłecki (1):
      dt-bindings: serial: brcm,bcm6345-uart: convert to the json-schema

Sam Protsenko (2):
      dt-bindings: serial: samsung: Add Exynos850 doc
      tty: serial: samsung: Improve naming for common macro

Sean Anderson (4):
      dt-bindings: serial: uartlite: Convert to json-schema
      dt-bindings: serial: uartlite: Add properties for synthesis-time parameters
      sh: j2: Update uartlite binding with data and parity properties
      tty: serial: uartlite: Prevent changing fixed parameters

Stefan Agner (1):
      serial: imx: fix detach/attach of serial console

Tony Lindgren (1):
      tty: n_gsm: Don't ignore write return value in gsmld_output()

Uwe Kleine-König (2):
      serial: max310x: Make max310x_remove() return void
      serial: sc16is7xx: Make sc16is7xx_remove() return void

Xianting Tian (3):
      tty: hvc: use correct dma alignment size
      tty: hvc: pass DMA capable memory to put_chars()
      virtio-console: remove unnecessary kmemdup()

Zhenguo Zhao (8):
      tty: n_gsm: Add some instructions and code for requester
      tty: n_gsm: Modify cr bit value when config requester
      tty: n_gsm: Modify CR,PF bit when config requester
      tty: n_gsm: Modify CR,PF bit printk info when config requester
      tty: n_gsm: Delete gsm_disconnect when config requester
      tty: n_gsm: Delete gsmtty open SABM frame when config requester
      tty: n_gsm: Modify gsmtty driver register method when config requester
      tty: n_gsm: Save dlci address open status when config requester

 .../devicetree/bindings/serial/8250_omap.yaml      |   2 +-
 .../bindings/serial/brcm,bcm6345-uart.txt          |  36 --
 .../bindings/serial/brcm,bcm6345-uart.yaml         |  47 +++
 .../devicetree/bindings/serial/samsung_uart.yaml   |   1 +
 .../devicetree/bindings/serial/sprd-uart.yaml      |   1 +
 .../bindings/serial/xlnx,opb-uartlite.txt          |  23 --
 .../bindings/serial/xlnx,opb-uartlite.yaml         |  89 +++++
 Documentation/driver-api/serial/n_gsm.rst          |  71 +++-
 Documentation/driver-api/serial/tty.rst            |   2 +-
 arch/sh/boot/dts/j2_mimas_v2.dts                   |   2 +
 drivers/bluetooth/hci_ldisc.c                      |   2 +-
 drivers/input/serio/serport.c                      |   3 +-
 drivers/net/can/slcan.c                            |   5 +-
 drivers/net/hamradio/6pack.c                       |   2 +-
 drivers/net/ppp/ppp_async.c                        |   7 +-
 drivers/net/ppp/ppp_synctty.c                      |   7 +-
 drivers/net/slip/slip.c                            |   5 +-
 drivers/rpmsg/rpmsg_core.c                         |  21 ++
 drivers/rpmsg/rpmsg_internal.h                     |   2 +
 drivers/rpmsg/virtio_rpmsg_bus.c                   |  10 +
 drivers/tty/Kconfig                                |  12 +
 drivers/tty/Makefile                               |   1 +
 drivers/tty/hvc/hvc_console.c                      |   2 +-
 drivers/tty/moxa.c                                 | 302 +++++++++++++++-
 drivers/tty/moxa.h                                 | 307 ----------------
 drivers/tty/mxser.c                                | 119 +++----
 drivers/tty/n_gsm.c                                | 116 ++++--
 drivers/tty/n_hdlc.c                               |   2 +-
 drivers/tty/n_tty.c                                |   3 +-
 drivers/tty/rpmsg_tty.c                            | 275 +++++++++++++++
 drivers/tty/serial/8250/8250_dw.c                  |  28 +-
 drivers/tty/serial/8250/8250_dwlib.c               |  10 +
 drivers/tty/serial/8250/8250_dwlib.h               |   1 +
 drivers/tty/serial/8250/8250_fsl.c                 |   8 +-
 drivers/tty/serial/8250/8250_lpss.c                |   9 +-
 drivers/tty/serial/8250/8250_pci.c                 | 143 +++-----
 drivers/tty/serial/8250/8250_pnp.c                 |   4 -
 drivers/tty/serial/8250/8250_port.c                |  31 +-
 drivers/tty/serial/8250/Kconfig                    |   2 +-
 drivers/tty/serial/Kconfig                         |   9 +-
 drivers/tty/serial/atmel_serial.c                  |   4 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   2 +
 drivers/tty/serial/imx.c                           |  16 +-
 drivers/tty/serial/max310x.c                       |   7 +-
 drivers/tty/serial/samsung_tty.c                   |  13 +-
 drivers/tty/serial/sc16is7xx.c                     |  12 +-
 drivers/tty/serial/serial_core.c                   |  16 +-
 drivers/tty/serial/sifive.c                        |   2 +-
 drivers/tty/serial/stm32-usart.c                   | 388 ++++++++++++++++-----
 drivers/tty/serial/stm32-usart.h                   |  13 +-
 drivers/tty/serial/sunzilog.c                      |   2 +-
 drivers/tty/serial/uartlite.c                      |  91 ++++-
 drivers/tty/serial/xilinx_uartps.c                 |   3 +-
 drivers/tty/sysrq.c                                |   2 +
 drivers/tty/tty_baudrate.c                         |   2 +-
 drivers/tty/tty_buffer.c                           |   3 +
 drivers/tty/tty_ioctl.c                            |  12 +-
 include/linux/console.h                            |   2 +
 include/linux/rpmsg.h                              |  10 +
 include/linux/tty.h                                | 140 ++++----
 include/linux/tty_driver.h                         |  10 +-
 include/linux/tty_flip.h                           |  20 +-
 include/linux/tty_ldisc.h                          |  27 +-
 net/nfc/nci/uart.c                                 |   2 +-
 sound/soc/codecs/cx20442.c                         |   3 +-
 sound/soc/ti/ams-delta.c                           |   3 +-
 66 files changed, 1667 insertions(+), 860 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.txt
 create mode 100644 Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
 delete mode 100644 drivers/tty/moxa.h
 create mode 100644 drivers/tty/rpmsg_tty.c
