From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v3 0/3] serial: 8250_dw: add fractional divisor support
Date: Mon, 9 Jul 2018 16:18:18 +0800
Message-ID: <20180709160942.11a74f7a@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 introduces necessary hooks to 8250 core.
patch2 exports serial8250_do_set_divisor()
patch3 implements the fractional divisor support for Synopsys DW 8250.

Since v2:
 - rebase to tty-next branch, since I need one patch from Andy which
   is in tty-next
 - drop the patch "serial: 8250: let serial8250_get_divisor() get
   uart_port * as param" since it's in tty-next now.
 - add a new patch to export serial8250_do_set_divisor(), and reuse it
   to complete dw8250_set_divisor().
 - remove DW 8250 version check, since the DLF register always exists
   and if fractional divisor isn't supported, the register read as 0
 - add comments to explain how dw8250_get_divisor() get quot and frac.
 - the frac calcuation is simplified with well implemented GENMASK
 - Add Andy's Reviewed-by tag to patch1.

Since v1:
 - add an extra patch to let serial8250_get_divisor() get uart_port *
   as param
 - take Andy's suggestions to "integrates hooks in the same way like
   it's done for the rest of 8250 ones". Many thanks to Andy.

Jisheng Zhang (3):
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250: export serial8250_do_set_divisor()
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 45 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 30 +++++++++++++++----
 include/linux/serial_8250.h         |  3 ++
 include/linux/serial_core.h         |  7 +++++
 5 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.18.0
