From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCHv2 0/2] tty: serial: men_z135_uart.c: Updates for men_z135_uart
Date: Thu,  6 Aug 2015 09:16:36 +0200
Message-ID: <cover.1438844880.git.jthumshirn@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Andreas Werner <andreas.werner@men.de>, Johannes Thumshirn <jthumshirn@suse.de>
List-Id: linux-serial@vger.kernel.org

Version two of the updates for the men_z135_uart, incorporating Peter's review
comments.

1/2: Use spin_lock_irq() in settermios() and spin_lock() in ISR to avoid
     deadlocks.
2/2: Removes the double initialization of the port.lock spinlock.

Johannes Thumshirn (2):
  tty: serial: men_z135_uart.c: Fix race between IRQ and set_termios()
  tty: serial: men_z135_uart.c: Don't initialize port->lock

 drivers/tty/serial/men_z135_uart.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

-- 
2.4.6
