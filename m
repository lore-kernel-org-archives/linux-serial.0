From: Greg KH <gregkh@linuxfoundation.org>
Subject: [GIT PATCH] TTY/serial patches for 3.6-rc1
Date: Fri, 27 Jul 2012 12:05:05 -0700
Message-ID: <20120727190505.GA31989@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55357 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab2G0TFK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Jul 2012 15:05:10 -0400
Received: by yhmm54 with SMTP id m54so3551987yhm.19
        for <linux-serial@vger.kernel.org>; Fri, 27 Jul 2012 12:05:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf423229f92:

  Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-3.6-rc1

for you to fetch changes up to 38bd2a1ac736901d1cf4971c78ef952ba92ef78b:

  pch_uart: Fix parity setting issue (2012-07-26 13:37:14 -0700)

----------------------------------------------------------------
TTY/Serial patches for 3.6-rc1

Here's the "tiny" set of patches for 3.6-rc1 for the tty layer and
serial drivers.  They were cherry-picked from the tty-next branch of the
tty git tree, as they are small and "obvious" fixes.  The larger
changes, as mentioned before, will be saved for the 3.7-rc1 merge
window.

All of these changes have been in the linux-next releases for quite a
while.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Cox (1):
      pch_uart: Fix missing break for 16 byte fifo

Corbin (1):
      serial_core: Update buffer overrun statistics.

Darren Hart (1):
      pch_uart: Add eg20t_port lock field, avoid recursive spinlocks

Kyoungil Kim (1):
      serial: samsung: Fixed wrong comparison for baudclk_rate

Rabin Vincent (1):
      vt: fix race in vt_waitactive()

Roland Stigge (2):
      serial/8250: Add LPC3220 standard UART type
      serial/of-serial: Add LPC3220 standard UART compatible string

Shachar Shemesh (1):
      tty ldisc: Close/Reopen race prevention should check the proper flag

Tomoya MORINAGA (2):
      pch_uart: Fix rx error interrupt setting issue
      pch_uart: Fix parity setting issue

 .../devicetree/bindings/tty/serial/of-serial.txt   |    1 +
 drivers/tty/serial/8250/8250.c                     |    8 +++
 drivers/tty/serial/of_serial.c                     |    1 +
 drivers/tty/serial/pch_uart.c                      |   59 +++++++++++++-------
 drivers/tty/serial/samsung.c                       |    4 +-
 drivers/tty/serial/serial_core.c                   |    6 +-
 drivers/tty/tty_ldisc.c                            |    2 +-
 drivers/tty/vt/vt_ioctl.c                          |   47 +++++++++++-----
 include/linux/serial_core.h                        |    3 +-
 9 files changed, 93 insertions(+), 38 deletions(-)
