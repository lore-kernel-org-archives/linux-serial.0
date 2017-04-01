From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial driver fixes for 4.11-rc5
Date: Sat, 1 Apr 2017 17:59:26 +0200
Message-ID: <20170401155926.GA18354@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit c02ed2e75ef4c74e41e421acb4ef1494671585e8:

  Linux 4.11-rc4 (2017-03-26 14:15:16 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.11-rc5

for you to fetch changes up to e53e597fd4c4a0b6ae58e57d76a240927fd17eaa:

  tty: pl011: fix earlycon work-around for QDF2400 erratum 44 (2017-04-01 11:07:29 +0200)

----------------------------------------------------------------
TTY/Serial fixes for 4.11-rc5

Here are some small fixes for some serial drivers and Kconfig help text
for 4.11-rc5.  Nothing major here at all, a few things resolving
reported bugs in some random serial drivers.

I don't think these made the last linux-next due to me getting to them
yesterday, but I am not sure, they might have snuck in.  The patches
only affect drivers that the maintainers of sent me these patches for,
so we should be safe here :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Nicolas Ferre (1):
      tty/serial: atmel: fix TX path in atmel_console_write()

Paul Gortmaker (1):
      serial: 8250_EXAR: fix duplicate Kconfig text and add missing help text

Richard Genoud (1):
      tty/serial: atmel: fix race condition (TX+DMA)

Timur Tabi (1):
      tty: pl011: fix earlycon work-around for QDF2400 erratum 44

Uwe Kleine-König (1):
      serial: mxs-auart: Fix baudrate calculation

 drivers/tty/serial/8250/Kconfig   |  8 ++++++--
 drivers/tty/serial/amba-pl011.c   | 23 +++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.c |  8 ++++++++
 drivers/tty/serial/mxs-auart.c    |  2 +-
 4 files changed, 36 insertions(+), 5 deletions(-)
