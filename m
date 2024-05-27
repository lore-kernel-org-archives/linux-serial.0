Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62EDDC1
	for <linux-serial@vger.kernel.org>; Mon, 27 May 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716789809; cv=none; b=hHfmHWMW5voFZn70PUMzgu8ygfibBwQlOSxWoOm7oWjq+61EUathaOqG6h+7J41qlzk+1gqGrfkTZn0OYL1CHeyEOGZ4i2O7EcgTprlTPudk17qrPBbOnrdDnKbAQONWCHs5IJ1YYSli2KSzoWl/wAitYcrK4N7t0ixcMY2hg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716789809; c=relaxed/simple;
	bh=91RmJoS8ApwBbCnKWn4Vdvz5yrryEn4O0r1bO0e2r28=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GXwYX6svBFbgor+zZZRwyurfsb0iCDGsBDKgyqKGBEr2hHXn5mlBXCxkb2ey8HGy/zqG6dFhBM/eig05h/N637eUwFJJF2Q4dhIEcwPXO8x95viFLmoi90ocEiungv+zK8thXxfewdi5okj53r4iBggTDb4YePErDY8e+0NJ4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3737b3ee909so30398545ab.2
        for <linux-serial@vger.kernel.org>; Sun, 26 May 2024 23:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716789807; x=1717394607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylosgLFWkzz27URtDPQRIStv485PYnIrmAp+vnJMT5w=;
        b=QKTPl40Ruj1fy2aPdK32l5bhIAAbWJJ4h/D6wQuUgeSwouUQcLmtVisXJjNb6zDzmt
         hhhGwLGiLMwBTiZxO2ZfNyDL5UQYzAs26ebxYPNpqXVN9zUKW24jAXzmBwL6HUmKGw2n
         lYo+I9XkFQuNFWC3QMlAU6z60z1TNnrKRS7A5GzEtiTn1BdnyYgIVVgYY/U7VDSytOWl
         zynyxLh1Hey8JxuqPBIcB7jhlgtVKw+n2kXxDvqfFlbMisID7mmxwfTaSlvlFq9Btfsk
         GY3T1h32Wg+EEcjfoq3FND7umKWGS4pHT3aTjfLoUv0GAOYfb3Q2loZ0cmzt+eWsDOEP
         nagw==
X-Forwarded-Encrypted: i=1; AJvYcCUw8MBzbq32SQg65X15Au6ELQ0/KlSs9Bp50QiNw/SRte25tOCbrze26fr0a+Sf9hXEL81Uy3zLSMKbnCono1MoNM5+2eNJReH8FozO
X-Gm-Message-State: AOJu0YzhBBUjq5gOT4rpwz94jBBeCoRmlGZ8ftaW1qDOFDxODWoq10Ge
	t2v1n60B+nNvzoC/0Ygx2O8n3teCEdv995RlSlVnd7Cm8I9DqS3dUMn9jcnZioS2KLPB5WrJREz
	eUJQfl9mm/ctyQL9HufM/PP6fqguez86YWk+AEyPrD/MPYCZQzGMQuDw=
X-Google-Smtp-Source: AGHT+IGziuuHeulebz6CLCVgizY+guJCFI18W9Te8LGSJfIs/iYOaxdh3laW9XqBc7ooLU5qkANCTYlary/U5tulRumwz/2bkTIh
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:374:5d81:9135 with SMTP id
 e9e14a558f8ab-3745d819329mr531955ab.0.1716789807386; Sun, 26 May 2024
 23:03:27 -0700 (PDT)
Date: Sun, 26 May 2024 23:03:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fa48a06196946dc@google.com>
Subject: [syzbot] [serial?] WARNING in uart_write
From: syzbot <syzbot+a38f8e1908608d337bb3@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    124cfbcd6d18 Add linux-next specific files for 20240521
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12341062980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c3a67a38201bdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=a38f8e1908608d337bb3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ff8e45d8b821/disk-124cfbcd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6aeeec759cde/vmlinux-124cfbcd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e7d931d0a4b/bzImage-124cfbcd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a38f8e1908608d337bb3@syzkaller.appspotmail.com

sp0: Synchronizing with TNC
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5215 at drivers/tty/serial/serial_core.c:625 uart_write+0x2b0/0x320 drivers/tty/serial/serial_core.c:625
Modules linked in:
CPU: 0 PID: 5215 Comm: syz-executor.1 Not tainted 6.9.0-next-20240521-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:uart_write+0x2b0/0x320 drivers/tty/serial/serial_core.c:625
Code: 74 08 48 89 df e8 c0 5e bf fc 48 83 3b 00 74 74 e8 55 7a 59 fc eb 97 e8 4e 7a 59 fc 45 31 e4 eb 08 e8 44 7a 59 fc 45 31 ed 90 <0f> 0b 90 45 84 e4 74 0a e8 33 7a 59 fc 45 31 f6 eb 84 e8 29 7a 59
RSP: 0018:ffffc900047874b8 EFLAGS: 00010046
RAX: ffffffff853ceb62 RBX: dffffc0000000000 RCX: 0000000000040000
RDX: ffffc9000a14b000 RSI: 000000000001b0ec RDI: 000000000001b0ed
RBP: ffff888020728f48 R08: 0000000000000003 R09: fffff520008f0e74
R10: dffffc0000000000 R11: fffff520008f0e74 R12: 0000000000000000
R13: 0000000000000246 R14: ffff888020728be8 R15: ffffffff94adece0
FS:  00007f53ae0446c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1488dbcc98 CR3: 0000000079a6e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tnc_init drivers/net/hamradio/6pack.c:531 [inline]
 sixpack_open+0x790/0xa80 drivers/net/hamradio/6pack.c:628
 tty_ldisc_open drivers/tty/tty_ldisc.c:432 [inline]
 tty_ldisc_reinit+0x2d4/0x4a0 drivers/tty/tty_ldisc.c:667
 tty_reopen+0x20b/0x2d0 drivers/tty/tty_io.c:1366
 tty_open_by_driver drivers/tty/tty_io.c:2082 [inline]
 tty_open+0xa26/0xdf0 drivers/tty/tty_io.c:2135
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f53ad27cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f53ae0440c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f53ad3ac050 RCX: 00007f53ad27cee9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: ffffffffffffff9c
RBP: 00007f53ad2c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f53ad3ac050 R15: 00007ffc05d3f0d8
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
