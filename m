From: Noam Camus <noamc@ezchip.com>
Subject: [v5] *** 8250_dw ***
Date: Tue, 25 Aug 2015 11:57:08 +0300
Message-ID: <1440493029-28760-1-git-send-email-noamc@ezchip.com>
References: <1437886478-29273-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437886478-29273-1-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

v5 change:
Two patches is now squashed into single one

v4 change
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

Noam Camus (1):
  serial: 8250_dw: Add support for big-endian MMIO accesses

 drivers/tty/serial/8250/8250_dw.c |   72 ++++++++++++++++++++++++++++++++-----
 1 files changed, 63 insertions(+), 9 deletions(-)
