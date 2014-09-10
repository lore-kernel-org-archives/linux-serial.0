From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 00/14] tty/serial flow control fixes
Date: Wed, 10 Sep 2014 15:06:22 -0400
Message-ID: <1410375996-4693-1-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

Changes since v1:
1. Omits v1 patches 1-12 which you already applied
2. Depends on 'locking: Add WARN_ON_ONCE lock assertion',
   which replaces v1 patch 13
3. Works around Alpha EV4/5 non-atomic byte/short storage
4. Works around gcc bug in versions < 4.7.2, where bitfield stores can
   corrupt adjacent storage on ia64, ppc64, sparc64 and 64-bit parisc arches
   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52080

v1:

This patch series reworks the internals of tty and serial flow control to
fix multiple races in both START/STOP flow control and RTS/CTS flow control.

The main changes in this series are:
Patch 2 (v1 patch 15)
   Rename and move ASYNC_CTS_FLOW and ASYNC_CHECK_CD statuses into
   a private field for the serial core, and add helper functions to test
   those statuses for UART drivers.

   This is a necessary step toward making tty port->flags SMP-safe, without
   introducing a new lock.

Patches 1, 4 and 8 (v1 patches 14, 17 and 21)
   Make CTS flow control state SMP-safe, by moving hw_stopped into a private
   field of the serial core.

Patches 9-11 (v1 patches 22-24)
   Make tty flow control changes mutually exclusive.

   Protecting tty->stopped and tty->flow_stopped with a new spin lock (instead
   of the ->ctrl_lock) is required to fix multiple races with controlling
   terminal changes, coming in a follow-on patch series.

Patches 12 & 13 (v1 patches 25 & 26)
   Cleanup tcflow(TCIxxx)

Regards,

Peter Hurley (14):
  serial: core: Document and assert lock requirements for irq helpers
  serial: core: Privatize modem status enable flags
  isdn: i4l: Remove ASYNC_CTS_FLOW
  serial: core: Privatize tty->hw_stopped
  usb: serial: Remove unused tty->hw_stopped
  serial: bfin-uart: Fix auto CTS
  serial: core: Use spin_lock_irq() in uart_set_termios()
  tty: Convert tty_struct bitfield to ints
  tty: Serialize tty flow control changes with flow_lock
  tty: Move packet mode flow control notifications to pty driver
  tty: Serialize tcflow() with other tty flow control changes
  tty: Move and rename send_prio_char() as tty_send_xchar()
  tty: Hold termios_rwsem for tcflow(TCIxxx)
  tty: Workaround Alpha non-atomic byte storage in tty_struct

 drivers/isdn/i4l/isdn_tty.c           |  5 --
 drivers/tty/pty.c                     | 41 +++++++++++++++
 drivers/tty/serial/bfin_uart.c        | 15 +++---
 drivers/tty/serial/mxs-auart.c        |  2 +-
 drivers/tty/serial/serial_core.c      | 70 +++++++++++++++-----------
 drivers/tty/tty_io.c                  | 93 ++++++++++++++++++++++-------------
 drivers/tty/tty_ioctl.c               | 47 +++++-------------
 drivers/usb/serial/digi_acceleport.c  |  7 +--
 drivers/usb/serial/io_ti.c            |  7 +--
 drivers/usb/serial/ti_usb_3410_5052.c |  7 +--
 include/linux/serial_core.h           | 15 +++++-
 include/linux/tty.h                   | 15 ++++--
 include/linux/tty_driver.h            |  4 ++
 13 files changed, 193 insertions(+), 135 deletions(-)

-- 
2.1.0
