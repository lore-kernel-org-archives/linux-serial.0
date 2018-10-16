From: <shubhrajyoti.datta@gmail.com>
Subject: [LINUX PATCHv3 0/9] serial-uartlite: Add support for dynamic allocation
Date: Tue, 16 Oct 2018 15:47:59 +0530
Message-ID: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jacmet@sunsite.dk, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Currently the number of uarts are configured through a Kconfig
option Make it dynamic.
While at it adapt to the runtime framework.

It is based a similar series on the uartps from Michal

Shubhrajyoti Datta (9):
  serial-uartlite: Move the uart register
  serial-uartlite: Add get serial id if not provided
  serial-uartlite: Do not use static struct uart_driver out of probe()
  serial-uartlite: Add runtime support
  serial-uartlite: Fix the unbind path
  serial-uartlite: Change logic how console_port is setup
  serial-uartlite: Use allocated structure instead of static ones
  serial-uartlite: Remove ULITE_NR_PORTS macro
  serial-uartlite: Remove SERIAL_UARTLITE_NR_UARTS

 drivers/tty/serial/Kconfig    |   9 --
 drivers/tty/serial/uartlite.c | 325 +++++++++++++++++++++++++++++++-----------
 2 files changed, 243 insertions(+), 91 deletions(-)

-- 
2.1.1
