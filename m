From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver patches for 4.11-rc1
Date: Wed, 22 Feb 2017 15:56:34 +0100
Message-ID: <20170222145634.GA17381@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.11-rc1

for you to fetch changes up to d8a4995bcea168dfac8ee41c28c79109907e4fba:

  tty: pl011: Work around QDF2400 E44 stuck BUSY bit (2017-02-15 14:46:43 -0800)

----------------------------------------------------------------
TTY/Serial driver patches for 4.11-rc1

Here is the big tty/serial driver patchset for 4.11-rc1.

Not much here, but a lot of little fixes and individual serial driver
updates all over the subsystem.  Majority are for the sh-sci driver and
platform (the arch-specific changes have acks from the maintainer).

The start of the "serial bus" code is here as well, but nothing is
converted to use it yet.  That work is still ongoing, hopefully will
start to show up across different subsystems for 4.12 (bluetooth is one
major place that will be used.)

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Cox (1):
      tty_port: allow a port to be opened with a tty that has no file handle

Alexander Shiyan (1):
      serial: max310x: Add support for newer silicon revisions

Alexander Sverdlin (1):
      serial: pl011: Mark console as CON_ANYTIME

Alexandre Belloni (1):
      tty/serial: atmel: ensure state is restored after suspending

Alexey Brodkin (1):
      serial: 8250_port: Remove dangerous pr_debug()

Andy Shevchenko (4):
      serial: 8250_lpss: avoid potential kernel crash when remove
      serial: 8250_mid: handle interrupt correctly in DMA case
      serial: 8250_mid: enable MSI on Denverton
      serial: 8250_mid: set PCI master only for DMA capable device

Arnd Bergmann (1):
      8250: of: remove remnants of generic of_serial driver

Arvind Yadav (1):
      tty: serial: 8250: 8250_gsc:- Handle return NULL error from ioremap_nocache

Bhumika Goyal (2):
      tty: serial: constify dev_pm_ops structures
      tty: serial: constify uart_ops structures

Christophe JAILLET (2):
      serial: pic32_uart: Fix 'request_irq' and 'free_irq' inconsistancy
      tty: goldfish: Fix a parameter of a call to free_irq

Christopher Covington (1):
      tty: pl011: Work around QDF2400 E44 stuck BUSY bit

Dan Carpenter (1):
      serdev: ttyport: check whether tty_init_dev() fails

David Lechner (2):
      doc: DT: Add ti,da830-uart to serial/8250 bindings
      serial: 8250: Add new port type for TI DA8xx/66AK2x

Dmitry Torokhov (1):
      tty: serial: cpm_uart: make use of for_each_node_by_type()

Douglas Anderson (1):
      serial: 8250_dw: Avoid "too much work" from bogus rx timeout interrupt

Fabio Estevam (3):
      serial: imx: Allow passing 'rst-gpios' for rs485 mode
      serial: imx: Fix the RTS GPIO polarity in RS485 mode
      serial: imx: Fix the CTS_B polarity in RS485 mode

Felix Fietkau (1):
      serial: do not accept sysrq characters via serial port

Geert Uytterhoeven (1):
      serial: sh-sci: Reformat sci_parse_dt() for git diff

Greg Kroah-Hartman (1):
      Merge 4.10-rc4 into tty-next

Ian Abbott (1):
      serial: 8250_pci: Add MKS Tenta SCOM-0800 and SCOM-0801 cards

Jan Kiszka (7):
      serial: exar: Fix mapping of port I/O resources
      serial: exar: Fix initialization of EXAR registers for ports > 0
      serial: exar: Fix feature control register constants
      serial: exar: Move Commtech adapters to 8250_exar as well
      serial: pci: Remove unused pci_boards entries
      serial: exar: Move register defines from uapi header to consumer site
      serial: exar: Enable MSI support

Jason Uy (1):
      serial: 8250_dw: Allow hardware flow control to be used

