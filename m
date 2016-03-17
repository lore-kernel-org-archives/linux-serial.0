From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.6-rc1
Date: Wed, 16 Mar 2016 17:08:24 -0700
Message-ID: <20160317000824.GA12746@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 18558cae0272f8fd9647e69d3fec1565a794=
9865:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.6-rc1

for you to fetch changes up to a95fc9c8e576dc238ad849f65c67e4fd33c01d3b=
:

  serial: 8250: describe CONFIG_SERIAL_8250_RSA (2016-03-07 16:11:14 -0=
800)

----------------------------------------------------------------
TTY/Serial patches for 4.6-rc1

Here's the big tty/serial driver pull request for 4.6-rc1.

Lots of changes in here, Peter has been on a tear again, with lots of
refactoring and bugs fixes, many thanks to the great work he has been
doing.  Lots of driver updates and fixes as well, full details in the
shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Khoroshilov (1):
      tty: synclinkmp: do not ignore errors in probe()

Andreas F=E4rber (1):
      tty: serial: meson: Add support for XTAL clock input

Andy Shevchenko (5):
      serial: 8250_dw: remove redundant 'else' keyword
      serial: 8250_dw: remove leftover definitions
      serial: 8250_pci: convert to pcim_*() API
      serial: 8250_pci: all known Braswell ports are 1 channel
      serial: 8250: convert drivers to use up_to_u8250p()

Anton Wuerfel (13):
      tty: serial: 8250: Fix whitespace errors
      tty: serial: 8250: Replace spaces with tabs
      tty: serial: 8250: Fix braces after struct
      tty: serial: 8250: Fix multiline comment style
      tty: serial: 8250: Remove else after return
      tty: serial: 8250: Move EXPORT_SYMBOL to function
      tty: serial: 8250: Fix line continuation warning
      tty: serial: 8250: Add parentheses to macro
      tty: serial: 8250: Fix multi-line strings
      tty: serial: 8250: Correct conversion specifiers
      tty: serial: 8250: Merge duplicate conditions
      tty: serial: 8250: Fix indentation warnings
      tty: serial: 8250: Add generic port init macro

Arnd Bergmann (12):
      serial: amba-pl011: mark vendor_zte as __maybe_unused
      tty: nozomi: avoid a harmless gcc warning
      tty: cyclades: cyz_interrupt is only used for PCI
      tty: hvc_xen: hide xen_console_remove when unused
      8250: mediatek: mark PM functions as __maybe_unused
      serial: ifx6x60: avoid uninitialized variable use
      Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-m=
odular"
      Revert "drivers/tty/serial: make 8250/8250_ingenic.c explicitly n=
on-modular"
      serial: 8250/uniphier: fix modular build
      serial: 8250/ingenic: fix building with SERIAL_8250=3Dm
      serial: 8250/mediatek: fix building with SERIAL_8250=3Dm
      serial: sa1100: make sa1100_register_uart_fns a function

Aya Mahfouz (3):
      tty: serial: constify psc_ops structs
      char: constify tty_port_operations structs
      tty: constify tty_port_operations structs

Ed Spiridonov (1):
      serial: pl011: add mark/space parity support

=46rederik V=F6lkel (1):
      serial: Remove 68328 driver

Gabriel Krisman Bertazi (1):
      serial: jsm: change maintainer to myself

Geert Uytterhoeven (6):
      serial: sh-sci: Add more Serial Mode Register documentation
      serial: sh-sci: Preserve SCIFA/SCIFB bit rate config for serial c=
onsole
      serial: sh-sci: Use premultiplier to handle half sampling rate
      serial: sh-sci: Use a bitmask to indicate supported sampling rate=
s
      serial: sh-sci: Add support for SCIFA/SCIFB variable sampling rat=
es
      serial: sh-sci: Remove redundant instances of EARLYCON_DECLARE()

Geliang Tang (1):
      serial: 8250_pci: use to_pci_dev()

Greg Hackmann (1):
      tty: goldfish: support platform_device with id -1

Greg Kroah-Hartman (3):
      Merge 4.5-rc2 into tty-next
      Merge 4.5-rc4 into tty-next
      Revert "sc16is7xx: implemented get_mctrl"

