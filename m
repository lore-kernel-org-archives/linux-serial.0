Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE82C11F67
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 17:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442FA6197B
	for <linux-serial@archiver.kernel.org>; Mon,  5 Jul 2021 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhGERPo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 5 Jul 2021 13:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhGERPo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Jul 2021 13:15:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF5061166;
        Mon,  5 Jul 2021 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625505186;
        bh=OB9lX34Vc0z0TKFup/CIDFjNXkaFwAQposKO96nIrEU=;
        h=Date:From:To:Cc:Subject:From;
        b=sq20ciX9R7HsF2QQzyQpVoZl/xJRnol1Gpf1565jtaF4ws0W4Q7iPfnTXOd37rrpQ
         uAsRXaitxMUuAyAAnHc58UoEZumsif3Ej+vX0hq52CNo4JUSOdaW+0WtX5cwmdySxe
         //J4zwL6v07yhwf+8LI+NALCbqYhJddMLVxhuRb0=
Date:   Mon, 5 Jul 2021 19:13:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 5.14-rc1
Message-ID: <YOM9n3QwCwN/2FiW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-5.14-rc1

for you to fetch changes up to 15279ebe99d7c6142d9f1a6ae4ded66c0f168678:

  serial: mvebu-uart: remove unused member nb from struct mvebu_uart (2021-06-25 13:53:51 +0200)

----------------------------------------------------------------
TTY / Serial patches for 5.14-rc1

Here is the big set of tty and serial driver patches for 5.14-rc1.

A bit more than normal, but nothing major, lots of cleanups.  Highlights
are:
	- lots of tty api cleanups and mxser driver cleanups from Jiri
	- build warning fixes
	- various serial driver updates
	- coding style cleanups
	- various tty driver minor fixes and updates
	- removal of broken and disable r3964 line discipline (finally!)

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andreas Färber (1):
      dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK1808

Andy Shevchenko (4):
      vt: Move custom isspace() to its own namespace
      serial: max310x: Try to get crystal clock rate from property
      serial: sc16is7xx: Use devm_clk_get_optional()
      serial: 8250_exar: Extract exar_get_platform() helper

Baokun Li (1):
      tty: tty_ldisc: fix doc warnings in tty_ldisc.c

Biju Das (2):
      serial: sh-sci: Add support for RZ/G2L SoC
      serial: sh-sci: Add support for RZ/G2L SoC

Christophe JAILLET (5):
      serial: 8250: Use 'hlist_for_each_entry' to simplify code
      serial: 8250: Add an empty line and remove some useless {}
      tty: nozomi: Fix a resource leak in an error handling function
      tty: nozomi: Fix the error handling path of 'nozomi_card_init()'
      tty: serial: 8250: serial_cs: Fix a memory leak in error handling path

Colin Ian King (5):
      serial: qcom_geni_serial: redundant initialization to variable line
      serial: meson: remove redundant initialization of variable id
      serial: kgdb_nmi: remove redundant initialization of variable c
      tty: pty: remove redundant initialization of variable fd
      ttyprintk: remove redundant initialization of variable i

Dan Carpenter (1):
      serial: 8250_omap: fix a timeout loop condition

Daniel Mack (1):
      serial: tty: uartlite: fix console setup

Dmitry Baryshkov (1):
      serial: qcom_geni_serial: use DT aliases according to DT bindings

Erwan Le Ray (1):
      serial: stm32: defer probe for dma devices

Fabien Lahoudere (2):
      serial: imx: Add DMA buffer configuration via DT
      ARM: dts: imx53-ppd: add dma-info nodes

Geert Uytterhoeven (1):
      serial: sh-sci: Remove unused STEPFN() macro

Greg Kroah-Hartman (4):
      Revert "serial: sh-sci: Add support for RZ/G2L SoC"
      Merge 5.13-rc4 into tty-next
      Merge tag 'v5.13-rc6' into tty-next
      Revert "tty: serial: Add UART driver for Cortina-Access platform"

