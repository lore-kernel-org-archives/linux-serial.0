From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PULL] TTY/Serial fixes for 3.15-rc2
Date: Fri, 18 Apr 2014 14:37:44 -0700
Message-ID: <20140418213744.GA3605@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42779 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbaDRVhf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Apr 2014 17:37:35 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297f=
d6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tt=
y-3.15-rc2

for you to fetch changes up to 12de375ec493ab1767d4a07dde823e63ae5edc21=
:

  Revert "serial: 8250, disable "too much work" messages" (2014-04-17 0=
9:33:19 -0700)

----------------------------------------------------------------
TTY/Serial driver fixes for 3.15-rc2

Here are a number of small tty/serial driver fixes for 3.15-rc2.  Also
in here are some Documentation file removals for drivers that we remove=
d
a long time ago, no need to keep it around any longer.

All of these have been in linux-next for a bit.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shiyan (1):
      Revert "serial: clps711x: Give a chance to perform useful tasks d=
uring wait loop"

Chen Tingjie (1):
      tty: fix memleak in alloc_pid

Daniel Thompson (1):
      serial: st-asc: Fix SysRq char handling

Geert Uytterhoeven (1):
      serial_core: Fix pm imbalance on unbind

Greg Kroah-Hartman (1):
      Revert "serial: 8250, disable "too much work" messages"

Guennadi Liakhovetski (2):
      serial: pl011: change Rx burst size to half of trigger level
      serial: amba-pl011: fix regression, causing an Oops on rmmod

Jean Delvare (3):
      serial: timberdale: Depend on X86_32
      Documentation/serial: Delete obsolete driver documentation
      tty: Fix help text of SYNCLINK_CS

Jiri Slaby (1):
      serial: 8250, disable "too much work" messages

Sanjay Singh Rawat (1):
      serial: omap: free the wakeup settings in remove

Seth Bollinger (1):
      serial_core: Fix conditional start_tx on ring buffer not empty

Takashi Iwai (2):
      ttyprintk: Fix wrong tty_unregister_driver() call in the error pa=
th
      ttyprintk: Allow built as a module

Tony Lindgren (1):
      serial: omap: Fix missing pm_runtime_resume handling by simplifyi=
ng code

Uwe Kleine-K=F6nig (1):
      serial: efm32: use $vendor,$device scheme for compatible string

 .../devicetree/bindings/serial/efm32-uart.txt      |   4 +-
 Documentation/kernel-parameters.txt                |  13 -
 Documentation/magic-number.txt                     |  12 -
 Documentation/serial/00-INDEX                      |   8 -
 Documentation/serial/digiepca.txt                  |  98 ------
 Documentation/serial/riscom8.txt                   |  36 --
 Documentation/serial/specialix.txt                 | 383 -------------=
--------
 Documentation/serial/sx.txt                        | 294 -------------=
---
 Documentation/zh_CN/magic-number.txt               |  12 -
 drivers/char/Kconfig                               |   2 +-
 drivers/char/pcmcia/Kconfig                        |   2 +-
 drivers/char/ttyprintk.c                           |  15 +-
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/amba-pl011.c                    |   8 +-
 drivers/tty/serial/clps711x.c                      |  20 +-
 drivers/tty/serial/efm32-uart.c                    |   3 +
 drivers/tty/serial/omap-serial.c                   |  30 +-
 drivers/tty/serial/serial_core.c                   |   5 +-
 drivers/tty/serial/st-asc.c                        |   4 +-
 drivers/tty/tty_io.c                               |   4 +-
 firmware/WHENCE                                    |  10 -
 21 files changed, 57 insertions(+), 907 deletions(-)
 delete mode 100644 Documentation/serial/digiepca.txt
 delete mode 100644 Documentation/serial/riscom8.txt
 delete mode 100644 Documentation/serial/specialix.txt
 delete mode 100644 Documentation/serial/sx.txt
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
