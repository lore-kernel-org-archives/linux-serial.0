From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 0/3] serial: 8250_early: simplify serial_putc()
Date: Fri, 30 Oct 2015 11:39:02 +0900
Message-ID: <1446172745-5115-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org



Changes in v3:
  - Split into three patches.
  - Confirm the empty TX only after sending each character.

Changes in v2:
  - split into two patches

Masahiro Yamada (3):
  serial: 8250_early: do not save and restore IER in write callback
  serial: 8250_early: confirm empty transmitter after sending characters
  serial: 8250_early: squash wait_for_xmitr() into serial_putc()

 drivers/tty/serial/8250/8250_early.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

-- 
1.9.1