Guenter Roeck (1):
      tty: hvc_iucv: Drop unnecessary NULL check after container_of

Jason Li (1):
      tty: serial: Add UART driver for Cortina-Access platform

Jim Quinlan (1):
      serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271

Jinchao Wang (1):
      serial: Prefer unsigned int to bare use of unsigned

Jiri Slaby (111):
      tty: remove broken r3964 line discipline
      n_tty: remove n_tty_receive_char wrapper
      n_tty: remove n_tty_receive_char_fast
      n_tty: drop n_tty_receive_buf_fast
      n_tty: drop parmrk_dbl from n_tty_receive_char
      n_tty: move lnext handling
      n_tty: make n_tty_receive_char_special return void
      n_tty: do only one cp dereference in n_tty_receive_buf_standard
      n_tty: invert TTY_NORMAL condition in n_tty_receive_buf_standard
      n_tty: remove superfluous return from n_tty_receive_signal_char
      tty: make fp of tty_ldisc_ops::receive_buf{,2} const
      tty: cumulate and document tty_struct::flow* members
      tty: cumulate and document tty_struct::ctrl* members
      tty: set tty_ldisc_ops::num statically
      n_gsm: use goto-failpaths in gsm_init
      tty: make tty_ldisc_ops a param in tty_unregister_ldisc
      tty: drop tty_ldisc_ops::refcount
      tty: no checking of tty_unregister_ldisc
      tty: return void from tty_unregister_ldisc
      ti-st: use goto-failpath in st_core_init
      ti-st: use tty_write_room
      tty: make tty_operations::write_room return uint
      tty: make tty_buffer_space_avail return uint
      tty: remove tty_operations::chars_in_buffer for non-buffering
      tty: make tty_operations::chars_in_buffer return uint
      nozomi: simplify ntty_chars_in_buffer
      tty: remove empty tty_operations::flush_buffer
      tty: remove empty tty_operations::set_termios
      isdn: capi, remove optional tty ops
      isdn: capi, drop useless pr_debugs
      tty: remove unused tty_throttle
      tty/serial: clean up uart_match_port
      tty/serial: make port of serial8250_register_8250_port const
      tty: fix kernel-doc for tty_{read,write}
      tty: fix kernel-doc for {start,stop}_tty
      ipwireless: remove unused ipw_tty::closing
      tty: make tty_get_{char,frame}_size available
      mxs-auart: redefine AUART_LINECTRL_WLEN to accept bits count
      cypress_m8: switch data_bits to real character bits
      tty: make use of tty_get_{char,frame}_size
      mxser: drop ISA support
      mxser: renumber mxser_cards
      mxser: remove info printout from init
      mxser: integrate mxser.h into .c
      mxser: cleanup Gpci_uart_info struct
      mxser: rename CheckIsMoxaMust to mxser_get_must_hwid
      mxser: rename mxser_board::chip_flag to must_hwid
      mxser: introduce enum mxser_must_hwid
      mxser: drop constant board::uart_type
      mxser: move max_baud from port to board
      mxser: remove nonsense from ISR
      mxser: cleanup LSR handling in mxser_receive_chars
      mxser: extract port ISR
      mxser: simplify mxser_interrupt and drop mxser_board::vector_mask
      mxser: extract mxser_receive_chars_new
      mxser: extract mxser_receive_chars_old
      mxser: remove else from LSR bits checks
      mxser: correct types for uart variables
      mxser: make xmit ring buffer variables unsigned
      mxser: drop UART_MCR_AFE and UART_LSR_SPECIAL defines
      mxser: drop unused MOXA_DIAGNOSE macro
      mxser: remove MOXA_GET_MAJOR deprecated ioctl
      mxser: remove MOXA_SET_BAUD_METHOD ioctl
      mxser: remove MOXA_ASPP_MON and friends
      mxser: remove MOXA_ASPP_LSTATUS ioctl
      mxser: remove MOXA_CHKPORTENABLE ioctl
      mxser: remove MOXA_GETDATACOUNT ioctl
      mxser: remove MOXA_GETMSTATUS ioctl
      mxser: remove MOXA_ASPP_OQUEUE ioctl
      mxser: remove MOXA_HighSpeedOn ioctl
      mxser: remove cnt from mxser_receive_chars
      mxser: don't allocate MXSER_PORTS + 1
      mxser: drop unused mxser_port::normal_termios
      mxser: remove unused mxser_port::stop_rx
      mxser: drop mxser_port::baud_base
      mxser: drop mxser_port::custom_divisor
      mxser: cleanup mxser_change_speed
      mxser: extract mxser_ioctl_op_mode
      mxser: simplify mxser_ioctl_op_mode
      mxser: dedup mxser_must_set_enhance_mode
      mxser: introduce mxser_must_select_bank and use it
      mxser: clean up the rest of MUST helpers
      mxser: move board init into mxser_initbrd
      mxser: inline mxser_board_remove into mxser_remove
      mxser: pci, switch to managed resources
      mxser: move request irq to probe and switch to managed
      mxser: remove info message from probe
      mxser: remove mxser_cardinfo
      mxser: cleanup mxser_process_txrx_fifo
      mxser: rework and simplify mxser_open
      mxser: make mxser_board::idx really an index
      mxser: alloc struct mxser_board dynamically
      mxser: alloc only needed # of ports
      mxser: remove pointless ioaddr checks
      mxser: cleanup mxser_rs_break
      mxser: cleanup mxser_dtr_rts
      mxser: don't start TX from tty_operations::put_char
      mxser: extract and dedup CTS handling
      mxser: introduce and use start/stop_tx helpers
      mxser: remove xmit_cnt < 0 tests
      mxser: decrypt FCR values
      mxser: fix typos around enhanced mode
      mxser: access info->MCR under info->slock
      mxser: use port variable in mxser_set_serial_info
      mxser: rename flags to old_speed in mxser_set_serial_info
      mxser: introduce mxser_16550A_or_MUST helper
      mxser: Documentation, remove traces of callout device
      mxser: Documentation, make the docs up-to-date
      mxser: Documentation, fix typos
      MAINTAINERS: add me back as mxser maintainer
      tty: make linux/tty_flip.h self-contained

