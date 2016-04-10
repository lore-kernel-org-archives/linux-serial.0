From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 0/8] Replace kernel-defined ASYNC_ bits
Date: Sat,  9 Apr 2016 17:53:19 -0700
Message-ID: <1460249607-8014-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Grant Edwards <grant.b.edwards@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

As outlined in my January email ("RFC: out-of-tree tty driver breakage"),
the tty/serial core uses 5 bits in the tty_port.flags field to manage
state. They are:

ASYNCB_INITIALIZED
ASYNCB_SUSPENDED
ASYNCB_NORMAL_ACTIVE
ASYNCB_CTS_FLOW
ASYNCB_CHECK_CD

(NB: ASYNC_CLOSING was recently removed)

However, updates to this field (tty_port.flags) can be and often are
non-atomic. Additionally, the field is visible to/modifiable by userspace
(the state bits above are not modifiable by userspace though).

This series moves these state bits into a different tty_port field
(iflags) and abstracts state tests and changes with trivial helpers.

The last patch of the series purposefully breaks out-of-tree driver
builds to ensure they update state test/change methods to the helpers
instead.

REQUIRES: "tty: Replace TTY_IO_ERROR bit tests with tty_io_error()"
          "tty: Replace TTY_THROTTLED bit tests with tty_throttled()"

Regards,

Peter Hurley (8):
  tty: Define ASYNC_ replacement bits
  tty: Replace ASYNC_CTS_FLOW bit and update atomically
  tty: Replace ASYNC_NORMAL_ACTIVE bit and update atomically
  tty: Replace ASYNC_CHECK_CD and update atomically
  tty: Replace ASYNC_SUSPENDED bit and update atomically
  tty: Replace ASYNC_INITIALIZED bit and update atomically
  tty: mxser: Remove unused ASYNC_SHARE_IRQ flag
  tty: core: Undefine ASYNC_* flags superceded by TTY_PORT* flags

 drivers/char/pcmcia/synclink_cs.c   | 25 +++++-------
 drivers/ipack/devices/ipoctal.c     |  5 +--
 drivers/isdn/i4l/isdn_tty.c         | 38 ++++++++----------
 drivers/s390/char/con3215.c         | 22 +++++------
 drivers/tty/amiserial.c             | 31 +++++++--------
 drivers/tty/cyclades.c              | 38 ++++++++----------
 drivers/tty/isicom.c                | 19 ++++-----
 drivers/tty/moxa.c                  | 10 ++---
 drivers/tty/mxser.c                 | 28 +++++---------
 drivers/tty/n_gsm.c                 |  8 ++--
 drivers/tty/rocket.c                | 13 ++++---
 drivers/tty/serial/crisv10.c        | 25 ++++++------
 drivers/tty/serial/serial_core.c    | 40 ++++++++++---------
 drivers/tty/synclink.c              | 65 ++++++++++++++-----------------
 drivers/tty/synclink_gt.c           | 35 +++++++----------
 drivers/tty/synclinkmp.c            | 35 +++++++----------
 drivers/tty/tty_port.c              | 25 ++++++------
 drivers/usb/class/cdc-acm.c         |  4 +-
 drivers/usb/serial/console.c        |  4 +-
 drivers/usb/serial/generic.c        |  6 +--
 drivers/usb/serial/mxuport.c        |  6 +--
 drivers/usb/serial/sierra.c         |  4 +-
 drivers/usb/serial/usb-serial.c     |  2 +-
 drivers/usb/serial/usb_wwan.c       |  4 +-
 include/linux/tty.h                 | 77 ++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/tty_flags.h      | 13 ++++++-
 net/irda/ircomm/ircomm_tty.c        | 29 +++++++-------
 net/irda/ircomm/ircomm_tty_attach.c |  2 +-
 net/irda/ircomm/ircomm_tty_ioctl.c  | 10 ++---
 29 files changed, 320 insertions(+), 303 deletions(-)

-- 
2.8.1
