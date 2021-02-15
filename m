Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90829C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B63864DFF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Feb 2021 16:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhBOQaX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Feb 2021 11:30:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232049AbhBOQ2R (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Feb 2021 11:28:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC30460200;
        Mon, 15 Feb 2021 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613406441;
        bh=BliUV72ji+FDfrLN09W99a1LVlldaxjMnaHHvvvEdwE=;
        h=Date:From:To:Cc:Subject:From;
        b=fT4Gf596fMrFBXuMQ3nRd1zF3Y4b7CNYi9Izdzvvp6jaBxtQyg3SIPEh0QpRN9js+
         aOEdteq98jmFx8T3Qvaxtrrr6MbeYvDQGFoxee6Oko3Oq8RSpcRf6OlqhOk8M7nySa
         nnHNd6tDp+TU088aMD/z2iumylegg5jQaGf9pgNI=
Date:   Mon, 15 Feb 2021 17:27:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY / Serial driver changes for 5.12-rc1
Message-ID: <YCqg5ufpr1yD9tvk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.12-rc1

for you to fetch changes up to a157270fbf37f822e1fa9e9faa8ed8c81da1eb28:

  serial: core: Remove BUG_ON(in_interrupt()) check (2021-02-09 11:45:04 +0100)

----------------------------------------------------------------
TTY/Serial driver changes for 5.12-rc1

Here is the big set of tty/serial driver changes for 5.12-rc1.

Nothing huge, just lots of good cleanups and additions:
	- Your n_tty line discipline cleanups
	- vt core cleanups and reworks to make the code more "modern"
	- stm32 driver additions
	- tty led support added to the tty core and led layer
	- minor serial driver fixups and additions

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmed S. Darwish (2):
      vt_ioctl: Remove in_interrupt() check
      serial: core: Remove BUG_ON(in_interrupt()) check

Andy Shevchenko (1):
      serial: ifx6x60: Remove driver for deprecated platform

Arnd Bergmann (1):
      serial: remove sirf prima/atlas driver

Christophe Leroy (1):
      tty: serial: cpm_uart: Add udbg support for enabling xmon

Corey Minyard (2):
      tty: Export redirect release
      drivers:tty:pty: Fix a race causing data loss on close

Cristian Ciocaltea (1):
      tty: serial: owl: Add support for kernel debugger

Emil Renner Berthing (1):
      vt: keyboard, use new API for keyboard_tasklet

Erwan Le Ray (9):
      serial: stm32: fix DMA initialization error handling
      serial: stm32: fix code cleaning warnings and checks
      serial: stm32: add "_usart" prefix in functions name
      serial: stm32: add author
      dt-bindings: serial: stm32: update rts-gpios and cts-gpios
      serial: stm32: update conflicting RTS/CTS config comment
      serial: stm32: clean probe and remove port deinit
      serial: stm32: update transmission complete error message in shutdown
      serial: stm32: improve platform_get_irq condition handling in init_port

Fabio Estevam (4):
      serial: fsl_lpuart: Use of_device_get_match_data()
      serial: mxs-auart: Remove serial_mxs_probe_dt()
      serial: mxs-auart: Remove <asm/cacheflush.h>
      dt-bindings: serial: imx: Switch to my personal address

Greg Kroah-Hartman (2):
      Merge branch 'tty-splice' of git://git.kernel.org/.../torvalds/linux into tty-next
      Merge 5.11-rc5 into tty-next

Jiri Slaby (12):
      vt: move set_leds to keyboard.c
      vt: keyboard, make keyboard_tasklet local
      vt: keyboard, defkeymap.c_shipped, approach the definitions
      vt: keyboard, defkeymap.c_shipped, approach the unicode table
      tty: pty, remove BUG_ON from pty_close
      8250_tegra: clean up tegra_uart_handle_break
      vt/consolemap: do font sum unsigned
      vt: drop old FONT ioctls
      vgacon: drop BROKEN_GRAPHICS_PROGRAMS
      tty: cpm_uart, use port->flags instead of low_latency
      tty_port: drop last traces of low_latency
      tty: drop termiox user definitions

Linus Torvalds (8):
      tty: convert tty_ldisc_ops 'read()' function to take a kernel pointer
      tty: implement read_iter
      tty: clean up legacy leftovers from n_tty line discipline
      tty: teach n_tty line discipline about the new "cookie continuations"
      tty: teach the n_tty ICANON case about the new "cookie continuations" too
      tty: fix up hung_up_tty_write() conversion
      tty: fix up hung_up_tty_read() conversion
      tty: fix up iterate_tty_read() EOVERFLOW handling

Uwe Kleine-König (7):
      tty: rename tty_kopen() and add new function tty_kopen_shared()
      tty: new helper function tty_get_icount()
      tty: hvcs: Drop unnecessary if block
      tty: vcc: Drop unnecessary if block
      tty: vcc: Drop impossible to hit WARN_ON
      leds: trigger: implement a tty trigger
      tty: serial: Drop unused efm32 serial driver

Wolfram Sang (1):
      dt-bindings: serial: renesas,hscif: Add r8a779a0 support

Yan.Gao (1):
      tty: Protect disc_data in n_tty_close and n_tty_flush_buffer

Zheng Yongjun (3):
      tty/serial/imx: convert comma to semicolon
      tty/serial/lantiq: convert comma to semicolon
      tty: serial: icom: Use DEFINE_SPINLOCK() for spinlock

 .../ABI/testing/sysfs-class-led-trigger-tty        |    6 +
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |    2 +-
 .../devicetree/bindings/serial/fsl-mxs-auart.yaml  |    2 +-
 .../devicetree/bindings/serial/renesas,hscif.yaml  |    1 +
 .../devicetree/bindings/serial/sirf-uart.txt       |   34 -
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   13 +-
 Documentation/networking/caif/caif.rst             |    1 -
 drivers/accessibility/speakup/spk_ttyio.c          |    2 +-
 drivers/bluetooth/hci_ldisc.c                      |   34 +-
 drivers/char/pcmcia/synclink_cs.c                  |    2 -
 drivers/input/serio/serport.c                      |    4 +-
 drivers/leds/trigger/Kconfig                       |    9 +
 drivers/leds/trigger/Makefile                      |    1 +
 drivers/leds/trigger/ledtrig-tty.c                 |  183 +++
 drivers/net/caif/caif_serial.c                     |    3 +-
 drivers/net/ppp/ppp_async.c                        |    3 +-
 drivers/net/ppp/ppp_synctty.c                      |    3 +-
 drivers/s390/char/con3215.c                        |    1 -
 drivers/s390/char/sclp_tty.c                       |    1 -
 drivers/s390/char/sclp_vt220.c                     |    1 -
 drivers/s390/char/tty3270.c                        |    2 -
 drivers/tty/amiserial.c                            |    3 -
 drivers/tty/hvc/hvcs.c                             |    5 +-
 drivers/tty/ipwireless/tty.c                       |    1 -
 drivers/tty/mxser.c                                |    1 -
 drivers/tty/n_gsm.c                                |    3 +-
 drivers/tty/n_hdlc.c                               |   60 +-
 drivers/tty/n_null.c                               |    3 +-
 drivers/tty/n_r3964.c                              |   10 +-
 drivers/tty/n_tracerouter.c                        |    4 +-
 drivers/tty/n_tracesink.c                          |    4 +-
 drivers/tty/n_tty.c                                |  153 +-
 drivers/tty/pty.c                                  |   16 +-
 drivers/tty/serial/8250/8250_tegra.c               |   11 +-
 drivers/tty/serial/Kconfig                         |   42 -
 drivers/tty/serial/Makefile                        |    3 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |   43 +-
 drivers/tty/serial/efm32-uart.c                    |  852 -----------
 drivers/tty/serial/fsl_lpuart.c                    |    4 +-
 drivers/tty/serial/icom.c                          |    4 +-
 drivers/tty/serial/ifx6x60.c                       | 1390 ------------------
 drivers/tty/serial/ifx6x60.h                       |  118 --
 drivers/tty/serial/imx.c                           |    2 +-
 drivers/tty/serial/lantiq.c                        |    2 +-
 drivers/tty/serial/max3100.c                       |    3 -
 drivers/tty/serial/mxs-auart.c                     |   45 +-
 drivers/tty/serial/owl-uart.c                      |   38 +
 drivers/tty/serial/serial_core.c                   |   11 +-
 drivers/tty/serial/sirfsoc_uart.c                  | 1503 --------------------
 drivers/tty/serial/sirfsoc_uart.h                  |  447 ------
 drivers/tty/serial/stm32-usart.c                   |  419 +++---
 drivers/tty/synclink_gt.c                          |    1 -
 drivers/tty/tty_io.c                               |  210 ++-
 drivers/tty/vcc.c                                  |   10 +-
 drivers/tty/vt/consolemap.c                        |    2 +-
 drivers/tty/vt/defkeymap.c_shipped                 |   82 +-
 drivers/tty/vt/keyboard.c                          |   18 +-
 drivers/tty/vt/vt.c                                |   42 +-
 drivers/tty/vt/vt_ioctl.c                          |  154 +-
 drivers/video/console/vgacon.c                     |   19 -
 include/linux/kbd_kern.h                           |   10 +-
 include/linux/kd.h                                 |    8 -
 include/linux/platform_data/efm32-uart.h           |   19 -
 include/linux/spi/ifx_modem.h                      |   15 -
 include/linux/tty.h                                |   11 +-
 include/linux/tty_ldisc.h                          |    3 +-
 include/linux/vt_kern.h                            |   12 -
 include/uapi/linux/serial_core.h                   |    3 -
 include/uapi/linux/termios.h                       |   15 -
 net/nfc/nci/uart.c                                 |    3 +-
 70 files changed, 958 insertions(+), 5187 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-trigger-tty
 delete mode 100644 Documentation/devicetree/bindings/serial/sirf-uart.txt
 create mode 100644 drivers/leds/trigger/ledtrig-tty.c
 delete mode 100644 drivers/tty/serial/efm32-uart.c
 delete mode 100644 drivers/tty/serial/ifx6x60.c
 delete mode 100644 drivers/tty/serial/ifx6x60.h
 delete mode 100644 drivers/tty/serial/sirfsoc_uart.c
 delete mode 100644 drivers/tty/serial/sirfsoc_uart.h
 delete mode 100644 include/linux/kd.h
 delete mode 100644 include/linux/platform_data/efm32-uart.h
 delete mode 100644 include/linux/spi/ifx_modem.h
