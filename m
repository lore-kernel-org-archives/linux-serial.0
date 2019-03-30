From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 5.1-rc3
Date: Sat, 30 Mar 2019 10:04:00 +0100
Message-ID: <20190330090400.GA5598@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.1-rc3

for you to fetch changes up to f4e68d58cf2b20a581759bbc7228052534652673:

  tty: fix NULL pointer issue when tty_port ops is not set (2019-03-28 01:21:21 +0900)

----------------------------------------------------------------
TTY/Serial fixes for 5.1-rc3

Here are some small tty and serial driver fixes for 5.1-rc3.

Nothing major here, just a number of potential problems fixes for error
handling paths, as well as some other minor bugfixes for reported issues
with 5.1-rc1.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (2):
      serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference
      serial: max310x: Fix to avoid potential NULL pointer dereference

Erin Lo (1):
      dt-bindings: serial: Add compatible for Mediatek MT8183

Fabien Dessenne (1):
      tty: fix NULL pointer issue when tty_port ops is not set

Hoan Nguyen An (1):
      serial: sh-sci: Fix setting SCSCR_TIE while transferring data

Kangjie Lu (2):
      tty: atmel_serial: fix a potential NULL pointer dereference
      tty: mxs-auart: fix a potential NULL pointer dereference

Mao Wenan (1):
      sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()

Nathan Chancellor (1):
      tty: serial: qcom_geni_serial: Initialize baud in qcom_geni_console_setup

Petr Štetiar (1):
      serial: ar933x_uart: Fix build failure with disabled console

Razvan Stefanescu (2):
      tty/serial: atmel: Add is_half_duplex helper
      tty/serial: atmel: RS485 HD w/DMA: enable RX after TX is stopped

Wentao Wang (1):
      Disable kgdboc failed by echo space to /sys/module/kgdboc/parameters/kgdboc

 .../devicetree/bindings/serial/mtk-uart.txt        |  1 +
 drivers/tty/serial/ar933x_uart.c                   | 24 ++++------
 drivers/tty/serial/atmel_serial.c                  | 52 +++++++++++++++-------
 drivers/tty/serial/kgdboc.c                        |  4 +-
 drivers/tty/serial/max310x.c                       |  2 +
 drivers/tty/serial/mvebu-uart.c                    |  3 ++
 drivers/tty/serial/mxs-auart.c                     |  4 ++
 drivers/tty/serial/qcom_geni_serial.c              |  2 +-
 drivers/tty/serial/sc16is7xx.c                     | 12 ++++-
 drivers/tty/serial/sh-sci.c                        | 12 +----
 drivers/tty/tty_port.c                             | 10 ++---
 11 files changed, 75 insertions(+), 51 deletions(-)
