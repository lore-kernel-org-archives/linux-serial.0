Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793C12B95
	for <linux-serial@vger.kernel.org>; Thu, 25 Jul 2024 04:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881649; cv=none; b=WODkBZCiFy4jXMSeEyDzfJtbY69cck33ITsQ9hzKNBWyBYTyzxPLEOfon9K5GIyjOpAEJ1V/jFdX0RuUc6YpHOZK4Ucqwa2HOVFHRC24/+1WgoL4U/Ao2DECGk7Qwar/oj6yodkCryzFQfscH1gxbEGhwDXwfMLrL9l0GLW22eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881649; c=relaxed/simple;
	bh=+y0LYOXdo+Rbtg55T3IOqrCtEJNFT6WwTdn6LjJQgC4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lkrrvb2kwaq/XTgghC0G1FR9fyCNd5YLWANyRQ400qJuVU5RbNtmZuJKx2H67UvRNjXq0a4f3G9Q9z5M2k67tS3SAMzWDVZsztAntJ+GKIujM1r+pSJIt+yoB4NUkpao2KuQdoYmbspNIxssCtA7ILoS4l1WzeSvJp3mQ3YePTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so11512339f.2
        for <linux-serial@vger.kernel.org>; Wed, 24 Jul 2024 21:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881646; x=1722486446;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lON8fGworFpTJ7CQFsh8gPqMnx74mEVJ/DboqaaKd4=;
        b=wLlqcFtDpzfBvAusL07unkf0zXIbHf9NhaZ1Pz17c08FUlIZoAKYtHJK1VVd7iavBg
         rysP7omf0NWbMG8+14Bvev82w7/ekcap6JTT2M8I0zOFJOPBrpKwT0+BQjObmCYONKfr
         HYeJdfR4zBBjdmqVEcBE/UK2v/iQnGknVYdwSlkUlzbbZ/C0wmZSGTrYicZ+4sVt4+eC
         v7C+7F8SK1kobUpKc9JY0tG2U3j7/ABZptF9tsnijVe3XGZAD1LULnNzRFl2QIlbFyTv
         LUnrRtvTyYuoQqD+IlEXn8ojoWsjy+tJ7keXnHTIQI0TxwiZrR6Z0GZDoX8/rUQScupK
         pspA==
X-Forwarded-Encrypted: i=1; AJvYcCWAlWM0EquOhmIZrV5CFEGnl4HS/xL++0+XrFESe78wyPPvXRFl59XlXwAB/p7z36c4TmoSCCpSgvEwzwbriJ95upUJpt9YK40xPzSr
X-Gm-Message-State: AOJu0YxlWYc4E/oQVRC165w2G4N/uqE3XGAk+D+goTtC1L5jELDEQSPg
	2vRNUjlylv3hmATCHe/wquIDwXAallL8o4rKJNTdRyMRiRwfL+iohyQF48X+kOPYy8OvCAU1C+s
	ZP96jBkMg4NxdYblKmw1n5kuxvsJynj8mDmhc8v3FbarH7CJfvDVYJMg=
X-Google-Smtp-Source: AGHT+IFKiVs0ynWU6sPaCWcQc5bXJcd0XJIfyj44zLasAXY91uG3+wsbMLFkmbv0EE6qda5A+h8isJyfufw+RA985Cqd6wazdMkN
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8412:b0:4c1:4388:46bb with SMTP id
 8926c6da1cb9f-4c2a0d82265mr29149173.0.1721881646548; Wed, 24 Jul 2024
 21:27:26 -0700 (PDT)
Date: Wed, 24 Jul 2024 21:27:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e35983061e0acfa9@google.com>
Subject: [syzbot] [serial?] general protection fault in n_tty_receive_buf_common
 (2)
From: syzbot <syzbot+2dda672e146ff12ccb02@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    786c8248dbd3 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f0d29d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47beaba1a1054668
dashboard link: https://syzkaller.appspot.com/bug?extid=2dda672e146ff12ccb02
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e4bf4a8f547d/disk-786c8248.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9b69a5fd8929/vmlinux-786c8248.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e0060dfb7885/bzImage-786c8248.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2dda672e146ff12ccb02@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000044c: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000002260-0x0000000000002267]
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:n_tty_receive_buf_common+0xf3/0x1980 drivers/tty/n_tty.c:1718
Code: 00 48 89 74 24 60 4a 8d 0c 39 4a 8d 34 3a 48 89 4c 24 70 48 89 74 24 68 48 89 84 24 a0 00 00 00 e8 b2 c7 95 fc 48 8b 44 24 68 <80> 38 00 0f 85 af 15 00 00 48 8b 44 24 18 48 8b a8 60 22 00 00 48
RSP: 0018:ffffc90000117ad0 EFLAGS: 00010293
RAX: dffffc000000044c RBX: 0000000000000001 RCX: dffffc0000000000
RDX: ffff8880172fda00 RSI: ffffffff84f4beee RDI: 000000000000005c
RBP: 0000000000000004 R08: 0000000000000001 R09: ffffed100bfcec50
R10: ffff88805fe76287 R11: 0000000000000000 R12: ffffffff84f4d790
R13: 0000000000000000 R14: ffff88805fe76000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f62429bcfc8 CR3: 0000000066f7a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tty_ldisc_receive_buf+0xa2/0x190 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x264/0x780 drivers/tty/tty_buffer.c:495
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:n_tty_receive_buf_common+0xf3/0x1980 drivers/tty/n_tty.c:1718
Code: 00 48 89 74 24 60 4a 8d 0c 39 4a 8d 34 3a 48 89 4c 24 70 48 89 74 24 68 48 89 84 24 a0 00 00 00 e8 b2 c7 95 fc 48 8b 44 24 68 <80> 38 00 0f 85 af 15 00 00 48 8b 44 24 18 48 8b a8 60 22 00 00 48
RSP: 0018:ffffc90000117ad0 EFLAGS: 00010293
RAX: dffffc000000044c RBX: 0000000000000001 RCX: dffffc0000000000
RDX: ffff8880172fda00 RSI: ffffffff84f4beee RDI: 000000000000005c
RBP: 0000000000000004 R08: 0000000000000001 R09: ffffed100bfcec50
R10: ffff88805fe76287 R11: 0000000000000000 R12: ffffffff84f4d790
R13: 0000000000000000 R14: ffff88805fe76000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055557bdc65c8 CR3: 0000000058bdc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 89 74 24 60       	mov    %rsi,0x60(%rsp)
   5:	4a 8d 0c 39          	lea    (%rcx,%r15,1),%rcx
   9:	4a 8d 34 3a          	lea    (%rdx,%r15,1),%rsi
   d:	48 89 4c 24 70       	mov    %rcx,0x70(%rsp)
  12:	48 89 74 24 68       	mov    %rsi,0x68(%rsp)
  17:	48 89 84 24 a0 00 00 	mov    %rax,0xa0(%rsp)
  1e:	00
  1f:	e8 b2 c7 95 fc       	call   0xfc95c7d6
  24:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
* 29:	80 38 00             	cmpb   $0x0,(%rax) <-- trapping instruction
  2c:	0f 85 af 15 00 00    	jne    0x15e1
  32:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  37:	48 8b a8 60 22 00 00 	mov    0x2260(%rax),%rbp
  3e:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