Javier Martinez Canillas (1):
      tty: serial: msm: Fix module autoload

Jean Delvare (3):
      serial: 8250_pci: make option visible
      serial: 8250_lpss: make option visible
      serial: 8250_mid: make option visible

Ji-Ze Hong (Peter Hong) (1):
      serial: 8250_fintek: Add resource check for Fintek F81504/508/512

John Crispin (1):
      tty: update my email address

Laurent Pinchart (18):
      serial: sh-sci: Set the SCSCR TE and RE bits in the driver
      serial: sh-sci: Don't rely on platform data flags when not needed
      sh: Don't set sh-sci pdata scscr TE and RE bits
      sh: Don't set sh-sci pdata scscr TIE and RIE bits
      sh: sh726[49]: Don't set sh-sci pdata scscr TOIE bit
      sh: Don't set the sh-sci pdata UPF_BOOT_AUTOCONF flags
      sh: Don't set sh-sci port_reg
      sh: Don't set the sh-sci platform data scscr CKE0 bit
      sh: Don't set the sh-sci platform data REIE bit when not implemented
      serial: sh-sci: Fix register offsets for the IRDA serial port
      serial: sh-sci: Remove initialization of zero fields in sci_port_params
      serial: sh-sci: Replace regmap array with port parameters
      serial: sh-sci: Constify platform data
      serial: sh-sci: Extend sci_port_params with more port parameters
      serial: sh-sci: Remove the platform data dma slave rx/tx channel IDs
      serial: sh-sci: Remove manual break debouncing
      serial: sh-sci: Remove unused platform data capabilities field
      serial: sh-sci: Compute the regshift value for SCI ports

Lee Jones (10):
      serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
      serial: st-asc: Provide RTS functionality
      serial: st-asc: Read in all Pinctrl states
      serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
      serial: st-asc: Use generic DT binding for announcing RTS/CTS lines
      dt-bindings: serial: Update 'uart-has-rtscts' description
      ARM: dts: STiH410-b2260: Identify the UART RTS line
      ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
      ARM: dts: STiH407-family: Use new Pinctrl groups
      ARM: dts: STiH410-b2260: Enable HW flow-control

Lokesh Vutla (1):
      serial: omap: Add omapserial earlycon

Manuel Schölling (4):
      console: Move scrollback data into its own struct
      console: Add callback to flush scrollback buffer to consw struct
      console: Add persistent scrollback buffers for all VGA consoles
      console: Make persistent scrollback a boot parameter

Marek Szyprowski (1):
      serial: samsung: Simplify DMA engine initialization code

Martin Blumenstingl (2):
      tty: serial: lantiq: implement earlycon support
      tty: serial: meson: allow baud-rates higher than 115200

Matwey V. Kornilov (1):
      serial: 8250: moxa: Store num_ports in brd

Nikita Yushchenko (1):
      tty: serial: fsl_lpuart: fix del_timer_sync() vs timer routine deadlock

Pan Bian (1):
      tty: serial: sh-sci: set error code when kasprintf fails

Paul Gortmaker (1):
      serial: hp300: mask the warning for people just doing build coverage

Rob Herring (8):
      tty: move the non-file related parts of tty_release to new tty_release_struct
      tty_port: make tty_port_register_device wrap tty_port_register_device_attr
      tty: constify tty_ldisc_receive_buf buffer pointer
      tty_port: Add port client functions
      dt/bindings: Add a serial/UART attached device binding
      serdev: Introduce new bus for serial attached devices
      serdev: add a tty port controller driver
      tty_port: register tty ports with serdev bus

Romain Izard (1):
      atmel_serial: Use the fractional divider when possible

Sergio Valverde (1):
      tty: Remove extra include in HVC console tty framework

Sudeep Holla (1):
      tty: serial: pl011: add ttyAMA for matching pl011 console

Sudip Mukherjee (2):
      serial: exar: split out the exar code from 8250_pci
      serial: 8250_pci: remove exar code