Johan Hovold (1):
      serial: drop irq-flags initialisations

Lad Prabhakar (1):
      dt-bindings: serial: renesas,scif: Document r9a07g044 bindings

Lee Jones (8):
      tty: vt: selection: Correct misspelled function sel_loadlut()
      tty: serdev: core: Fix misspelled function name __serdev_device_driver_register()
      tty: tty_buffer: Fix incorrectly documented function __tty_buffer_request_room()
      tty: tty_jobctrl: Fix 2 incorrectly documented functions
      tty: n_hdlc: Fix a little doc-rot in n_hdlc_tty_read()
      tty: serial: st-asc: Demote a kernel-doc formatting abuse
      tty: n_gsm: Fix function naming and provide missing param descriptions
      tty: serial: xilinx_uartps: Fix documentation for cdns_uart_clk_notifier_cb()

Liang Chen (1):
      dt-bindings: serial: snps-dw-apb-uart: add description for rk3568

Lukas Bulwahn (1):
      MAINTAINERS: TTY LAYER: add some ./include/linux/ header files

Maciej W. Rozycki (6):
      serial: 8250: Dissociate 4MHz Titan ports from Oxford ports
      serial: 8250: Correct the clock for OxSemi PCIe devices
      serial: 8250: Document SMSC Super I/O UART peculiarities
      serial: 8250: Actually allow UPF_MAGIC_MULTIPLIER baud rates
      serial: 8250: Handle custom baud rates in UPF_MAGIC_MULTIPLIER range
      MIPS: Malta: Enable magic multipliers for Super I/O UARTs

