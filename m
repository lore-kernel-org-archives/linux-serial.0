From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.15-rc1
Date: Mon, 13 Nov 2017 17:19:18 +0100
Message-ID: <20171113161918.GA29199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.15-rc1

for you to fetch changes up to 57f5d648c45c3d40a3257c06629c14fd53c383bc:

  tty: ehv_bytechan: fix spelling mistake (2017-11-08 14:27:10 +0100)

----------------------------------------------------------------
TTY/Serial patches for 4.15-rc1

Here is the big tty/serial driver pull request for 4.15-rc1.

Lots of serial driver updates in here, some small vt cleanups, and a
raft of SPDX and license boilerplate cleanups, messing up the diffstat a
bit.

Nothing major, with no realy functional changes except better hardware
support for some platforms.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaron Sierra (1):
      serial: 8250: Preserve DLD[7:4] for PORT_XR17V35X

Allen Pais (10):
      drivers: tty: imx: use setup_timer() helper.
      drivers: tty: mux: use setup_timer() helper.
      drivers: tty: vcc: use setup_timer() helper.
      drivers: tty: max3100: use setup_timer() helper.
      drivers: tty: 8250: use setup_timer() helper.
      drivers: tty: pnx8xxx: use setup_timer() helper.
      drivers: tty: n_gsm: use setup_timer() helper.
      drivers: tty: sn_console: use setup_timer() helper.
      drivers: tty: ifx6x60: use setup_timer() helper.
      drivers: tty: sa1100: use setup_timer() helper.

Allen Yan (5):
      serial: mvebu-uart: support probe of multiple ports
      serial: mvebu-uart: add soft reset at probe
      serial: mvebu-uart: add function to change baudrate
      serial: mvebu-uart: clear state register before IRQ request
      serial: mvebu-uart: add TX interrupt trigger for pulse interrupts

Andy Lowe (1):
      serial: sh-sci: suppress warning for ports without dma channels

Andy Shevchenko (1):
      serial: 8250_mid: Enable HSU on Intel Cedar Fork PCH

Antonio Borneo (1):
      ttyport: trivial fix for some typo in comments

Arnd Bergmann (1):
      serial: mvebu-uart: drop incorrect memset

Arvind Yadav (2):
      serial-uartlite: pr_err() strings should end with newlines
      tty: ehv_bytechan: fix spelling mistake

Bhumika Goyal (1):
      tty: serial: make sport_uart_ops static and const

Christophe JAILLET (1):
      tty: synclink: Reuse an existing error handling path

Colin Ian King (3):
      tty: max3100: remove unused variable rts and remove unused assignment
      serial: core: remove redundant assignment to port
      tty: serial: jsm: remove redundant pointer ts

Ed Blake (2):
      serial: Add define for max baud rate divisor
      serial: 8250_dw: Improve clock rate setting

Fabio Estevam (1):
      serial: fsl_lpuart: Remove unused 'bd' variable

Frédéric Danis (2):
      serdev: Add ACPI support
      ACPI / scan: Fix enumeration for special UART devices

Geert Uytterhoeven (1):
      serial: sh-sci: Use of_device_get_match_data() helper

Gimcuan Hui (6):
      tty: serial: jsm: Add space before the open brace
      tty: serial: jsm: change the type of local variable
      tty: serial: jsm: add blank line after declarations
      tty: serial: jsm: delete space between function name and '('
      tty: serial: jsm: fix coding style
      tty: serial: jsm: add space before the open parenthesis '('

Greg Kroah-Hartman (6):
      Merge 4.14-rc4 into tty-next
      tty: add SPDX identifiers to all remaining files in drivers/tty/
      tty: serial: Remove redundant license text
      tty: hvc: Remove redundant license text
      tty: serdev: Remove redundant license text
      tty: Remove redundant license text

Ian Jamison (1):
      serial: imx: Update cached mctrl value when changing RTS

Ji-Ze Hong (Peter Hong) (5):
      serial: 8250_fintek: UART dynamic clocksource on Fintek F81866
      serial: 8250_fintek: UART dynamic clocksource on Fintek F81216H
      serial: 8250_fintek: fix warning reported from smatch
      serial: 8250_fintek: Fix finding base_port with activated SuperIO
      serial: 8250_fintek: Fix crash with baud rate B0

Jibin Xu (1):
      sysrq : fix Show Regs call trace on ARM