Guenter Roeck (2):
      serial: clps711x: Fix bad usage of IS_ERR_VALUE
      tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE

Jaeden Amero (1):
      serial: atmel: Use atmel_port consistently

Jakob =D8stergaard Jensen (1):
      tty: serial: jsm_tty: fixed redundant variable issue.

Jan Beulich (1):
      serial/8250_pci: simplify Pericom handling

Jean Delvare (2):
      ARM: OMAP: serial: Rename DRIVER_NAME
      serial: 8250: Add hardware dependency to RT288X option

Jeffy Chen (1):
      serial: core: remove baud_rates when serial console setup

Jiri Slaby (11):
      TTY: serial/mpsc, stop leaking mappings
      TTY: serial/mpsc, clean up init/remove functions
      TTY: serial/mpsc, remove unused fields
      TTY: 8250_pnp, constify tables
      TTY: 8250_pnp, make checks bool
      TTY: xtensa/iss/console, remove unused _INLINE_ definition
      TTY: serial/m32r_sio, disband m32r_sio.h
      TTY: serial/m32r_sio, simplify old_serial_port
      TTY: serial/m32r_sio, remove debug macros
      TTY: serial/m32r_sio, remove unused members
      TTY: n_hdlc, fix lockdep false positive

Jon Hunter (1):
      serial: 8250_early: Add earlycon support for Tegra

Julia Lawall (1):
      xen/hvc: constify hv_ops structures

Konstantin Khlebnikov (1):
      TTY, devpts: document pty count limiting

Ludovic Desroches (1):
      tty/serial: at91: fix bad offset for UART timeout register

Maarten Brock (6):
      sc16is7xx: implemented set_mctrl
      sc16is7xx: implemented get_mctrl
      serial-uartlite: Enlarge maximum nr of devices to 16.
      serial-uartlite: Constify uartlite_be/uartlite_le
      serial-uartlite: Spinlock inside the loop.
      serial-uartlite: Configure for rising edge irq trigger.

Maciej S. Szmigiero (1):
      serial: 8250: describe CONFIG_SERIAL_8250_RSA

Maciej W. Rozycki (1):
      serial: zs: Fix a transmit lockup in console output

Martin Fuzzey (1):
      serial: imx: Fix suspend / resume.

Martin Sperl (3):
      dt/bindings: serial: bcm2835: add binding documentation for bcm28=
35-aux-uart
      serial: bcm2835: add driver for bcm2835-aux-uart
      serial: bcm2835: fix unsigned int issue with irq

Mathieu OTHACEHE (1):
      tty: serial: 8250: add MOXA Smartio MUE boards support

Matwey V. Kornilov (5):
      tty: Move serial8250_stop_rx() in front of serial8250_start_tx()
      tty: Add software emulated RS485 support for 8250
      tty: 8250_omap: Use software emulated RS485 direction control
      tty: serial: 8250: Cleanup p->em485 in serial8250_unregister_port
      tty: serial: Use GFP_ATOMIC instead of GFP_KERNEL in serial8250_e=
m485_init()

Melchior FRANZ (1):
      tty: vt: initialize softcursor_original correctly

Michal Simek (1):
      serial: xuartps: Enable OF earlycon support

Miodrag Dinic (1):
      drivers: tty: goldfish: Add device tree bindings

Nicolas Ferre (2):
      serial: atmel: trivial: clean the IP version decoding code
      serial: atmel: add support for new UART version

Noam Camus (3):
      serial: 8250_dw: Avoid serial_outx code duplicate with new dw8250=
_check_lcr()
      serial: 8250_dw: Add support for big-endian MMIO accesses
      serial: 8250_dw: Do not use readl/writel before checking port iot=
ype

Paul Gortmaker (3):
      drivers/tty: make serial 8250_ingenic.c explicitly non-modular
      drivers/tty: make hvc/hvc_vio.c explicitly non-modular
      drivers/tty: make ehv_bytechan.c explicitly non-modular

