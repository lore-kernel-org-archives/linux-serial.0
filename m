From: Michal Simek <michal.simek@xilinx.com>
Subject: [RFC PATCH v2 0/6] serial: uartps: Add run time support for more IPs than hardcoded 2
Date: Wed,  6 Jun 2018 14:41:33 +0200
Message-ID: <cover.1528288895.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, gnomes@lxorguk.ukuu.org.uk, Alexander Graf <agraf@suse.de>, shubhraj@xilinx.com, robh@kernel.org
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

this series is trying to address discussion I had with Alan in past
https://patchwork.kernel.org/patch/9738445/ and also with Rob in v1
https://lkml.org/lkml/2018/4/26/551.

The first 5 patches are preparation patches to have the last patch as
small as possible to focus on changes there.

Cases without DT aliases are not solved in this series but one function
was shared in RFC v1.
The purpose of this series to get feedback on solution where every
driver instance allocate at run time own uart_driver.

For example this is how it works.
uart0 on higher alias
serial0 = &uart1;
serial100 = &uart0;

~# ls -la /dev/ttyPS*
crw-------    1 root     root      252,   0 Jun  6 12:19 /dev/ttyPS0
crw--w----    1 root     root      253, 100 Jan  1  1970 /dev/ttyPS100

Thanks,
Michal


Changes in v2:
- new patch - it can be sent separately too
- Remove nr field logic
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- new patch - it can be sent separately too
- Register one uart_driver with unique minor at probe time

Michal Simek (6):
  serial: uartps: Do not initialize field to zero again
  serial: uartps: Move register to probe based on run time detection
  serial: uartps: Do not use static struct uart_driver out of probe()
  serial: uartps: Move alias reading higher in probe()
  serial: uartps: Fill struct uart_driver in probe()
  serial: uartps: Remove CDNS_UART_NR_PORTS macro

 drivers/tty/serial/xilinx_uartps.c | 126 ++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 58 deletions(-)

-- 
1.9.1
