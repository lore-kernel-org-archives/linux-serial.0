From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.3-rc5
Date: Sat, 10 Oct 2015 09:21:19 -0700
Message-ID: <20151010162119.GA14385@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit 9ffecb10283508260936b96022d4ee43a779=
8b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-4.3-rc5

for you to fetch changes up to 0c55627167870255158db1cde0d28366f91c8872=
:

  drivers/tty: require read access for controlling terminal (2015-10-04=
 19:20:30 +0100)

----------------------------------------------------------------
TTY/Serial driver fixes for 4.3-rc5

Here are a few bug fixes for the tty core that resolve reported issues,
and some serial driver fixes as well (including the much-reported imx
driver problem.)

All of these have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dmitry Vyukov (3):
      tty: fix data race in flush_to_ldisc
      tty: fix data race in tty_buffer_flush
      tty: fix data race on tty_buffer.commit

=46abio Estevam (1):
      Revert "serial: imx: remove unbalanced clk_prepare"

Jann Horn (1):
      drivers/tty: require read access for controlling terminal

Kosuke Tatsukawa (1):
      tty: fix stall caused by missing memory barrier in drivers/tty/n_=
tty.c

Leon Yu (1):
      tty: don't leak cdev in tty_cdev_add()

Mans Rullgard (1):
      serial: 8250: add uart_config entry for PORT_RT2880

Uwe Kleine-K=F6nig (1):
      serial: atmel: fix error path of probe function

 drivers/tty/n_tty.c                 | 15 +++++---------
 drivers/tty/serial/8250/8250_port.c |  8 ++++++++
 drivers/tty/serial/atmel_serial.c   |  2 +-
 drivers/tty/serial/imx.c            | 20 +++++++++++++------
 drivers/tty/tty_buffer.c            | 22 +++++++++++++++-----
 drivers/tty/tty_io.c                | 40 +++++++++++++++++++++++++++++=
++------
 6 files changed, 79 insertions(+), 28 deletions(-)
