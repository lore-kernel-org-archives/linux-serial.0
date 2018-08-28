From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] tty: serial: lpuart: avoid leaking struct tty_struct
Date: Tue, 28 Aug 2018 12:44:24 +0200
Message-ID: <20180828104424.19860-1-stefan@agner.ch>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, stable@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The function tty_port_tty_get() gets a reference to the tty. Since
the code is not using tty_port_tty_set(), the reference is kept
even after closing the tty.

Avoid using tty_port_tty_get() by directly access the tty instance.
Since lpuart_start_rx_dma() is called from the .startup() and
.set_termios() callback, it is safe to assume the tty instance is
valid.

Cc: stable@vger.kernel.org # v4.9+
Fixes: 5887ad43ee02 ("tty: serial: fsl_lpuart: Use cyclic DMA for Rx")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
This fixes a memory leak observable when opening/closing the tty in a
loop. This is also reported by kmemleak:

unreferenced object 0xc9d17000 (size 1024):
  comm "(agetty)", pid 389, jiffies 4294943045 (age 100.670s)
  hex dump (first 32 bytes):
    01 54 00 00 01 00 00 00 00 8c 9b c8 80 58 9b c8  .T...........X..
    48 58 c4 c0 00 00 00 00 00 00 00 00 00 00 00 00  HX..............
  backtrace:
    [<(ptrval)>] kmem_cache_alloc_trace+0x160/0x2b8
    [<(ptrval)>] alloc_tty_struct+0x44/0x254
    [<(ptrval)>] tty_init_dev+0x44/0x1c8
    [<(ptrval)>] tty_open+0x268/0x414
    [<(ptrval)>] chrdev_open+0xb4/0x1bc
    [<(ptrval)>] do_dentry_open+0x1c0/0x388
    [<(ptrval)>] vfs_open+0x34/0x38
    [<(ptrval)>] path_openat+0x5b0/0x11bc
    [<(ptrval)>] do_filp_open+0x7c/0xe8
    [<(ptrval)>] do_sys_open+0x188/0x20c
    [<(ptrval)>] sys_openat+0x14/0x18
    [<(ptrval)>] ret_fast_syscall+0x0/0x28
    [<(ptrval)>] 0xbee0a460
    [<(ptrval)>] 0xffffffff

I *think* the statement that accessing tty_struct without using
tty_port_tty_get is safe in this case is true. It would be good if
somebody with more TTY knowledge could review the change.
