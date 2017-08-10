From: Arnd Bergmann <arnd@arndb.de>
Subject: Race between release_tty() and vt_disallocate()
Date: Thu, 10 Aug 2017 17:55:24 +0200
Message-ID: <CAK8P3a2Pok0Mpmj+DZG3gi13F9bWrK_u7M0hC4kHKuUzSuH1Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adam Borowski <kilobyte@angband.pl>, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, jun.he@linaro.org, graeme.gregory@linaro.org, gema.gomez-solano@linaro.org
List-Id: linux-serial@vger.kernel.org

Hi tty people,

I tracked down a bug report to what I think is a race between a tty_struct
and the vt_data going away at the same time. See
https://bugs.linaro.org/show_bug.cgi?id=3174 for the long story.

The short version is that a backtrace shows

[ 1138.433484] [<ffff0000080e78f0>] __cancel_work_timer+0x80/0x1c8
[ 1138.433486] [<ffff0000080e7a5c>] cancel_work_sync+0x24/0x30
[ 1138.433491] [<ffff0000084e9dd0>] tty_buffer_cancel_work+0x20/0x30
[ 1138.433493] [<ffff0000084de828>] release_tty+0xc8/0x138
[ 1138.433495] [<ffff0000084e0dc8>] tty_release+0x428/0x650
[ 1138.433499] [<ffff000008265a3c>] __fput+0xa4/0x220
[ 1138.433501] [<ffff000008265c58>] ____fput+0x20/0x30
[ 1138.433503] [<ffff0000080eb3a4>] task_work_run+0xcc/0xe8
[ 1138.433506] [<ffff0000080cf334>] do_exit+0x30c/0x9f0
[ 1138.433507] [<ffff0000080cfaa8>] do_group_exit+0x40/0xb0
[ 1138.433510] [<ffff0000080dbff8>] get_signal+0x2d0/0x588
[ 1138.433513] [<ffff0000080893f4>] do_signal+0x8c/0x550
[ 1138.433515] [<ffff000008089b28>] do_notify_resume+0x98/0xb8
[ 1138.433516] [<ffff0000080835dc>] work_pending+0x8/0x10

get_work_pool_id() crashes while dereferencing tty->port.buf.work.data
as a pointer, after that has apparently been overwritten with the
non-pointer value 0x00000028fecaedff. The tty_port belongs to
a vc_data structure, which gets freed after we find that
console_driver->ttys[i]->count is zero in the VT_DISALLOCATE
ioctl. Apparently at the same time, the agetty process owning
the tty closes and that leads to  tty->count dropping to zero
before we call tty_buffer_cancel_work() on the tty_port that
has now been freed.

Apparently the locking and/or reference counting between the
two code paths is insufficient, but I don't understand enough
about tty locking to come up with a fix that doesn't break other
things. Please have a look.

        Arnd
