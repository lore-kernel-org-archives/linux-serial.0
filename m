From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial patches for 4.2-rc4
Date: Sat, 25 Jul 2015 19:21:15 -0700
Message-ID: <20150726022115.GA21421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 52721d9d3334c1cb1f76219a161084094ec6=
34dc:

  Linux 4.2-rc3 (2015-07-19 14:45:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.2-rc4

for you to fetch changes up to 61e86cc90af49cecef9c54ccea1f572fbcb695ac=
:

  tty: vt: Fix !TASK_RUNNING diagnostic warning from paste_selection() =
(2015-07-23 18:08:29 -0700)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.2-rc4

Here are a number of small serial and tty fixes for reported issues.

All have been in linux-next successfully.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Axel Lin (1):
      serial: etraxfs-uart: Fix release etraxfs_uart_ports

Bo Svang=E5rd (1):
      sc16is7xx: fix FIFO address of secondary UART

David Jander (1):
      Revert "serial: imx: initialized DMA w/o HW flow enabled"

Dongxing Zhang (1):
      tty/vt: Fix the memory leak in visual_init

Jakub Kicinski (1):
      sc16is7xx: fix Kconfig dependencies

Krzysztof Kozlowski (1):
      serial: amba-pl011: Fix devm_ioremap_resource return value check

Peter Hurley (4):
      n_tty: signal and flush atomically
      m32r: Add ioreadXX/iowriteXX big-endian mmio accessors
      serial: core: Fix crashes while echoing when closing
      tty: vt: Fix !TASK_RUNNING diagnostic warning from paste_selectio=
n()

 arch/m32r/include/asm/io.h        |  5 +++++
 drivers/tty/n_tty.c               | 16 +++++++++++++---
 drivers/tty/serial/Kconfig        |  2 +-
 drivers/tty/serial/amba-pl011.c   |  4 ++--
 drivers/tty/serial/etraxfs-uart.c |  2 +-
 drivers/tty/serial/imx.c          | 15 +++++++--------
 drivers/tty/serial/sc16is7xx.c    | 30 +++++++++++++++++++++++-------
 drivers/tty/serial/serial_core.c  |  3 ++-
 drivers/tty/vt/selection.c        |  1 +
 drivers/tty/vt/vt.c               |  2 ++
 10 files changed, 57 insertions(+), 23 deletions(-)
