From: Andrey Konovalov <andreyknvl@google.com>
Subject: Potential data race in uart_ioctl
Date: Tue, 25 Aug 2015 14:17:22 +0200
Message-ID: <CAAeHK+xPOrm4JMjmRL4Er+LU7Auh_+rSnNcbWniPOoQFMZaqfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>
List-Id: linux-serial@vger.kernel.org

Hi!

We are working on a dynamic data race detector for the Linux kernel
called KernelThreadSanitizer (ktsan)
(https://github.com/google/ktsan/wiki).

While booting the kernel (upstream revision 21bdb584af8c) we got a report:

==================================================================
ThreadSanitizer: data-race in uart_ioctl

Read of size 8 by thread T424 (K971):
 [<ffffffff81673c56>] uart_ioctl+0x36/0x11e0
drivers/tty/serial/serial_core.c:1216
 [<ffffffff81643802>] tty_ioctl+0x4f2/0x11d0 drivers/tty/tty_io.c:2924
 [<     inlined    >] do_vfs_ioctl+0x44a/0x750 vfs_ioctl fs/ioctl.c:43
 [<ffffffff8127b0ca>] do_vfs_ioctl+0x44a/0x750 fs/ioctl.c:607
 [<     inlined    >] SyS_ioctl+0x79/0xa0 SYSC_ioctl fs/ioctl.c:622
 [<ffffffff8127b449>] SyS_ioctl+0x79/0xa0 fs/ioctl.c:613
 [<ffffffff81eae0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
arch/x86/entry/entry_64.S:186
DBG: cpu = ffff88063fc1fe68
DBG: cpu id = 0

Previous write of size 8 by thread T422 (K970):
 [<ffffffff816737ef>] uart_open+0x12f/0x220
drivers/tty/serial/serial_core.c:1629
 [<ffffffff81645be2>] tty_open+0x192/0x8f0 drivers/tty/tty_io.c:2105
 [<ffffffff812628fc>] chrdev_open+0x13c/0x290 fs/char_dev.c:388
 [<ffffffff812582fc>] do_dentry_open+0x3ac/0x550 fs/open.c:736
 [<ffffffff81259d68>] vfs_open+0xb8/0xe0 fs/open.c:853
 [<     inlined    >] path_openat+0x81c/0x2440 do_last fs/namei.c:3163
 [<ffffffff81272f1c>] path_openat+0x81c/0x2440 fs/namei.c:3295
 [<ffffffff8127656a>] do_filp_open+0xfa/0x170 fs/namei.c:3330
 [<ffffffff8125a243>] do_sys_open+0x183/0x2b0 fs/open.c:1025
 [<     inlined    >] SyS_open+0x35/0x50 SYSC_open fs/open.c:1043
 [<ffffffff8125a3a5>] SyS_open+0x35/0x50 fs/open.c:1038
 [<ffffffff81eae0ae>] entry_SYSCALL_64_fastpath+0x12/0x71
arch/x86/entry/entry_64.S:186
DBG: cpu = ffff88063fd1fe68

DBG: addr: ffff8801d2a0ce88
DBG: first offset: 0, second offset: 0
DBG: T424 clock: {T424: 211057, T422: 275728}
DBG: T422 clock: {T422: 275819}
==================================================================

It seems that one thread reads and uses tty->driver_data while it's
being initialized in another one. The second thread holds port->mutex,
but the first one does a few accesses to tty->driver_data before
locking it.

Could you confirm if this is a real race?

Thanks!
