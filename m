Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9832745E
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560472; cv=none; b=tgWPu/eKO90+QnTcF90/Cay0bH/vbUMiNDZEBozrG7iUXfCep7Vz3ZLTpyZcxOYT5/nRCg49wngLHZm/+YEbk3qG0bTKzR9bJo525IFn+BhW7YtbsRRGxO9RMMlQ6zkl3YglGyFgi8wY5jSbc5fhwqTitHp2JyuzD/e8wP1EXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560472; c=relaxed/simple;
	bh=yDHdwxfPQYCeGTAf+YxdkncpKWYO/ddSsDIrl5rVOuA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XgA0qV//gihSCLArnRNu16LO+ZPkAhUk1A9aQtQ5445jfxV56XBQUkt4T5wwwspm++cwqdJdmkgmidiBPK9Oc1GH1Rmick46pg942hB7j34yPgue2CaibIvYq4Ny9WCE0OpDSWxUtCgRiZHQazr3d3UTXHzQ8qbp5MUDZRmSV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-662ef20f6b2so2176235eaf.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 16:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560470; x=1770165270;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmaEqNobnh6Ha6POl18OBUfpAee0rR3HCZeV8vxEBis=;
        b=r//o8Bf/VZtpmKvJARTeq6L8VZ7rMApnGPm+dxO64Q887KM3QedjK7S0+haD3q218A
         A5YQKiXWpwkGriTOiYfD9scAMzv548bEl0Rw7Ug5xz5Y6p6Esch4fhEoprrEBVp8y1ZU
         8lJ7rYHVCWRZMRCL1nMyQhOJUhFTrSYe6cvPCitgwvyLfBwZ/3wN5huCf9vC8T1C0j5C
         G8oSn289v8QnsG2nwimXjwPoi7MZJwcvW92+lm+0m5cXzMd0rgTssFLNlDRwz0FRGM6p
         7TJhyuayHVhHZomU0vePQd1v6OwEdw4Up5lEkOftHYaMIru/c3e39K8xCQAVc/UIvPVn
         wZiA==
X-Forwarded-Encrypted: i=1; AJvYcCUPk25XhImYY4lxWK4kuFoqGoH2pjfjjUiEPC6wd0Eo/xvtZ1WKwPhcIiropyDI3KHank9dVfSfEnlQKtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvX43fgNwLNYn5qCuUxUPz9rODgOmM7N3+4c0/3oT7TDLiutTG
	ZgqY3wphwzASt4N6bD83Qzy8DYExLgRfC/E3LVAgdNYlQe+YiWzeZ7AAXe0HxsSyhMEjNaORGze
	98YjfeIfpMG2rvJCeCyzIUmS0ZyqyZU2vnPmcOK9UWpkO+6OfuU65ogNGb68=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d0c:b0:65b:5553:8e9b with SMTP id
 006d021491bc7-662f20548d3mr2595744eaf.12.1769560470093; Tue, 27 Jan 2026
 16:34:30 -0800 (PST)
Date: Tue, 27 Jan 2026 16:34:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69795996.050a0220.c9109.0029.GAE@google.com>
Subject: [syzbot] [serial?] general protection fault in to_utf8
From: syzbot <syzbot+3f83d97f1d51ddaabd8a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    615aad0f61e0 Add linux-next specific files for 20260126
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147b432a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d51c584a7396ddf1
dashboard link: https://syzkaller.appspot.com/bug?extid=3f83d97f1d51ddaabd8a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16201fb3980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bba802580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5318e5f027be/disk-615aad0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d165e561fa49/vmlinux-615aad0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb0e01c90aa5/bzImage-615aad0f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f83d97f1d51ddaabd8a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 6053 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc900036c7318 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff88802f848000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  0000555556b5d500(0000) GS:ffff8881253b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31663fff CR3: 0000000075e7c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 put_queue drivers/tty/vt/keyboard.c:328 [inline]
 to_utf8+0x872/0x1ad0 drivers/tty/vt/keyboard.c:-1
 put_queue_utf8 drivers/tty/vt/keyboard.c:382 [inline]
 k_unicode drivers/tty/vt/keyboard.c:683 [inline]
 k_self+0x326/0x7e0 drivers/tty/vt/keyboard.c:701
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
RIP: 0033:0x7fa3fd19aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb1030708 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa3fd415fa0 RCX: 00007fa3fd19aeb9
RDX: 0000000000002250 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007fa3fd208c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa3fd415fac R14: 00007fa3fd415fa0 R15: 00007fa3fd415fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc900036c7318 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff88802f848000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  0000555556b5d500(0000) GS:ffff8881253b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31663fff CR3: 0000000075e7c000 CR4: 00000000003526f0
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
