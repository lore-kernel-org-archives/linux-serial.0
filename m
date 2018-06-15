From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 0/6] Use printk_safe context for TTY and UART port locks
Date: Fri, 15 Jun 2018 18:39:13 +0900
Message-ID: <20180615093919.559-1-sergey.senozhatsky@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

	Hello,

	RFC

	printk_safe buffers help us to avoid printk() deadlocks that are
caused by recursive printk() calls, e.g.

printk()
 vprintk_emit()
 spin_lock(&logbuf_lock)
  vsnprintf()
   format_decode()
    warn_slowpath_fmt()
     vprintk_emit()
     spin_lock(&logbuf_lock)   << deadlock

It doesn't come as a surprise that recursive printk() calls are not the
only way for us to deadlock in printk() and we still have a whole bunch
of other printk() deadlock scenarios. For instance, those that involve
TTY port->lock spin_lock and UART port->lock spin_lock.

syzbot recently hit one of such scenarios [1]:

 CPU0                                     CPU1
 tty_ioctl()
  spin_lock(&tty_port->lock)              IRQ
   kmalloc()                              foo_console_handle_IRQ()
    printk()                               spin_lock(&uart_port->lock)
     call_console_drivers()                 tty_wakeup()
      foo_console_driver()
       spin_lock(&uart_port->lock)           spin_lock(&tty_port->lock)

So the idea of this patch set is to take tty_port->lock and
uart_port->lock from printk_safe context and to eliminate some
of non-recursive printk() deadlocks - the ones that don't start
in printk(), but involve console related locks and thus eventually
deadlock us in printk(). For this purpose the patch set introduces
several helper macros:

- uart_port_lock_irq() / uart_port_unlock_irq()
  uart_port_lock_irqsave() / uart_port_unlock_irqrestore()

  To lock/unlock uart_port->lock spin_lock from printk_safe
  context.

And

- tty_port_lock_irq() / tty_port_unlock_irq()
  tty_port_lock_irqsave() / tty_port_unlock_irqrestore()

  To lock/unlock tty_port->lock spin_lock from printk_safe
  context.

I converted tty/pty/serial_core to use those helper macros.
Now, the boring part is that all serial console drivers must be converted
to use uart_port_lock macros. In this patch set I only modified the 8250
serial console [since this is RFC patch set], but if the patch set will
not see a lot of opposition I can do so for the rest of serial consoles
[or ask the maintainers to help me out]. The conversion is pretty
simple.

It would be great if we could "forbid" direct tty_port->lock and
uart_port->lock manipulation [I don't know, rename them to ->__lock]
and enforce uart_port_lock/tty_port_lock macros usage.

There are some other cases [2] that we can handle with this
patch set. For instance:

   IRQ
   spin_lock(&uart_port->lock)
    tty_wakeup()
     tty_port_default_wakeup()
      tty_port_tty_get()
       refcount_inc()
        WARN_ONCE()
         printk()
          call_console_drivers()
           foo_console_driver()
            spin_lock(&uart_port->lock)               << deadlock

Of course, TTY and UART port spin_locks are not the only locks that
we can deadlock on. So this patch set does not address all deadlock
scenarios, it just makes a small step forward.

Any opinions?

[1]: lkml.kernel.org/r/00000000000087008b056df8fbb3@google.com
[2]: lkml.kernel.org/r/20180607051019.GA10406@jagdpanzerIV

Sergey Senozhatsky (6):
  printk: move printk_safe macros to printk header
  tty: add tty_port locking helpers
  tty/pty: switch to tty_port helpers
  serial: add uart port locking helpers
  serial: switch to uart_port locking helpers
  tty: 8250: switch to uart_port locking helpers

 drivers/tty/pty.c                   |   4 +-
 drivers/tty/serial/8250/8250_core.c |   8 +-
 drivers/tty/serial/8250/8250_dma.c  |   4 +-
 drivers/tty/serial/8250/8250_port.c |  74 +++++++++----------
 drivers/tty/serial/serial_core.c    | 109 ++++++++++++++--------------
 drivers/tty/tty_port.c              |  38 +++++-----
 include/linux/printk.h              |  40 ++++++++++
 include/linux/serial_core.h         |  35 +++++++++
 include/linux/tty.h                 |  24 ++++++
 kernel/printk/internal.h            |  37 ----------
 10 files changed, 218 insertions(+), 155 deletions(-)

-- 
2.17.1
