From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.4-rc1
Date: Wed, 4 Nov 2015 14:17:43 -0800
Message-ID: <20151104221743.GA23350@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 25cb62b76430a91cc6195f902e61c2cb84ad=
e622:

  Linux 4.3-rc5 (2015-10-11 11:09:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.4-rc1

for you to fetch changes up to e052c6d15c61cc4caff2f06cbca72b183da9f15e=
:

  tty: Use unbound workqueue for all input workers (2015-10-17 21:32:21=
 -0700)

----------------------------------------------------------------
TTY/Serial driver patches for 4.4-rc1

Here is the big tty and serial driver update for 4.4-rc1.

Lots of serial driver updates and a few small tty core changes.  Full
details in the shortlog.

All of these have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abhimanyu Kapur (1):
      ARM64: TTY: hvc_dcc: Add support for ARM64 dcc

Aleksandar Mitev (1):
      serial: sh-sci: Remove timer on shutdown of port

Alexandre Belloni (1):
      tty/serial: at91: move ATMEL_MAX_UART

Andre Przywara (1):
      serial: atmel: fix compiler warning on address cast

Andreas Werner (1):
      tty: serial: men_z135_uart.c: use mcb memory region size instead =
of hardcoded one

Andrzej Hajda (1):
      tty: serial: lpc32xx_hs: fix handling platform_get_irq result

Andy Shevchenko (1):
      serial: 8250_dma: no need to sync RX buffer

Arnd Bergmann (1):
      serial: fix mctrl helper functions

Axel Lin (1):
      serial: mux: Convert to uart_console_device instead of open-coded

Christoph Hellwig (1):
      mpsc: use dma_set_mask insted of dma_supported

Ezequiel Garcia (1):
      serial: omap: remove warnings about unused functions

=46abio Estevam (1):
      serial: 68328serial: Use NULL for pointers

Geert Uytterhoeven (35):
      serial: sh-sci: Replace buggy big #ifdef by runtime logic
      serial: sh-sci: Prevent compiler warnings on 64-bit
      serial: sh-sci: Correct SCIF_ERROR_CLEAR for plain SCIF
      serial: sh-sci: Use SCIF_DR instead of hardcoded literal 1
      serial: sh-sci: Use SCSMR_CKS instead of hardcoded literal 3
      serial: sh-sci: Drop path in reference to serial_core.c
      serial: sh-sci: Improve readability of sampling rate configuratio=
n
      serial: sh-sci: Make sci_irq_desc[] const
      serial: sh-sci: Make sci_regmap[] const
      serial: sh-sci: Remove useless memory allocation failure printks
      serial: sh-sci: Remove bogus sci_handle_fifo_overrun() call on (H=
)SCIF
      serial: sh-sci: Improve DMA error messages
      serial: sh-sci: Improve comments for DMA timeout calculation
      serial: sh-sci: Handle DMA init failures inside sci_request_dma()
      serial: sh-sci: Use correct device for DMA mapping with IOMMU
      serial: sh-sci: Use min_t()/max_t() instead of casts
      serial: sh-sci: Switch to dma_map_single() for DMA transmission
      serial: sh-sci: Fix TX buffer mapping leak
      serial: sh-sci: Use DMA submission helpers instead of open-coding
      serial: sh-sci: Switch to generic DMA residue handling
      serial: sh-sci: Stop acknowledging DMA transmit completions
      serial: sh-sci: Simplify sci_submit_rx() error handling
      serial: sh-sci: Do not resubmit DMA descriptors
      serial: sh-sci: Fix race condition between RX worker and cleanup
      serial: sh-sci: Pass scatterlist to sci_dma_rx_push()
      serial: sh-sci: Use tty_insert_flip_string() for DMA receive
      serial: sh-sci: Use incrementing pointers instead of stack array
      serial: sh-sci: Don't call sci_rx_interrupt() on error when using=
 DMA
      serial: sh-sci: Don't call sci_dma_rx_push() if no data has arriv=
ed
      serial: sh-sci: Shuffle functions around
      serial: sh-sci: Get rid of the workqueue to handle receive DMA re=
quests
      serial: sh-sci: Submit RX DMA from RX interrupt on (H)SCIF
      serial: sh-sci: Stop calling sci_start_rx() from sci_request_dma(=
)
      serial: sh-sci: Add DT support to DMA setup
      serial: pl011: Spelling s/clocks-names/clock-names/

Greg Kroah-Hartman (1):
      Merge 4.3-rc5 into tty-next

Guillaume Gomez (1):
      tty: remove unneeded return statement

Heikki Krogerus (15):
      serial: 8250_dw: add separate pointer for the uart_port to dw8250=
_probe
      serial: 8250_dw: adapt to unified device property interface
      serial: 8250_dw: hook the DMA in one place
      serial: 8250_dw: only setup the port from one place
      serial: 8250_dw: add dw8250_quirks function
      serial: 8250_dw: proper support for UARTs without busy functional=
ity
      serial: 8250_dw: rename and comment the fallback dma filter
      serial: 8250_dw: cleanup dw8250_idma_filter
      serial: 8250_dw: cleanup dw8250_setup_port
      serial: 8250_dw: don't set UPF_BOOT_AUTOCONF flag
      serial: 8250_pci: Intel MID UART support to its own driver
      dmaengine: hsu: make the UART driver in control of selecting this=
 driver
      dmaengine: hsu: introduce stubs for the exported functions
      dmaengine: hsu: remove platform data
      serial: 8250_mid: add support for DMA engine handling from UART M=
MIO

Ivan T. Ivanov (4):
      tty: serial: msm: Add msm prefix to all driver functions
      tty: serial: msm: Add TX DMA support
      tty: serial: msm: Add RX DMA support
      tty: serial: msm: Remove 115.2 Kbps maximum baud rate limitation

James Hogan (2):
      serial: 8250: Tolerate clock variance for max baud rate
      ttyFDC: Fix build problems due to use of module_{init,exit}

Javier Martinez Canillas (1):
      serial: sc16is7xx: Remove unnecessary MODULE_ALIAS()

Jiri Slaby (2):
      serial: at91, fix rs485 properties
      tty: synclink, fix indentation

Jon Hunter (4):
      serial: tegra: Handle another RX race condition
      serial: tegra: Remove unnecessary return statements
      serial: tegra: Remove redundant code and check in tegra_uart_stop=
_rx()
      serial: tegra: Add helper function for handling RX buffer

Kazuya Mizuguchi (1):
      serial: sh-sci: Fix exclusion of work_fn_rx and sci_dma_rx_comple=
te

Kuninori Morimoto (1):
      serial: sh-sci: Add device tree support for r8a7795

Lucas Stach (8):
      serial: imx: add earlycon support
      serial: imx: make setup_ufcr more useful
      serial: imx: set up aging timer interrupt as DMA trigger
      serial: imx: always restart DMA if more data is available
      serial: imx: configure proper DMA burst sizes
      serial: imx: don't use idle condition detect for DMA transfers
      serial: imx: re-enable DMA support without hardware flow control
      serial: imx: also update RX stats in DMA path

Luis de Bethencourt (4):
      tty: serial: apbuart: Fix module autoload for OF platform driver
      tty: serial: of_serial: Fix module autoload for OF platform drive=
r
      tty: serial: sprd: Fix module autoload for OF platform driver
      tty: serial: cpm_uart: Fix module autoload for OF platform driver

Maciej S. Szmigiero (1):
      serial: don't register CIR serial ports

Mans Rullgard (1):
      serial: 8250: simplify ralink/alchemy register remap selection

Martin Sperl (1):
      serial: of-serial: compile correctly when 8250 driver is compiled=
 as module

Matt Redfearn (3):
      serial: 8250_ingenic: Enable hardware flow control
      serial: 8250_ingenic: Enable FIFO for Ingenic UARTs
      devicetree: Add JZ4760/JZ4775 to Ingenic SoC UART binding

Max Filippov (1):
      serial_core: support native endianness

Muhammad Hamza Farooq (4):
      serial: sh-sci: Redirect port interrupts to CPU _only_ when DMA s=
tops
      serial: sh-sci: Call dma_async_issue_pending when transaction com=
pletes
      serial: sh-sci: Do not terminate DMA engine when race condition o=
ccurs
      serial: sh-sci: Pause DMA engine and get DMA status again

Paul Gortmaker (6):
      drivers/tty: make pty.c slightly more explicitly non-modular
      drivers/tty: make sysrq.c slightly more explicitly non-modular
      drivers/tty: make hvc_console.c explicitly non-modular
      drivers/tty: make serial/mpsc.c driver explicitly non-modular
      drivers/tty: make serial 8250_lpc18xx.c Kconfig a tristate
      tty: disable unbind for old 74xx based serial/mpsc console port

Peter Hurley (15):
      serial: 8250: Refactor serial console restore-from-suspend
      serial: 8250_omap: Remove RTS clear
      tty: Remove tty_wait_until_sent_from_close()
      tty: Remove ASYNC_CLOSING checks in open()/hangup() methods
      usb: gadget: gserial: Privatize close_wait
      tty: Remove tty_port::close_wait
      tty: r3964: Use tty->read_wait waitqueue
      tty: r3964: Replace/remove bogus tty lock use
      tty: Remove wait_event_interruptible_tty()
      n_tty: Remove reader wakeups for TTY_BREAK/TTY_PARITY chars
      tty: Combine SIGTTOU/SIGTTIN handling
      tty: core: Use correct spinlock flavor in tiocspgrp()
      tty: Prevent tty teardown during tty_write_message()
      tty: Abstract tty buffer work
      tty: Use unbound workqueue for all input workers

Pramod Gurav (2):
      tty: serial: msm: Add mask value for UART_DM registers
      tty: serial: msm: replaces (1 << x) with BIT(x) macro

Robert Baldyga (4):
      serial: samsung: remove unused 'irq' parameter
      serial: samsung: remove unneded 'ignore_char' label
      serial: samsung: introduce s3c24xx_serial_rx_drain_fifo() functio=
n
      serial: samsung: Fix UART status handling in DMA mode

Scott Wood (2):
      serial: 8250: Add OF earlycon support
      serial: Enable Freescale 16550 workaround on arm

Sean Nyekjaer (1):
      sc16is7xx: null ptr check

Sebastian Andrzej Siewior (1):
      serial: 8250_omap: check how many bytes were injected

Stefan Agner (1):
      serial: fsl_lpuart: add earlycon support

Sudeep Holla (2):
      MIPS: ttyFDC: replace IRQF_NO_SUSPEND with IRQF_COND_SUSPEND
      tty/serial: st-asc: drop the use of IRQF_NO_SUSPEND

Taichi Kageyama (1):
      serial: 8250: Fix autoconfig_irq() to avoid race conditions

Tilman Schmidt (1):
      Documentation: improve line discipline method descriptions

Timur Tabi (2):
      hvc_dcc: don't ignore errors during initialization
      serial: amba-pl011: fix incorrect integer size in pl011_fifo_to_t=
ty()

Tobias Klauser (1):
      serial: altera_uart: Use of_property_read_u32 instead of open-cod=
ing it

Uwe Kleine-K=F6nig (5):
      serial: mpc52xx: add delay after resetting transmitter to fix bro=
ken chars
      serial: atmel: allow compile testing on non-atmel architectures
      serial: mxs-auart+imx: allow compile testing on non-Freescale arc=
hitectures
      serial: mctrl-gpio: rename init function
      serial: mctrl_gpio: implement interrupt handling

Yoshihiro Shimoda (3):
      serial: sh-sci: Return IRQ_HANDLED when overrun if detected
      serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enable=
d
      serial: sh-sci: Don't kick tx in sci_er_interrupt() when using DM=
A

 .../devicetree/bindings/serial/ingenic,uart.txt    |    3 +-
 Documentation/devicetree/bindings/serial/pl011.txt |    2 +-
 .../devicetree/bindings/serial/qcom,msm-uartdm.txt |    6 +
 .../bindings/serial/renesas,sci-serial.txt         |    2 +
 .../bindings/serial/snps-dw-apb-uart.txt           |    3 +
 Documentation/kernel-parameters.txt                |    7 +
 Documentation/serial/driver                        |   10 +-
 Documentation/serial/tty.txt                       |   60 +-
 arch/arm64/include/asm/dcc.h                       |   55 +
 drivers/char/pcmcia/synclink_cs.c                  |    9 -
 drivers/dma/hsu/Kconfig                            |    9 +-
 drivers/dma/hsu/hsu.c                              |   24 +-
 drivers/dma/hsu/hsu.h                              |    1 +
 drivers/dma/hsu/pci.c                              |    2 +-
 drivers/isdn/i4l/isdn_tty.c                        |    2 +-
 drivers/tty/cyclades.c                             |    9 -
 drivers/tty/hvc/Kconfig                            |    2 +-
 drivers/tty/hvc/hvc_console.c                      |   20 +-
 drivers/tty/hvc/hvc_dcc.c                          |   15 +-
 drivers/tty/hvc/hvcs.c                             |    2 +-
 drivers/tty/mips_ejtag_fdc.c                       |   39 +-
 drivers/tty/n_r3964.c                              |   28 +-
 drivers/tty/n_tty.c                                |   32 +-
 drivers/tty/pty.c                                  |    7 +-
 drivers/tty/rocket.c                               |   13 -
 drivers/tty/serial/68328serial.c                   |    5 +-
 drivers/tty/serial/8250/8250_core.c                |   26 +-
 drivers/tty/serial/8250/8250_dma.c                 |    6 -
 drivers/tty/serial/8250/8250_dw.c                  |  288 ++--
 drivers/tty/serial/8250/8250_early.c               |    4 +
 drivers/tty/serial/8250/8250_ingenic.c             |   88 +-
 drivers/tty/serial/8250/8250_mid.c                 |  326 +++++
 drivers/tty/serial/8250/8250_omap.c                |    8 +-
 drivers/tty/serial/8250/8250_pci.c                 |  229 +--
 drivers/tty/serial/8250/8250_port.c                |   86 +-
 drivers/tty/serial/8250/Kconfig                    |   25 +-
 drivers/tty/serial/8250/Makefile                   |    1 +
 drivers/tty/serial/Kconfig                         |   12 +-
 drivers/tty/serial/altera_uart.c                   |   26 +-
 drivers/tty/serial/amba-pl011.c                    |    4 +-
 drivers/tty/serial/apbuart.c                       |    1 +
 drivers/tty/serial/atmel_serial.c                  |   27 +-
 drivers/tty/serial/clps711x.c                      |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |    1 +
 drivers/tty/serial/crisv10.c                       |   34 +-
 drivers/tty/serial/fsl_lpuart.c                    |   39 +
 drivers/tty/serial/imx.c                           |  175 ++-
 drivers/tty/serial/lpc32xx_hs.c                    |    7 +-
 drivers/tty/serial/men_z135_uart.c                 |   23 +-
 drivers/tty/serial/mpc52xx_uart.c                  |    7 +
 drivers/tty/serial/mpsc.c                          |   41 +-
 drivers/tty/serial/msm_serial.c                    |  622 ++++++++-
 drivers/tty/serial/msm_serial.h                    |   53 +-
 drivers/tty/serial/mux.c                           |    9 +-
 drivers/tty/serial/mxs-auart.c                     |    2 +-
 drivers/tty/serial/of_serial.c                     |   10 +
 drivers/tty/serial/omap-serial.c                   |    2 +
 drivers/tty/serial/samsung.c                       |   66 +-
 drivers/tty/serial/sc16is7xx.c                     |    7 +-
 drivers/tty/serial/serial-tegra.c                  |   94 +-
 drivers/tty/serial/serial_core.c                   |    9 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |  133 +-
 drivers/tty/serial/serial_mctrl_gpio.h             |   40 +-
 drivers/tty/serial/sh-sci.c                        | 1460 ++++++++++--=
--------
 drivers/tty/serial/sh-sci.h                        |   49 +-
 drivers/tty/serial/sprd_serial.c                   |    1 +
 drivers/tty/serial/st-asc.c                        |    2 +-
 drivers/tty/serial/stm32-usart.c                   |    3 +-
 drivers/tty/synclink.c                             |   20 +-
 drivers/tty/synclink_gt.c                          |   14 +-
 drivers/tty/synclinkmp.c                           |   14 +-
 drivers/tty/sysrq.c                                |    6 +-
 drivers/tty/tty_buffer.c                           |   12 +-
 drivers/tty/tty_io.c                               |   59 +-
 drivers/tty/tty_ldisc.c                            |    2 +-
 drivers/tty/tty_port.c                             |   28 +-
 drivers/usb/gadget/function/u_serial.c             |    6 +-
 include/linux/dma/hsu.h                            |   11 +-
 include/linux/n_r3964.h                            |    8 +-
 include/linux/platform_data/atmel.h                |    6 -
 include/linux/platform_data/dma-hsu.h              |    4 -
 include/linux/tty.h                                |   48 +-
 net/irda/ircomm/ircomm_tty.c                       |   31 +-
 83 files changed, 2736 insertions(+), 1948 deletions(-)
 create mode 100644 arch/arm64/include/asm/dcc.h
 create mode 100644 drivers/tty/serial/8250/8250_mid.c
