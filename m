Return-Path: <SRS0=RtBO=BQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF84DC433E0
	for <linux-serial@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1626F206B2
	for <linux-serial@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735154;
	bh=Ko6EMrokn2zl/9MuT100PIK32SrkIjcyEGTGRbhmZas=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zoBhjzxNU4xVTe/ZoHH4n8c9moY98Nwi+CjVpfKmFD3406PjEzoPtVNdiSzUZkS3o
	 6lkoe19lahre4y0EggB7qc5v8ibMp14voqVFAKgC7uJ9bJbMQRWid3ePLrrhFilp2O
	 Bjo+AitjKJxXDQJ6cgZvKJ7dEHKF6BhJIMxcE35k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgHFRcc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729888AbgHFRcG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0512722CF7;
        Thu,  6 Aug 2020 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717219;
        bh=Ko6EMrokn2zl/9MuT100PIK32SrkIjcyEGTGRbhmZas=;
        h=Date:From:To:Cc:Subject:From;
        b=P8pL3q4gr0T4k1UEo4RGdqG35VLYWLP7A7oysMfbW+7EtEENrJHhoCvnu1t7gv495
         KwPJhXw+HCTcV+ZsKk5z2CIPlxkfs9S+kwk9eCpjBxBsNoYE+Ri5PoGzU6mFHDqpjO
         WDv5yZCXX/b5z+0OPCoYi7IUgqgEpmafzIfeITt4=
Date:   Thu, 6 Aug 2020 14:33:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver patches for 5.9-rc1
Message-ID: <20200806123354.GA2858200@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.9-rc1

for you to fetch changes up to f6c6eb2fe8223f8e64babcdaad2838ba6ede277d:

  MAINTAINERS: enlist Greg formally for console stuff (2020-08-04 09:41:22 +0200)

----------------------------------------------------------------
TTY/Serial patches for 5.9-rc1

Here is the large set of TTY and Serial driver patches for 5.9-rc1.

Lots of bugfixes in here, thanks to syzbot fuzzing for serial and vt and
console code.

Other highlights include:
	- much needed vt/vc code cleanup from Jiri Slaby
	- 8250 driver fixes and additions
	- various serial driver updates and feature enhancements
	- locking cleanup for serial/console initializations
	- other minor cleanups

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ahmad Fatoum (1):
      serial: imx: use hrtimers for rs485 delays

Alexander A. Klimov (4):
      tty: vt: Replace HTTP links with HTTPS ones
      tty: serial: Replace HTTP links with HTTPS ones
      tty: serial: uartlite: Replace HTTP links with HTTPS ones
      serial: altera_jtaguart: Replace HTTP links with HTTPS ones

Alexey Kardashevskiy (1):
      tty/vt: Do not warn when huge selection requested

Andy Shevchenko (12):
      serial: 8250_em: Switch to use platform_get_irq()
      serial: 8250_omap: Switch to use platform_get_irq()
      serial: 8250_pxa: Switch to use platform_get_irq()
      serial: 8250_ingenic: Switch to use platform_get_irq()
      serial: 8250_mtk: Switch to use platform_get_irq()
      Revert "serial: sunhv: Initialize lock for non-registered console"
      Revert "serial: amba-pl011: Make sure we initialize the port.lock spinlock"
      Revert "tty: serial: add missing spin_lock_init for SiFive serial console"
      Revert "serial: imx: Initialize lock for non-registered console"
      Revert "serial: sh-sci: Initialize spinlock for uart console"
      serial: 8250: Let serial core initialise spin lock
      Revert "serial: 8250: Let serial core initialise spin lock"

Christoph Hellwig (1):
      tty/synclink: remove leftover bits of non-PCI card support

Dan Carpenter (1):
      tty: serial: qcom_geni_serial: Clean up an ARRAY_SIZE() vs sizeof()

Daniel Vetter (1):
      MAINTAINERS: enlist Greg formally for console stuff

Denis Efremov (1):
      tty/vt: check allocation size in con_set_unimap()

Douglas Anderson (1):
      serial: kgdboc: Fix bad line wrapping in comment