Tony Lindgren (1):
      serial: 8250_omap: Fix probe and remove for PM runtime

Ulrich Hecht (7):
      serial: sh-sci: add FIFO trigger bits
      serial: sh-sci: consider DR (data ready) bit adequately
      serial: sh-sci: implement FIFO threshold register setting
      serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
      serial: sh-sci: SCIFA/B RX FIFO software timeout
      serial: sh-sci: make RX FIFO parameters tunable via sysfs
      serial: sh-sci: fix hardware RX trigger level setting

Vignesh R (3):
      serial: 8250_omap: pause DMA only if DMA transfer in progress
      serial: 8250_omap: Add OMAP_DMA_TX_KICK quirk for AM437x
      serial: 8250_omap: Remove rx_dma_broken flag

Wei Yongjun (1):
      serial: 8250_pci: make pciserial_detach_ports() static

Wolfgang Ocker (1):
      serial: mxs-auart: support CMSPAR termios cflag

Yasir-Khan (1):
      serial: xuartps: Enable uart loopback mode

남영민 (1):
      serial: samsung: enable clock before accessing interrupt mask resister

 Documentation/admin-guide/kernel-parameters.txt    |    6 +
 Documentation/devicetree/bindings/serial/8250.txt  |    1 +
 .../devicetree/bindings/serial/serial.txt          |    3 +-
 .../devicetree/bindings/serial/slave-device.txt    |   36 +
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/stih407-family.dtsi              |    3 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |   12 +-
 arch/arm/boot/dts/stih410-b2260.dts                |    5 +
 arch/sh/kernel/cpu/sh2/setup-sh7619.c              |    9 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c                |    3 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c             |   24 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c             |   16 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c             |   12 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c             |   32 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c             |   32 +-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c              |    6 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c              |   10 -
 arch/sh/kernel/cpu/sh3/setup-sh7710.c              |    8 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c              |    4 -
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c             |    3 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c              |    9 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c              |   21 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c             |   12 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c             |    4 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c             |    9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c             |   21 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c             |   21 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c             |   18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c             |    9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c             |    9 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c             |   30 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c             |    6 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c             |   18 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c             |   18 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |    9 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c                 |    4 +-
 drivers/acpi/spcr.c                                |   23 +
 drivers/char/Kconfig                               |    1 +
 drivers/dma/hsu/pci.c                              |   17 +-
 drivers/tty/Makefile                               |    1 +
 drivers/tty/goldfish.c                             |    2 +-
 drivers/tty/hvc/hvc_console.c                      |    1 -
 drivers/tty/serdev/Kconfig                         |   16 +
 drivers/tty/serdev/Makefile                        |    5 +
 drivers/tty/serdev/core.c                          |  421 ++++++++
 drivers/tty/serdev/serdev-ttyport.c                |  226 ++++
 drivers/tty/serial/8250/8250_dw.c                  |   28 +-
 drivers/tty/serial/8250/8250_exar.c                |  487 +++++++++
 drivers/tty/serial/8250/8250_gsc.c                 |    4 +
 drivers/tty/serial/8250/8250_hp300.c               |    2 +-
 drivers/tty/serial/8250/8250_lpss.c                |    4 +-
 drivers/tty/serial/8250/8250_mid.c                 |   45 +-
 drivers/tty/serial/8250/8250_moxa.c                |    1 +
 drivers/tty/serial/8250/8250_of.c                  |   94 +-
 drivers/tty/serial/8250/8250_omap.c                |   33 +-
 drivers/tty/serial/8250/8250_pci.c                 |  515 +--------
 drivers/tty/serial/8250/8250_port.c                |   32 +-
 drivers/tty/serial/8250/Kconfig                    |   11 +-
 drivers/tty/serial/8250/Makefile                   |    1 +
 drivers/tty/serial/Kconfig                         |    1 +
 drivers/tty/serial/amba-pl010.c                    |    2 +-
 drivers/tty/serial/amba-pl011.c                    |   70 +-
 drivers/tty/serial/ar933x_uart.c                   |    2 +-
 drivers/tty/serial/atmel_serial.c                  |   51 +-
 drivers/tty/serial/bfin_sport_uart.c               |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   18 +-
 drivers/tty/serial/dz.c                            |    2 +-
 drivers/tty/serial/efm32-uart.c                    |    2 +-
 drivers/tty/serial/fsl_lpuart.c                    |   35 +-
 drivers/tty/serial/icom.c                          |    2 +-
 drivers/tty/serial/imx.c                           |   32 +-
 drivers/tty/serial/ioc3_serial.c                   |    2 +-
 drivers/tty/serial/ioc4_serial.c                   |    2 +-
 drivers/tty/serial/ip22zilog.c                     |    2 +-
 drivers/tty/serial/lantiq.c                        |   42 +-
 drivers/tty/serial/lpc32xx_hs.c                    |    2 +-
 drivers/tty/serial/max310x.c                       |    2 +-
 drivers/tty/serial/meson_uart.c                    |    2 +-
 drivers/tty/serial/mpsc.c                          |    2 +-
 drivers/tty/serial/msm_serial.c                    |    1 +
 drivers/tty/serial/mxs-auart.c                     |    3 +
 drivers/tty/serial/omap-serial.c                   |   57 +-
 drivers/tty/serial/pic32_uart.c                    |    6 +-
 drivers/tty/serial/pmac_zilog.c                    |    2 +-
 drivers/tty/serial/pnx8xxx_uart.c                  |    2 +-
 drivers/tty/serial/pxa.c                           |    2 +-
 drivers/tty/serial/samsung.c                       |   20 +-
 drivers/tty/serial/samsung.h                       |    4 -
 drivers/tty/serial/serial-tegra.c                  |    2 +-
 drivers/tty/serial/serial_txx9.c                   |    2 +-
 drivers/tty/serial/sh-sci.c                        | 1092 +++++++++++---------
 drivers/tty/serial/sh-sci.h                        |   12 +-
 drivers/tty/serial/sirfsoc_uart.c                  |    2 +-
 drivers/tty/serial/sn_console.c                    |    2 +-
 drivers/tty/serial/sprd_serial.c                   |    2 +-
 drivers/tty/serial/st-asc.c                        |  101 +-
 drivers/tty/serial/sunhv.c                         |    2 +-
 drivers/tty/serial/sunzilog.c                      |    2 +-
 drivers/tty/serial/vr41xx_siu.c                    |    2 +-
 drivers/tty/serial/vt8500_serial.c                 |    2 +-
 drivers/tty/serial/xilinx_uartps.c                 |    9 +
 drivers/tty/serial/zs.c                            |    2 +-
 drivers/tty/tty_buffer.c                           |   19 +-
 drivers/tty/tty_io.c                               |   52 +-
 drivers/tty/tty_port.c                             |   65 +-
 drivers/tty/vt/vt.c                                |    9 +
 drivers/video/console/Kconfig                      |   27 +-
 drivers/video/console/vgacon.c                     |  164 ++-
 include/linux/console.h                            |    4 +
 include/linux/serdev.h                             |  262 +++++
 include/linux/serial_core.h                        |    2 +-
 include/linux/serial_sci.h                         |   15 -
 include/linux/tty.h                                |   12 +-
 include/uapi/linux/serial_core.h                   |    3 +-
 include/uapi/linux/serial_reg.h                    |   26 +-
 lib/Kconfig.debug                                  |   10 +
 116 files changed, 3057 insertions(+), 1640 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
 create mode 100644 drivers/tty/serdev/Kconfig
 create mode 100644 drivers/tty/serdev/Makefile
 create mode 100644 drivers/tty/serdev/core.c
 create mode 100644 drivers/tty/serdev/serdev-ttyport.c
 create mode 100644 drivers/tty/serial/8250/8250_exar.c
 create mode 100644 include/linux/serdev.h
