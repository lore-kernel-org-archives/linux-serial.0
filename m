From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 4.0-rc6
Date: Sat, 4 Apr 2015 13:09:55 +0200
Message-ID: <20150404110955.GA15229@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The following changes since commit bc465aa9d045feb0e13b4a8f32cc33c1943f62d6:

  Linux 4.0-rc5 (2015-03-22 16:50:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.0-rc6

for you to fetch changes up to 8e4934c6d6c659e22b1b746af4196683e77ce6ca:

  tty: serial: fsl_lpuart: clear receive flag on FIFO flush (2015-03-26 23:13:14 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 4.0-rc6

Here are 3 serial driver fixes for 4.0-rc6.  They fix some reported
issues with the samsung and fsl_lpuart drivers.

All have been in linux-next for a while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Javier Martinez Canillas (1):
      serial: samsung: Clear operation mode on UART shutdown

Stefan Agner (2):
      tty: serial: fsl_lpuart: specify transmit FIFO size
      tty: serial: fsl_lpuart: clear receive flag on FIFO flush

 drivers/tty/serial/fsl_lpuart.c | 5 +++++
 drivers/tty/serial/samsung.c    | 1 +
 2 files changed, 6 insertions(+)
