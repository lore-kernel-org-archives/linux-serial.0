From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Tue, 30 May 2017 07:59:14 -0500
Message-ID: <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530123726.18598-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Peter Senna Tschudin <peter.senna@collabora.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, May 30, 2017 at 7:37 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Trying to load a serdev driver agains a tty port on i.MX6Q results in
> the following lockdep warning:
>
> kworker/u8:1/100 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
>  (&(&tty->files_lock)->rlock){+.+...}, at: [<c04d3d4c>] imx_startup+0x2c0/0x50c
>
> and this task is already holding:
>  (&port_lock_key){-.....}, at: [<c04d3b98>] imx_startup+0x10c/0x50c
> which would create a new lock dependency:
>  (&port_lock_key){-.....} -> (&(&tty->files_lock)->rlock){+.+...}
>
> but this new dependency connects a HARDIRQ-irq-safe lock:
>  (&port_lock_key){-.....}
>
> ... which became HARDIRQ-irq-safe at:
>   lock_acquire+0x74/0x94
>   _raw_spin_lock_irqsave+0x40/0x54
>   imx_txint+0x18/0x1d8
>   imx_int+0xc0/0x21c
>   __handle_irq_event_percpu+0x8c/0x124
>   handle_irq_event_percpu+0x24/0x60
>   handle_irq_event+0x40/0x64
>   handle_fasteoi_irq+0xd4/0x1ac
>   generic_handle_irq+0x28/0x3c
>   __handle_domain_irq+0x6c/0xe8
>   gic_handle_irq+0x58/0xb8
>   __irq_svc+0x70/0x98
>   cpuidle_enter_state+0x18c/0x2b8
>   cpuidle_enter+0x1c/0x20
>   call_cpuidle+0x28/0x44
>   do_idle+0x1b0/0x224
>   cpu_startup_entry+0x20/0x24
>   rest_init+0x128/0x168
>   start_kernel+0x328/0x39c
>   0x1000807c
>
> to a HARDIRQ-irq-unsafe lock:
>  (&(&tty->files_lock)->rlock){+.+...}
>
> ... which became HARDIRQ-irq-unsafe at:
> ...
>   lock_acquire+0x74/0x94
>   _raw_spin_lock+0x30/0x40
>   tty_add_file+0x28/0x50
>   tty_open+0x9c/0x490
>   chrdev_open+0xa4/0x180
>   do_dentry_open+0x1f0/0x318
>   vfs_open+0x54/0x84
>   path_openat+0x32c/0xfbc
>   do_filp_open+0x68/0xcc
>   do_sys_open+0x108/0x1d0
>   SyS_open+0x20/0x24
>   kernel_init_freeable+0x15c/0x200
>   kernel_init+0x10/0x11c
>   ret_from_fork+0x14/0x24
>
> other info that might help us debug this:
>
>  Possible interrupt unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&(&tty->files_lock)->rlock);
>                                local_irq_disable();
>                                lock(&port_lock_key);
>                                lock(&(&tty->files_lock)->rlock);
>   <Interrupt>
>     lock(&port_lock_key);
>
>  *** DEADLOCK ***
>
> In order to avoid this problem, change the code to opportunisticaly
> take 'tty->files_lock' by using spin_trylock() in the offending
> codepath instead.
>
> Fixes: 18a4208826dd0a13eb06de724c86bba2c225f943 ("imx-serial: Reduce
> RX DMA startup latency when opening for reading")
>
> Cc: cphealy@gmail.com
> Cc: Peter Senna Tschudin <peter.senna@collabora.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>
> Not sure if this is the best way to solve the problem (hence the RFC
> tag). If anyone has a better idea, or if there's a better fix for this
> already, please let me know.

IMO, the low level serial drivers shouldn't be accessing
tty->tty_files in the first place. Is being opened for write-only that
common and is skipping the DMA setup really necessary?

Rob
