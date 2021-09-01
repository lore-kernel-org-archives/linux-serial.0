Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753E8C432BE
	for <linux-serial@archiver.kernel.org>; Wed,  1 Sep 2021 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3F3610A8
	for <linux-serial@archiver.kernel.org>; Wed,  1 Sep 2021 14:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244035AbhIAOSW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Sep 2021 10:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244921AbhIAOSW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Sep 2021 10:18:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA8E161056;
        Wed,  1 Sep 2021 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630505845;
        bh=blHwiSKm1Tp+ace9iDYfBQyQKEfhbLuqsI7ereoh08M=;
        h=Date:From:To:Cc:Subject:From;
        b=gLT7WXbTWLtaHBpWzjnZAAhulKD99+qAXnWf54ZbEWtGVTswdegARIqC96mNXrACg
         M8XnrQY6Dyh5nmTy0/ryvQS4pz4yx2QmSDUwjV5w6OBDP7cEwc/uqHeydOIyM+Vo3o
         mmycS3zrqst68UbziE/KS2nAzvAuD/REnju6UCJw=
Date:   Wed, 1 Sep 2021 16:17:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 5.15-rc1
Message-ID: <YS+Lc/G+7JS4c93M@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.15-rc1

for you to fetch changes up to 2e5f3a69b6fcd52a64ce3d746c6ee8390b6cabe8:

  tty: serial: uartlite: Use read_poll_timeout for a polling loop (2021-08-27 16:34:32 +0200)

----------------------------------------------------------------
TTY / Serial patches for 5.15-rc1

Here is the "big" set of tty/serial driver patches for 5.15-rc1

Nothing major in here at all, just some driver updates and more cleanups
on old tty apis and code that needed it that includes:
	- tty.h cleanup of things that didn't belong in it
	- other tty cleanups by Jiri
	- driver cleanups
	- rs485 support added to amba-pl011 driver
	- dts updates
	- stm32 serial driver updates
	- other minor fixes and driver updates

All have been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Duan (1):
      tty: serial: fsl_lpuart: fix the wrong mapbase value

Andy Shevchenko (5):
      serial: 8250_exar: Add ->unregister_gpio() callback
      serial: 8250_lpss: Enable DMA on Intel Elkhart Lake
      serial: max310x: Use clock-names property matching to recognize EXTCLK
      serdev: Split and export serdev_acpi_get_uart_resource()
      platform/surface: aggregator: Use serdev_acpi_get_uart_resource() helper

Bing Fan (1):
      arm pl011 serial: support multi-irq request

Changbin Du (1):
      tty: replace in_irq() with in_hardirq()

Colin Ian King (3):
      serial: 8250: 8250_omap: make a const array static, makes object smaller
      serial: 8250_bcm7271: use NULL to initialized a null pointer
      tty: serial: Fix spelling mistake "Asychronous" -> "Asynchronous"

Dan Carpenter (2):
      tty: moxa: use semi-colons instead of commas
      mxser: use semi-colons instead of commas

Fugang Duan (3):
      tty: serial: fsl_lpuart: check dma_tx_in_progress in tx dma callback
      tty: serial: fsl_lpuart: enable two stop bits for lpuart32
      tty: serial: fsl_lpuart: do software reset for imx7ulp and imx8qxp

Greg Kroah-Hartman (6):
      serial: 8250_pci: make setup_port() parameters explicitly unsigned
      vt: keyboard: treat kbd_table as an array all the time.
      vt: keyboard.c: make console an unsigned int
      Revert "cx20442: tty_ldisc_ops::write_wakeup is optional"
      Revert "v253_init: eliminate pointer to string"
      Merge 5.14-rc5 into tty-next

Igor Matheus Andrade Torrente (1):
      tty: Fix out-of-bound vmalloc access in imageblit

Jianmin Lv (1):
      serial: 8250_pnp: Support configurable clock frequency