Erwan Le Ray (2):
      dt-bindings: serial: add generic DT binding for announcing RTS/CTS lines
      serial: stm32: Use generic DT binding for announcing RTS/CTS lines

Flavio Suligoi (1):
      tty: fix spelling mistake

Fugang Duan (2):
      tty: serial: imx: enable imx serial console port as module
      tty: serial: imx: add imx earlycon driver

Greg Kroah-Hartman (2):
      Merge 5.8-rc6 into tty-next
      Merge 5.8-rc7 into tty-next

Gustavo A. R. Silva (3):
      tty: Avoid the use of one-element arrays
      tty: Fix identation issues in struct serial_struct32
      tty: Use the preferred form for passing the size of a structure type

Jiri Slaby (41):
      um: line, remove put_char
      vc: separate state
      vt: introduce enum vc_intensity for intensity
      vc: switch state to bool
      vt: deduplicate setGx code
      vt: switch G0/1_charset to an array
      vt: convert vc_tab_stop to bitmap
      vt: remove 25 years stale comment
      vt: use tty_insert_flip_string in respond_string
      vt: get rid of VT10.ID macros
      vt: move vc_translate to vt.c and rename it
      vt: use modern types in do_con_write
      vt: separate unicode handling into vc_translate_unicode
      vt: rearrange vc_translate_unicode
      vt: extract attribute inversion to vc_invert_attr
      vt: move rescan_last_byte label earlier
      vc: move translation out of do_con_write
      vc: introduce struct vc_draw_region
      vc: extract detecting control characters from do_con_write
      vc: move normal char processing from do_con_write
      vc: simplify condition in vc_con_write_normal
      vt: simplify vc_attr handling in vc_con_write_normal
      vt: make tc write more obvious in vc_con_write_normal
      vt: synchronize types and use min in csi_X
      vt: whitespace and paren cleanup in add_softcursor
      vt: redefine world of cursor macros
      vt: use newly defined CUR_* macros
      vt: remove superfluous parens in invert_screen and build_attr
      vt: simplify noncolor attributes in build_attr
      vt_ioctl: eliminate ret & breaks in vt_ioctl
      vt_ioctl: eliminate use of uival and ucval
      vt_ioctl: move K* ioctls to a separate function
      vt_ioctl: move io ioctls to a separate function
      vt_ioctl: move vt_setactivate out of vt_ioctl
      vt_ioctl: move vt_reldisp out of vt_ioctl
      vt_ioctl: move vt_resizex out of vt_ioctl
      vt_ioctl: move vt_io_fontreset out of vt_io_ioctl
      vt_ioctl: move vt_kdsetmode out of vt_k_ioctl
      vt_ioctl: move perm checks level up
      newport_con: vc_color is now in state
      tty: keyboard, do not speculate on func_table index

Johan Hovold (3):
      serial: core: drop unnecessary gpio include
      serial: pmac_zilog: add sparse context annotation
      serial: msm_serial: add sparse context annotation

Krzysztof Kozlowski (1):
      serial: samsung: Minor whitespace cleanups

Marek Vasut (1):
      serial: stm32: Add RS485 RTS GPIO control

Pavel Machek (1):
      8250-men-mcb: fix signed/unsigned confusion

Randolph Maaßen (1):
      serial: serial-tegra: reduce irq-latency after rx errors

Serge Semin (4):
      serial: 8250: Add 8250 port clock update method
      serial: 8250_dw: Simplify the ref clock rate setting procedure
      serial: 8250_dw: Pass the same rate to the clk round and set rate methods
      serial: 8250_dw: Fix common clocks usage race condition

Tamseel Shams (2):
      serial: samsung: fix spelling mistake
      serial: core: Fix Coding Style

Tiezhu Yang (1):
      serial: Remove duplicated macro definition of port type

Uwe Kleine-König (1):
      serial: imx: implement rts delaying for rs485

Vabhav Sharma (1):
      tty: serial: fsl_lpuart: minimum baud rate support

Vaibhav Gupta (1):
      serial: pch_uart: use generic power management