Jiri Slaby (1):
      mxser: remove unused parameters

Joe Perches (1):
      vt: Use consistent logging style

Johan Hovold (6):
      serdev: enable TTY port controller support by default
      serdev: ttyport: enforce tty-driver open() requirement
      serdev: ttyport: add missing open() error handling
      serdev: fix registration of second slave
      serdev: fix controller-allocation error handling
      tty: fix tty_ldisc_receive_buf() documentation

Kees Cook (13):
      tty: metag_da: Convert timers to use timer_setup()
      serial: m32r_sio: Convert timers to use timer_setup()
      tty/sysrq: Convert timers to use timer_setup()
      tty: mips_ejtag_fdc: Convert timers to use timer_setup()
      tty: amba-pl011: Convert timers to use timer_setup()
      serial: 8250: Convert timers to use timer_setup()
      serial: bfin_uart: Convert timers to use timer_setup()
      serial: sccnxp: Convert timers to use timer_setup()
      tty/serial: altera_uart: Convert timers to use timer_setup()
      tty: vcc: Convert timers to use timer_setup()
      tty: cyclades: Convert timers to use timer_setup()
      tty/serial: atmel: Convert timers to use timer_setup()
      serial: m32r_sio: Drop redundant .data assignment

Lukas Wunner (3):
      serial: omap: Fix EFR write on RTS deassertion
      serial: 8250_fintek: Fix rs485 disablement on invalid ioctl()
      serial: pl011: Adopt generic flag to store auto RTS status

Martin Townsend (1):
      omap_serial: Removing superfluous check on no interrupt pending.

Martyn Welch (3):
      serial: imx: Use RX_BUF_SIZE to set size of RX buffer
      serial: imx: Switch setting dma_is_txing from "false" to "0"
      serial: imx: Correct comment imx_flush_buffer()

Matthias Kaehlcke (1):
      serial: sh-sci: Fix init data attribute for struct 'port_cfg'

Meng Xu (1):
      tty: vt: remove multi-fetch, derive font.height from font.data

Miquel Raynal (4):
      serial: mvebu-uart: use a generic way to access the registers
      serial: mvebu-uart: dissociate RX and TX interrupts
      serial: mvebu-uart: augment the maximum number of ports
      serial: mvebu-uart: support extended port registers layout

Philipp Zabel (1):
      serial: imx: add hibernation support

Ricardo Ribalda Delgado (2):
      serial: 8250_fintek: Return -EINVAL on invalid configuration
      serial: 8250_fintek: Disable delays for ports != 0

Romain Izard (1):
      tty/serial: atmel: Prevent a warning on suspend

Romain Perier (1):
      serial: imx: only set dma_is_rxing when DMA starts

Sascha Hauer (5):
      serial: atmel: Use common rs485 device tree parsing function
      serial: fsl_lpuart: Use common rs485 device tree parsing function
      serial: omap-serial: Use common rs485 device tree parsing function
      serial: imx: default to half duplex rs485
      serial: imx: Use common rs485 device tree parsing function

Shubhrajyoti Datta (1):
      tty: xilinx_uartps: move to arch_initcall for earlier console

Takatoshi Akiyama (1):
      serial: sh-sci: Fix unlocked access to SCSCR register

Thomas Meyer (1):
      vt: Use bsearch library function in is_double_width

Thomas Rohloff (1):
      tty: serial: meson: allow baud-rates lower than 9600

Tomas Melin (1):
      serial: 8250: fix potential deadlock in rs485-mode

Troy Kisky (2):
      tty: serial: imx: disable ageing timer interrupt if dma in use
      tty: serial: imx: remove dead code imx_dma_rxint

Ulrich Hecht (1):
      serial: sh-sci: Support for variable HSCIF hardware RX timeout

Uwe Kleine-König (2):
      serial: Add common rs485 device tree parsing function
      dt-bindings: serial: document rs485 bindings for various devices

Vikas Manocha (2):
      Arm: dts: stm32: remove extra compatible string for uart
      Arm: dts: stm32: remove extra compatible string from DT & driver

Yehuda Yitschak (1):
      serial: mvebu-uart: use driver name when requesting an interrupt

Yixun Lan (1):
      serial: meson: add Magic SysRq support

