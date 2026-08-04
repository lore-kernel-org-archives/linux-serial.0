Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A140DFBD
	for <linux-serial@vger.kernel.org>; Tue,  4 Aug 2026 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785813463; cv=none; b=hWUGp/cLffrloWYp6vmxn0VH9FkYjJ5Ac+2cPskU6M1WebegMd+ha3sXcdDyrNttNt7HwmuYynWe5NkqLO58IQMVdUWvbSUx2FKXIT17Zeg8yHNBFjt6cvN2E1uwo1ste+kt4X2JHUUA5icR35Bqg+6afrZXfmGaBsEQlmyzyX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785813463; c=relaxed/simple;
	bh=qvQmn7GXQmbqP1KH12N1PKWy4Q0IA30OMH5HSW/bewQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TC61vE/nRdIAJklKHXKSImxXF6vAnOhrurhsTnmMP0zuFELheMSrx3JryHS91CjMhZDwJV4vZGM88TjkjHBax/7ZEQTTNAgC2eafzObYncmOPLrVsp0nPEVlMtT1vDJ3bMDutTz4vofgl3iD9EzacBM1orNqNpASQuZe1Mvl2ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e9f686e18cso5538717a34.0
        for <linux-serial@vger.kernel.org>; Mon, 03 Aug 2026 20:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785813461; x=1786418261;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WvbIdHRijZxTDFtSkb6sL8tw/r5AAl0KoJSh/W+ke/w=;
        b=OxxQOwDBRFTUjd3+HVeWwE1VhfFdt79BIWGrUdSYpiOvZL0NLxrvV67TFkthZKVnSU
         t3gFXrDhYtH0+Eu46ms5c979tZawkRB+8C12EP81QpmiNW/LNu8B1dYEEA3RDdyWtF+e
         KP2xZ/7siHL74mLz2SCVbZSpjSEjoyvyPcyynw7+n8OPZMVGcgFOTvGzTf1uaj4KGdkl
         qEKkPiEYFMkJGJcDjDTlxYTPQ/5+DOIg6Cdz2MGvpZzclQbv3VjE/Jvs8W2HrUq4AMkj
         q2aYzlf45fEsAxOGu5oHkfb4TZ2TBDuGx8Dn3XxjeZx7sKGZXa1j3Ov/pT/uy2YKg+ui
         izdA==
X-Forwarded-Encrypted: i=1; AHgh+RpDj6NQGrmRsbX3PfdhqSCVf9HazEPjsvHJgOpyH3hx7JUvi4zS4RW9IHIzt+1EZNlADvC4QuhM0gUd2fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtFZbq5fPwvE3wGfh5yIyWjfBUM1uap7NcFNosy23z0GBCPsCY
	0DFe90f5jl79MLYsEdfvtfZRxaXry1WTmqxAI6WXPrBthGHg7F8MFmLvSPL8jeZiRbvbNJAeLCz
	9Dl6tAnkmSWj2ygChM2ZoZqNmPDSkxJugw/Wj79fA4b+O8C/9jKqZs3krMHQ=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1c09:b0:496:11f1:f2b3 with SMTP id
 5614622812f47-4af5e461595mr20728510b6e.20.1785813461240; Mon, 03 Aug 2026
 20:17:41 -0700 (PDT)
Date: Mon, 03 Aug 2026 20:17:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7159d5.9511d2ce.1fc5b9.0333.GAE@google.com>
Subject: [syzbot] [serial?] WARNING in register_console
From: syzbot <syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075b74841bd0 Linux 7.2-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16947db9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=1ebbc20f223b99446034
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a0f4edd30437/disk-075b7484.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07bfd5e330f0/vmlinux-075b7484.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96d6ea3053f1/bzImage-075b7484.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com

printk: legacy console [ttyS0] enabled
------------[ cut here ]------------
IS_ERR(kt)
WARNING: kernel/printk/printk.c:3728 at legacy_kthread_create kernel/printk/printk.c:3728 [inline], CPU#1: syz.5.580/9206
WARNING: kernel/printk/printk.c:3728 at printk_kthreads_check_locked+0x2a7/0x3f0 kernel/printk/printk.c:3802, CPU#1: syz.5.580/9206
Modules linked in:
CPU: 1 UID: 0 PID: 9206 Comm: syz.5.580 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:legacy_kthread_create kernel/printk/printk.c:3728 [inline]
RIP: 0010:printk_kthreads_check_locked+0x2a7/0x3f0 kernel/printk/printk.c:3802
Code: fe c1 38 c1 7c 9a 4c 89 f7 e8 f5 89 8a 00 eb 90 e8 be 16 21 00 eb 05 e8 b7 16 21 00 b0 01 88 05 0f a6 08 18 e9 e2 00 00 00 90 <0f> 0b 90 48 c7 c7 80 bd 6d 8b e8 fa a0 82 ff 48 8b 1d 73 a0 04 18
RSP: 0018:ffffc90005367a70 EFLAGS: 00010206
RAX: fffffffffffffffc RBX: 0000000000000001 RCX: 664c2998e3563700
RDX: ffffc90016660000 RSI: 000000000000051b RDI: 000000000000051c
RBP: ffffc90005367b70 R08: ffff88803f2dbfaf R09: 1ffff11007e5b7f5
R10: dffffc0000000000 R11: ffffed1007e5b7f6 R12: 0000000000000000
R13: dffffc0000000000 R14: 1ffff92000a6cf5c R15: dffffc0000000000
FS:  00007f51410156c0(0000) GS:ffff888125d3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb5f0865000 CR3: 0000000040d7c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 register_console+0xc19/0xfc0 kernel/printk/printk.c:4221
 console_store+0x359/0x4f0 drivers/tty/serial/serial_core.c:2999
 kernfs_fop_write_iter+0x3a5/0x540 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5142dde019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5141015028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f5143066090 RCX: 00007f5142dde019
RDX: 0000000000000002 RSI: 0000200000000600 RDI: 0000000000000003
RBP: 00007f5142e7500c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5143066128 R14: 00007f5143066090 R15: 00007ffe01de2878
 </TASK>


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
