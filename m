Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE5A309DDB
	for <linux-serial@vger.kernel.org>; Sat, 31 Jan 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769829267; cv=none; b=ui8+q8yVmXWy7fimjmBBWkq0gyMm5h3bAEra+tot6hZHDLAlE8UbLdH2tgs/CydSOE440kxH1KcUrMWomamo0mkQ8VZo0prNHDs8Yt0hLNnOKg8qlyM9Wyr67Or28nAOKgWJqHXF0ySw2UZKWXFfH1pB5Kj/D8+TUYhFqgtWkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769829267; c=relaxed/simple;
	bh=KvE5Cr0argFxZL6Ry3HuGw2SVPM+bg2vd/26ndGW6i8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qoe5YMdvMlWc4T1aqOb5dDCpgrkzAmKsLJljVrrCYVSx3rvZStzB+sTov8lg4FZhIsa7IbcScgvnyEASHavw7C60n0HGyq3KhCTQqX1/FXq3pc07w4GNl4r2tVFtkR14NzmkSD9A/v45hK9iq/5j5I7Y6rs4EvERgcW9hx4bWUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-4042356948fso10054829fac.3
        for <linux-serial@vger.kernel.org>; Fri, 30 Jan 2026 19:14:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769829264; x=1770434064;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2haHDjwxy1ppiV1c3ehNi9kAO9S8pubyopAnq8yBrQ=;
        b=GcBI65C+noWXFiS8mzdPZAiraH9t24+LwbaEoz2s9/vN756IFamY4mffIsr23sqFbH
         Bhn5QFDStDWYZoD2VuipNREzFq1N2jRY+IrRhzyd7BcU9ngICsX6KPsHAh75wk/VMVFq
         u2qu0P/hesFUVxqAg2sqTTmaruwQlgdXOJYp1TqyyimRgSlk622YZtD4nHXor0Ie2Ozu
         Jcc2F8d9laKFHhaFhr0ek+7fBFVuOv9R9E6pN5ulLM2g9oOK+kVQLzEGsvW4JlKOm3gk
         6vsfduOXXxt7ZenYnb6LnD+jIAcR52lSYW38AlN/CSgzt+wGLuudN1aJkL38ZmGHEfnS
         MBgA==
X-Forwarded-Encrypted: i=1; AJvYcCVbtxJNXKhPcwbHpR6pYVo0UZgHroprEIeEoMd3Wt+7NWuiHzhfIrmlas1PrSl55f2gZaox1eQ8Mqr7IGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAneDQ+X3k5V0olxbiwyFMB4XbHPL3w2CQmqy0118nQKSX4hkr
	7SzUpqcSW0iPW+qrkLUTQe0CDlBZr8MRNzVVGsQy2G3ipWwsFbBV46vHlW0jagpTqqGlk1Ac4wu
	oahiWtuGQiSK9dRKZNzAZ1cXmV4yqURyTmSvkqQz0W/KhrSvT404jySd03MU=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1689:b0:663:e8d:ce8 with SMTP id
 006d021491bc7-6630f389944mr2441877eaf.57.1769829264382; Fri, 30 Jan 2026
 19:14:24 -0800 (PST)
