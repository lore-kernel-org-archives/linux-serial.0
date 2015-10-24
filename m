From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 0/2] serial: 8250_early: simplify serial_putc()
Date: Sat, 24 Oct 2015 13:17:43 +0900
Message-ID: <1445660265-13668-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, Wang Long <long.wanglong@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org


Changes in v2:
  - split into two patches

Masahiro Yamada (2):
  serial: 8250_early: do not save and restore IER in write callback
  serial: 8250_early: squash wait_for_xmitr() into serial_putc()

 drivers/tty/serial/8250/8250_early.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

-- 
1.9.1
