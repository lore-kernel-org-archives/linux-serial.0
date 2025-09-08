Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5131CAA92
	for <linux-serial@vger.kernel.org>; Mon,  8 Sep 2025 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757357133; cv=none; b=taHzNm6harL5Ejcb2HumhKA/W93oUprtabxZznOdgFu3EA+twR9fBQaACdSzIOxh8B5rX7AVnlPzhHy8aMutRUFFPt1NpPldq+Mo+ls4nFYxSD++PvDM4uV6VWoz59mNzhkXbgrWedyl1IpOkTZYvQ8wyX/n1QWzmA6VwxV4YFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757357133; c=relaxed/simple;
	bh=T1qo6a/TUcnJiT6mvynHEi9MWIhITWvsfSfmdZ6voVs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j4iTHBZO/jyqsVD9mTWwVzLt1UCyiFqlcag5pfBt8FH2cl2nSP5yg38ixK8BQZOJh61wxEtFM50y1ByJ/jebfXaVYqH+IPFz3LbVHLdKhywMozq5k61g2lQl6jOVyfCC8HRHbVvfp5jF3DhPvJdQdJex/qMAB3fUrwtY65g1Ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-40528b44500so16974645ab.1
        for <linux-serial@vger.kernel.org>; Mon, 08 Sep 2025 11:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757357130; x=1757961930;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4rpIw4Z9cvceYkZykcJtkfZw05I+KJyWWW3NBceNUk=;
        b=cBDefsfUBtY0uWee8MNEQBGE0NVHGu49agt9ZHrylo0QzhB7YOmYWp1Fo6mlgt6lXI
         wsIBX768WtP92a9Vg8ZSxV5J9KkQFAfDmRw9gW6bYykM2doC8fq7Kp6j0I6HssMsBs39
         368fjMD056VSpAFGSxsSmg7TKty+UGpAWt2APyBnfRsl1NGK651NkVYL1XsFbR2l7VDj
         uW45/Jfu36Ea+HibilKqr+VTRtRyXMbvTAPJMcF0O4IK+4B2UWOu3ZI/yoTxE9z6VoP7
         bJDkSt8OhtYG0svMleBnipgWdUD4UsONJUNNETp6MwUxrD1IuLxEbcFDvFy4GoTLq9bJ
         IPMw==
X-Forwarded-Encrypted: i=1; AJvYcCWLgCFYyp0Fd4JlvDH5cOPJTkI6kGCRkQzsMVlJ6FZVzPeM49Cg98anqmBMVEXhsi1kE+q4jIT9QGQkkic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZz6te4iEYniIByNqPj13kl0BUPE65RffecAANf5kR61v/Z237
	3muRrDG218lMJnjC0dZcTYfzavvEtiFyeF2tl6wNXz/Sr4PpJ/2dItDbQSHBPcLzk89oOYFk84I
	I1+zxhb7FJ61cCXL8qlibzfiC7CL0FrkQWOtFT0RXACDlE35SAhrfM3K8bpo=
X-Google-Smtp-Source: AGHT+IHBT7DTZEGxAOZYWpHTes750AEJWQKD32H1tP+pCIa9zxYfigQhdZ5lXYfPESvvwcfciU1M0aHUoKTMrL0xl5+xAc9XQSLO
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa1:b0:3f6:618f:6b2b with SMTP id
 e9e14a558f8ab-3fd87c4d5b5mr128088375ab.28.1757357130483; Mon, 08 Sep 2025
 11:45:30 -0700 (PDT)