nixiaoming (1):
      tty fix oops when rmmod 8250

 .../devicetree/bindings/dma/stm32-dma.txt          |   2 +-
 .../devicetree/bindings/serial/atmel-usart.txt     |   1 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   1 +
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   1 +
 .../devicetree/bindings/serial/omap_serial.txt     |   1 +
 .../devicetree/bindings/serial/st,stm32-usart.txt  |  10 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |  12 +-
 arch/arm/boot/dts/stm32f746.dtsi                   |  12 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |   4 +-
 drivers/acpi/scan.c                                |  37 +-
 drivers/tty/amiserial.c                            |   1 +
 drivers/tty/bfin_jtag_comm.c                       |   3 +-
 drivers/tty/cyclades.c                             |  17 +-
 drivers/tty/ehv_bytechan.c                         |   9 +-
 drivers/tty/goldfish.c                             |  11 +-
 drivers/tty/hvc/hvc_bfin_jtag.c                    |   3 +-
 drivers/tty/hvc/hvc_console.c                      |  15 +-
 drivers/tty/hvc/hvc_console.h                      |  15 +-
 drivers/tty/hvc/hvc_dcc.c                          |  13 +-
 drivers/tty/hvc/hvc_opal.c                         |  16 +-
 drivers/tty/hvc/hvc_rtas.c                         |  15 +-
 drivers/tty/hvc/hvc_tile.c                         |  11 +-
 drivers/tty/hvc/hvc_udbg.c                         |  15 +-
 drivers/tty/hvc/hvc_vio.c                          |  15 +-
 drivers/tty/hvc/hvc_xen.c                          |  15 +-
 drivers/tty/hvc/hvcs.c                             |  15 +-
 drivers/tty/hvc/hvsi.c                             |  15 +-
 drivers/tty/ipwireless/main.c                      |   1 +
 drivers/tty/isicom.c                               |   6 +-
 drivers/tty/metag_da.c                             |  16 +-
 drivers/tty/mips_ejtag_fdc.c                       |  13 +-
 drivers/tty/moxa.c                                 |   6 +-
 drivers/tty/mxser.c                                |  22 +-
 drivers/tty/n_gsm.c                                |  18 +-
 drivers/tty/n_hdlc.c                               |   3 +-
 drivers/tty/n_null.c                               |  14 +-
 drivers/tty/n_r3964.c                              |   4 +-
 drivers/tty/n_tracerouter.c                        |  12 +-
 drivers/tty/n_tracesink.c                          |  12 +-
 drivers/tty/n_tracesink.h                          |  12 +-
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/nozomi.c                               |  15 +-
 drivers/tty/rocket.c                               |  15 +-
 drivers/tty/serdev/Kconfig                         |   8 +
 drivers/tty/serdev/core.c                          | 152 +++++--
 drivers/tty/serdev/serdev-ttyport.c                |  31 +-
 drivers/tty/serial/21285.c                         |   1 +
 drivers/tty/serial/8250/8250.h                     |   6 +-
 drivers/tty/serial/8250/8250_accent.c              |   5 +-
 drivers/tty/serial/8250/8250_acorn.c               |   5 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   6 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   6 +-
 drivers/tty/serial/8250/8250_boca.c                |   5 +-
 drivers/tty/serial/8250/8250_core.c                |  23 +-
 drivers/tty/serial/8250/8250_dma.c                 |   6 +-
 drivers/tty/serial/8250/8250_dw.c                  |  36 +-
 drivers/tty/serial/8250/8250_early.c               |   5 +-
 drivers/tty/serial/8250/8250_em.c                  |  14 +-
 drivers/tty/serial/8250/8250_exar.c                |   5 +-
 drivers/tty/serial/8250/8250_exar_st16c554.c       |   5 +-
 drivers/tty/serial/8250/8250_fintek.c              | 123 ++++-
 drivers/tty/serial/8250/8250_fourport.c            |   5 +-
 drivers/tty/serial/8250/8250_fsl.c                 |   5 +-
 drivers/tty/serial/8250/8250_gsc.c                 |   6 +-
 drivers/tty/serial/8250/8250_hp300.c               |   1 +
 drivers/tty/serial/8250/8250_hub6.c                |   5 +-
 drivers/tty/serial/8250/8250_ingenic.c             |  10 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |   6 +-
 drivers/tty/serial/8250/8250_lpss.c                |   5 +-
 drivers/tty/serial/8250/8250_mid.c                 |  11 +-
 drivers/tty/serial/8250/8250_moxa.c                |   5 +-
 drivers/tty/serial/8250/8250_mtk.c                 |  13 +-
 drivers/tty/serial/8250/8250_of.c                  |   7 +-
 drivers/tty/serial/8250/8250_omap.c                |   5 +-
 drivers/tty/serial/8250/8250_pci.c                 |   6 +-
 drivers/tty/serial/8250/8250_pnp.c                 |   5 +-
 drivers/tty/serial/8250/8250_port.c                |  16 +-
 drivers/tty/serial/8250/8250_pxa.c                 |   7 +-
 drivers/tty/serial/8250/8250_uniphier.c            |  11 +-
 drivers/tty/serial/8250/serial_cs.c                |   1 +
 drivers/tty/serial/altera_jtaguart.c               |   6 +-
 drivers/tty/serial/altera_uart.c                   |  14 +-
 drivers/tty/serial/amba-pl010.c                    |  15 +-
 drivers/tty/serial/amba-pl011.c                    |  32 +-
 drivers/tty/serial/apbuart.c                       |   1 +
 drivers/tty/serial/ar933x_uart.c                   |   5 +-
 drivers/tty/serial/arc_uart.c                      |   5 +-
 drivers/tty/serial/atmel_serial.c                  |  65 +--
 drivers/tty/serial/atmel_serial.h                  |   6 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   5 +-
 drivers/tty/serial/bfin_sport_uart.c               |   5 +-
 drivers/tty/serial/bfin_sport_uart.h               |   3 +-
 drivers/tty/serial/bfin_uart.c                     |  10 +-
 drivers/tty/serial/clps711x.c                      |   6 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |   6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  16 +-
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c        |  16 +-
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c        |  16 +-
 drivers/tty/serial/digicolor-usart.c               |   6 +-
 drivers/tty/serial/dz.c                            |   1 +
 drivers/tty/serial/earlycon-arm-semihost.c         |  13 +-
 drivers/tty/serial/earlycon.c                      |   5 +-
 drivers/tty/serial/efm32-uart.c                    |   1 +
 drivers/tty/serial/fsl_lpuart.c                    |  33 +-
 drivers/tty/serial/icom.c                          |  16 +-
 drivers/tty/serial/icom.h                          |  15 +-
 drivers/tty/serial/ifx6x60.c                       |  20 +-
 drivers/tty/serial/ifx6x60.h                       |  18 +-
 drivers/tty/serial/imx.c                           | 103 ++---
 drivers/tty/serial/ioc3_serial.c                   |   5 +-
 drivers/tty/serial/ioc4_serial.c                   |   5 +-
 drivers/tty/serial/ip22zilog.c                     |   1 +
 drivers/tty/serial/jsm/jsm.h                       |  11 +-
 drivers/tty/serial/jsm/jsm_cls.c                   |  11 +-
 drivers/tty/serial/jsm/jsm_driver.c                |  11 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |  11 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |  27 +-
 drivers/tty/serial/kgdb_nmi.c                      |   5 +-
 drivers/tty/serial/kgdboc.c                        |   5 +-
 drivers/tty/serial/lantiq.c                        |  14 +-
 drivers/tty/serial/lpc32xx_hs.c                    |  11 +-
 drivers/tty/serial/m32r_sio.c                      |  14 +-
 drivers/tty/serial/m32r_sio_reg.h                  |   4 +-
 drivers/tty/serial/max3100.c                       |  16 +-
 drivers/tty/serial/max310x.c                       |   6 +-
 drivers/tty/serial/mcf.c                           |   6 +-
 drivers/tty/serial/men_z135_uart.c                 |   5 +-
 drivers/tty/serial/meson_uart.c                    |  31 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   5 +-
 drivers/tty/serial/mps2-uart.c                     |   5 +-
 drivers/tty/serial/mpsc.c                          |   6 +-
 drivers/tty/serial/msm_serial.c                    |  10 +-
 drivers/tty/serial/mux.c                           |   9 +-
 drivers/tty/serial/mvebu-uart.c                    | 495 ++++++++++++++++-----
 drivers/tty/serial/mxs-auart.c                     |   5 +-
 drivers/tty/serial/netx-serial.c                   |  14 +-
 drivers/tty/serial/omap-serial.c                   |  23 +-
 drivers/tty/serial/owl-uart.c                      |  14 +-
 drivers/tty/serial/pch_uart.c                      |  14 +-
 drivers/tty/serial/pic32_uart.c                    |   3 +-
 drivers/tty/serial/pic32_uart.h                    |   3 +-
 drivers/tty/serial/pmac_zilog.c                    |  15 +-
 drivers/tty/serial/pnx8xxx_uart.c                  |  11 +-
 drivers/tty/serial/pxa.c                           |   6 +-
 drivers/tty/serial/rp2.c                           |   5 +-
 drivers/tty/serial/sa1100.c                        |  20 +-
 drivers/tty/serial/samsung.c                       |   5 +-
 drivers/tty/serial/samsung.h                       |   5 +-
 drivers/tty/serial/sb1250-duart.c                  |   6 +-
 drivers/tty/serial/sc16is7xx.c                     |   7 +-
 drivers/tty/serial/sccnxp.c                        |  13 +-
 drivers/tty/serial/serial-tegra.c                  |  13 +-
 drivers/tty/serial/serial_core.c                   |  54 ++-
 drivers/tty/serial/serial_ks8695.c                 |   7 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |  11 +-
 drivers/tty/serial/serial_mctrl_gpio.h             |  12 +-
 drivers/tty/serial/serial_txx9.c                   |   5 +-
 drivers/tty/serial/sh-sci.c                        | 103 +++--
 drivers/tty/serial/sh-sci.h                        |   3 +
 drivers/tty/serial/sirfsoc_uart.c                  |   3 +-
 drivers/tty/serial/sirfsoc_uart.h                  |   3 +-
 drivers/tty/serial/sn_console.c                    |  23 +-
 drivers/tty/serial/sprd_serial.c                   |  10 +-
 drivers/tty/serial/st-asc.c                        |   7 +-
 drivers/tty/serial/stm32-usart.c                   |   5 +-
 drivers/tty/serial/stm32-usart.h                   |   2 +-
 drivers/tty/serial/suncore.c                       |   1 +
 drivers/tty/serial/sunhv.c                         |   1 +
 drivers/tty/serial/sunsab.c                        |   1 +
 drivers/tty/serial/sunsu.c                         |   1 +
 drivers/tty/serial/sunzilog.c                      |   1 +
 drivers/tty/serial/tilegx.c                        |  11 +-
 drivers/tty/serial/timbuart.c                      |  14 +-
 drivers/tty/serial/timbuart.h                      |  14 +-
 drivers/tty/serial/uartlite.c                      |   7 +-
 drivers/tty/serial/ucc_uart.c                      |   6 +-
 drivers/tty/serial/vr41xx_siu.c                    |  15 +-
 drivers/tty/serial/vt8500_serial.c                 |  10 +-
 drivers/tty/serial/xilinx_uartps.c                 |   9 +-
 drivers/tty/serial/zs.c                            |   1 +
 drivers/tty/synclink.c                             |   6 +-
 drivers/tty/synclink_gt.c                          |   3 +-
 drivers/tty/synclinkmp.c                           |   2 +-
 drivers/tty/sysrq.c                                |  18 +-
 drivers/tty/tty_audit.c                            |   6 +-
 drivers/tty/tty_baudrate.c                         |   1 +
 drivers/tty/tty_buffer.c                           |   3 +-
 drivers/tty/tty_io.c                               |   1 +
 drivers/tty/tty_ioctl.c                            |   1 +
 drivers/tty/tty_jobctrl.c                          |   1 +
 drivers/tty/tty_ldisc.c                            |   1 +
 drivers/tty/tty_ldsem.c                            |   4 +-
 drivers/tty/tty_port.c                             |   5 +-
 drivers/tty/vcc.c                                  |  25 +-
 drivers/tty/vt/consolemap.c                        |   1 +
 drivers/tty/vt/keyboard.c                          |   1 +
 drivers/tty/vt/vt.c                                | 107 ++---
 fs/proc/proc_tty.c                                 |   3 +-
 include/acpi/acpi_bus.h                            |   2 +-
 include/linux/cyclades.h                           |   3 +
 include/linux/serial_core.h                        |   5 +
 include/uapi/linux/serial_reg.h                    |   1 +
 202 files changed, 1276 insertions(+), 1668 deletions(-)
