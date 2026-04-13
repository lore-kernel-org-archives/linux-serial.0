Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1E3A168F
	for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085178; cv=none; b=XhR0ZDE0R4JoFqWJFeLH8VaV0Exn977DLXBGdP6l4+ULtg4973/i1AK7O8z7C8qbAeAr1oplkD35HWtc0Gpn692fvyfin8Kb4lCoAYw547LIgqrHoxx/MovsWSWzf+cjg4JSxWgfyNZy1+eD68lXzrbEL2aHsLZmAXZk1cMZOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085178; c=relaxed/simple;
	bh=z4XWfzkjEpLzr6paDj9g/f5v7+wXjseVinFpPz/gC6k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bh71md5Ihkb0wXveWtCVvG2YnokHQn1960JjhO/FAx5m78q+k8PgDgd+hh7fuI3CGo6axMd6YEcFWHuy6rXjE8MP9yh137Ey5cP1BSFeYTKrD6lRfYoXmPf3WRGAiYZdshDUPJD9xGay9XR3XDuZPLKMHJMXDXiqVsKoKBT9X38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7dbbb806e10so8556348a34.1
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 05:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776085175; x=1776689975;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DijaP2EFboDsBl+FutWi7RyJ5FRstsis7pmaPrKlluE=;
        b=Fj5uZVz+w+adVC82cCGKH13taiaz1lQVa6cA+VMirsAcwF1fYV2W5y9E9Vw/ZpFXHO
         Pue8by7gRkA47iH9XSxylMqUKlgjlzi7MCi+45OKGf5gF5ZPxlPUQFVDi5/1ovkvFe03
         oLsTwhpHvKG9gSDxUDmyKxQtatElPiYunjZpHtzeX2togqF4yNni5oHFxeUlUBZOK7Ej
         lkTxYacT7TZJTqefnFOicIpK4kRnPvy88a9db42pwuEHzZDGKBgXY5L2w8Ez56AM2SAV
         K9da/7A2U3dGh7/CBswRJZ25k24eIg4CcQtRUTyslb3Re1WlEDDBmBkPpfQgPxVN/tlv
         HRYA==
X-Forwarded-Encrypted: i=1; AFNElJ+0SDYvmcuf0WtAidW4W0E8MsXs1kCbBZyhHZzFAZmWuajs0vm873L48uN9X/BOhK1rvT0B8QNetNAq5Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsBm52HazCLZkEHJLSkx6cpsolgM46lf/4Fn9Q/G/NbvKSL7iz
	zW0qkh4OnqQ0SQFPj/Z50Fj0OocTfRAOFvCRq+M95sRMR6XeU9Yjt7vMr/yNcXw380r6KltUgHi
	WjhNkpUk6MoK5Qxfns5huWe6jtd5VY3FrCeTg/cUnRmtSgxc0uyQYv2olMis=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f012:b0:68e:6182:3eb2 with SMTP id
 006d021491bc7-68e61823f5bmr3226406eaf.47.1776085175703; Mon, 13 Apr 2026
 05:59:35 -0700 (PDT)
Date: Mon, 13 Apr 2026 05:59:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dce8b7.a00a0220.468cb.0047.GAE@google.com>
Subject: [syzbot] [serial?] KCSAN: data-race in serial8250_do_startup /
 serial8250_modem_status (4)
From: syzbot <syzbot+a12081a388b863499373@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c6c4ed80b87 Merge tag 'vfs-7.0-rc8.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11711106580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a78dd265deac3a9
dashboard link: https://syzkaller.appspot.com/bug?extid=a12081a388b863499373
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/952ebc34a0d7/disk-7c6c4ed8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d3c6b295fa45/vmlinux-7c6c4ed8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6cbdb6b4817a/bzImage-7c6c4ed8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a12081a388b863499373@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in serial8250_do_startup / serial8250_modem_status