Yunhai Zhang (1):
      vgacon: Fix for missing check in scrollback handling

 .../devicetree/bindings/serial/st,stm32-uart.yaml  |    4 +-
 Documentation/driver-api/serial/n_gsm.rst          |    2 +-
 MAINTAINERS                                        |    6 +
 arch/um/drivers/line.c                             |    5 -
 arch/um/drivers/line.h                             |    1 -
 arch/um/drivers/ssl.c                              |    1 -
 arch/um/drivers/stdio_console.c                    |    1 -
 drivers/accessibility/braille/braille_console.c    |   10 +-
 drivers/staging/speakup/main.c                     |   28 +-
 drivers/tty/moxa.h                                 |    2 +-
 drivers/tty/serial/8250/8250_dw.c                  |  120 ++-
 drivers/tty/serial/8250/8250_em.c                  |   16 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   16 +-
 drivers/tty/serial/8250/8250_men_mcb.c             |    4 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   16 +-
 drivers/tty/serial/8250/8250_omap.c                |   16 +-
 drivers/tty/serial/8250/8250_port.c                |   41 +
 drivers/tty/serial/8250/8250_pxa.c                 |   14 +-
 drivers/tty/serial/8250/Kconfig                    |    4 +-
 drivers/tty/serial/Kconfig                         |   17 +-
 drivers/tty/serial/altera_jtaguart.c               |    2 +-
 drivers/tty/serial/amba-pl011.c                    |    1 -
 drivers/tty/serial/fsl_lpuart.c                    |    3 +
 drivers/tty/serial/imx.c                           |  207 ++--
 drivers/tty/serial/imx_earlycon.c                  |   50 +
 drivers/tty/serial/jsm/jsm_driver.c                |    2 +-
 drivers/tty/serial/kgdboc.c                        |    3 +-
 drivers/tty/serial/msm_serial.c                    |    2 +
 drivers/tty/serial/pch_uart.c                      |   34 +-
 drivers/tty/serial/pmac_zilog.c                    |    1 +
 drivers/tty/serial/qcom_geni_serial.c              |    2 +-
 drivers/tty/serial/samsung_tty.c                   |   24 +-
 drivers/tty/serial/serial-tegra.c                  |    6 +-
 drivers/tty/serial/serial_core.c                   |    5 +-
 drivers/tty/serial/sh-sci.c                        |    3 -
 drivers/tty/serial/sifive.c                        |    1 -
 drivers/tty/serial/stm32-usart.c                   |   13 +-
 drivers/tty/serial/sunhv.c                         |    3 -
 drivers/tty/serial/uartlite.c                      |    2 +-
 drivers/tty/synclink.c                             |  350 ++----
 drivers/tty/tty_io.c                               |   52 +-
 drivers/tty/vt/consolemap.c                        |    2 +-
 drivers/tty/vt/keyboard.c                          |    3 +-
 drivers/tty/vt/selection.c                         |    2 +-
 drivers/tty/vt/vt.c                                |  982 +++++++++--------
 drivers/tty/vt/vt_ioctl.c                          | 1109 ++++++++++----------
 drivers/usb/misc/sisusbvga/sisusb_con.c            |   11 +-
 drivers/video/console/mdacon.c                     |   20 +-
 drivers/video/console/newport_con.c                |   10 +-
 drivers/video/console/sticon.c                     |   14 +-
 drivers/video/console/vgacon.c                     |   40 +-
 drivers/video/fbdev/core/bitblit.c                 |   10 +-
 drivers/video/fbdev/core/fbcon.c                   |   10 +-
 drivers/video/fbdev/core/fbcon_ccw.c               |    8 +-
 drivers/video/fbdev/core/fbcon_cw.c                |    8 +-
 drivers/video/fbdev/core/fbcon_ud.c                |    8 +-
 drivers/video/fbdev/core/tileblit.c                |    6 +-
 include/linux/console.h                            |   13 +-
 include/linux/console_struct.h                     |   93 +-
 include/linux/serial_8250.h                        |    2 +
 include/linux/serial_core.h                        |    2 +-
 include/linux/vt_kern.h                            |    3 -
 include/uapi/linux/serial_core.h                   |   14 -
 63 files changed, 1847 insertions(+), 1613 deletions(-)
 create mode 100644 drivers/tty/serial/imx_earlycon.c