Peter Hurley (89):
      tty: Fix ldisc leak in failed tty_init_dev()
      tty: Remove !tty check from free_tty_struct()
      tty: Fix tty_init_termios() declaration
      tty: Re-declare tty_driver_remove_tty() file scope
      pty: Remove pty_unix98_shutdown()
      tty: Remove __lockfunc annotation from tty lock functions
      tty: Consolidate noctty checks in tty_open()
      tty: Refactor tty_open()
      staging: digi: Replace open-coded tty_wakeup()
      serial: 68328: Remove bogus ldisc reset
      NFC: nci: Remove dead code
      tty: Remove chars_in_buffer() line discipline method
      tty: Reset c_line from driver's init_termios
      tty: Fix comments for tty_ldisc_get()
      tty: Fix comments for tty_ldisc_release()
      tty: Prepare for destroying line discipline on hangup
      tty: Handle NULL tty->ldisc
      tty: Move tty_ldisc_kill()
      tty: Use 'disc' for line discipline index name
      tty: Refactor tty_ldisc_reinit() for reuse
      tty: Destroy ldisc instance on hangup
      tty: Document c_line =3D=3D N_TTY initial condition
      tty: Avoid unnecessary temporaries for tty->ldisc
      tty: Unexport system-wide tty_mutex
      tty: Eliminate global symbol tty_ldisc_N_TTY
      tty: Remove declarations to non-existent functions
      tty: Move tty_check_change() helper
      tty: Remove unreferenced tty flags macro TTY_DEBUG
      tty: Make tty_files_lock per-tty
      tty: audit: Early-out pty master reads earlier
      tty: audit: Never audit packet mode
      tty: audit: Remove icanon mode from call chain
      tty: audit: Defer audit buffer association
      tty: audit: Take siglock directly
      tty: audit: Ignore current association for audit push
      tty: audit: Combine push functions
      tty: audit: Track tty association with dev_t
      tty: audit: Handle tty audit enable atomically
      tty: audit: Remove false memory optimization
      tty: audit: Remove tty_audit_buf reference counting
      tty: audit: Simplify first-use allocation
      tty: audit: Check audit enable first
      tty: audit: Always push audit buffer before TIOCSTI
      tty: audit: Poison tty_audit_buf while process exits
      n_tty: Always wake up read()/poll() if new input
      tty, n_tty: Remove fasync() ldisc notification
      tty: Add fasync() hung up file operation
      tty: Fix ioctl(FIOASYNC) on hungup file
      n_tty: Fix stuck write wakeup
      n_tty: Remove tty count checks from unthrottle
      tty: n_tty: fix SIGIO for output
      serial: 8250: Refactor serial8250_rx_chars() inner loop
      serial: 8250: Fix lost rx state
      serial: 8250: Remove low_latency workaround
      serial: 8250: Unlink uart console ptr if console setup fails
      serial: 8250: Wait for irq to complete before shutdown
      serial: 8250: Unfold < 80 char lines
      tty: rocket: Remove private close_wait
      n_tty: Ignore all read data when closing
      ia64: Pin controlling tty for unaligned fault message
      staging: dgap: Remove redundant write_wait wakeups
      tty: Fix GPF in flush_to_ldisc(), part 2
      tty: Unify receive_buf() code paths
      tty: Allow unreadable mess to be > 80 chars
      tty: Use termios c_*flag macros
      serial: core: Fold __uart_put_char() into caller
      serial: core: Fold do_uart_get_info() into caller
      serial: core: Use tty->index for port # in debug messages
      serial: Fix ASYNC_* =3D> UPF_* flags misuse
      serial: core: Cleanup uart_open() exit
      serial: core: Remove cast from void ptr in uart_open()
      serial: core: Unfold < 80 char lines
      serial: core: Perform RTS signalling before soft flow ctrl
      tty: mxser: Remove ASYNC_CLOSING
      isdn: Remove ASYNC_CLOSING
      tty: Remove ASYNC_CLOSING
      of: earlycon: of_setup_earlycon() requires CONFIG_OF_EARLY_FLATTR=