write to 0xffffffff893ff4c6 of 1 bytes by task 7024 on cpu 1:
 serial8250_do_startup+0x1628/0x1d50 drivers/tty/serial/8250/8250_port.c:2334
 serial8250_startup+0x41/0x50 drivers/tty/serial/8250/8250_port.c:2354
 uart_port_startup drivers/tty/serial/serial_core.c:321 [inline]
 uart_startup+0x464/0xae0 drivers/tty/serial/serial_core.c:365
 uart_port_activate+0x67/0xc0 drivers/tty/serial/serial_core.c:1949
 tty_port_open+0x196/0x270 drivers/tty/tty_port.c:747
 uart_open+0x30/0x40 drivers/tty/serial/serial_core.c:1929
 tty_open+0x3d4/0xaf0 drivers/tty/tty_io.c:2137
 chrdev_open+0x2eb/0x3a0 fs/char_dev.c:411
 do_dentry_open+0x4ca/0xa90 fs/open.c:949
 vfs_open+0x37/0x1e0 fs/open.c:1081
 do_open fs/namei.c:4677 [inline]
 path_openat+0x1b70/0x2050 fs/namei.c:4836
 do_file_open+0x16c/0x290 fs/namei.c:4865
 do_sys_openat2+0x94/0x130 fs/open.c:1366
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0xf2/0x120 fs/open.c:1383
 x64_sys_call+0x1e39/0x3020 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffffffff893ff4c6 of 1 bytes by interrupt on cpu 0:
 serial8250_modem_status+0x6a/0x1e0 drivers/tty/serial/8250/8250_port.c:1742
 serial8250_handle_irq_locked+0x331/0x420 drivers/tty/serial/8250/8250_port.c:1822
 serial8250_handle_irq+0xad/0x280 drivers/tty/serial/8250/8250_port.c:1841
 serial8250_default_handle_irq+0x8e/0x170 drivers/tty/serial/8250/8250_port.c:1855
 serial8250_interrupt+0x63/0x130 drivers/tty/serial/8250/8250_core.c:86
 __handle_irq_event_percpu+0x9c/0x4d0 kernel/irq/handle.c:209
 handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
 handle_irq_event+0x64/0xf0 kernel/irq/handle.c:263
 handle_edge_irq+0x154/0x470 kernel/irq/chip.c:855
 generic_handle_irq_desc include/linux/irqdesc.h:186 [inline]
 handle_irq arch/x86/kernel/irq.c:262 [inline]
 call_irq_handler arch/x86/kernel/irq.c:-1 [inline]
 __common_interrupt+0x60/0xb0 arch/x86/kernel/irq.c:333
 common_interrupt+0x7e/0x90 arch/x86/kernel/irq.c:326
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:688
 __skb_datagram_iter+0x194/0x680 net/core/datagram.c:415
 skb_copy_datagram_iter+0x3f/0x120 net/core/datagram.c:535
 skb_copy_datagram_msg include/linux/skbuff.h:4218 [inline]
 __unix_dgram_recvmsg+0x4b0/0x870 net/unix/af_unix.c:2615
 unix_dgram_recvmsg+0x81/0x90 net/unix/af_unix.c:2672
 sock_recvmsg_nosec+0xc2/0xf0 net/socket.c:1078
 ____sys_recvmsg+0x26f/0x280 net/socket.c:2810
 ___sys_recvmsg+0x11f/0x3b0 net/socket.c:2854
 do_recvmmsg+0x1ef/0x560 net/socket.c:2949
 __sys_recvmmsg net/socket.c:3023 [inline]
 __do_sys_recvmmsg net/socket.c:3046 [inline]
 __se_sys_recvmmsg net/socket.c:3039 [inline]
 __x64_sys_recvmmsg+0xe5/0x170 net/socket.c:3039
 x64_sys_call+0x80f/0x3020 arch/x86/include/generated/asm/syscalls_64.h:300
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0x05

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 6993 Comm: syz.3.814 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
==================================================================
EXT4-fs (loop7): error count since last fsck: 1
EXT4-fs (loop7): initial error at time 1775890841: ext4_free_branches:1023: inode 11
EXT4-fs (loop7): last error at time 1775890841: ext4_free_branches:1023: inode 11


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
