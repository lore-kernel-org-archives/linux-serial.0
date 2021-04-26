Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BF5C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08B361263
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhDZMwy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233218AbhDZMww (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:52:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAF0C61289;
        Mon, 26 Apr 2021 12:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619441530;
        bh=IbS90KZeo8HK3HIKu6CCyWwpJ6T+bshv3m/kWIfT8h4=;
        h=Date:From:To:Cc:Subject:From;
        b=crs+0fQDnPofqtuKZXeGPfmJf2FhJ4L1kZvgNqDVHZ5B5OQesIlPylZBofEcFWHCJ
         plYzXYxDAFhhVf2DbsvKoWv+Lvu98/Df2+MpRUkwqj9MDe+Ka1Cm5laVXNQAKGaCLA
         pialnXK3fJmWk/nLpqdkDCg+Tk+2a1RQY96R1Kv0=
Date:   Mon, 26 Apr 2021 14:52:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 5.13-rc1
Message-ID: <YIa3d/xiS/pbBudv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.13-rc1

for you to fetch changes up to 8720037d55dbfa3011b8795ca2187b00bb05ee03:

  serial: extend compile-test coverage (2021-04-22 13:12:13 +0200)

----------------------------------------------------------------
TTY/Serial driver updates for 5.13-rc1

Here is the big set of tty and serial driver updates for 5.13-rc1.

Actually busy this release, with a number of cleanups happening:
	- much needed core tty cleanups by Jiri Slaby
	- removal of unused and orphaned old-style serial drivers.  If
	  anyone shows up with this hardware, it is trivial to restore
	  these but we really do not think they are in use anymore.
	- fixes and cleanups from Johan Hovold on a number of termios
	  setting corner cases that loads of drivers got wrong as well
	  as removing unneeded code due to tty core changes from long
	  ago that were never propagated out to the drivers
	- loads of platform-specific serial port driver updates and
	  fixes
	- coding style cleanups and other small fixes and updates all
	  over the tty/serial tree.

All of these have been in linux-next for a while now with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (2):
      dt-bindings: Add support for the Broadcom UART driver
      serial: 8250: Add new 8250-core based Broadcom STB driver

Alexandre Torgue (1):
      serial: stm32: update wakeup IRQ management

Andy Shevchenko (2):
      vt: keyboard, Fix typo in the doc for vt_get_shift_state()
      tty: pti: Remove Kconfig leftovers

Annaliese McDermond (1):
      sc16is7xx: Defer probe if device read fails

Bhaskar Chowdhury (1):
      tty: vt: Mundane typo fix in the file vt.c

Bixuan Cui (1):
      serial: Add missing MODULE_DEVICE_TABLE

Colin Ian King (1):
      tty: synclink_gt: remove redundant initialization of variable count

Dario Binacchi (2):
      serial: omap: don't disable rs485 if rts gpio is missing
      serial: omap: fix rs485 half-duplex filtering

Erwan Le Ray (20):
      serial: stm32: fix probe and remove order for dma
      serial: stm32: fix startup by enabling usart for reception
      serial: stm32: fix incorrect characters on console
      serial: stm32: fix TX and RX FIFO thresholds
      serial: stm32: fix a deadlock condition with wakeup event
      serial: stm32: fix wake-up flag handling
      serial: stm32: fix a deadlock in set_termios
      serial: stm32: fix tx dma completion, release channel
      serial: stm32: call stm32_transmit_chars locked
      serial: stm32: fix FIFO flush in startup and set_termios
      serial: stm32: add FIFO flush when port is closed
      serial: stm32: fix tx_empty condition
      serial: stm32: add support for "flush_buffer" ops
      serial: stm32: rework wakeup management
      serial: stm32: clean wakeup handling in serial_suspend
      irqchip/stm32: add usart instances exti direct event support
      ARM: dts: stm32: Add wakeup management on stm32mp15x UART nodes
      dt-bindings: serial: add RX and TX FIFO properties
      dt-bindings: serial: stm32: override FIFO threshold properties
      dt-bindings: serial: 8250: update TX FIFO trigger level

Fabrice Gasnier (1):
      serial: stm32: add FIFO threshold configuration

Greg Kroah-Hartman (10):
      tty: serial: pch_uart.c: remove debugfs dentry pointer
      Merge 5.12-rc3 into tty-next
      Merge 5.12-rc6 into tty-next
      tty: create internal tty.h file
      tty: tty.h: remove tty_info()
      tty: audit: move some local functions out of tty.h
      tty: move some internal tty lock enums and functions out of tty.h
      tty: make tty_release_redirect() static
      tty: move some tty-only functions to drivers/tty/tty.h
      tty: clean include/linux/tty.h up

Guobin Huang (1):
      tty: n_gsm: use DEFINE_SPINLOCK() for spinlock

Hector Martin (8):
      tty: serial: samsung_tty: Add ucon_mask parameter
      tty: serial: samsung_tty: Separate S3C64XX ops structure
      tty: serial: samsung_tty: Add s3c24xx_port_type
      tty: serial: samsung_tty: IRQ rework
      tty: serial: samsung_tty: Use devm_ioremap_resource
      dt-bindings: serial: samsung: Add apple,s5l-uart compatible
      tty: serial: samsung_tty: Add support for Apple UARTs
      tty: serial: samsung_tty: Add earlycon support for Apple UARTs

Heikki Krogerus (1):
      serial: 8250_exar: Constify the software nodes

Hillf Danton (1):
      tty: n_gsm: check error while registering tty devices

Jiri Slaby (42):
      MAINTAINERS: orphan mxser
      MAINTAINERS: drop cyclades.com reference
      PCI: remove synclink entries from pci_ids
      vgacon: comment on vga_rolled_over
      tty: cyclades, remove this orphan
      tty: isicom, remove this orphan
      tty: rocket, remove the driver
      tty: remove TTY_LDISC_MAGIC
      tty: n_tty, set tty_ldisc_ops::owner
      tty: imx, use ms_to_ktime
      tty: 8250, use ms_to_ktime
      tty: 8250, cleanup em485 timers
      tty: 8250/serial_cs, propagate errors in simple_config
      net: caif: inline register_ldisc
      net: nfc: nci: remove memset of nci_uart_drivers
      net: nfc: nci: drop nci_uart_ops::recv_buf
      net: nfc: nci: drop nci_uart_default_recv
      tty: con3215, remove tasklet for tty_wakeup
      tty: con3215, remove unneeded tty checks
      tty: con3215, remove tty->driver_data casts
      tty: jsm_tty, make char+error handling readable
      tty: nozomi, remove struct buffer
      tty: nozomi, remove init/exit messages
      tty: nozomi, remove useless debug prints
      tty: vcc, make globals static
      tty: vcc, drop version dump
      tty: vcc, use name strings directly
      tty: vcc, remove useless tty checks
      tty: xtensa/iss, drop serial_version & serial_name
      tty: xtensa/iss, don't reassign to tty->port
      tty: xtensa/iss, remove stale comments
      tty: xtensa/iss, setup the timer statically
      tty: xtensa/iss, make rs_init static
      tty: do not check tty_unregister_driver's return value
      tty: let tty_unregister_driver return void
      tty: localise ptychar and make it const
      tty: synclink_gt, drop unneeded forward declarations
      tty: hvc, drop unneeded forward declarations
      tty: n_gsm, remove duplicates of parameters
      tty: cleanup tty_chars_in_buffer
      tty: make everyone's chars_in_buffer return >= 0
      tty: make everyone's write_room return >= 0

Johan Hovold (56):
      serial: imx: drop workaround for forced irq threading
      staging: fwserial: fix TIOCSSERIAL jiffies conversions
      staging: fwserial: fix TIOCSSERIAL permission check
      staging: fwserial: fix TIOCSSERIAL implementation
      staging: fwserial: fix TIOCGSERIAL implementation
      staging: greybus: uart: fix TIOCSSERIAL jiffies conversions
      staging: greybus: uart: fix unprivileged TIOCCSERIAL
      staging: greybus: uart: clean up TIOCGSERIAL
      tty: amiserial: fix TIOCSSERIAL permission check
      tty: amiserial: add missing TIOCSSERIAL jiffies conversions
      tty: moxa: fix TIOCSSERIAL jiffies conversions
      tty: moxa: fix TIOCSSERIAL permission check
      tty: moxa: fix TIOCSSERIAL implementation
      tty: mxser: fix TIOCSSERIAL jiffies conversions
      tty: mxser: fix TIOCSSERIAL permission check
      pcmcia: synclink_cs: drop redundant tty-port initialisation
      tty: synclink_gt: drop redundant tty-port initialisation
      tty: actually undefine superseded ASYNC flags
      tty: fix return value for unsupported ioctls
      tty: fix return value for unsupported termiox ioctls
      tty: use pr_warn_ratelimited() for deprecated serial flags
      tty: refactor TIOCSSERIAL handling
      tty: add ASYNC_SPLIT_TERMIOS to deprecation mask
      serial: core: drop redundant TIOCGSERIAL memset
      serial: core: return early on unsupported ioctls
      tty: clarify that not all ttys have a class device
      serial: do not restore interrupt state in sysrq helper
      serial: stm32: fix threaded interrupt handling
      serial: stm32: defer sysrq processing
      tty: mxser: drop low-latency workaround
      serial: altera_jtaguart: drop low-latency workaround
      serial: altera_uart: drop low-latency workaround
      serial: amba-pl010: drop low-latency workaround
      serial: amba-pl011: drop low-latency workaround
      serial: apbuart: drop low-latency workaround
      serial: ar933x: drop low-latency workaround
      serial: arc_uart: drop low-latency workaround
      serial: atmel_serial: drop low-latency workaround
      serial: bcm63xx: drop low-latency workaround
      serial: icom: drop low-latency workaround
      serial: lpc32xx_hs: drop low-latency workaround
      serial: mcf: drop low-latency workaround
      serial: meson: drop low-latency workaround
      serial: mpc52xx_uart: drop low-latency workaround
      serial: msm_serial: drop low-latency workaround
      serial: owl: drop low-latency workaround
      serial: rda: drop low-latency workaround
      serial: rp2: drop low-latency workaround
      serial: sa1100: drop low-latency workaround
      serial: txx9: drop low-latency workaround
      serial: sifive: drop low-latency workaround
      serial: sunsu: drop low-latency workaround
      serial: timbuart: drop low-latency workaround
      serial: vt8500: drop low-latency workaround
      serial: xilinx_uartps: drop low-latency workaround
      serial: extend compile-test coverage

Jonathan Neuschäfer (2):
      dt-bindings: serial: 8250: Add nuvoton,wpcm450-uart
      serial: 8250_of: Add nuvoton,wpcm450-uart

Julian Braha (1):
      drivers: tty: serial: IMX_EARLYCON: fix Kconfig dependency on SERIAL_CORE

Krzysztof Kozlowski (3):
      dt-bindings: serial: samsung: add DMA properties
      tty: serial: samsung_tty: remove spinlock flags in interrupt handlers
      dt-bindings: serial: samsung: include generic dtschema to match bluetooth child

Martin Devera (2):
      dt-bindings: serial: Add rx-tx-swap to stm32-usart
      tty/serial: Add rx-tx-swap OF option to stm32-usart

Pavel Skripkin (1):
      tty: fix memory leak in vc_deallocate

Seiya Wang (1):
      dt-bindings: serial: Add compatible for Mediatek MT8195

Stephen Kitt (1):
      vgacon: drop unused vga_init_done

Tetsuo Handa (1):
      ttyprintk: Add TTY hangup callback.

Ulrich Hecht (1):
      serial: sh-sci: remove obsolete latency workaround

Wang Qing (2):
      tty: serial: 8250: delete redundant printing of return value
      drivers: tty: serial: sh-sci: fix spelling typo of 'wheter'

Wei Yongjun (3):
      serial: liteuart: fix return value check in liteuart_probe()
      serial: pch_uart: fix build error with !CONFIG_DEBUG_FS
      serial: 8250_bcm7271: Fix return value check in brcmuart_probe()

Xiaofei Tan (11):
      tty: pty: Add a blank line after declarations
      tty/sysrq: Add a blank line after declarations
      tty/sysrq: Fix issues of code indent should use tabs
      tty: tty_jobctrl: Add a blank line after declarations
      tty: tty_jobctrl: Fix coding style issues of block comments
      tty: tty_jobctrl: Remove spaces before tabs
      tty: tty_ldisc: Fix an issue of code indent should use tabs
      tty: tty_ldisc: Add a blank line after declarations
      tty: tty_ldisc: Fix coding style issues of block comments
      tty: tty_ldisc: Do not use assignment in if condition
      tty: tty_ldisc: Remove the repeated word 'the'

Yu Kuai (1):
      tty: hvc: make symbol 'hvc_udbg_dev' static

Zev Weiss (4):
      dt-bindings: serial: 8250: deprecate aspeed, sirq-polarity-sense
      serial: 8250_aspeed_vuart: refactor sirq and lpc address setting code
      serial: 8250_aspeed_vuart: add aspeed, lpc-io-reg and aspeed, lpc-interrupts DT properties
      dt-bindings: serial: 8250: add aspeed, lpc-io-reg and aspeed, lpc-interrupts

Zucheng Zheng (1):
      serial: 8250: Make symbol 'brcmuart_debugfs_root' static

dillon min (1):
      dt-bindings: serial: stm32: Use 'type: object' instead of false for 'additionalProperties'

kernel test robot (1):
      tty: max310x: fix flexible_array.cocci warnings

 Documentation/admin-guide/devices.txt              |   12 +-
 Documentation/devicetree/bindings/serial/8250.yaml |   30 +-
 .../bindings/serial/brcm,bcm7271-uart.yaml         |   95 +
 .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   18 +-
 .../devicetree/bindings/serial/serial.yaml         |   10 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   59 +-
 Documentation/driver-api/serial/cyclades_z.rst     |   11 -
 Documentation/driver-api/serial/index.rst          |    1 -
 Documentation/driver-api/serial/rocket.rst         |  185 -
 Documentation/process/magic-number.rst             |    4 -
 .../translations/it_IT/process/magic-number.rst    |    4 -
 .../translations/zh_CN/process/magic-number.rst    |    4 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |   30 +-
 arch/arm/boot/dts/stm32mp151.dtsi                  |   24 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/xtensa/platforms/iss/console.c                |   45 +-
 drivers/accessibility/speakup/spk_ttyio.c          |    1 -
 drivers/bluetooth/hci_ldisc.c                      |    1 -
 drivers/char/pcmcia/synclink_cs.c                  |    2 -
 drivers/char/ttyprintk.c                           |   11 +
 drivers/irqchip/irq-stm32-exti.c                   |    7 +
 drivers/misc/ti-st/st_core.c                       |    1 -
 drivers/net/caif/caif_serial.c                     |   18 +-
 drivers/net/can/slcan.c                            |    1 -
 drivers/net/hamradio/6pack.c                       |    1 -
 drivers/net/hamradio/mkiss.c                       |    1 -
 drivers/net/ppp/ppp_async.c                        |    1 -
 drivers/net/ppp/ppp_synctty.c                      |    1 -
 drivers/net/slip/slip.c                            |    1 -
 drivers/pps/clients/pps-ldisc.c                    |    3 -
 drivers/s390/char/con3215.c                        |   56 +-
 drivers/staging/fwserial/fwserial.c                |   19 +-
 drivers/staging/gdm724x/gdm_tty.c                  |    2 +-
 drivers/staging/greybus/uart.c                     |   16 +-
 drivers/tty/Kconfig                                |   86 +-
 drivers/tty/Makefile                               |    3 -
 drivers/tty/amiserial.c                            |   33 +-
 drivers/tty/cyclades.c                             | 4119 --------------------
 drivers/tty/hvc/hvc_udbg.c                         |    2 +-
 drivers/tty/hvc/hvcs.c                             |   24 -
 drivers/tty/ipwireless/tty.c                       |   11 +-
 drivers/tty/isicom.c                               | 1699 --------
 drivers/tty/moxa.c                                 |   25 +-
 drivers/tty/mxser.c                                |   38 +-
 drivers/tty/n_gsm.c                                |   37 +-
 drivers/tty/n_hdlc.c                               |    2 +-
 drivers/tty/n_null.c                               |    1 -
 drivers/tty/n_r3964.c                              |    1 -
 drivers/tty/n_tty.c                                |    3 +-
 drivers/tty/nozomi.c                               |   26 +-
 drivers/tty/pty.c                                  |    5 +
 drivers/tty/rocket.c                               | 3127 ---------------
 drivers/tty/rocket.h                               |  111 -
 drivers/tty/rocket_int.h                           | 1214 ------
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |  107 +-
 drivers/tty/serial/8250/8250_bcm7271.c             | 1202 ++++++
 drivers/tty/serial/8250/8250_exar.c                |   17 +-
 drivers/tty/serial/8250/8250_fsl.c                 |   16 +-
 drivers/tty/serial/8250/8250_of.c                  |    1 +
 drivers/tty/serial/8250/8250_omap.c                |    6 +-
 drivers/tty/serial/8250/8250_port.c                |   30 +-
 drivers/tty/serial/8250/Kconfig                    |   21 +-
 drivers/tty/serial/8250/Makefile                   |    1 +
 drivers/tty/serial/8250/serial_cs.c                |   12 +-
 drivers/tty/serial/Kconfig                         |   21 +-
 drivers/tty/serial/altera_jtaguart.c               |    2 -
 drivers/tty/serial/altera_uart.c                   |    2 -
 drivers/tty/serial/amba-pl010.c                    |    2 -
 drivers/tty/serial/amba-pl011.c                    |    2 -
 drivers/tty/serial/apbuart.c                       |    2 -
 drivers/tty/serial/ar933x_uart.c                   |    2 -
 drivers/tty/serial/arc_uart.c                      |    2 -
 drivers/tty/serial/atmel_serial.c                  |   18 -
 drivers/tty/serial/bcm63xx_uart.c                  |    2 -
 drivers/tty/serial/icom.c                          |    2 -
 drivers/tty/serial/imx.c                           |   16 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |   24 +-
 drivers/tty/serial/kgdb_nmi.c                      |    4 +-
 drivers/tty/serial/liteuart.c                      |    4 +-
 drivers/tty/serial/lpc32xx_hs.c                    |    2 -
 drivers/tty/serial/max310x.c                       |    2 +-
 drivers/tty/serial/mcf.c                           |    2 -
 drivers/tty/serial/meson_uart.c                    |    2 -
 drivers/tty/serial/mpc52xx_uart.c                  |    2 -
 drivers/tty/serial/msm_serial.c                    |    4 -
 drivers/tty/serial/omap-serial.c                   |   51 +-
 drivers/tty/serial/owl-uart.c                      |    2 -
 drivers/tty/serial/pch_uart.c                      |   22 +-
 drivers/tty/serial/qcom_geni_serial.c              |    6 +-
 drivers/tty/serial/rda-uart.c                      |    2 -
 drivers/tty/serial/rp2.c                           |    2 -
 drivers/tty/serial/sa1100.c                        |    2 -
 drivers/tty/serial/samsung_tty.c                   |  507 ++-
 drivers/tty/serial/sc16is7xx.c                     |    2 +-
 drivers/tty/serial/serial_core.c                   |    8 +-
 drivers/tty/serial/serial_txx9.c                   |    4 +-
 drivers/tty/serial/sh-sci.c                        |   15 +-
 drivers/tty/serial/sifive.c                        |    2 -
 drivers/tty/serial/stm32-usart.c                   |  310 +-
 drivers/tty/serial/stm32-usart.h                   |   17 +-
 drivers/tty/serial/sunsu.c                         |    4 -
 drivers/tty/serial/tegra-tcu.c                     |    1 +
 drivers/tty/serial/timbuart.c                      |    2 -
 drivers/tty/serial/vt8500_serial.c                 |    2 -
 drivers/tty/serial/xilinx_uartps.c                 |    3 +-
 drivers/tty/synclink_gt.c                          |   66 +-
 drivers/tty/sysrq.c                                |   35 +-
 drivers/tty/tty.h                                  |  114 +
 drivers/tty/tty_audit.c                            |    1 +
 drivers/tty/tty_baudrate.c                         |    1 +
 drivers/tty/tty_buffer.c                           |    2 +-
 drivers/tty/tty_io.c                               |   69 +-
 drivers/tty/tty_ioctl.c                            |    8 +-
 drivers/tty/tty_jobctrl.c                          |   30 +-
 drivers/tty/tty_ldisc.c                            |   42 +-
 drivers/tty/tty_mutex.c                            |    1 +
 drivers/tty/tty_port.c                             |    1 +
 drivers/tty/vcc.c                                  |   72 +-
 drivers/tty/vt/keyboard.c                          |    2 +-
 drivers/tty/vt/vt.c                                |    3 +-
 drivers/usb/serial/mos7720.c                       |    2 +-
 drivers/video/console/vgacon.c                     |    5 +-
 include/linux/cyclades.h                           |  364 --
 include/linux/isicom.h                             |   85 -
 include/linux/pci_ids.h                            |   31 -
 include/linux/serial_core.h                        |   10 +-
 include/linux/serial_s3c.h                         |   16 +
 include/linux/tty.h                                |  103 +-
 include/linux/tty_driver.h                         |    2 +-
 include/linux/tty_ldisc.h                          |    3 -
 include/net/nfc/nci_core.h                         |    2 -
 include/uapi/linux/cyclades.h                      |  494 ---
 include/uapi/linux/major.h                         |    2 -
 include/uapi/linux/serial.h                        |    4 +-
 include/uapi/linux/tty_flags.h                     |    8 +-
 net/nfc/nci/uart.c                                 |  148 +-
 sound/soc/codecs/cx20442.c                         |    1 -
 sound/soc/ti/ams-delta.c                           |    1 -
 140 files changed, 2737 insertions(+), 12732 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 delete mode 100644 Documentation/driver-api/serial/cyclades_z.rst
 delete mode 100644 Documentation/driver-api/serial/rocket.rst
 delete mode 100644 drivers/tty/cyclades.c
 delete mode 100644 drivers/tty/isicom.c
 delete mode 100644 drivers/tty/rocket.c
 delete mode 100644 drivers/tty/rocket.h
 delete mode 100644 drivers/tty/rocket_int.h
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
 create mode 100644 drivers/tty/tty.h
 delete mode 100644 include/linux/cyclades.h
 delete mode 100644 include/linux/isicom.h
 delete mode 100644 include/uapi/linux/cyclades.h
