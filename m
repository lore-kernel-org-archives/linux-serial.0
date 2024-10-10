Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667E01CCEF1
	for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576875; cv=none; b=U9Ld/zBHlLr9XbvPrKtFiVa1TUuWbCYQo8KdptmUtlXoOHXl1Ucg2Zs8L1gbvWBTPX1dFtSOX6KS8r42vQWgyKb0ossQsElxbIWjpxB1dJb5cFYW4GMi3a7bgbYdupZeEzz/2pR3UxiqR64JwMv3d/bnUkCYIVhNYDY8f2PVHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576875; c=relaxed/simple;
	bh=v49gd/Nb+FyIdhlg8fr61T4W9gSocllzctpMIEdTQ5U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GMN/cJj2kcaD/wZqBj44n6UpOAFswdXEPb5XVTIypJxte4uiNkpUQxIoZbljBwNu8kJAPAFh6LdmIgtYeMEtKSCEr/CZLtcl2cVeQqgDEnFxmV5ksx17hMoFc44zz/G1xN0nKz7b+jXVi4aXGVS/K7CKvt/irHD0uvqbjroqUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae775193so8296625ab.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Oct 2024 09:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576873; x=1729181673;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIFxVb1FmDfK2PJKmv3dgTK2BMItDdXdJ1krqU6KjrI=;
        b=NLiZcPD4iGhqibRpGOEQirt8fLKR1CU0gMbd5eofc3kkatgFGAJ77FCIPkTkNB/WGI
         yq5xUQu6B7aY4k2IIqEfQUg2s7dSnxNfHgDf/zI+dLUdVocsSYVXEfb9e81d9XuUuvT0
         vlrUP41R0CiIPZ+hRhhNwFYZhv4qiPticio+1bG2YpWkX90TV0wkCGMc+ozhdb4l5JT2
         m6sX/XYL31qdLO2QZrrZchKN25ybu1+2gl0L07fWG6Ll8OECbOWOWc5gq4iGqIZVmGRa
         tnVaWArbrwRKcW3RCxYn/Oxe1eQ4cw0V3qAZFMmm/fjTQqxL/MoHssGujgULjq1+gEb7
         vYgg==
X-Forwarded-Encrypted: i=1; AJvYcCWbD1OqTsFA8tDjSemW7sOKMuNAzXxaq8GImMlKko7SN91nbZbyYi9Z1hSRjQEPPsDaD/LrZVH3ytiF164=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhI7qwhOvlSYCnEZ7snPTWaxnU96ZKxWwv9Y0StMkj/CZ/xVjD
	if/8byCg6Cpz2aSRdcdwkg09+3vBOeTbjRaGs8ApkEvdKFnT6N8A49WddTEI89xmYj2R7FZ35Bc
	QJbM7WXVWy7sFfIinmEAZxqgKsAC1/ANiR8GS/fzRBs1N4KomVsBrLOU=
X-Google-Smtp-Source: AGHT+IHsnuMdq3Jm/+33YY3qVXnZpnJQ9Pjg+b7XZJhRjAZkYBTD5ZeFYybAQP5cCchsEQAMqYVCBvSfAE7OMyVAuzmEYtIazxaX
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:3a3:b254:ca2c with SMTP id
 e9e14a558f8ab-3a3b254cad5mr14537025ab.25.1728576873555; Thu, 10 Oct 2024
 09:14:33 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:14:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707fd69.050a0220.3e960.0000.GAE@google.com>
Subject: [syzbot] [serial?] KMSAN: kernel-infoleak in con_font_op (2)
From: syzbot <syzbot+955da2d57931604ee691@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f602276d390 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8f307980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d302f14701986aa0
dashboard link: https://syzkaller.appspot.com/bug?extid=955da2d57931604ee691
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/241996bfa3de/disk-8f602276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/417de1b4ca32/vmlinux-8f602276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2c793c19b953/bzImage-8f602276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+955da2d57931604ee691@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _inline_copy_to_user include/linux/uaccess.h:187 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _inline_copy_to_user include/linux/uaccess.h:187 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:26
 copy_to_user include/linux/uaccess.h:216 [inline]
 con_font_get drivers/tty/vt/vt.c:4760 [inline]
 con_font_op+0x14a2/0x1710 drivers/tty/vt/vt.c:4854
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x2b6e/0x2fe0 drivers/tty/vt/vt_ioctl.c:751
 tty_ioctl+0xd0c/0x1990 drivers/tty/tty_io.c:2803
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x25e/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x18bf/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 ___kmalloc_large_node+0x22c/0x370 mm/slub.c:4219
 __kmalloc_large_node_noprof+0x3f/0x1e0 mm/slub.c:4236
 __do_kmalloc_node mm/slub.c:4252 [inline]
 __kmalloc_node_noprof+0x9d6/0xf50 mm/slub.c:4270
 __kvmalloc_node_noprof+0xc0/0x2d0 mm/util.c:658
 con_font_get drivers/tty/vt/vt.c:4729 [inline]
 con_font_op+0x659/0x1710 drivers/tty/vt/vt.c:4854
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x2b6e/0x2fe0 drivers/tty/vt/vt_ioctl.c:751
 tty_ioctl+0xd0c/0x1990 drivers/tty/tty_io.c:2803
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0x25e/0x450 fs/ioctl.c:893
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:893
 x64_sys_call+0x18bf/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 61440-76799 of 76800 are uninitialized
Memory access of size 76800 starts at ffff8880b5c00000
Data copied to user address 0000000020000880

CPU: 0 UID: 0 PID: 7973 Comm: syz.2.4245 Tainted: G        W          6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
=====================================================


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