EE
      earlycon: Use common framework for earlycon declarations
      serial: earlycon: Fixup earlycon console name and index
      of: earlycon: Fixup earlycon console name and index
      of: earlycon: Add options string handling
      of: earlycon: Initialize port fields from DT properties
      of: earlycon: Move address translation to of_setup_earlycon()
      serial: earlycon: Common log banner for command line and DT
      serial: earlycon: Show the earlycon "driver" in banner
      serial: 8250_early: Use port->regshift
      of: earlycon: Log more helpful message if stdout-path node not fo=
und
      serial: 8250_omap: Add omap8250 earlycon
      net: irda: Fix use-after-free in irtty_open()

Phillip Raffeck (2):
      tty: serial: 8250: Suitably replace printk
      tty: serial: 8250: Remove SERIAL_DEBUG_PNP macro

Rich Felker (2):
      serial-uartlite: add earlycon support
      serial-uartlite: fix missing locking in isr

Robin Murphy (1):
      tty: amba-pl011: don't dereference NULL platform data

Romain Izard (2):
      tty/serial: at91: restore dynamic driver binding
      serial: mctrl_gpio: Add missing module license

Saurabh Sengar (1):
      tty/vt/keyboard: use memdup_user to simplify code

Sebastian Frias (1):
      8250: use callbacks to access UART_DLL/UART_DLM

Simon Horman (2):
      serial: sh-sci: Add device tree support for r8a7792
      tty: sh-sci: Use ARCH_RENESAS

Soren Brinkmann (14):
      tty: xuartps: Beautify read-modify writes
      tty: xuartps: Use spinlock to serialize HW access
      tty: xuartps: Don't consider circular buffer when enabling transm=
itter
      tty: xuartps: Clear interrupt status register in shutdown
      tty: xuartps: Improve startup function
      tty: xuartps: Keep lock for whole ISR
      tty: xuartps: Acquire port lock for shutdown
      tty: xuartps: Move RX path into helper function
      tty: xuartps: Move request_irq to after setting up the HW
      tty: xuartps: Refactor IRQ handling
      tty: xuartps: Cleanup: Reformat if-else
      tty: xuartps: Improve sysrq handling
      tty: xuartps: Remove '_OFFSET' suffix from #defines
      tty: xuartps: Consolidate TX handling

Sudip Mukherjee (1):
      tty: audit: remove unused variable

Timur Tabi (1):
      serial: amba-pl011: use cpu_relax when polling registers

Wang Dongsheng (1):
      serial: 8250: of: Enable suspend/resume for 8250_of driver

Wills Wang (1):
      sc16is7xx: fix incorrect register bits macro

Wilson Ding (1):
      serial: mvebu-uart: initial support for Armada-3700 serial port

Yoshinori Sato (1):
      serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support

