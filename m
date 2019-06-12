From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 0/6] serial: uartps:
Date: Wed, 12 Jun 2019 13:14:37 +0200
Message-ID: <cover.1560338079.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: johan@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,

This patchset is fixing several issues reported by checkpatch but also
major number handling for multiple allocated ports. For more information
please look at the first patch which describes more details.

When this patchset is applied driver only reports one checkpatch warning
which should be fixed via console.h first.
include/linux/console.h:147:    void    (*write)(struct console *, const char *, unsigned);

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+				    unsigned n)

Thanks,
Michal

v1
 https://lkml.org/lkml/2019/6/10/186
 https://lkml.org/lkml/2019/6/10/187


Changes in v2:
- Fix typo in subject line
- Swap patches compare to previous series
- Add Fixes tag
- Split patch from v1
- Fixes second S_IRUGO usage
- Add Fixes tag
- Split patch from v1
- Add Fixes tag
- Split patch from v1
- Add Fixes tag
- Split patch from v1
- Add Fixes tag
- Split patch from v1
- Add Fixes tag

Nava kishore Manne (5):
  serial: uartps: Use octal permission for module_param()
  serial: uartps: Fix multiple line dereference
  serial: uartps: Fix long line over 80 chars
  serial: uartps: Do not add a trailing semicolon to macro
  serial: uartps: Remove useless return from cdns_uart_poll_put_char

Shubhrajyoti Datta (1):
  serial: uartps: Use the same dynamic major number for all ports

 drivers/tty/serial/xilinx_uartps.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.17.1
