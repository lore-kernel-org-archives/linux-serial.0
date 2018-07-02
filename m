From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Date: Mon, 2 Jul 2018 18:04:28 +0800
Message-ID: <20180702180428.331b36c5@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 introduces necessary hooks to 8250 core.
patch2 implement the fractional divisor support for Synopsys DW 8250.

Jisheng Zhang (2):
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 54 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c |  8 +++++
 include/linux/serial_8250.h         |  7 ++++
 4 files changed, 73 insertions(+)

-- 
2.18.0