Youngmin Nam (1):
      serial: samsung: optimize UART rx fifo access routine

 Documentation/devicetree/bindings/goldfish/tty.txt |   17 +
 .../bindings/serial/brcm,bcm2835-aux-uart.txt      |   18 +
 .../bindings/serial/renesas,sci-serial.txt         |    2 +
 .../devicetree/bindings/tty/serial/mvebu-uart.txt  |   13 +
 Documentation/filesystems/devpts.txt               |    9 +
 Documentation/kernel-parameters.txt                |    6 +
 Documentation/serial/tty.txt                       |    3 -
 Documentation/sysctl/kernel.txt                    |    1 +
 MAINTAINERS                                        |    2 +-
 arch/alpha/include/asm/serial.h                    |    8 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 arch/frv/include/asm/serial.h                      |    2 +-
 arch/ia64/kernel/unaligned.c                       |    7 +-
 arch/m68k/include/asm/serial.h                     |    8 +-
 arch/mips/pmcs-msp71xx/msp_serial.c                |    2 +-
 arch/mn10300/include/asm/serial.h                  |   10 +-
 arch/xtensa/platforms/iss/console.c                |    4 -
 arch/xtensa/platforms/xt2000/setup.c               |    2 +-
 drivers/char/pcmcia/synclink_cs.c                  |   21 +-
 drivers/char/ttyprintk.c                           |    2 +-
 drivers/isdn/i4l/isdn_tty.c                        |   12 +-
 drivers/mmc/card/sdio_uart.c                       |   14 +-
 drivers/net/irda/irtty-sir.c                       |   10 -
 drivers/of/fdt.c                                   |   32 +-
 drivers/of/fdt_address.c                           |   11 +-
 drivers/s390/char/con3215.c                        |    3 +-
 drivers/staging/dgap/dgap.c                        |   36 +-
 drivers/staging/dgnc/dgnc_tty.c                    |   20 +-
 drivers/tty/Kconfig                                |    2 +-
 drivers/tty/amiserial.c                            |   28 +-
 drivers/tty/cyclades.c                             |   22 +-
 drivers/tty/ehv_bytechan.c                         |   40 +-
 drivers/tty/goldfish.c                             |   42 +-
 drivers/tty/hvc/hvc_vio.c                          |   29 +-
 drivers/tty/hvc/hvc_xen.c                          |    6 +-
 drivers/tty/isicom.c                               |    3 +-
 drivers/tty/mxser.c                                |   21 +-
 drivers/tty/n_gsm.c                                |   22 +-
 drivers/tty/n_hdlc.c                               |   19 +-
 drivers/tty/n_tty.c                                |  117 +-
 drivers/tty/nozomi.c                               |    2 +-
 drivers/tty/pty.c                                  |   30 +-
 drivers/tty/rocket.c                               |   18 +-
 drivers/tty/rocket_int.h                           |    1 -
 drivers/tty/serial/68328serial.c                   | 1322 ------------=