Michael Walle (9):
      serial: fsl_lpuart: don't modify arbitrary data on lpuart32
      serial: fsl_lpuart: use UARTDATA_MASK macro
      serial: fsl_lpuart: don't restore interrupt state in ISR
      serial: fsl_lpuart: split sysrq handling
      serial: fsl_lpuart: handle break and make sysrq work
      serial: fsl_lpuart: remove RTSCTS handling from get_mctrl()
      serial: fsl_lpuart: remove manual RTSCTS control from 8-bit LPUART
      serial: fsl_lpuart: add loopback support
      serial: fsl_lpuart: disable DMA for console and fix sysrq

Mikko Perttunen (1):
      serial: tegra-tcu: Reorder channel initialization

Neil Armstrong (2):
      dt-bindings: serial: amlogic, meson-uart: add fifo-size property
      tty: serial: meson: retrieve port FIFO size from DT

Ondrej Zary (2):
      serial_cs: remove wrong GLOBETROTTER.cis entry
      serial_cs: Add Option International GSM-Ready 56K/ISDN modem

Pali Rohár (6):
      serial: mvebu-uart: fix calculation of clock divisor
      serial: mvebu-uart: do not allow changing baudrate when uartclk is not available
      serial: mvebu-uart: correctly calculate minimal possible baudrate
      dt-bindings: mvebu-uart: fix documentation
      arm64: dts: marvell: armada-37xx: Fix reg for standard variant of UART
      serial: mvebu-uart: remove unused member nb from struct mvebu_uart

Samo Pogačnik (2):
      ttyprintk: Add TTY port shutdown callback
      ttyprintk: Removed unnecessary TTY ioctl callback

Shaokun Zhang (1):
      vt: vt_kern.h, remove the repeated declaration

Sherry Sun (1):
      tty: serial: fsl_lpuart: fix the potential risk of division or modulo by zero

Stafford Horne (1):
      serial: liteuart: Add support for earlycon

Tian Tao (1):
      tty: serial: samsung_tty: remove set but not used variables

Vignesh Raghavendra (2):
      dt-bindings: serial: Move omap-serial.txt to YAML schema
      serial: 8250: 8250_omap: Fix possible interrupt storm on K3 SoCs

Xiaofei Tan (18):
      tty: tty_baudrate: Remove unnecessary tab and spaces in comment sentence
      tty: tty_baudrate: Fix coding style issues of block comments
      tty: tty_buffer: Add a blank line after declarations
      tty: tty_buffer: Remove the repeated word 'the'
      tty: tty_buffer: Fix coding style issues of block comments
      tty: tty_io: Remove spaces before tabs
      tty: tty_io: Add a blank line after declarations
      tty: tty_io: Fix spaces required around that ':'
      tty: tty_io: Fix trailing whitespace issues
      tty: tty_io: Fix coding style issues of block comments
      tty: tty_io: Remove the repeated word 'can'
      tty: tty_io: Fix an issue of code indent for conditional statements
      tty: tty_io: Delete a blank line before EXPORT_SYMBOL(foo)
      tty: tty_io: Remove return in void function
      tty: tty_port: Delete a blank line before EXPORT_SYMBOL(foo)
      tty: tty_port: Add a blank line after declarations
      tty: tty_port: Fix coding style issues of block comments
      tty: hvc_console: Remove the repeated words 'no' and 'from'

Yang Yingliang (1):
      tty: pty: correct function name pty_resize()

Yoshihiro Shimoda (1):
      serial: sh-sci: Stop dmaengine transfer in sci_stop_tx()

Zev Weiss (3):
      serial: 8250_aspeed_vuart: factor out aspeed_vuart_{read, write}b() helper functions
      serial: 8250_aspeed_vuart: initialize vuart->port in aspeed_vuart_probe()
      serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping

