Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A655C1E5B7B
	for <linux-serial@vger.kernel.org>; Wed, 28 Jan 2026 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769560536; cv=none; b=BqVD36VXriCh0OdBguGlFkrH6Rlhg3oc3yeI4jP7gaQ8TX8d25AigKawUU/LkZRbTW8HfCBGw8dv9nIIsjeoOLwu23OO/f0KmMe+Nlm8cUCGW187SA9sKSsMmrgHgp0Gfle9uMx1mX1tdYa5uuNsEm7ebCEE5APWty86900Oohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769560536; c=relaxed/simple;
	bh=rsYhG4vNF2tjG+6NQ8vlM3NK/7kIHjmb7diqCpLo39o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K9fZgp/us/wIeUpbPDHebFzZgtQ0u0j6Ck36ZG3jJfurfNOtUQCwWUs9rL02RxwAMsONNz6QSpqOEDFn02DKJUMFQaVtY67mgrNBAHUVH5NcoNAbMcXw/e2yMEWkSuc4wSzuAP767uah1/+8mSzMBxPqvuXKufauBl0MPNJrvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-66115eb3950so13735503eaf.3
        for <linux-serial@vger.kernel.org>; Tue, 27 Jan 2026 16:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769560533; x=1770165333;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiL/J+GAd7m8/xrFYt4nDSBEtCYZ184sjlc7HOx8SLI=;
        b=s3VZXYsnibi8vefAsp1B3BoIgVgO8RxNX01b+WfUesOg0mR3YIS82i1pKMt+GdeoWz
         XnixTPdIHLrjtKFFCrOymAB/oP2bZo1DtVF0eLrWN0VZ4ci/o3WP22JubLY7zNfTdsiN
         GWvw8PlWmoiI72JDg+S2T649XeoOgOIpfbdPM/MrS6sOs9sFIgbSqFrI0y2dgm0+oGqD
         pnoffHc1+4B5nKt1t14mo3jKDYvSEp25jsXL7kRza8BFyKrVam31iuOwCdnvmLXHq3dm
         TNHLPP6xA1hyG82ihEk8P7xGgn3M49en0EIrEAb4YFcm5k9KiMLBFrldHq2stbzhqo6d
         w5nw==
X-Forwarded-Encrypted: i=1; AJvYcCWOF49RBC20pZiXHWbc3LdpXbwthEP83yNB5ET/N1FG3qa+KHscO0bP3GypKCJyHPNNm5HXAAsIK6bBR68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv2B+N9uZhLpZl1WO5hVA45pFqOn2GfO/9t74+HbTGkudQQ0F+
	zv0Nw9dEMRtik+7Ix/G13H1+XyYLGQ/9lLGHviIF9X4lMFRT9EDje5lLHnx+PfPbwGq3aqAD+Kw
	Nfe8OIeuLV0bXwKri8lZgEHKs8XdxUoX26ulRq1Ny47R0BzW4WHt/EpgRGQk=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2207:b0:662:c4c8:7adc with SMTP id
 006d021491bc7-662f2053007mr2311970eaf.34.1769560533545; Tue, 27 Jan 2026
 16:35:33 -0800 (PST)
Date: Tue, 27 Jan 2026 16:35:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697959d5.050a0220.c9109.002b.GAE@google.com>
Subject: [syzbot] [serial?] general protection fault in fn_enter
From: syzbot <syzbot+bbe4d8bcf8e458140bb8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    615aad0f61e0 Add linux-next specific files for 20260126
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1625a6ef980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d51c584a7396ddf1
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe4d8bcf8e458140bb8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11747d2a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1190d05a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5318e5f027be/disk-615aad0f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d165e561fa49/vmlinux-615aad0f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb0e01c90aa5/bzImage-615aad0f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbe4d8bcf8e458140bb8@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 1 UID: 0 PID: 6023 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc900036f74b8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff888031643c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  0000555577a96500(0000) GS:ffff8881253b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fccc4f840c0 CR3: 000000007b780000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 put_queue drivers/tty/vt/keyboard.c:328 [inline]
 fn_enter+0x45d/0x900 drivers/tty/vt/keyboard.c:480
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
RIP: 0033:0x7fccc4f9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe15585178 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fccc5215fa0 RCX: 00007fccc4f9aeb9
RDX: 00000000000012d8 RSI: 0000200000000040 RDI: 0000000000000003
RBP: 00007fccc5008c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fccc5215fac R14: 00007fccc5215fa0 R15: 00007fccc5215fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 4e f4 37 00 85 ed 0f 85 ef 0c 00 00 e8 01 f0 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc900036f74b8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: ffff888031643c80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  0000555577a96500(0000) GS:ffff8881253b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fccc4f840c0 CR3: 000000007b780000 CR4: 00000000003526f0
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
