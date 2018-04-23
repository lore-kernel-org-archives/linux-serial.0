From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 0/4] serial: uartps: Dynamic allocation
Date: Mon, 23 Apr 2018 11:50:59 +0200
Message-ID: <cover.1524477059.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

this is the initial version before next step which is move
uart_register_driver to probe function.
I was able to get rid of static array with uart_port structures.
It was wired with console which is also fixed.
And the next step is the most complicated one handle .nr in uart_driver
structure in more generic way.

I am sending these patches as v1. RFC was sent in past
(https://www.spinics.net/lists/linux-serial/msg27106.html)
and I promised to wait till Geert's
"serial: xuartps: Fix out-of-bounds access through DT
alias" (sha1: e7d75e18d0fc3f7193b65282b651f980c778d935) is applied.

Thanks,
Michal


Michal Simek (4):
  serial: uartps: Remove console_initcall from the driver
  serial: uartps: Use dynamic array for console port
  serial: uartps: Move cnds_uart_get_port to probe
  serial: uartps: Remove static port array

 drivers/tty/serial/xilinx_uartps.c | 102 +++++++++++------------------
 1 file changed, 40 insertions(+), 62 deletions(-)

-- 
2.17.0
