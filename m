From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.16-rc1
Date: Thu, 1 Feb 2018 12:07:35 +0100
Message-ID: <20180201110735.GA28809@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 30a7acd573899fd8b8ac39236eff6468b195ac7d:

  Linux 4.15-rc6 (2017-12-31 14:47:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.16-rc1

for you to fetch changes up to c7e1b4059075c9e8eed101d7cc5da43e95eb5e18:

  tty: serial: exar: Relocate sleep wake-up handling (2018-01-25 12:44:50 +0100)

----------------------------------------------------------------
TTY/Staging driver updates for 4.16-rc1

Here is the big tty/serial driver update for 4.16-rc1.

The usual number of various serial driver fixes and updates to try to
get them to work with crazy hardware configurations (seriously, how many
different ways are hardware engineers going to come up with to hook up a
simple UART?)

There is also some serdev bugfixes and updates, as well as a smattering
of other small fixes in here.

All have been in the linux-next tree for a while, with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Sierra (1):
      tty: serial: exar: Relocate sleep wake-up handling

Andrey Smirnov (2):
      serdev: Make .remove in struct serdev_device_driver optional
      serdev: Introduce devm_serdev_device_open()

Andy Shevchenko (2):
      MAINTAINERS: Add myself as designated reviewer for 8250_dw
      serial: 8250_dw: Revert "Improve clock rate setting"

Branislav Radocaj (1):
      tty: serial: mxs-auart: fix error handling in mxs_auart_probe

Christian Borntraeger (1):
      serial: forbid 8250 on s390

Colin Ian King (1):
      tty: n_gsm: remove redundant pointer gsm

Fabio Estevam (2):
      dt-bindings: serial: fsl-imx-uart: Remove 'fsl,irda-mode' property
      serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Gaurav Kohli (1):
      tty: fix data race between tty_init_dev and flush of buf

Geert Uytterhoeven (5):
      tty: serial: sh-sci: Hide number of ports config question
      tty: serial: sh-sci: Hide serial console config question
      tty: serial: sh-sci: Hide earlycon config question
      tty: serial: sh-sci: Hide DMA config question
      tty: serial: sh-sci: Add default for number of ports for compile-testing

Greg Kroah-Hartman (2):
      Merge 4.15-rc3 into tty-next
      Merge 4.15-rc6 into tty-next

Guilherme G. Piccoli (2):
      tty: serial: jsm: Remove unnecessary NULL checks
      tty: serial: jsm: Add one check against NULL pointer dereference

Gustavo A. R. Silva (1):
      tty: vt: replace _manual_ swap with swap macro in set_selection

Hans de Goede (1):
      serdev: Fix serdev_uevent failure on ACPI enumerated serdev-controllers

Jan Kundrát (9):
      serial: max310x: Fix invalid memory access during GPIO init
      serial: max310x: Do not hard-code the IRQ type
      serial: max310x: Use level-triggered interrupts
      serial: max310x: Support IRQ sharing with other devices
      serial: max310x: Document clock setup
      serial: max310x: use a batch write op for UART transmit
      serial: max310x: Use batched reads when reasonably safe
      serial: max310x: Reduce RX work starvation
      gpio: serial: max310x: Support open-drain configuration for GPIOs

Jia-Ju Bai (1):
      tty/isicom: Fix a possible sleep-in-atomic bug in WaitTillCardIsFree

Johan Hovold (6):
      serdev: document driver callbacks
      serdev: ttyport: release tty lock sooner on open
      serdev: ttyport: ignore carrier detect to avoid hangups
      serdev: ttyport: do not used keyed wakeup in write_wakeup
      serdev: do not generate modaliases for controllers
      serdev: only match serdev devices

Lars Kanis (1):
      tty: moxa: Add support for CMSPAR

Ludovic Barre (1):
      serial: stm32: fix name conflict with 8250

Lukas Wunner (7):
      serial: pl011: Drop duplicate loop counter
      serial: pl011: Use cached copy of IMSC register
      serial: Make retrieval of rs485 properties platform-agnostic
      dt-bindings: serial: Add common rs485 binding for RTS polarity
      serial: core: Support common rs485 binding for RTS polarity
      serial: fsl_lpuart: Support common rs485 binding for RTS polarity
      serial: imx: Support common rs485 binding for RTS polarity

Martin Blumenstingl (4):
      tty: serial: meson: remove duplicate "clear error" bit definition
      tty: serial: meson: merge the two register sections for AML_UART_CONTROL
      tty: serial: meson: fix typo in the "stop bit" register definition
      nvmem: meson-mx-efuse: fix reading from an offset other than 0

Martin Kaiser (1):
      serial: imx: fix endless loop during suspend

Masahiro Yamada (1):
      serial: 8250_of: fix return code when probe function fails to get reset

Miquel Raynal (1):
      dt-bindings: mvebu-uart: update documentation with extended UART

Paul Cercueil (3):
      serial: core: Make uart_parse_options take const char* argument
      serial: 8250_ingenic: Add support for the JZ4770 SoC
      serial: 8250_ingenic: Parse earlycon options

Rafael Gago (1):
      tty: omap-serial: Fix initial on-boot RTS GPIO level

Rolf Evers-Fischer (1):
      serial: 8250: 8250_omap: Fix spelling error.

Sahara (1):
      pty: cancel pty slave port buf's work in tty_release

Sebastian Andrzej Siewior (2):
      tty: goldfish: Enable 'earlycon' only if built-in
      serial: core: mark port as initialized after successful IRQ change

Stefan Potyra (1):
      serial: 8250_dw: Disable clock on error

Tony Lindgren (1):
      tty: n_gsm: Allow ADM response in addition to UA for control dlci

Troy Kisky (1):
      tty: serial: imx: remove imx_disable_rx_int

Wei Yongjun (1):
      serial: 8250_uniphier: fix error return code in uniphier_uart_probe()

Wolfram Sang (1):
      serial: mxs-auart: don't use GPIOF_* with gpiod_get_direction

 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   4 +-
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   3 +-
 .../devicetree/bindings/serial/ingenic,uart.txt    |   8 +-
 .../devicetree/bindings/serial/maxim,max310x.txt   |  18 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |  50 +++-
 .../devicetree/bindings/serial/omap_serial.txt     |   1 +
 Documentation/devicetree/bindings/serial/rs485.txt |   1 +
 Documentation/driver-model/devres.txt              |   3 +
 MAINTAINERS                                        |   5 +
 drivers/tty/Kconfig                                |   6 +-
 drivers/tty/goldfish.c                             |   2 +
 drivers/tty/isicom.c                               |   6 +-
 drivers/tty/moxa.c                                 |  17 +-
 drivers/tty/moxa.h                                 |   2 +
 drivers/tty/n_gsm.c                                |  19 +-
 drivers/tty/serdev/core.c                          | 106 +++++---
 drivers/tty/serdev/serdev-ttyport.c                |   8 +-
 drivers/tty/serial/8250/8250_dw.c                  |  33 ++-
 drivers/tty/serial/8250/8250_exar.c                |  34 ++-
 drivers/tty/serial/8250/8250_ingenic.c             |  17 +-
 drivers/tty/serial/8250/8250_of.c                  |   5 +-
 drivers/tty/serial/8250/8250_omap.c                |   2 +-
 drivers/tty/serial/8250/8250_port.c                |  26 --
 drivers/tty/serial/8250/8250_uniphier.c            |   5 +-
 drivers/tty/serial/8250/Kconfig                    |   1 +
 drivers/tty/serial/Kconfig                         |  14 +-
 drivers/tty/serial/amba-pl011.c                    |  12 +-
 drivers/tty/serial/atmel_serial.c                  |   2 +-
 drivers/tty/serial/fsl_lpuart.c                    |  15 +-
 drivers/tty/serial/imx.c                           |  93 +++----
 drivers/tty/serial/jsm/jsm_neo.c                   |   6 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |   6 -
 drivers/tty/serial/max310x.c                       | 267 ++++++++++++++-------
 drivers/tty/serial/meson_uart.c                    |  31 ++-
 drivers/tty/serial/mxs-auart.c                     |  11 +-
 drivers/tty/serial/omap-serial.c                   |  18 +-
 drivers/tty/serial/serial_core.c                   |  35 ++-
 drivers/tty/serial/stm32-usart.h                   |   2 +-
 drivers/tty/tty_io.c                               |  10 +-
 drivers/tty/tty_ldisc.c                            |   4 +-
 drivers/tty/vt/selection.c                         |   6 +-
 include/linux/serdev.h                             |   7 +-
 include/linux/serial_core.h                        |   8 +-
 include/linux/tty.h                                |   2 +
 44 files changed, 579 insertions(+), 352 deletions(-)
