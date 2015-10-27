From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 00/15] drivers/tty/: Deinline smaller/less used functions
Date: Tue, 27 Oct 2015 18:46:32 +0100
Message-ID: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For Peter's review.
(Pater, I removed a few patches which looked most problematic)

Denys Vlasenko (15):
  cyclades: Deinline cyz_is_loaded, save 240 bytes
  isicom: Deinline drop_dtr, save 112 bytes
  tty: Deinline n_tty_receive_char_inline, save 224 bytes
  serial/fsl_lpuart: Deinline lpuart_transmit_buffer, save 176 bytes
  serial/m32r_sio: Deinline wait_for_xmitr, save 165 bytes
  serial/men_z135_uart: Deinline men_z135_reg_clr, save 176 bytes
  serial/msm_serial: Deinline wait_for_xmitr, save 165 bytes
  serial/omap-serial: Deinline wait_for_xmitr, save 165 bytes
  serial/pxa: Deinline wait_for_xmitr, save 165 bytes
  serial/sprd_serial: Deinline wait_for_xmitr, save 165 bytes
  serial/sunsu: Deinline wait_for_xmitr, save 165 bytes
  serial/vt8500_serial: Deinline wait_for_xmitr, save 165 bytes
  tty: Deinline __ldsem_down_read_nested, save 128 bytes
  tty: Deinline __ldsem_down_write_nested, save 128 bytes
  vt: Deinline save_screen, save 238 bytes

 drivers/tty/cyclades.c             | 2 +-
 drivers/tty/isicom.c               | 2 +-
 drivers/tty/n_tty.c                | 2 +-
 drivers/tty/serial/fsl_lpuart.c    | 2 +-
 drivers/tty/serial/m32r_sio.c      | 2 +-
 drivers/tty/serial/men_z135_uart.c | 2 +-
 drivers/tty/serial/msm_serial.c    | 2 +-
 drivers/tty/serial/omap-serial.c   | 2 +-
 drivers/tty/serial/pxa.c           | 2 +-
 drivers/tty/serial/sprd_serial.c   | 2 +-
 drivers/tty/serial/sunsu.c         | 2 +-
 drivers/tty/serial/vt8500_serial.c | 2 +-
 drivers/tty/tty_ldsem.c            | 4 ++--
 drivers/tty/vt/vt.c                | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

-- 
1.8.1.4
