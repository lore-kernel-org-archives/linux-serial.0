From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Tue, 15 May 2018 21:37:18 +0300
Message-ID: <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 2018-05-15 at 21:34 +0300, Andy Shevchenko wrote:
> Kernel console is sensitive to any kind of complex work needed to
> print
> out anything on it. One such case is emergency print during Oops.
> 
> This series proposes to disable runtime PM and DMA operations on 8250
> serial console.
> 
> More detailed explanation why is provided in patch 2.
> 
> The series has been in our internal trees for years already with no
> problems observed.

+Cc: Tony.

You might have some thoughts / test means for this.

> 
> Andy Shevchenko (3):
>   console: introduce ->exit() callback
>   serial: 8250_port: Don't use power management for kernel console
>   serial: 8250_port: Disable DMA operations for kernel console
> 
>  drivers/tty/serial/8250/8250_core.c |  9 +++++++++
>  drivers/tty/serial/8250/8250_port.c | 27 ++++++++++++++++++++++-----
>  include/linux/console.h             |  1 +
>  include/linux/serial_8250.h         |  1 +
>  kernel/printk/printk.c              |  3 +++
>  5 files changed, 36 insertions(+), 5 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