Date: Mon, 08 Sep 2025 11:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bf244a.050a0220.192772.0882.GAE@google.com>
Subject: [syzbot] [serial?] general protection fault in vc_deallocate
From: syzbot <syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e8e5822146b Add linux-next specific files for 20250908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11984642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
dashboard link: https://syzkaller.appspot.com/bug?extid=f6cb41c144427dc0796a
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17230934580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15984642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaa87d8bc6ca/disk-3e8e5822.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6640e70f5002/vmlinux-3e8e5822.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40f622291050/bzImage-3e8e5822.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f6cb41c144427dc0796a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc00000000b2: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000590-0x0000000000000597]
CPU: 0 UID: 0 PID: 6062 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:vc_deallocate+0x303/0x3e0 drivers/tty/vt/vt.c:1345
Code: e8 f2 1f d7 fc 49 c7 07 00 00 00 00 eb 0e e8 14 1d 73 fc eb 05 e8 0d 1d 73 fc 31 db 4c 8d b3 90 05 00 00 4d 89 f4 49 c1 ec 03 <43> 80 3c 2c 00 74 08 4c 89 f7 e8 ce 1e d7 fc 4d 8b 3e 4d 85 ff 74
RSP: 0018:ffffc900035f79e0 EFLAGS: 00010206
RAX: ffffffff854c8f03 RBX: 0000000000000000 RCX: ffff88807dd3dac0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000003f
RBP: ffffc900035f7a90 R08: ffffffff8fc3c7cf R09: 1ffffffff1f878f9
R10: dffffc0000000000 R11: fffffbfff1f878fa R12: 00000000000000b2
R13: dffffc0000000000 R14: 0000000000000590 R15: ffffffff9a034a30
FS:  000055557fa10500(0000) GS:ffff8881259f1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557fa10808 CR3: 000000007ba62000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vt_disallocate_all+0x60/0xe0 drivers/tty/vt/vt_ioctl.c:652
 vt_ioctl+0x1adc/0x1f20 drivers/tty/vt/vt_ioctl.c:886
 tty_ioctl+0x926/0xde0 drivers/tty/tty_io.c:2792
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97fa38ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe553801c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f97fa5c5fa0 RCX: 00007f97fa38ebe9
RDX: 0000000000000000 RSI: 0000000000005608 RDI: 0000000000000004
RBP: 00007f97fa411e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f97fa5c5fa0 R14: 00007f97fa5c5fa0 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vc_deallocate+0x303/0x3e0 drivers/tty/vt/vt.c:1345
Code: e8 f2 1f d7 fc 49 c7 07 00 00 00 00 eb 0e e8 14 1d 73 fc eb 05 e8 0d 1d 73 fc 31 db 4c 8d b3 90 05 00 00 4d 89 f4 49 c1 ec 03 <43> 80 3c 2c 00 74 08 4c 89 f7 e8 ce 1e d7 fc 4d 8b 3e 4d 85 ff 74
RSP: 0018:ffffc900035f79e0 EFLAGS: 00010206
RAX: ffffffff854c8f03 RBX: 0000000000000000 RCX: ffff88807dd3dac0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 000000000000003f
RBP: ffffc900035f7a90 R08: ffffffff8fc3c7cf R09: 1ffffffff1f878f9
R10: dffffc0000000000 R11: fffffbfff1f878fa R12: 00000000000000b2
R13: dffffc0000000000 R14: 0000000000000590 R15: ffffffff9a034a30
FS:  000055557fa10500(0000) GS:ffff8881259f1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557fa10808 CR3: 000000007ba62000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	e8 f2 1f d7 fc       	call   0xfcd71ff7
   5:	49 c7 07 00 00 00 00 	movq   $0x0,(%r15)
   c:	eb 0e                	jmp    0x1c
   e:	e8 14 1d 73 fc       	call   0xfc731d27
  13:	eb 05                	jmp    0x1a
  15:	e8 0d 1d 73 fc       	call   0xfc731d27
  1a:	31 db                	xor    %ebx,%ebx
  1c:	4c 8d b3 90 05 00 00 	lea    0x590(%rbx),%r14
  23:	4d 89 f4             	mov    %r14,%r12
  26:	49 c1 ec 03          	shr    $0x3,%r12
* 2a:	43 80 3c 2c 00       	cmpb   $0x0,(%r12,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 ce 1e d7 fc       	call   0xfcd71f07
  39:	4d 8b 3e             	mov    (%r14),%r15
  3c:	4d 85 ff             	test   %r15,%r15
  3f:	74                   	.byte 0x74


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
