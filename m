From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 4.11-rc4
Date: Thu, 13 Apr 2017 12:50:36 +0200
Message-ID: <CAOMGZ=F8xdUHnZaDo18DkkrYgacx6y8Cm=f8-8xnuvPupepnfg@mail.gmail.com>
References: <20170326110432.GA9241@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170326110432.GA9241@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 26 March 2017 at 13:04, Greg KH <gregkh@linuxfoundation.org> wrote:
> The following changes since commit 4495c08e84729385774601b5146d51d9e5849f81:
>
>   Linux 4.11-rc2 (2017-03-12 14:47:08 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git/ tags/tty-4.11-rc4
>
> for you to fetch changes up to a4a3e061149f09c075f108b6f1cf04d9739a6bc2:
>
>   tty: fix data race in tty_ldisc_ref_wait() (2017-03-17 14:07:10 +0900)
>
> ----------------------------------------------------------------
> TTY/Serial driver fixes for 4.11-rc4
>
> Here are some tty and serial driver fixes for 4.11-rc4.  One of these
> fix a long-standing issue in the ldisc code that was found by Dmitry
> Vyukov with his great fuzzing work.  The other fixes resolve other
> reported issues, and there is one revert of a patch in 4.11-rc1 that
> wasn't correct.
>
> All of these have been in linux-next for a while with no reported
> issues.
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ----------------------------------------------------------------
> Aleksey Makarov (1):
>       Revert "tty: serial: pl011: add ttyAMA for matching pl011 console"
>
> Dmitry Vyukov (2):
>       tty: don't panic on OOM in tty_set_ldisc()

I've bisected a syzkaller crash down to this commit
(5362544bebe85071188dd9e479b5a5040841c895). The crash is:

[   25.137552] BUG: unable to handle kernel paging request at 0000000000002280
[   25.137579] IP: mutex_lock_interruptible+0xb/0x30
[   25.137589] PGD 3b0c067
[   25.137593] PUD 3911067
[   25.137597] PMD 0
[   25.137601]
[   25.137611] Oops: 0002 [#1] PREEMPT SMP KASAN
[   25.137624] CPU: 1 PID: 3690 Comm: a.out Not tainted 4.11.0-rc2+ #145
[   25.137631] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[   25.137639] task: ffff880003b96400 task.stack: ffff880004e98000
[   25.137651] RIP: 0010:mutex_lock_interruptible+0xb/0x30
[   25.137657] RSP: 0018:ffff880004e9fae0 EFLAGS: 00010246
[   25.137668] RAX: 0000000000000000 RBX: ffff880004e6c000 RCX: ffffffff817bb2a9
[   25.137675] RDX: ffff880003b96400 RSI: 0000000000000015 RDI: 0000000000002280
[   25.137696] RBP: ffff880004e9fca0 R08: 0000000000000003 R09: 0000000000000002
[   25.137703] R10: 0000000000000002 R11: ffffed0000c23fe9 R12: ffff880004e6c000
[   25.137710] R13: 0000000080045430 R14: ffff880004bac900 R15: ffff880004bacb60
[   25.137720] FS:  00007f7cac233700(0000) GS:ffff880006100000(0000)
knlGS:0000000000000000
[   25.137727] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   25.137733] CR2: 0000000000002280 CR3: 0000000003b67000 CR4: 00000000000006e0
[   25.137746] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   25.137752] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   25.137755] Call Trace:
[   25.137769]  ? n_tty_read+0x15f/0xc70
[   25.137783]  ? preempt_count_add+0xb2/0xe0
[   25.137793]  ? n_tty_flush_buffer+0x90/0x90
[   25.137806]  ? wait_woken+0x100/0x100
[   25.137817]  tty_read+0xd8/0x140
[   25.137830]  __vfs_read+0xd1/0x320
[   25.137842]  ? do_sendfile+0x6c0/0x6c0
[   25.137853]  ? __fsnotify_update_child_dentry_flags+0x30/0x30
[   25.137864]  ? selinux_file_permission+0x1c0/0x210
[   25.137873]  ? __fsnotify_parent+0x27/0x130
[   25.137882]  ? security_file_permission+0xce/0xf0
[   25.137893]  ? rw_verify_area+0x73/0x140
[   25.137904]  vfs_read+0xba/0x1b0
[   25.137915]  SyS_read+0xa0/0x120
[   25.137926]  ? vfs_write+0x260/0x260
[   25.137938]  ? preempt_count_sub+0x13/0xd0
[   25.137949]  entry_SYSCALL_64_fastpath+0x1a/0xa9
[   25.137957] RIP: 0033:0x7f7caf61351d
[   25.137963] RSP: 002b:00007f7cac232f20 EFLAGS: 00000293 ORIG_RAX:
0000000000000000
[   25.137974] RAX: ffffffffffffffda RBX: 00007f7cac233700 RCX: 00007f7caf61351d
[   25.137980] RDX: 000000000000003e RSI: 0000000080045430 RDI: 0000000000000004
[   25.137987] RBP: 00007fffb4f21250 R08: 00007f7cac233700 R09: 00007f7cac233700
[   25.137993] R10: 00007f7cac2339d0 R11: 0000000000000293 R12: 0000000000000000
[   25.137999] R13: 00007fffb4f2124f R14: 00007f7cac2339c0 R15: 0000000000000000
[   25.138002] Code: c7 43 20 00 00 00 00 48 89 df e8 91 ff ff ff 5b
41 5c 5d c3 83 e8 01 41 89 44 24 10 eb e1 66 90 65 48 8b 14 25 40 54
01 00 31 c0 <f0> 48 0f b1 17 48 85 c0 74 0a 55 48 89 e5 e8 e2 f4 ff ff
5d f3
[   25.138218] RIP: mutex_lock_interruptible+0xb/0x30 RSP: ffff880004e9fae0
[   25.138221] CR2: 0000000000002280
[   25.138301] ---[ end trace 242fd54c56b177b4 ]---

The syzkaller reproducer is:

# {Threaded:true Collide:true Repeat:true Procs:1 Sandbox:setuid Repro:false}
mmap(&(0x7f0000000000/0x9f000)=nil, (0x9f000), 0x3, 0x32,
0xffffffffffffffff, 0x0)
r0 = openat$ptmx(0xffffffffffffff9c,
&(0x7f0000001000-0xa)="2f6465762f70746d7800", 0x201, 0x0)
ioctl$TIOCSPTLCK(r0, 0x40045431, &(0x7f000009a000)=0x0)
r1 = syz_open_pts(r0, 0x0)
read(r1, &(0x7f0000028000-0x86)="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
0x3e)
ioctl$TIOCSETD(r1, 0x5423, &(0x7f000009f000-0x4)=0x10080000001)

It takes 10-50 seconds to reproduce, but you can reduce it to ~2
seconds by opening /dev/ptmx only once in each process.

I've verified that reverting the commit from latest mainline makes the
crash go away.


Vegard
