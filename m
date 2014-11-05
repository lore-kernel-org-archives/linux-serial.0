From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 0/9] various tty cleanups
Date: Wed,  5 Nov 2014 12:26:23 -0500
Message-ID: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

These patches are a mixture of dead declaration removals, uapi cleanup,
and other miscellany.

This series depends on the 10-patch 'serial core fixes' series.

Regards,

Peter Hurley (9):
  tty: Replace open-coded test with tty_hung_up_p()
  tty: Call methods in modern style
  tty: Remove defunct pcxe_open() declaration
  tty: Remove defunct serial_console_init() declaration
  serial: hp300: Remove obsolete comments
  cris: Remove obsolete ASYNC_SPLIT_TERMIOS behavior
  tty: Document defunct ASYNC_SPLIT_TERMIOS flag in uapi header
  vt: Remove vt_get_kmsg_redirect() from uapi header
  serial: 8250_em: Remove out-of-memory message

 drivers/tty/serial/8250/8250_em.c    |  4 +---
 drivers/tty/serial/8250/8250_hp300.c |  4 ----
 drivers/tty/serial/crisv10.c         | 12 ------------
 drivers/tty/serial/crisv10.h         |  1 -
 drivers/tty/tty_io.c                 | 14 +++++++-------
 drivers/tty/tty_ioctl.c              |  4 ++--
 drivers/tty/vt/vt.c                  |  2 ++
 include/linux/tty.h                  |  8 --------
 include/uapi/linux/tty_flags.h       |  2 +-
 include/uapi/linux/vt.h              |  3 ---
 10 files changed, 13 insertions(+), 41 deletions(-)

-- 
2.1.3