Jiri Slaby (29):
      amiserial: remove unused DBG_CNT
      amiserial: remove serial_* strings
      amiserial: remove stale comment
      amiserial: remove serial_state::xmit_fifo_size
      amiserial: simplify rs_open
      amiserial: use memset to zero serial_state
      amiserial: expand serial_isroot
      amiserial: expand "custom"
      amiserial: pack and sort includes
      amiserial: switch rs_table to a single state
      amiserial: remove unused state from shutdown
      cx20442: tty_ldisc_ops::write_wakeup is optional
      v253_init: eliminate pointer to string
      tty: move tty_driver related prototypes to tty_driver.h
      tty: include kref.h in tty_driver.h
      tty: move ldisc prototypes to tty_ldisc.h
      tty: include list & lockdep from tty_ldisc.h
      tty: move tty_ldisc_receive_buf to tty_flip.h
      tty: move tty_buffer definitions to new tty_buffer.h
      tty: move tty_port to new tty_port.h
      tty: tty_flip.h needs only tty_buffer and tty_port
      xtensa: ISS: don't panic in rs_init
      hvsi: don't panic on tty_register_driver failure
      tty: don't store semi-state into tty drivers
      tty: stop using alloc_tty_driver
      tty: drop alloc_tty_driver
      tty: make tty_set_operations an inline
      tty: drop put_tty_driver
      tty: pdc_cons, free tty_driver upon failure

Johan Hovold (1):
      serial: 8250: extend compile-test coverage

Juergen Gross (1):
      tty: hvc: replace BUG_ON() with negative return value

Lino Sanfilippo (1):
      serial: amba-pl011: add RS485 support

Linus Walleij (1):
      dt-bindings: serial: 8250: Add Exar compatibles

Maciej W. Rozycki (2):
      serial: core: Report magic multiplier extra baud rates
      serial: 8250: Define RX trigger levels for OxSemi 950 devices

Nguyen Dinh Phi (1):
      tty: Fix data race between tiocsti() and flush_to_ldisc()

Nobuhiro Iwamatsu (1):
      dt-bindings: serial: convert Cadence UART bindings to YAML

Qian Cai (1):
      Revert "arm pl011 serial: support multi-irq request"

Sam Protsenko (3):
      tty: serial: samsung: Init USI to keep clocks running
      tty: serial: samsung: Fix driver data macros style
      tty: serial: samsung: Add Exynos850 SoC data

Sam Shih (1):
      dt-bindings: serial: Add compatible for Mediatek MT7986

Sean Anderson (2):
      tty: serial: uartlite: Use constants in early_uartlite_putc
      tty: serial: uartlite: Use read_poll_timeout for a polling loop

Shubhrajyoti Datta (2):
      tty: serial: uartlite: Disable clocks in case of errors
      tty: serial: uartlite: Add runtime pm support

Tamseel Shams (1):
      serial: samsung: use dma_ops of DMA if attached

Tang Bin (7):
      serial: stm32: fix the conditional expression writing
      serial: stm32: use the defined variable to simplify code
      serial: stm32: use devm_platform_get_and_ioremap_resource()
      tty: serial: linflexuart: Remove redundant check to simplify the code
      serial: 8250_ingenic: Use of_device_get_match_data
      serial: tegra: Use of_device_get_match_data
      serial: vt8500: Use of_device_get_match_data

Tony Lindgren (4):
      serial: omap: Disable PM runtime autoidle to remove pm_runtime_irq_safe()
      serial: omap: Only allow if 8250_omap is not selected
      dt-bindings: serial: 8250: Update for standard overrun-throttle property
      serial: 8250_omap: Handle optional overrun-throttle-ms property

Ulrich Hecht (1):
      serial: sh-sci: fix break handling for sysrq

