From: Ming Lei <ming.lei@canonical.com>
Subject: [BUG] n_tty: 4.0-rc3+: Unable to handle kernel paging request at
 virtual address 000044d0
Date: Fri, 13 Mar 2015 14:02:37 +0800
Message-ID: <CACVXFVMWBnZSPk=QAB1ZkRkNYUxw2kdpGeazUR31h2HiAmxswA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Guys,

Just found the following oops during kernel booting when I
test the latest linus tree on one arm64 VM booted from uefi
plus grub2:


Unable to handle kernel paging request at virtual address 000044d0
pgd = ffffffc0007fb000
[000044d0] *pgd=0000000079407003, *pud=0000000079407003,
*pmd=0000000079408003, *pte=0060000008004707
Internal error: Oops: 94000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 632 Comm: kworker/1:1 Not tainted 4.0.0-rc3+ #121
Hardware name: linux,dummy-virt (DT)
Workqueue: events flush_to_ldisc
task: ffffffc0395eac00 ti: ffffffc038cb0000 task.ti: ffffffc038cb0000
PC is at n_tty_receive_buf_common+0x60/0xa28
LR is at n_tty_receive_buf_common+0x4c/0xa28
pc : [<ffffffc000362490>] lr : [<ffffffc00036247c>] pstate: 20000145
sp : ffffffc038cb3c70
x29: ffffffc038cb3c70 x28: ffffffc0385ab400
x27: ffffffc03ffe3380 x26: 0000000000000008
x25: ffffffc0006a5260 x24: ffffffc0385b0e28
x23: ffffffc038557340 x22: ffffffc0385ab400
x21: ffffffc0385b0e08 x20: ffffffc0385b0e00
x19: ffffffc03854c800 x18: 0000007fda9ad810
x17: 0000007f8291ee7c x16: ffffffc000185540
x15: 0000007f8298f590 x14: 0000007472617473
x13: 2d65727000000009 x12: 0000000000000020
x11: 000000000000002c x10: 0000007fb1e23360
x9 : ffffffc038cb3d40 x8 : ffffffc00079cb10
x7 : ffffffc000362e58 x6 : ffffffc03854c820
x5 : 00000000000044d0 x4 : ffffff8000278000
x3 : 000000000000002e x2 : 0000000000000000
x1 : 0000000000000001 x0 : ffffffc00058f250

Process kworker/1:1 (pid: 632, stack limit = 0xffffffc038cb0028)
Stack: (0xffffffc038cb3c70 to 0xffffffc038cb4000)
3c60:                                     38cb3d20 ffffffc0 00362e68 ffffffc0
3c80: 3854c800 ffffffc0 385b0e00 ffffffc0 385b0e08 ffffffc0 385ab400 ffffffc0
3ca0: 38557340 ffffffc0 385b0e28 ffffffc0 006a5260 ffffffc0 00000008 00000000
3cc0: 3ffe3380 ffffffc0 00000000 00000000 3946c200 ffffffc0 3946c268 ffffffc0
3ce0: 385ab4d8 ffffffc0 00000001 00000000 00278000 ffffff80 3854c820 ffffffc0
3d00: 00000000 00000000 0000002e ffffffc0 385b0e58 ffffffc0 0058f250 ffffffc0
3d20: 38cb3d30 ffffffc0 00365b68 ffffffc0 38cb3d80 ffffffc0 000b522c ffffffc0
3d40: 38b84540 ffffffc0 385b0e08 ffffffc0 3ffe3380 ffffffc0 3ffe7600 ffffffc0
3d60: 00000000 00000000 00000000 00000000 006a5260 ffffffc0 000b5220 ffffffc0
3d80: 38cb3dd0 ffffffc0 000b5974 ffffffc0 38b84540 ffffffc0 3ffe3398 ffffffc0
3da0: 3ffe3380 ffffffc0 38b84570 ffffffc0 007c641d ffffffc0 00000001 00000000
3dc0: 006a5260 ffffffc0 00000008 00000000 38cb3e30 ffffffc0 000ba900 ffffffc0
3de0: 38c7d8c0 ffffffc0 007cced0 ffffffc0 006a3ee8 ffffffc0 38b84540 ffffffc0
3e00: 000b5828 ffffffc0 00000000 00000000 00000000 00000000 00000000 00000000
3e20: 00000000 00000000 00000000 00000000 00000000 00000000 00085bf0 ffffffc0
3e40: 000ba828 ffffffc0 38c7d8c0 ffffffc0 00000000 00000000 00000000 00000000
3e60: 00000000 00000000 000c0fbc ffffffc0 000ba828 ffffffc0 00000000 00000000
3e80: 00000000 00000000 38b84540 ffffffc0 00000000 00000000 00000000 00000000
3ea0: 38cb3ea0 ffffffc0 38cb3ea0 ffffffc0 00000000 ffffffc0 00000000 ffffffc0
3ec0: 38cb3ec0 ffffffc0 38cb3ec0 ffffffc0 00000000 00000000 00000000 00000000
3ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3f00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3f20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3f40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3f60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3f80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000005 00000000
3fe0: 00000000 00000000 00000000 00000000 afafafaf afafafaf afafafaf afafafaf
Call trace:
[<ffffffc000362490>] n_tty_receive_buf_common+0x60/0xa28
[<ffffffc000362e64>] n_tty_receive_buf2+0xc/0x18
[<ffffffc000365b64>] flush_to_ldisc+0xec/0x140
[<ffffffc0000b5228>] process_one_work+0x138/0x338
[<ffffffc0000b5970>] worker_thread+0x148/0x420
[<ffffffc0000ba8fc>] kthread+0xd4/0xf0
Code: 91094000 f90057a0 d2844d05 8b0500a5 (c8dffca3)
---[ end trace a6c1b0900ff37a1c ]---

Thanks,
