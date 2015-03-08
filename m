From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.0-rc3
Date: Sun, 8 Mar 2015 13:52:20 +0100
Message-ID: <20150308125220.GA400@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 13a7a6ac0a11197edcd0f756a035f472b42cdf8b:

  Linux 4.0-rc2 (2015-03-03 09:04:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.0-rc3

for you to fetch changes up to c37bc682e30b8027054356214eb8a3aafbda8e37:

  TTY: fix tty_wait_until_sent maximum timeout (2015-03-07 03:44:15 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 4.0-rc3

Here are some tty and serial driver fixes for 4.0-rc3.

Along with the atime fix that you know about, here are some other serial
driver bugfixes as well.  Most notable is a wait_until_sent bugfix that
was traced back to being around since before 2.6.12 that Johan has fixed
up.

All have been in linux-next successfully.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Axel Lin (1):
      serial: sprd: Fix missing spin_unlock in sprd_handle_irq()

Baruch Siach (1):
      Revert "tty/serial: of_serial: add DT alias ID handling"

Desmond Liu (1):
      serial: 8250_dw: Fix get_mctrl behaviour

Jiri Slaby (1):
      tty: fix up atime/mtime mess, take four

Johan Hovold (5):
      net: irda: fix wait_until_sent poll timeout
      TTY: bfin_jtag_comm: remove incorrect wait_until_sent operation
      USB: serial: fix infinite wait_until_sent timeout
      TTY: fix tty_wait_until_sent on 64-bit machines
      TTY: fix tty_wait_until_sent maximum timeout

Peter Hurley (3):
      console: Fix console name size mismatch
      serial: core: Fix iotype userspace breakage
      serial: uapi: Declare all userspace-visible io types

Russell King (1):
      Change email address for 8250_pci

Sebastian Andrzej Siewior (1):
      serial: 8250: Revert "tty: serial: 8250_core: read only RX if there is something in the FIFO"

Wang YanQing (2):
      serial:8250:8250_pci: fix redundant entry report for WCH_CH352_2S
      serial:8250:8250_pci: delete unneeded quirk entries

 .../bindings/serial/snps-dw-apb-uart.txt           | 16 +++++++++++
 drivers/tty/bfin_jtag_comm.c                       | 13 ---------
 drivers/tty/serial/8250/8250_core.c                | 11 ++++----
 drivers/tty/serial/8250/8250_dw.c                  | 32 ++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c                 | 20 +-------------
 drivers/tty/serial/of_serial.c                     |  4 ---
 drivers/tty/serial/sprd_serial.c                   |  4 ++-
 drivers/tty/tty_io.c                               |  4 +--
 drivers/tty/tty_ioctl.c                            | 16 +++++++----
 drivers/usb/serial/generic.c                       |  5 ++--
 include/linux/serial_core.h                        | 14 +++++-----
 include/uapi/linux/serial.h                        |  4 +++
 kernel/printk/console_cmdline.h                    |  2 +-
 kernel/printk/printk.c                             |  1 +
 net/irda/ircomm/ircomm_tty.c                       |  4 ++-
 15 files changed, 89 insertions(+), 61 deletions(-)
