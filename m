From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH 0/4] serial: uartps: Dynamic allocation
Date: Fri, 21 Jul 2017 11:32:23 +0200
Message-ID: <cover.1500629544.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi Alan,

this is the initial version before next step which is move
uart_register_driver to probe function.
I was able to get rid of static array with uart_port structures.
It was wired with console which is also fixed.
And the next step is the most complicated one handle .nr in uart_driver
structure in more generic way.

Thanks,
Michal


Michal Simek (4):
  serial: uartps: Remove console_initcall from the driver
  serial: uartps: Use dynamic array for console port
  serial: uartps: Move cnds_uart_get_port to probe
  serial: uartps: Remove static port array

 drivers/tty/serial/xilinx_uartps.c | 102 +++++++++++++++----------------------
 1 file changed, 40 insertions(+), 62 deletions(-)

-- 
1.9.1