Zhen Lei (4):
      dt-bindings: serial: Change to reference the kernel-defined serial.yaml
      dt-bindings: serial: Add label property in serial.yaml
      dt-bindings: serial: pl011: Delete an incorrect compatible string
      tty: vcc: use DEVICE_ATTR_*() macro

Zihao Tang (12):
      tty: serial: atmel: include <linux/io.h> instead of <asm/io.h>
      tty: serial: dz: include <linux/io.h> instead of <asm/io.h>
      tty: serial: icom: include <linux/io.h> instead of <asm/io.h>
      tty: serial: ip22zilog: include <linux/io.h> instead of <asm/io.h>
      tty: serial: mux: include <linux/io.h> instead of <asm/io.h>
      tty: serial: pmac_zilog: include <linux/io.h> insteiad of <asm/io.h>
      tty: serial: txx9: include <linux/io.h> instead of <asm/io.h>
      tty: serial: sunsab: include <linux/io.h> instead of <asm/io.h>
      tty: serial: sunsu: include <linux/io.h> instead of <asm/io.h>
      tty: serial: sunzilog: include <linux/io.h> instead of <asm/io.h>
      tty: serial: vr41xx_siu: include <linux/io.h> instead of <asm/io.h>
      tty: serial: sb1250-duart: include <linux/io.h> instead of <asm/io.h>

 Documentation/admin-guide/kernel-parameters.txt    |    5 +
 Documentation/devicetree/bindings/serial/8250.yaml |    2 +-
 .../devicetree/bindings/serial/8250_omap.yaml      |  118 ++
 .../bindings/serial/amlogic,meson-uart.yaml        |    5 +
 .../bindings/serial/brcm,bcm7271-uart.yaml         |    2 +-
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |   12 +
 .../devicetree/bindings/serial/ingenic,uart.yaml   |    2 +-
 .../devicetree/bindings/serial/mvebu-uart.txt      |    6 +-
 .../devicetree/bindings/serial/omap_serial.txt     |   40 -
 .../devicetree/bindings/serial/pl011.yaml          |   13 +-
 .../bindings/serial/qca,ar9330-uart.yaml           |    4 +-
 .../bindings/serial/renesas,em-uart.yaml           |    2 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |    4 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |    2 +-
 .../devicetree/bindings/serial/serial.yaml         |    2 +
 .../devicetree/bindings/serial/sifive-serial.yaml  |    4 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |    4 +-
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |    3 +-
 Documentation/driver-api/serial/moxa-smartio.rst   |  496 +----
 Documentation/networking/caif/caif.rst             |    4 +-
 MAINTAINERS                                        |    9 +-
 arch/alpha/kernel/srmcons.c                        |    9 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |    2 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |    2 +-
 arch/m68k/emu/nfcon.c                              |    2 +-
 arch/mips/mti-malta/malta-platform.c               |    3 +-
 arch/parisc/kernel/pdc_cons.c                      |    8 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    1 -
 arch/um/drivers/line.c                             |   15 +-
 arch/um/drivers/line.h                             |    5 +-
 arch/um/drivers/ssl.c                              |    1 -
 arch/um/drivers/stdio_console.c                    |    1 -
 arch/xtensa/platforms/iss/console.c                |    9 +-
 drivers/accessibility/speakup/spk_ttyio.c          |    9 +-
 drivers/bluetooth/hci_ldisc.c                      |   12 +-
 drivers/char/Kconfig                               |   13 -
 drivers/char/pcmcia/synclink_cs.c                  |   24 +-
 drivers/char/ttyprintk.c                           |   52 +-
 drivers/input/serio/serport.c                      |    8 +-
 drivers/ipack/devices/ipoctal.c                    |    4 +-
 drivers/isdn/capi/capi.c                           |   40 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c                   |    2 +-
 drivers/misc/ti-st/st_core.c                       |   30 +-
 drivers/mmc/core/sdio_uart.c                       |    6 +-
 drivers/net/caif/caif_serial.c                     |   13 +-
 drivers/net/can/slcan.c                            |   10 +-
 drivers/net/hamradio/6pack.c                       |   14 +-
 drivers/net/hamradio/mkiss.c                       |   13 +-
 drivers/net/ppp/ppp_async.c                        |   12 +-
 drivers/net/ppp/ppp_synctty.c                      |   12 +-
 drivers/net/slip/slip.c                            |    9 +-
 drivers/net/usb/hso.c                              |    8 +-
 drivers/pps/clients/pps-ldisc.c                    |   11 +-
 drivers/s390/char/con3215.c                        |    4 +-
 drivers/s390/char/sclp_rw.c                        |    4 +-
 drivers/s390/char/sclp_rw.h                        |    2 +-
 drivers/s390/char/sclp_tty.c                       |    9 +-
 drivers/s390/char/sclp_vt220.c                     |    9 +-
 drivers/s390/char/tty3270.c                        |   22 +-
 drivers/staging/fwserial/fwserial.c                |   14 +-
 drivers/staging/gdm724x/gdm_tty.c                  |    2 +-
 drivers/staging/greybus/uart.c                     |   22 +-
 drivers/tty/Kconfig                                |    2 +-
 drivers/tty/Makefile                               |    1 -
 drivers/tty/amiserial.c                            |   12 +-
 drivers/tty/ehv_bytechan.c                         |    4 +-
 drivers/tty/goldfish.c                             |    4 +-
 drivers/tty/hvc/hvc_console.c                      |    8 +-
 drivers/tty/hvc/hvc_iucv.c                         |    2 -
 drivers/tty/hvc/hvcs.c                             |    4 +-
 drivers/tty/hvc/hvsi.c                             |    6 +-
 drivers/tty/ipwireless/tty.c                       |    6 +-
 drivers/tty/mips_ejtag_fdc.c                       |    8 +-
 drivers/tty/moxa.c                                 |   22 +-
 drivers/tty/mxser.c                                | 1958 ++++++--------------
 drivers/tty/mxser.h                                |  151 --
 drivers/tty/n_gsm.c                                |   34 +-
 drivers/tty/n_hdlc.c                               |   18 +-
 drivers/tty/n_null.c                               |    7 +-
 drivers/tty/n_r3964.c                              | 1283 -------------
 drivers/tty/n_tty.c                                |  201 +-
 drivers/tty/nozomi.c                               |   26 +-
 drivers/tty/pty.c                                  |   89 +-
 drivers/tty/serdev/core.c                          |    2 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   54 +-
 drivers/tty/serial/8250/8250_core.c                |   27 +-
 drivers/tty/serial/8250/8250_exar.c                |   20 +-
 drivers/tty/serial/8250/8250_of.c                  |    4 +
 drivers/tty/serial/8250/8250_omap.c                |   22 +-
 drivers/tty/serial/8250/8250_pci.c                 |  172 +-
 drivers/tty/serial/8250/8250_port.c                |   57 +-
 drivers/tty/serial/8250/serial_cs.c                |   13 +-
 drivers/tty/serial/Kconfig                         |    1 +
 drivers/tty/serial/amba-pl011.c                    |    2 +-
 drivers/tty/serial/arc_uart.c                      |    2 +-
 drivers/tty/serial/atmel_serial.c                  |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   19 +-
 drivers/tty/serial/dz.c                            |    4 +-
 drivers/tty/serial/fsl_lpuart.c                    |  135 +-
 drivers/tty/serial/icom.c                          |    2 +-
 drivers/tty/serial/imx.c                           |   27 +-
 drivers/tty/serial/ip22zilog.c                     |    2 +-
 drivers/tty/serial/kgdb_nmi.c                      |    4 +-
 drivers/tty/serial/liteuart.c                      |   21 +
 drivers/tty/serial/max310x.c                       |   40 +-
 drivers/tty/serial/meson_uart.c                    |    8 +-
 drivers/tty/serial/mux.c                           |    2 +-
 drivers/tty/serial/mvebu-uart.c                    |   21 +-
 drivers/tty/serial/mxs-auart.c                     |   26 +-
 drivers/tty/serial/omap-serial.c                   |   10 +-
 drivers/tty/serial/pmac_zilog.c                    |    2 +-
 drivers/tty/serial/qcom_geni_serial.c              |   22 +-
 drivers/tty/serial/samsung_tty.c                   |    3 +-
 drivers/tty/serial/sb1250-duart.c                  |    2 +-
 drivers/tty/serial/sc16is7xx.c                     |   26 +-
 drivers/tty/serial/serial_core.c                   |   58 +-
 drivers/tty/serial/serial_txx9.c                   |    2 +-
 drivers/tty/serial/sh-sci.c                        |   41 +-
 drivers/tty/serial/sh-sci.h                        |    1 +
 drivers/tty/serial/st-asc.c                        |    4 +-
 drivers/tty/serial/stm32-usart.c                   |  197 +-
 drivers/tty/serial/sunsab.c                        |    2 +-
 drivers/tty/serial/sunsu.c                         |    2 +-
 drivers/tty/serial/sunzilog.c                      |    2 +-
 drivers/tty/serial/tegra-tcu.c                     |   26 +-
 drivers/tty/serial/uartlite.c                      |   27 +-
 drivers/tty/serial/vr41xx_siu.c                    |    2 +-
 drivers/tty/serial/xilinx_uartps.c                 |   12 +-
 drivers/tty/synclink_gt.c                          |   27 +-
 drivers/tty/tty_baudrate.c                         |   13 +-
 drivers/tty/tty_buffer.c                           |   28 +-
 drivers/tty/tty_io.c                               |  198 +-
 drivers/tty/tty_ioctl.c                            |   96 +-
 drivers/tty/tty_jobctrl.c                          |   88 +-
 drivers/tty/tty_ldisc.c                            |   29 +-
 drivers/tty/tty_port.c                             |   18 +-
 drivers/tty/ttynull.c                              |    2 +-
 drivers/tty/vcc.c                                  |   24 +-
 drivers/tty/vt/keyboard.c                          |    2 +-
 drivers/tty/vt/selection.c                         |   20 +-
 drivers/tty/vt/vt.c                                |   18 +-
 drivers/usb/class/cdc-acm.c                        |   21 +-
 drivers/usb/gadget/function/u_serial.c             |   12 +-
 drivers/usb/host/xhci-dbgtty.c                     |    8 +-
 drivers/usb/serial/belkin_sa.c                     |   20 +-
 drivers/usb/serial/cypress_m8.c                    |   21 +-
 drivers/usb/serial/pl2303.c                        |   15 +-
 drivers/usb/serial/usb-serial.c                    |    4 +-
 drivers/usb/serial/whiteheat.c                     |    9 +-
 include/linux/n_r3964.h                            |  175 --
 include/linux/serial_8250.h                        |    2 +-
 include/linux/serial_core.h                        |    5 +-
 include/linux/tty.h                                |   78 +-
 include/linux/tty_driver.h                         |   12 +-
 include/linux/tty_flip.h                           |    4 +-
 include/linux/tty_ldisc.h                          |    6 +-
 include/linux/vt_kern.h                            |    1 -
 include/uapi/linux/n_r3964.h                       |   99 -
 net/bluetooth/rfcomm/tty.c                         |    4 +-
 net/nfc/nci/uart.c                                 |    7 +-
 sound/soc/codecs/cx20442.c                         |    4 +-
 sound/soc/ti/ams-delta.c                           |   11 +-
 162 files changed, 2104 insertions(+), 5140 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/8250_omap.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/omap_serial.txt
 delete mode 100644 drivers/tty/mxser.h
 delete mode 100644 drivers/tty/n_r3964.c
 delete mode 100644 include/linux/n_r3964.h
 delete mode 100644 include/uapi/linux/n_r3964.h
