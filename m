From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCHv2 0/4] less deadlock prone serial consoles
Date: Tue, 16 Oct 2018 14:04:24 +0900
Message-ID: <20181016050428.17966-1-sergey.senozhatsky@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

	Hello,


	RFC


	The patch set reduces the number of ways serial consoles
can deadlock the system, including the recently reported deadlock
in panic().

The test scenario I ran on my x86_64 box:
- panic() the system while one of the CPUs holds 8250's
  uart_port->lock.

Test results:

	base		|	patched
	-----------------------------------------
	deadlock	|	flush logbuf
			|	reboot the system

To keep the cover letter short, please find full description in
commit messages.

P.S. since this is RFC I modify only 8250 serial driver.

Sergey Senozhatsky (4):
  panic: avoid deadlocks in re-entrant console drivers
  printk: move printk_safe macros to printk header
  seial: introduce uart_port locking helpers
  tty: 8250: switch to uart_port locking helpers

 drivers/tty/serial/8250/8250_core.c |  8 +--
 drivers/tty/serial/8250/8250_dma.c  |  4 +-
 drivers/tty/serial/8250/8250_port.c | 81 +++++++++++++----------------
 include/linux/printk.h              | 40 ++++++++++++++
 include/linux/serial_core.h         | 48 +++++++++++++++++
 kernel/panic.c                      |  6 +++
 kernel/printk/internal.h            | 37 -------------
 kernel/printk/printk_safe.c         |  6 ++-
 8 files changed, 141 insertions(+), 89 deletions(-)

-- 
2.19.1
