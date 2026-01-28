Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD71F5846
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560473; cv=none; b=LdasEw/t9lFr6b1Z+9a2sNTdVDCN6OauvwMnnxETkTJOaMOjXBJZsRotNbjG84I/vZ/9PigcVettQGYEYbkiaR8E/hb4e9ZyReW+vCBcslkpHeSMqUmkUy1LeP2vnSznvnj38XXC2qThgJRkJeTTTQFpZQhRwF8GgD5M6sbZiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560473; c=relaxed/simple;
	bh=GoA4nzoyoCbL/8U+wIMHhL4VObsnCRbfUht+W7K5Yfw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XUNj9txYZzwtsKhuLp/CoTcjcQlaqYYAeUkl/HAYWjInL1DxrgAEpEI3llmNf+F64o06bNVnnjt76LRkaMeBd1/ecAJSXS4L/1vW3gOSgMHIZsCID0+OZuwPLxrztk8wrX/d2dfk6ZkIi/X9VELDt8LW9sabpRCkUQWrnENOXWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7cfd0f67288so15027045a34.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 16:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560470; x=1770165270;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GMXfSgj7YpSdbxLnPiy6dtBZ28PSOIJzvqpGQtivY5I=;
        b=pUXuUWdIdFQugo9meVTuFzapXSPZU91tDoz0mZlH6K35rejV2McyEZA+ei9/yykz09
         U/kQbnDbqb+vCykyst4d11mjECeOqWUCvjzbzWWp6Gk6qOCbEDyqaFMUfQgqg3cwE+5E
         XTL0m1UJ0xag80bLOq3T+DJ4yzY+NBIiIcKgrxihPVklB7ymmKUOEJS3qaqJqyt6UJFr
         i3YMx4IXZchIxjpdBDd04z72P40pd3msm0vk1N78E1EgpUfPyGQ2gp7E3yOJIde7aReG
         iIZXzhj2JfYC560AVGkoqdOmk12qWOJPjek/bV/TswqC/rMCUs62K5e8R+i9QO7b0WvE
         yLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOhCP1rmSMs1yY5p7ku2gJ/tF3oo3G1nol7hqjBJ1lvvockXm16QWfcav/o447PzBo29mNTM21HAMYjWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygiT5Ucx8m2j7CdqEZRqALOAoFrQCP1H9qNg+fN+3xFq+COgTK
	3fsHBf3HLjiZGiheDXZtzs1UL4TGxQzurLBGSdd6fZaLlGs5uC1Ol7R275fzC+WFONeFfATogm9
	IRmUleNs1h8Wa7+GrG5XFDHWslzTdjZQNaDbmsHUxkG6BVciPuKvACsu8U78=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c82:b0:65f:6601:b343 with SMTP id
 006d021491bc7-662f20b0fc1mr2315719eaf.48.1769560470296; Tue, 27 Jan 2026
 16:34:30 -0800 (PST)
Date: Tue, 27 Jan 2026 16:34:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69795996.050a0220.c9109.002a.GAE@google.com>
Subject: [syzbot] [serial?] general protection fault in k_pad
From: syzbot <syzbot+4b914439b1ce3f6b1baf@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    615aad0f61e0 Add linux-next specific files for 20260126
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1504e5ac580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d51c584a7396ddf1
dashboard link: https://syzkaller.appspot.com/bug?extid=4b914439b1ce3f6b1baf
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b2198a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15947d2a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5318e5f027be/disk-615aad0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d165e561fa49/vmlinux-615aad0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb0e01c90aa5/bzImage-615aad0f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b914439b1ce3f6b1baf@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 6021 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc900030174d8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff88802ea33c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  000055558b419500(0000) GS:ffff8881253b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a63fff CR3: 000000003698e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 put_queue drivers/tty/vt/keyboard.c:328 [inline]
 k_pad+0x4c4/0xa90 drivers/tty/vt/keyboard.c:832
 kbd_keycode drivers/tty/vt/keyboard.c:1497 [inline]
 kbd_event+0x2ec1/0x40d0 drivers/tty/vt/keyboard.c:1515
 input_handle_events_default+0xd4/0x1a0 drivers/input/input.c:2541
 input_pass_values+0x288/0x890 drivers/input/input.c:128
 input_event_dispose+0x330/0x6b0 drivers/input/input.c:342
 input_inject_event+0x1dd/0x340 drivers/input/input.c:424
 evdev_write+0x325/0x4c0 drivers/input/evdev.c:528
 vfs_write+0x29a/0xb90 fs/read_write.c:686
 ksys_write+0x150/0x270 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcc5759aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc141a1f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fcc57815fa0 RCX: 00007fcc5759aeb9
RDX: 0000000000002250 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007fcc57608c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcc57815fac R14: 00007fcc57815fa0 R15: 00007fcc57815fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc900030174d8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff88802ea33c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  000055558b419500(0000) GS:ffff8881253b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30a63fff CR3: 000000003698e000 CR4: 00000000003526f0
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