Date: Fri, 30 Jan 2026 19:14:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697d7390.050a0220.1d0a41.0002.GAE@google.com>
Subject: [syzbot] [serial?] general protection fault in puts_queue
From: syzbot <syzbot+c3693b491545af43db87@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    615aad0f61e0 Add linux-next specific files for 20260126
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16d3705a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=750532df2c47a03
dashboard link: https://syzkaller.appspot.com/bug?extid=c3693b491545af43db87
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109cb98a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179d4ec6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a23e465e877/disk-615aad0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1ef2e20639b/vmlinux-615aad0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e82b02375a3f/bzImage-615aad0f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c3693b491545af43db87@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 5996 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc90000a07ed8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff88802d660000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813fe32017 R09: 1ffff11027fc6402
R10: dffffc0000000000 R11: ffffed1027fc6403 R12: dffffc0000000000
R13: ffff88813fe32010 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fc71835f880(0000) GS:ffff888125163000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000011f8 CR3: 000000007b69a000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 puts_queue+0xa3/0xe0 drivers/tty/vt/keyboard.c:334
 k_fn+0x7c/0xd0 drivers/tty/vt/keyboard.c:763
 k_pad+0x79a/0xa90 drivers/tty/vt/keyboard.c:-1
 kbd_keycode drivers/tty/vt/keyboard.c:1497 [inline]
 kbd_event+0x2ec1/0x40d0 drivers/tty/vt/keyboard.c:1515
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x3e5/0x6b0 drivers/input/input.c:353
 input_event+0x89/0xe0 drivers/input/input.c:396
 hidinput_hid_event+0x1487/0x1e60 drivers/hid/hid-input.c:1747
 hid_process_event+0x4be/0x620 drivers/hid/hid-core.c:1565
 hid_input_array_field+0x41c/0x5f0 drivers/hid/hid-core.c:1677
 hid_process_report drivers/hid/hid-core.c:1719 [inline]
 hid_report_raw_event+0xdd7/0x1720 drivers/hid/hid-core.c:2074
 __hid_input_report drivers/hid/hid-core.c:2144 [inline]
 hid_input_report+0x44b/0x580 drivers/hid/hid-core.c:2166
 hid_irq_in+0x47e/0x6d0 drivers/hid/usbhid/hid-core.c:286
 __usb_hcd_giveback_urb+0x376/0x540 drivers/usb/core/hcd.c:1657
 dummy_timer+0xbbd/0x45d0 drivers/usb/gadget/udc/dummy_hcd.c:1995
 __run_hrtimer kernel/time/hrtimer.c:1785 [inline]
 __hrtimer_run_queues+0x529/0xc30 kernel/time/hrtimer.c:1849
 hrtimer_run_softirq+0x182/0x5a0 kernel/time/hrtimer.c:1866
 handle_softirqs+0x22a/0x7c0 kernel/softirq.c:626
 do_softirq+0x76/0xd0 kernel/softirq.c:523
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x130 kernel/softirq.c:450
 sha256_blocks lib/crypto/x86/sha256.h:37 [inline]
 __sha256_update+0xf7/0x150 lib/crypto/sha256.c:208
 sha256_update include/crypto/sha2.h:356 [inline]
 crypto_sha256_update+0x27/0x40 crypto/sha256.c:145
 crypto_shash_update include/crypto/hash.h:1006 [inline]
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:491 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
 ima_calc_file_hash+0x1300/0x17f0 security/integrity/ima/ima_crypto.c:568
 ima_collect_measurement+0x48b/0x930 security/integrity/ima/ima_api.c:294
 process_measurement+0x12cd/0x1c80 security/integrity/ima/ima_main.c:407
 ima_bprm_check+0x121/0x180 security/integrity/ima/ima_main.c:589
 security_bprm_check+0xcd/0x240 security/security.c:794
 search_binary_handler fs/exec.c:1654 [inline]
 exec_binprm fs/exec.c:1696 [inline]
 bprm_execve+0x896/0x1410 fs/exec.c:1748
 do_execveat_common+0x50d/0x690 fs/exec.c:1846
 __do_sys_execve fs/exec.c:1930 [inline]
 __se_sys_execve fs/exec.c:1924 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:1924
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc717cf2107
Code: 0f 00 64 c7 00 07 00 00 00 b8 ff ff ff ff c9 c3 0f 1f 00 48 8b 05 a9 ee 0f 00 48 8b 10 e9 01 00 00 00 90 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c1 ec 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffc10b356d8 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00005646a103f140 RCX: 00007fc717cf2107
RDX: 00005646a1e9e9c0 RSI: 00007ffc10b357f0 RDI: 00007ffc10b35ff0
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000206 R12: 00005646a1e9e9c0
R13: 00007ffc10b357f0 R14: 000000000000000d R15: 0000000000000009
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc90000a07ed8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff88802d660000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813fe32017 R09: 1ffff11027fc6402
R10: dffffc0000000000 R11: ffffed1027fc6403 R12: dffffc0000000000
R13: ffff88813fe32010 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fc71835f880(0000) GS:ffff888125163000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000011f8 CR3: 000000007b69a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	31 ff                	xor    %edi,%edi
   2:	89 ee                	mov    %ebp,%esi
   4:	e8 4e f4 37 00       	call   0x37f457
   9:	85 ed                	test   %ebp,%ebp
   b:	0f 85 ef 0c 00 00    	jne    0xd00
  11:	e8 01 f0 37 00       	call   0x37f017
  16:	4d 8d b7 c0 01 00 00 	lea    0x1c0(%r15),%r14
  1d:	4c 89 f0             	mov    %r14,%rax
  20:	48 c1 e8 03          	shr    $0x3,%rax
  24:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
* 29:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 22 0d 00 00    	jne    0xd58
  36:	4c 89 34 24          	mov    %r14,(%rsp)
  3a:	41 8b 2e             	mov    (%r14),%ebp
  3d:	89 ee                	mov    %ebp,%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
