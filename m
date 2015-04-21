From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.1-rc1
Date: Tue, 21 Apr 2015 12:10:32 +0200
Message-ID: <20150421101032.GA4733@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit f22e6e847115abc3a0e2ad7bb18d243d4227=
5af1:

  Linux 4.0-rc7 (2015-04-06 15:39:45 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.1-rc1

for you to fetch changes up to 5dbc32a88f1e73f244e6134fc119dd4d60a398c0=
:

  n_gsm: Drop unneeded cast on netdev_priv (2015-04-10 14:43:48 +0200)

----------------------------------------------------------------
TTY/Serial patches for 4.1-rc1

Here's the big tty/serial driver update for 4.1-rc1.

It was delayed for a bit due to some questions surrounding some of the
console command line parsing changes that are in here.  There's still
one tiny regression for people who were previously putting multiple
console command lines and expecting them all to be ignored for some odd
reason, but Peter is working on fixing that.  If not, I'll send a rever=
t
for the offending patch, but I have faith that Peter can address it.

Other than the console work here, there's the usual serial driver
updates and changes, and a buch of 8250 reworks to try to make that
driver easier to maintain over time, and have it support more devices i=
n
the future.

All of these have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Brodkin (1):
      serial/8250_dw: use platform_get_irq() instead of platform_get_re=
source()

Andy Shevchenko (11):
      serial: 8250_pci: convert to dev_pm_ops
      dmaengine: append hsu DMA driver
      serial: 8250_pci: add Intel Penwell ports
      x86, intel-mid: remove Intel MID specific serial support
      serial, x86: use UPF_* constants for flags
      serial: 8250_pci: replace switch-case by formula
      serial: 8250_pci: replace switch-case by formula for Intel MID
      dmaengine: hsu: add Intel Tangier PCI ID
      serial: 8250_pci: add Intel Tangier support
      dmaengine: hsu: remove redundant pieces of code
      dmaengine: hsu: move memory allocation to GFP_NOWAIT

Arnd Bergmann (1):
      serial: pl010 is no longer broken

Axel Lin (1):
      serial: ar933x_uart: Fix off-by-one for checking valid alias id

Christophe Leroy (1):
      tty: cpm_uart: replace CONFIG_8xx by CONFIG_CPM1

Dan Carpenter (1):
      serial: jsm: some off by one bugs

Dave Martin (2):
      serial/amba-pl011: Activate TX IRQ passively
      serial/amba-pl011: Leave the TX IRQ alone when the UART is not op=
en

Dmitry Torokhov (1):
      serial: 8250_dw: fix 'cts-override'

Doug Kehn (1):
      tty/serial: omap: fix !wakeirq message

=46abian Frederick (3):
      serial: core: replace current->state by __set_current_state()
      tty/hvc_opal: constify of_device_id array
      tty: constify of_device_id array

=46abio Estevam (4):
      serial: imx: Do not store/restore the UBRC register
      serial: mxs-auart: Fix build error
      serial: mctrl_gpio: Fix build warnings
      serial: imx: Add braces to avoid ambiguous 'else'

Greg Kroah-Hartman (4):
      Merge 4.0-rc3 into tty-testing
      Merge 4.0-rc5 into tty-next
      tty: clean up the tty time logic a bit
      Merge 4.0-rc7 into tty-next

Hao Liang (1):
      bfin uart: it will hang when read current y count if not disable =
dma irq

Heikki Krogerus (2):
      serial: 8250_dw: remove useless ACPI ID check
      serial: 8250_dw: only get the clock rate in one place

Jakub Kicinski (4):
      sc16is7xx: remove ports on probe error path
      sc16is7xx: don't wipe out port configuration on shutdown
      sc16is7xx: enable the clock
      sc16is7xx: expose RTS inversion in RS-485 mode

Jorge Ramirez-Ortiz (2):
      drivers/tty: amba: defer DMA probe until the DMA channel is requi=
red.
      drivers/tty: serial: remove info message

Joseph Kogut (1):
      tty: serial: s/Medfile/Medfield

Julia Lawall (1):
      n_gsm: Drop unneeded cast on netdev_priv

Ken Xue (1):
      serial: 8250_dw: add support for AMD SOC Carrizo

Kevin Hao (1):
      tty: kconfig: remove the superfluous dependency on PPC_OF

Lad, Prabhakar (3):
      tty: serial/bcm63xx_uart: fix sparse warning
      tty: vt/vt: fix sparse warning
      tty/n_gsm: fix sparse warning

Leilei Zhao (5):
      tty/serial: at91: correct check of buf used in DMA
      tty/serial: at91: correct buffer size used in DMA
      tty/serial: at91: revise the return type of atmel_init_property
      tty/serial: at91: set ops in property init each time
      tty/serial: at91: correct the usage of tasklet

Mans Rullgard (2):
      serial: 8250: allow specifying iomem size in addition to address
      serial: of: set port iomem size from devicetree

Michal Simek (1):
      tty: serial: 8250_core: Remove trailing whitespaces

Mika Westerberg (1):
      serial: 8250_dw: Add missing MODULE_ALIAS() for module autoloadin=
g support

Nicholas Mc Guire (3):
      tty: max3100: use msecs_to_jiffies for time conversion
      vt: vt_ioctl: use msecs_to_jiffies for time conversion
      vt: use msecs_to_jiffies for time conversion

Nobuhiro Iwamatsu (2):
      serial: sh-sci: Add overrun handling of SCIFA and SCIFB
      serial: sh-sci: Update calculation of timeout for DMA

Paul Bolle (1):
      sprd_serial: compile sprd_suspend and sprd_resume conditionally

Peter Crosthwaite (1):
      tty: serial: xilinx_uartps: Use Macro for ttyPS0

Peter Hung (2):
      serial: 8250_pci: remove non-used var for F81504
      serial: 8250_pci: port failed after wakeup from S3

Peter Hurley (35):
      serial: sprd: Fix iotype
      serial: earlycon: Refactor parse_options into serial core
      console: Preserve index after console setup()
      serial: core: Add minor field to uart_port
      serial: 8250: Compute ttyS index from port minor
      serial: 8250: Remove duplicate ->handle_irq initialization
      serial: 8250: Simplify capabilities reset at port unregister
      serial: 8250: Move ns16550a_goto_hispeed() to local header
      serial: 8250: Decouple core from skip_txen_test module param
      console: Add extensible console matching
      serial: core: Fix kernel doc for uart_console_write()
      serial: 8250_early: Remove early_device variable
      serial: earlycon: Move ->uartclk initialize
      serial: 8250_early: Assume uart already initialized if no baud op=
tion
      serial: 8250_early: Fix setup() error code
      serial: earlycon: Ignore parse_options() error code
      serial: earlycon: Skip parse_options() if empty string
      serial: earlycon: Refactor earlycon registration
      serial: earlycon: Enable earlycon without command line param
      serial: 8250_early: Remove setup_early_serial8250_console()
      serial: 8250: Separate 8250 console interface
      serial: 8250: Separate legacy irq handling from core port operati=
ons
      serial: 8250: Separate port initialization
      serial: 8250: Encapsulate port i/o method init
      serial: 8250: Initialize fixed type fields when setting defaults
      serial: 8250: Initialize default dma handlers when setting defaul=
ts
      serial: 8250: Get RSA resource iff CONFIG_SERIAL_8250_RSA
      serial: 8250: Only get RSA resource when required
      serial: 8250: Decouple RSA probe
      serial: 8250: Declare base port operations const
      serial: 8250: Validate reg addr for Au1x00/RT288x i/o accessors
      serial: 8250: Check UART_SCR is writable
      earlycon: Fix __earlycon_table stride
      earlycon: 8250: Fix command line regression
      earlycon: 8250: Document kernel command line options

Sanjeev Sharma (1):
      serial:imx make of_device_id array const

Stephen Boyd (2):
      tty: serial: msm_serial: Remove dead code
      tty: serial: Remove orphaned serial driver

Takashi Iwai (1):
      tty: Use static attribute groups for sysfs entries

Thomas Betker (5):
      serial: xuartps: Fix register space size.
      serial: xuartps: Fix cdns_uart_port[] definition.
      serial: xuartps: Fix iobase use.
      serial: xuartps: Get rid of register access macros.
      serial: xuartps: Fix check in console_setup().

Uwe Kleine-K=F6nig (12):
      serial: atmel: fix error handling when mctrl_gpio_init fails
      serial: clps711x: fail if mctrl_gpio_init fails
      serial: mxs-auart: properly handle mctrl_gpio failing
      serial: mctrl-gpio: don't check for struct mctrl_gpios * to be in=
valid
      serial: mctrl-gpio: simplify init routine
      serial: imx: Fix clearing of receiver overrun flag
      serial: imx: remove long dead code
      serial: imx: drop members from driver data that are only used dur=
ing probe
      serial: imx: reformat and cleanup copyright header
      serial: imx: fix comment about which machines use the i.MX21 type
      serial: imx: drop support for IRDA
      serial: imx: add support for half duplex rs485

Wang Long (1):
      serial: 8250: remove the redundant include

 Documentation/kernel-parameters.txt                |   18 +-
 arch/mips/mti-malta/malta-init.c                   |    4 +-
 arch/x86/Kconfig.debug                             |    4 -
 arch/x86/include/asm/intel-mid.h                   |    3 -
 arch/x86/include/asm/serial.h                      |    8 +-
 arch/x86/kernel/early_printk.c                     |    6 -
 arch/x86/platform/intel-mid/Makefile               |    1 -
 .../platform/intel-mid/early_printk_intel_mid.c    |  112 --
 drivers/dma/Kconfig                                |    2 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/hsu/Kconfig                            |   14 +
 drivers/dma/hsu/Makefile                           |    5 +
 drivers/dma/hsu/hsu.c                              |  495 ++++++
 drivers/dma/hsu/hsu.h                              |  118 ++
 drivers/dma/hsu/pci.c                              |  124 ++
 drivers/firmware/pcdp.c                            |    4 +-
 drivers/tty/hvc/hvc_opal.c                         |    2 +-
 drivers/tty/n_gsm.c                                |   12 +-
 drivers/tty/serial/8250/8250.h                     |   23 +-
 drivers/tty/serial/8250/8250_core.c                |  493 +++--
 drivers/tty/serial/8250/8250_dw.c                  |   58 +-
 drivers/tty/serial/8250/8250_early.c               |   69 +-
 drivers/tty/serial/8250/8250_em.c                  |    1 -
 drivers/tty/serial/8250/8250_hp300.c               |    1 -
 drivers/tty/serial/8250/8250_omap.c                |    1 -
 drivers/tty/serial/8250/8250_pci.c                 |  414 +++--
 drivers/tty/serial/8250/Kconfig                    |    1 +
 drivers/tty/serial/Kconfig                         |   32 +-
 drivers/tty/serial/Makefile                        |    2 -
 drivers/tty/serial/amba-pl011.c                    |  234 +--
 drivers/tty/serial/apbuart.c                       |    2 +-
 drivers/tty/serial/ar933x_uart.c                   |    2 +-
 drivers/tty/serial/atmel_serial.c                  |   29 +-
 drivers/tty/serial/bcm63xx_uart.c                  |    4 +-
 drivers/tty/serial/bfin_uart.c                     |    2 +
 drivers/tty/serial/clps711x.c                      |    2 +
 drivers/tty/serial/cpm_uart/Makefile               |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart.h             |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |    2 +-
 drivers/tty/serial/earlycon.c                      |  140 +-
 drivers/tty/serial/fsl_lpuart.c                    |    2 +-
 drivers/tty/serial/imx.c                           |  317 ++--
 drivers/tty/serial/jsm/jsm_cls.c                   |    2 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |    6 +-
 drivers/tty/serial/max3100.c                       |    2 +-
 drivers/tty/serial/mfd.c                           | 1505 ------------=
----
 drivers/tty/serial/mpc52xx_uart.c                  |    2 +-
 drivers/tty/serial/msm_serial.h                    |    9 -
 drivers/tty/serial/msm_serial_hs.c                 | 1874 ------------=
--------
 drivers/tty/serial/mxs-auart.c                     |   18 +-
 drivers/tty/serial/of_serial.c                     |    5 +-
 drivers/tty/serial/omap-serial.c                   |   10 +-
 drivers/tty/serial/pmac_zilog.c                    |    2 +-
 drivers/tty/serial/pxa.c                           |    2 +-
 drivers/tty/serial/sc16is7xx.c                     |   46 +-
 drivers/tty/serial/serial-tegra.c                  |    2 +-
 drivers/tty/serial/serial_core.c                   |   52 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |   50 +-
 drivers/tty/serial/sh-sci.c                        |   88 +-
 drivers/tty/serial/sirfsoc_uart.c                  |    2 +-
 drivers/tty/serial/sprd_serial.c                   |    6 +-
 drivers/tty/serial/st-asc.c                        |    2 +-
 drivers/tty/serial/uartlite.c                      |    2 +-
 drivers/tty/serial/ucc_uart.c                      |    2 +-
 drivers/tty/serial/xilinx_uartps.c                 |  242 +--
 drivers/tty/tty_io.c                               |   24 +-
 drivers/tty/vt/vt.c                                |   74 +-
 drivers/tty/vt/vt_ioctl.c                          |    2 +-
 include/asm-generic/vmlinux.lds.h                  |    9 +
 include/linux/console.h                            |    3 +-
 include/linux/dma/hsu.h                            |   48 +
 include/linux/platform_data/dma-hsu.h              |   25 +
 include/linux/platform_data/msm_serial_hs.h        |   49 -
 include/linux/platform_data/serial-imx.h           |    5 -
 include/linux/serial_8250.h                        |   20 +-
 include/linux/serial_core.h                        |   23 +-
 include/linux/serial_mfd.h                         |   47 -
 include/uapi/linux/serial_reg.h                    |   19 -
 kernel/printk/printk.c                             |   53 +-
 79 files changed, 2357 insertions(+), 4743 deletions(-)
 delete mode 100644 arch/x86/platform/intel-mid/early_printk_intel_mid.=
c
 create mode 100644 drivers/dma/hsu/Kconfig
 create mode 100644 drivers/dma/hsu/Makefile
 create mode 100644 drivers/dma/hsu/hsu.c
 create mode 100644 drivers/dma/hsu/hsu.h
 create mode 100644 drivers/dma/hsu/pci.c
 delete mode 100644 drivers/tty/serial/mfd.c
 delete mode 100644 drivers/tty/serial/msm_serial_hs.c
 create mode 100644 include/linux/dma/hsu.h
 create mode 100644 include/linux/platform_data/dma-hsu.h
 delete mode 100644 include/linux/platform_data/msm_serial_hs.h
 delete mode 100644 include/linux/serial_mfd.h
