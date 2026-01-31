Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E216DEB0
	for <linux-serial@vger.kernel.org>; Sat, 31 Jan 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769871450; cv=none; b=hBpp13ZUe4CZZBQf7UR/Mtsfb1h7Jb7x2Uag9p4poU9CbK2hQeXGdQzTFNS7reqRnqQBlEUCuyybhQ7yIAefZP8Xmp2nQ+7ySmrW1o1yLHZY5C+nxo3X5k+nYqiqqTxtN/14Ibzb47Mayuj05QVjPv6HPtUfCi+CB7nhTuzyw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769871450; c=relaxed/simple;
	bh=dNarCsmxRopTRVGxfo/mOod5Tdjk0kHQiMyA/n7EDL0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F2vH5SPNOsoVXf7s+igXZ03jWDhir0m2M6Bmzu9xmiLDH/7119Tc30lkEQUByq+JnoL2hAyREOTEekBKo4Y4TNfQiRyMByVCQsH+Zpk0MilWCALAPqzRmUfn+YVmAkQqZzKIMHPWOlVNjomDtXMnLuL60cMp4zP3u4CZjHI87gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-4042e22be4bso9882947fac.1
        for <linux-serial@vger.kernel.org>; Sat, 31 Jan 2026 06:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769871448; x=1770476248;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0R3MvPUMn/R7hSOaimE/agS4+r2TfsLL4Ghh5ivieU=;
        b=b7OsnE4An4Q84k1uSBJwqIw5JsMVDl9BanqMwBPQOLctlDPrTHFVsG2gqLHIq2RURt
         3209yHm9NXvy8xVtzSjv4Gw+tZ96KUugMsvyuHbn7CYrxfunegngBzZZ5twZouTIdXnC
         4TkvsnrpNGTeyX7uWLlPinODGz9CWJe3s+afzYAvoQ7IM1xAjY00JziSOQUbuT3jK1K7
         Nk4dIk3P+Fw7KpHUdoGArOIMLWS2yq/XTqg3oct4b7mv9SOfuC7BFwEvo42xMH4hXY3c
         9ntPvZmo3B1eWtL0Dm6XNR7j0//hcD6hcvxO1Y3L8F8ALofa/hxbfUJN44kr0X1YnRXL
         Y2Dg==
X-Forwarded-Encrypted: i=1; AJvYcCV9cnYbg5NWdmP4tXGg45BTWs32Ebyct4UazoJCJdbaqnL2B0VQsRvXSjcA/llxsb34MZF74IBFVQTMuTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytHRLV1zvvDsWvz/siUv/GLUM5t6iMZBCf2loimM3sXa6U5cW9
	j5+gf+pBfLBpPyvXFyoraCcWRx74kdz9z2J/xSyGomC1wuywgZAn5MbAaezib5Q4I9FjPWtsoFY
	qJGrJ/ZS6zm1wX9QBkqqyDQtZzov/sZORVn6UYW6dZx+/9mcBH8dNxL7A41w=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c83:b0:65f:67b7:95bb with SMTP id
 006d021491bc7-6630f0338b9mr3033370eaf.18.1769871448009; Sat, 31 Jan 2026
 06:57:28 -0800 (PST)
Date: Sat, 31 Jan 2026 06:57:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697e1857.050a0220.1d0a41.0009.GAE@google.com>
Subject: [syzbot] [serial?] general protection fault in k_meta
From: syzbot <syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f938c7d3b25 Add linux-next specific files for 20260127
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1503b1b2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d51c584a7396ddf1
dashboard link: https://syzkaller.appspot.com/bug?extid=03f79366754268a0f20c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc0457d4d9f3/disk-4f938c7d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c54b095e6488/vmlinux-4f938c7d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5c734206eb97/bzImage-4f938c7d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000038: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000001c0-0x00000000000001c7]
CPU: 0 UID: 0 PID: 14584 Comm: syz.4.2379 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/13/2026
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 2e f3 37 00 85 ed 0f 85 ef 0c 00 00 e8 e1 ee 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc9001ac9f4b8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: 0000000000080000
RDX: ffffc9000c3c2000 RSI: 00000000000007c1 RDI: 00000000000007c2
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fded38f66c0(0000) GS:ffff8881252af000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000015a000 CR3: 0000000077524000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2405
 put_queue drivers/tty/vt/keyboard.c:328 [inline]
 k_meta+0x3e7/0x7f0 drivers/tty/vt/keyboard.c:884
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
RIP: 0033:0x7fded299aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fded38f6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fded2c15fa0 RCX: 00007fded299aeb9
RDX: 0000000000002250 RSI: 0000200000000040 RDI: 0000000000000004
RBP: 00007fded2a08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fded2c16038 R14: 00007fded2c15fa0 R15: 00007ffff85354c8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__queue_work+0xa2/0xf90 kernel/workqueue.c:2269
Code: 11 31 ff 89 ee e8 2e f3 37 00 85 ed 0f 85 ef 0c 00 00 e8 e1 ee 37 00 4d 8d b7 c0 01 00 00 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 0f b6 04 20 84 c0 0f 85 22 0d 00 00 4c 89 34 24 41 8b 2e 89 ee
RSP: 0018:ffffc9001ac9f4b8 EFLAGS: 00010002
RAX: 0000000000000038 RBX: 0000000000000008 RCX: 0000000000080000
RDX: ffffc9000c3c2000 RSI: 00000000000007c1 RDI: 00000000000007c2
RBP: 0000000000000000 R08: ffff88813ff72017 R09: 1ffff11027fee402
R10: dffffc0000000000 R11: ffffed1027fee403 R12: dffffc0000000000
R13: ffff88813ff72010 R14: 00000000000001c0 R15: 0000000000000000
FS:  00007fded38f66c0(0000) GS:ffff8881252af000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000015a000 CR3: 0000000077524000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	31 ff                	xor    %edi,%edi
   2:	89 ee                	mov    %ebp,%esi
   4:	e8 2e f3 37 00       	call   0x37f337
   9:	85 ed                	test   %ebp,%ebp
   b:	0f 85 ef 0c 00 00    	jne    0xd00
  11:	e8 e1 ee 37 00       	call   0x37eef7
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
