From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH v9 0/3]  serial: 8250_dw add big endian support
Date: Sat, 12 Dec 2015 19:18:24 +0200
Message-ID: <1449940707-17633-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, vgupta@synopsys.com, Alexey.Brodkin@synopsys.com, jslaby@suse.com, peter@hurleysoftware.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Add support for UPIO_MEM32BE in addition to UPIO_MEM32.

v9 change:
1) split patch into check_lcr routine and then add big endian feature
2) add new iotype support for BE 32 bit
3) make each call to readl/writel depend on iotype

V8 change:
rebase on tty-next head, no functional change.

V7 change:
Fix build warning due to redundant "const" qualifier at
_dw8250_serial_in32be() signature.

V6 change:
Adapt patch to latest version (nothing functional)

V5 change:
Two patches is now squashed into single one

V4 change
Remove patch for skipping looptest through DT option.
This is now handled in our simulator model.
Thanks to Vineet Gupta from Synopsys for his help.

We are left with 2 patches which adds BIG endian support.

V3 change:
Use second level accessors for big/little endian port.
The new accessors are now pointed from uart_port->private_data
These accessors are initialized during driver probe().
Driver shouldn't access directly to readl/writel but to
these new second level accessors (first level is at uart_port).
e.g. at dw8250_check_LCR() and dw8250_setup_port() I replaced such
direct calls.

V2 changes:
1) better description for each commit.
2) adding to CC list the device tree maintainer.
3) rename dw8250_check_control() --> dw8250_check_LCR().
4) remove bad patch of "add UPF_FIXED_TYPE to flags".

Noam Camus (3):
  serial: 8250_dw: Avoid serial_outx code duplicate with new
    dw8250_check_lcr()
  serial: 8250_dw: Add support for big-endian MMIO accesses
  serial: 8250_dw: Do not use readl/writel before checking port iotype

 drivers/tty/serial/8250/8250_dw.c |  126 ++++++++++++++++++++++---------------
 1 files changed, 75 insertions(+), 51 deletions(-)
