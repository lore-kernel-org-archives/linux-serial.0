Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89377C433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54935613E9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhEEJU1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:41244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhEEJU0 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C09AB151;
        Wed,  5 May 2021 09:19:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 00/35] tty cleanup for 5.14
Date:   Wed,  5 May 2021 11:18:53 +0200
Message-Id: <20210505091928.22010-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

this is again a series of various TTY cleanups. The stats say: 116 files
changed, 661 insertions, 2602 deletions. The major part of the removal
is a drop of BROKEN r3964 ldisc. The rest is mostly removal of dead
code, or adaption to the current tty core state.

Jiri Slaby (35):
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
  USB: serial: make usb_serial_driver::write_room return uint
  tty: make tty_buffer_space_avail return uint
  tty: remove tty_operations::chars_in_buffer for non-buffering
  tty: make tty_operations::chars_in_buffer return uint
  serial: make usb_serial_driver::chars_in_buffer return uint
  nozomi: simplify ntty_chars_in_buffer
  USB: serial: digi_acceleport, simplify digi_chars_in_buffer
  tty: remove empty tty_operations::flush_buffer
  tty: remove empty tty_operations::set_termios
  isdn: capi, remove optional tty ops
  isdn: capi, drop useless pr_debugs
  tty: make tty_get_byte_size available
  tty: make use of tty_get_byte_size

 Documentation/networking/caif/caif.rst      |    4 +-
 arch/alpha/kernel/srmcons.c                 |    9 +-
 arch/m68k/emu/nfcon.c                       |    2 +-
 arch/parisc/kernel/pdc_cons.c               |    8 +-
 arch/powerpc/configs/ppc6xx_defconfig       |    1 -
 arch/um/drivers/line.c                      |   15 +-
 arch/um/drivers/line.h                      |    5 +-
 arch/um/drivers/ssl.c                       |    1 -
 arch/um/drivers/stdio_console.c             |    1 -
 arch/xtensa/platforms/iss/console.c         |    9 +-
 drivers/accessibility/speakup/spk_ttyio.c   |    9 +-
 drivers/bluetooth/hci_ldisc.c               |   12 +-
 drivers/char/Kconfig                        |   13 -
 drivers/char/pcmcia/synclink_cs.c           |   24 +-
 drivers/char/ttyprintk.c                    |    2 +-
 drivers/input/serio/serport.c               |    8 +-
 drivers/ipack/devices/ipoctal.c             |    4 +-
 drivers/isdn/capi/capi.c                    |   40 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c            |    2 +-
 drivers/misc/ti-st/st_core.c                |   30 +-
 drivers/mmc/core/sdio_uart.c                |    6 +-
 drivers/net/caif/caif_serial.c              |   13 +-
 drivers/net/can/slcan.c                     |   10 +-
 drivers/net/hamradio/6pack.c                |   14 +-
 drivers/net/hamradio/mkiss.c                |   13 +-
 drivers/net/ppp/ppp_async.c                 |   12 +-
 drivers/net/ppp/ppp_synctty.c               |   12 +-
 drivers/net/slip/slip.c                     |    9 +-
 drivers/net/usb/hso.c                       |    8 +-
 drivers/pps/clients/pps-ldisc.c             |   11 +-
 drivers/s390/char/con3215.c                 |    4 +-
 drivers/s390/char/sclp_rw.c                 |    4 +-
 drivers/s390/char/sclp_rw.h                 |    2 +-
 drivers/s390/char/sclp_tty.c                |    9 +-
 drivers/s390/char/sclp_vt220.c              |    9 +-
 drivers/s390/char/tty3270.c                 |   22 +-
 drivers/staging/fwserial/fwserial.c         |   14 +-
 drivers/staging/gdm724x/gdm_tty.c           |    2 +-
 drivers/staging/greybus/uart.c              |   22 +-
 drivers/tty/Makefile                        |    1 -
 drivers/tty/amiserial.c                     |   12 +-
 drivers/tty/ehv_bytechan.c                  |    4 +-
 drivers/tty/goldfish.c                      |    4 +-
 drivers/tty/hvc/hvc_console.c               |    4 +-
 drivers/tty/hvc/hvcs.c                      |    4 +-
 drivers/tty/hvc/hvsi.c                      |    6 +-
 drivers/tty/ipwireless/tty.c                |    4 +-
 drivers/tty/mips_ejtag_fdc.c                |    8 +-
 drivers/tty/moxa.c                          |   22 +-
 drivers/tty/mxser.c                         |   16 +-
 drivers/tty/n_gsm.c                         |   28 +-
 drivers/tty/n_hdlc.c                        |   14 +-
 drivers/tty/n_null.c                        |    7 +-
 drivers/tty/n_r3964.c                       | 1283 -------------------
 drivers/tty/n_tty.c                         |  201 +--
 drivers/tty/nozomi.c                        |   17 +-
 drivers/tty/pty.c                           |   85 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c |    4 +-
 drivers/tty/serial/arc_uart.c               |    2 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c |   19 +-
 drivers/tty/serial/dz.c                     |    2 +-
 drivers/tty/serial/kgdb_nmi.c               |    2 +-
 drivers/tty/serial/mxs-auart.c              |   18 +-
 drivers/tty/serial/qcom_geni_serial.c       |   16 +-
 drivers/tty/serial/serial_core.c            |   38 +-
 drivers/tty/serial/sh-sci.c                 |   20 +-
 drivers/tty/serial/stm32-usart.c            |   32 +-
 drivers/tty/synclink_gt.c                   |   27 +-
 drivers/tty/tty_buffer.c                    |    6 +-
 drivers/tty/tty_io.c                        |   68 +-
 drivers/tty/tty_ioctl.c                     |   61 +-
 drivers/tty/tty_jobctrl.c                   |   84 +-
 drivers/tty/tty_ldisc.c                     |   26 +-
 drivers/tty/tty_port.c                      |    2 +-
 drivers/tty/ttynull.c                       |    2 +-
 drivers/tty/vcc.c                           |    8 +-
 drivers/tty/vt/keyboard.c                   |    2 +-
 drivers/tty/vt/vt.c                         |   18 +-
 drivers/usb/class/cdc-acm.c                 |   21 +-
 drivers/usb/gadget/function/u_serial.c      |   12 +-
 drivers/usb/host/xhci-dbgtty.c              |    8 +-
 drivers/usb/serial/belkin_sa.c              |   21 +-
 drivers/usb/serial/cyberjack.c              |    4 +-
 drivers/usb/serial/cypress_m8.c             |   35 +-
 drivers/usb/serial/digi_acceleport.c        |   19 +-
 drivers/usb/serial/garmin_gps.c             |    2 +-
 drivers/usb/serial/generic.c                |   12 +-
 drivers/usb/serial/io_edgeport.c            |   12 +-
 drivers/usb/serial/io_ti.c                  |   12 +-
 drivers/usb/serial/ir-usb.c                 |    6 +-
 drivers/usb/serial/keyspan.c                |    4 +-
 drivers/usb/serial/kobil_sct.c              |    4 +-
 drivers/usb/serial/mos7720.c                |   12 +-
 drivers/usb/serial/mos7840.c                |   13 +-
 drivers/usb/serial/opticon.c                |    6 +-
 drivers/usb/serial/oti6858.c                |   12 +-
 drivers/usb/serial/pl2303.c                 |   15 +-
 drivers/usb/serial/quatech2.c               |    4 +-
 drivers/usb/serial/sierra.c                 |    8 +-
 drivers/usb/serial/ti_usb_3410_5052.c       |   16 +-
 drivers/usb/serial/usb-serial.c             |    4 +-
 drivers/usb/serial/usb-wwan.h               |    4 +-
 drivers/usb/serial/usb_wwan.c               |   12 +-
 drivers/usb/serial/whiteheat.c              |    9 +-
 include/linux/n_r3964.h                     |  175 ---
 include/linux/serial_core.h                 |    2 +-
 include/linux/tty.h                         |   76 +-
 include/linux/tty_driver.h                  |   10 +-
 include/linux/tty_flip.h                    |    2 +-
 include/linux/tty_ldisc.h                   |    6 +-
 include/linux/usb/serial.h                  |    8 +-
 include/uapi/linux/n_r3964.h                |   99 --
 net/bluetooth/rfcomm/tty.c                  |    4 +-
 net/nfc/nci/uart.c                          |    7 +-
 sound/soc/codecs/cx20442.c                  |    4 +-
 sound/soc/ti/ams-delta.c                    |   11 +-
 116 files changed, 661 insertions(+), 2602 deletions(-)
 delete mode 100644 drivers/tty/n_r3964.c
 delete mode 100644 include/linux/n_r3964.h
 delete mode 100644 include/uapi/linux/n_r3964.h

-- 
2.31.1

