From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v2 0/3] serial: 8250_dw: add fractional divisor support
Date: Wed, 4 Jul 2018 16:59:08 +0800
Message-ID: <20180704165908.4bb8b090@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 lets serial8250_get_divisor() get uart_port * as param
patch2 introduces necessary hooks to 8250 core.
patch3 implements the fractional divisor support for Synopsys DW 8250.

Since v1:
 - add an extra patch to let serial8250_get_divisor() get uart_port *
   as param
 - take Andy's suggestions to "integrates hooks in the same way like
   it's done for the rest of 8250 ones". Many thanks to Andy.

Jisheng Zhang (3):
  serial: 8250: let serial8250_get_divisor() get uart_port * as param
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 53 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 33 ++++++++++++++----
 include/linux/serial_core.h         |  7 ++++
 4 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.18.0