Zheyu Ma (1):
      tty: serial: jsm: hold port lock when reporting modem line changes

 Documentation/devicetree/bindings/serial/8250.yaml |   6 +
 .../devicetree/bindings/serial/8250_omap.yaml      |   1 +
 .../devicetree/bindings/serial/cdns,uart.txt       |  27 --
 .../devicetree/bindings/serial/cdns,uart.yaml      |  66 +++++
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 arch/alpha/kernel/srmcons.c                        |   8 +-
 arch/m68k/emu/nfcon.c                              |  30 +--
 arch/parisc/kernel/pdc_cons.c                      |  34 +--
 arch/um/drivers/line.c                             |  13 +-
 arch/xtensa/platforms/iss/console.c                |  45 ++--
 drivers/char/pcmcia/synclink_cs.c                  |   4 +-
 drivers/char/ttyprintk.c                           |   4 +-
 drivers/ipack/devices/ipoctal.c                    |  13 +-
 drivers/isdn/capi/capi.c                           |  14 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c                   |   8 +-
 drivers/mmc/core/sdio_uart.c                       |  12 +-
 drivers/net/usb/hso.c                              |  12 +-
 drivers/platform/surface/aggregator/core.c         |   9 +-
 drivers/s390/char/con3215.c                        |  11 +-
 drivers/s390/char/sclp_tty.c                       |  15 +-
 drivers/s390/char/sclp_vt220.c                     |   9 +-
 drivers/s390/char/tty3270.c                        |   4 +-
 drivers/staging/fwserial/fwserial.c                |   8 +-
 drivers/staging/gdm724x/gdm_tty.c                  |  13 +-
 drivers/staging/greybus/uart.c                     |   4 +-
 drivers/tty/amiserial.c                            | 278 ++++++++-------------
 drivers/tty/ehv_bytechan.c                         |  34 +--
 drivers/tty/goldfish.c                             |  18 +-
 drivers/tty/hvc/hvc_console.c                      |  10 +-
 drivers/tty/hvc/hvc_xen.c                          |  17 +-
 drivers/tty/hvc/hvcs.c                             |  12 +-
 drivers/tty/hvc/hvsi.c                             |  55 ++--
 drivers/tty/ipwireless/tty.c                       |  12 +-
 drivers/tty/mips_ejtag_fdc.c                       |   2 +-
 drivers/tty/moxa.c                                 |  12 +-
 drivers/tty/mxser.c                                |  24 +-
 drivers/tty/n_gsm.c                                |  13 +-
 drivers/tty/nozomi.c                               |  12 +-
 drivers/tty/serdev/core.c                          |  36 ++-
 drivers/tty/serial/8250/8250_bcm7271.c             |   2 +-
 drivers/tty/serial/8250/8250_exar.c                |  36 ++-
 drivers/tty/serial/8250/8250_ingenic.c             |   6 +-
 drivers/tty/serial/8250/8250_lpss.c                |  10 +
 drivers/tty/serial/8250/8250_omap.c                |  27 +-
 drivers/tty/serial/8250/8250_pci.c                 |   2 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   2 +
 drivers/tty/serial/8250/8250_port.c                |   3 +-
 drivers/tty/serial/8250/Kconfig                    |  10 +-
 drivers/tty/serial/Kconfig                         |   4 +-
 drivers/tty/serial/amba-pl011.c                    | 163 +++++++++++-
 drivers/tty/serial/fsl_linflexuart.c               |   6 +-
 drivers/tty/serial/fsl_lpuart.c                    |  62 ++++-
 drivers/tty/serial/jsm/jsm_neo.c                   |   2 +
 drivers/tty/serial/jsm/jsm_tty.c                   |   3 +
 drivers/tty/serial/kgdb_nmi.c                      |  11 +-
 drivers/tty/serial/max310x.c                       |  15 +-
 drivers/tty/serial/omap-serial.c                   |  75 +-----
 drivers/tty/serial/samsung_tty.c                   |  95 +++++--
 drivers/tty/serial/serial-tegra.c                  |   6 +-
 drivers/tty/serial/serial_core.c                   |  20 +-
 drivers/tty/serial/sh-sci.c                        |   7 +-
 drivers/tty/serial/stm32-usart.c                   |  11 +-
 drivers/tty/serial/uartlite.c                      |  88 +++++--
 drivers/tty/serial/vt8500_serial.c                 |   7 +-
 drivers/tty/synclink_gt.c                          |  12 +-
 drivers/tty/sysrq.c                                |   4 +-
 drivers/tty/tty_io.c                               |  17 +-
 drivers/tty/ttynull.c                              |   4 +-
 drivers/tty/vcc.c                                  |   4 +-
 drivers/tty/vt/keyboard.c                          |  62 ++---
 drivers/tty/vt/vt.c                                |  27 +-
 drivers/usb/class/cdc-acm.c                        |  14 +-
 drivers/usb/gadget/function/u_serial.c             |  36 +--
 drivers/usb/host/xhci-dbgtty.c                     |   4 +-
 drivers/usb/serial/usb-serial.c                    |  13 +-
 include/linux/serdev.h                             |  14 ++
 include/linux/serial_s3c.h                         |   9 +
 include/linux/tty.h                                | 275 +-------------------
 include/linux/tty_buffer.h                         |  59 +++++
 include/linux/tty_driver.h                         |  39 +--
 include/linux/tty_flip.h                           |   8 +-
 include/linux/tty_ldisc.h                          |  17 ++
 include/linux/tty_port.h                           | 208 +++++++++++++++
 include/linux/vt_kern.h                            |  30 +--
 include/uapi/linux/serial_reg.h                    |   1 +
 net/bluetooth/rfcomm/tty.c                         |  12 +-
 86 files changed, 1411 insertions(+), 1037 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.yaml
 create mode 100644 include/linux/tty_buffer.h
 create mode 100644 include/linux/tty_port.h
