From: Nixiaoming <nixiaoming@huawei.com>
Subject: RE: [PATCH] tty fix oops when rmmod 8250
Date: Wed, 11 Oct 2017 02:03:04 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF1299F8D2B@DGGEMA505-MBX.china.huawei.com>
References: <20170915094556.55384-1-nixiaoming@huawei.com>
 <c18e422a-00fe-00bd-75ba-384f67c4f241@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c18e422a-00fe-00bd-75ba-384f67c4f241@suse.cz>
Content-Language: zh-CN
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Test on 4.14.0-rc4:

CPU: 7 PID: 449 Comm: rmmod Tainted: G           O    4.14.0-rc4+ #1
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Call Trace:
 dump_stack+0x50/0x80
 jtty_kref_put+0x5a/0x5c [jprobe_tty_kref_put]
 uart_remove_one_port+0xe8/0x220 [serial_core]
 ? __might_sleep+0x4a/0x90
 serial8250_unregister_port+0x71/0x100 [8250]
 serial_pnp_remove+0x26/0x30 [8250]
 pnp_device_remove+0x31/0x70
 device_release_driver_internal+0x185/0x240
 driver_detach+0x47/0x90
 bus_remove_driver+0x50/0xb0
 driver_unregister+0x30/0x50
 pnp_unregister_driver+0x12/0x20
 serial8250_pnp_exit+0x15/0x20 [8250]
 serial8250_exit+0x34/0xbf8 [8250]
 SyS_delete_module+0x17a/0x1f0
 ? exit_to_usermode_loop+0x9d/0xc0
 do_syscall_64+0x5c/0x120
 ? syscall_return_slowpath+0xb9/0xc0
 ? schedule_tail+0xc1/0xe0
 entry_SYSCALL64_slow_path+0x25/0x25
RIP: 0033:0x7ff7d37ab257
RSP: 002b:00007ffdb7879f08 EFLAGS: 00000202 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 0000000000000800 RCX: 00007ff7d37ab257
RDX: 00007ff7d38128c0 RSI: 0000000000000800 RDI: 00000000006d60f0
RBP: 00000000006d6090 R08: 00007ff7d3a5bf40 R09: 00007ffdb7878eb1
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffdb787be86
R13: 00000000006d6010 R14: 0000000000000000 R15: 00000000006d6090
BUG: unable to handle kernel paging request at ffffffffa00bdc91
IP: strchr+0x3/0x30
PGD 1c0b067 P4D 1c0b067 PUD 1c0c063 PMD 7f620067 PTE 0
Oops: 0000 [#1] PREEMPT SMP
Modules linked in: jprobe_tty_kref_put(O) iptable_filter br_netfilter bridge stp llc ipv6 ata_piix ahci libahci libata ext4 jbd2 8250_base serial_core ptp pps_core nfsd auth_rpcgss oid_registry nfsv3 nfs nfs_acl lockd sunrpc grace vfat fat quota_v2 quota_v1 quota_tree [last unloaded: 8250]
CPU: 6 PID: 74 Comm: kworker/6:1 Tainted: G           O    4.14.0-rc4+ #1
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
Workqueue: events release_one_tty
task: ffff8800dbb88000 task.stack: ffffc900008d0000
RIP: 0010:strchr+0x3/0x30
RSP: 0018:ffffc900008d3b38 EFLAGS: 00010286
RAX: ffffffff81c682c0 RBX: ffffffffa00bdc91 RCX: 000000018040003c
RDX: 000000000000002f RSI: 000000000000002f RDI: ffffffffa00bdc91
RBP: ffffc900008d3b78 R08: 0000000000000000 R09: ffffffff8140e1ed
R10: ffffea0001fd6b00 R11: 0000000000000000 R12: ffff8800df412900
R13: 0000000000000010 R14: ffffc900008d3b90 R15: ffffffffa00bdc91
FS:  0000000000000000(0000) GS:ffff8800dfb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffa00bdc91 CR3: 0000000072b7a000 CR4: 00000000000006e0
Call Trace:
 ? __xlate_proc_name+0x66/0xb0
 remove_proc_entry+0x37/0x140
 proc_tty_unregister_driver+0x28/0x40
 destruct_tty_driver+0x84/0xe0
 tty_driver_kref_put+0x1e/0x30
 release_one_tty+0x62/0xe0
 process_one_work+0x1d0/0x440
 ? sched_clock_local+0x1c/0x90
 ? schedule+0x4e/0xc0
 ? preempt_count_add+0xaa/0xc0
 worker_thread+0x110/0x4c0
 ? __schedule+0x4ee/0x8b0
 ? default_wake_function+0x12/0x20
 ? __wake_up_common+0x85/0x130
 ? schedule+0x4e/0xc0
 kthread+0x13a/0x140
 ? process_one_work+0x440/0x440
 ? kthreadd+0x1c0/0x1c0
 ret_from_fork+0x22/0x30
Code: 01 41 38 c0 75 13 48 ff c1 45 84 c0 74 05 48 ff ca 75 e3 31 c0 c9 66 90 c3 41 38 c0 c9 19 c0 83 c8 01 c3 0f 1f 44 00 00 55 89 f2 <0f> b6 07 48 89 e5 40 38 f0 75 0c eb 12 48 ff c7 0f b6 07 38 d0 
RIP: strchr+0x3/0x30 RSP: ffffc900008d3b38
CR2: ffffffffa00bdc91

-----
