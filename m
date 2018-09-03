From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v3 00/10] serial: uartps: Add run time support for more IPs than hardcoded 2
Date: Mon,  3 Sep 2018 15:10:48 +0200
Message-ID: <cover.1535980253.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

this series is trying to address discussion I had with Alan in past
https://patchwork.kernel.org/patch/9738445/ and also with Rob in v1
https://lkml.org/lkml/2018/4/26/551.

These patches are doing preparation to enable dynamic ID port allocation
which is capable to create devices with higher IDs.

For example this is how it works.
uart0 on higher alias
serial0 = &uart1;
serial30 = &uart0;

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jun  6 12:19 /dev/ttyPS0
crw--w----    1 root     root      253, 100 Jan  1  1970 /dev/ttyPS30

Thanks,
Michal

Changes in v3:
- New patch found by testing
- New patch - can be sent separately but there is dependency that's why
  sent in this series
- Fix uart_unregister_driver() in error path or when driver is removed.
- Change commit message
- s/,/;/ in filling structure
- get cdns_uart_uart_driver out of PS_UART_CONSOLE ifdefs
- New patch in series
- Rebase on the top of previous broken patch
- Change patch subject ("was serial: uartps: Remove CDNS_UART_NR_PORTS
  macro")
- Keep CDNS_UART_NR_PORTS in this patch and remove it in next one and
  align commit message to reflect this
- Allocate struct console dynamically too to be unique for every
  instance
- Cleanup error path
- New patch in series

Changes in v2:
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- Remove nr field logic
- new patch - it can be sent separately too
- Register one uart_driver with unique minor at probe time

Michal Simek (9):
  serial: uartps: console_setup() can't be placed to init section
  serial: uartps: Do not initialize field to zero again
  serial: uartps: Do not use static struct uart_driver out of probe()
  serial: uartps: Move alias reading higher in probe()
  serial: uartps: Move register to probe based on run time detection
  serial: uartps: Fill struct uart_driver in probe()
  serial: uartps: Change logic how console_port is setup
  serial: uartps: Register own uart console and driver structures
  serial: uartps: Move Port ID to device data structure

Nava kishore Manne (1):
  serial: uartps: Fix suspend functionality

 drivers/tty/serial/xilinx_uartps.c | 203 +++++++++++++++++++------------------
 1 file changed, 107 insertions(+), 96 deletions(-)

-- 
1.9.1