--------
 drivers/tty/serial/8250/8250.h                     |   14 +
 drivers/tty/serial/8250/8250_accent.c              |   13 +-
 drivers/tty/serial/8250/8250_acorn.c               |    2 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  146 +++
 drivers/tty/serial/8250/8250_boca.c                |   41 +-
 drivers/tty/serial/8250/8250_core.c                |   30 +-
 drivers/tty/serial/8250/8250_dw.c                  |  137 +-
 drivers/tty/serial/8250/8250_early.c               |   38 +-
 drivers/tty/serial/8250/8250_exar_st16c554.c       |   17 +-
 drivers/tty/serial/8250/8250_fourport.c            |   28 +-
 drivers/tty/serial/8250/8250_gsc.c                 |    7 +-
 drivers/tty/serial/8250/8250_hp300.c               |   27 +-
 drivers/tty/serial/8250/8250_hub6.c                |    2 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   14 +-
 drivers/tty/serial/8250/8250_moxa.c                |  157 +++
 drivers/tty/serial/8250/8250_mtk.c                 |   51 +-
 drivers/tty/serial/8250/8250_of.c                  |    1 +
 drivers/tty/serial/8250/8250_omap.c                |   40 +-
 drivers/tty/serial/8250/8250_pci.c                 |  147 +--
 drivers/tty/serial/8250/8250_pnp.c                 |   48 +-
 drivers/tty/serial/8250/8250_port.c                |  462 +++++--
 drivers/tty/serial/8250/8250_uniphier.c            |    2 +-
 drivers/tty/serial/8250/Kconfig                    |   51 +-
 drivers/tty/serial/8250/Makefile                   |    2 +
 drivers/tty/serial/8250/serial_cs.c                |   90 +-
 drivers/tty/serial/Kconfig                         |   42 +-
 drivers/tty/serial/Makefile                        |    2 +-
 drivers/tty/serial/amba-pl011.c                    |   24 +-
 drivers/tty/serial/arc_uart.c                      |    1 -
 drivers/tty/serial/atmel_serial.c                  |  180 ++-
 drivers/tty/serial/clps711x.c                      |   10 +-
 drivers/tty/serial/crisv10.c                       |   33 +-
 drivers/tty/serial/digicolor-usart.c               |    9 +-
 drivers/tty/serial/earlycon.c                      |  118 +-
 drivers/tty/serial/ifx6x60.c                       |    3 +
 drivers/tty/serial/imx.c                           |    5 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |   13 +-
 drivers/tty/serial/m32r_sio.c                      |  134 +-
 drivers/tty/serial/m32r_sio.h                      |   49 -
 drivers/tty/serial/meson_uart.c                    |    8 +-
 drivers/tty/serial/mpc52xx_uart.c                  |    8 +-
 drivers/tty/serial/mpsc.c                          |  178 ++-
 drivers/tty/serial/msm_serial.c                    |    2 -
 drivers/tty/serial/mvebu-uart.c                    |  650 ++++++++++
 drivers/tty/serial/omap-serial.c                   |    2 +-
 drivers/tty/serial/samsung.c                       |   24 +-
 drivers/tty/serial/sc16is7xx.c                     |   24 +-
 drivers/tty/serial/serial_core.c                   |  125 +-
 drivers/tty/serial/serial_ks8695.c                 |    2 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |    3 +
 drivers/tty/serial/sh-sci.c                        |  178 ++-
 drivers/tty/serial/sh-sci.h                        |   15 +
 drivers/tty/serial/sprd_serial.c                   |    2 -
 drivers/tty/serial/uartlite.c                      |   61 +-
 drivers/tty/serial/xilinx_uartps.c                 |  543 ++++----
 drivers/tty/serial/zs.c                            |    4 +
 drivers/tty/synclink.c                             |   23 +-
 drivers/tty/synclink_gt.c                          |   19 +-
 drivers/tty/synclinkmp.c                           |   63 +-
 drivers/tty/tty_audit.c                            |  237 +---
 drivers/tty/tty_buffer.c                           |   39 +-
 drivers/tty/tty_io.c                               |  267 ++--
 drivers/tty/tty_ioctl.c                            |   12 +-
 drivers/tty/tty_ldisc.c                            |  198 +--
 drivers/tty/tty_mutex.c                            |    8 +-
 drivers/tty/tty_port.c                             |   11 +-
 drivers/tty/vt/keyboard.c                          |   14 +-
 drivers/tty/vt/selection.c                         |    2 +
 drivers/tty/vt/vt.c                                |    2 +-
 drivers/usb/serial/console.c                       |    6 +-
 drivers/usb/serial/cypress_m8.c                    |    3 +-
 drivers/usb/serial/digi_acceleport.c               |    8 +-
 drivers/usb/serial/io_edgeport.c                   |    4 +-
 drivers/usb/serial/mct_u232.c                      |    2 +-
 drivers/usb/serial/mos7720.c                       |    4 +-
 drivers/usb/serial/mos7840.c                       |    4 +-
 include/asm-generic/vmlinux.lds.h                  |    6 +-
 include/linux/atmel_serial.h                       |    3 +-
 include/linux/audit.h                              |    4 +
 include/linux/isdn.h                               |    1 +
 include/linux/of_fdt.h                             |    2 +-
 include/linux/platform_data/sa11x0-serial.h        |    8 +-
 include/linux/platform_data/serial-omap.h          |    2 +-
 include/linux/sched.h                              |    1 -
 include/linux/serial_8250.h                        |    8 +
 include/linux/serial_core.h                        |   25 +-
 include/linux/tty.h                                |   58 +-
 include/linux/tty_ldisc.h                          |   13 -
 include/uapi/linux/serial_core.h                   |    3 +
 kernel/audit.c                                     |   27 +-
 net/irda/ircomm/ircomm_tty.c                       |   15 +-
 net/irda/ircomm/ircomm_tty_ioctl.c                 |   13 +-
 net/nfc/nci/uart.c                                 |    9 +-
 security/selinux/hooks.c                           |    4 +-
 139 files changed, 3447 insertions(+), 3701 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/goldfish/tty.txt
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm28=
35-aux-uart.txt
 create mode 100644 Documentation/devicetree/bindings/tty/serial/mvebu-=
uart.txt
 delete mode 100644 drivers/tty/serial/68328serial.c
 create mode 100644 drivers/tty/serial/8250/8250_bcm2835aux.c
 create mode 100644 drivers/tty/serial/8250/8250_moxa.c
 delete mode 100644 drivers/tty/serial/m32r_sio.h
 create mode 100644 drivers/tty/serial/mvebu-uart.c
