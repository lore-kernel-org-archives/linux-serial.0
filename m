From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Tue, 15 May 2018 21:34:06 +0300
Message-ID: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Kernel console is sensitive to any kind of complex work needed to print
out anything on it. One such case is emergency print during Oops.

This series proposes to disable runtime PM and DMA operations on 8250
serial console.

More detailed explanation why is provided in patch 2.

The series has been in our internal trees for years already with no
problems observed.

Andy Shevchenko (3):
  console: introduce ->exit() callback
  serial: 8250_port: Don't use power management for kernel console
  serial: 8250_port: Disable DMA operations for kernel console

 drivers/tty/serial/8250/8250_core.c |  9 +++++++++
 drivers/tty/serial/8250/8250_port.c | 27 ++++++++++++++++++++++-----
 include/linux/console.h             |  1 +
 include/linux/serial_8250.h         |  1 +
 kernel/printk/printk.c              |  3 +++
 5 files changed, 36 insertions(+), 5 deletions(-)

-- 
2.17.0
