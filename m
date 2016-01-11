From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 0/9] Misc tty fixes & cleanups
Date: Sun, 10 Jan 2016 20:36:07 -0800
Message-ID: <1452486976-7594-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Again, apologies for the mixed series; this is the other series.
This series contains accumulated cleanups for the tty core and drivers.

Regards,

Peter Hurley (9):
  tty: rocket: Remove private close_wait
  n_tty: Ignore all read data when closing
  ia64: Pin controlling tty for unaligned fault message
  staging: dgap: Remove redundant write_wait wakeups
  tty: Fix GPF in flush_to_ldisc(), part 2
  tty: Unify receive_buf() code paths
  tty: Allow unreadable mess to be > 80 chars
  tty: Use termios c_*flag macros
  tty: Use test_bit() with tty->flags

 arch/ia64/hp/sim/simserial.c         |  2 +-
 arch/ia64/kernel/unaligned.c         |  7 +++++--
 drivers/char/pcmcia/synclink_cs.c    | 23 +++++++++------------
 drivers/isdn/i4l/isdn_tty.c          |  6 +++---
 drivers/mmc/card/sdio_uart.c         | 14 ++++++-------
 drivers/s390/char/tty3270.c          |  4 ++--
 drivers/staging/dgap/dgap.c          | 10 ++-------
 drivers/staging/dgnc/dgnc_tty.c      |  4 ++--
 drivers/tty/amiserial.c              | 28 ++++++++++----------------
 drivers/tty/cyclades.c               | 14 ++++++-------
 drivers/tty/isicom.c                 |  3 +--
 drivers/tty/mxser.c                  | 10 ++++-----
 drivers/tty/n_gsm.c                  |  6 +++---
 drivers/tty/n_tty.c                  |  2 --
 drivers/tty/pty.c                    |  3 +--
 drivers/tty/rocket.c                 | 10 ++++-----
 drivers/tty/rocket_int.h             |  1 -
 drivers/tty/serial/68328serial.c     |  6 ++----
 drivers/tty/serial/crisv10.c         | 22 +++++++++-----------
 drivers/tty/serial/jsm/jsm_tty.c     |  3 +--
 drivers/tty/serial/serial_core.c     | 26 +++++++++++-------------
 drivers/tty/synclink.c               | 27 ++++++++++---------------
 drivers/tty/synclink_gt.c            | 23 +++++++++------------
 drivers/tty/synclinkmp.c             | 23 +++++++++------------
 drivers/tty/tty_buffer.c             | 39 ++++++++++++++++++++++++++----------
 drivers/tty/tty_ioctl.c              | 12 +++++------
 drivers/tty/tty_port.c               | 10 ++++-----
 drivers/usb/serial/cypress_m8.c      |  3 +--
 drivers/usb/serial/digi_acceleport.c |  8 ++++----
 drivers/usb/serial/io_edgeport.c     |  4 ++--
 drivers/usb/serial/mct_u232.c        |  2 +-
 drivers/usb/serial/mos7720.c         |  4 ++--
 drivers/usb/serial/mos7840.c         |  4 ++--
 include/linux/tty.h                  | 16 ++-------------
 net/irda/ircomm/ircomm_tty.c         | 11 +++++-----
 net/irda/ircomm/ircomm_tty_ioctl.c   | 19 +++++++-----------
 36 files changed, 178 insertions(+), 231 deletions(-)

-- 
2.7.0
