Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29D3093D8
	for <linux-serial@vger.kernel.org>; Thu,  6 Aug 2026 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991648; cv=none; b=Dk56L9bJk7IXMLeaX1DQlqrTiV6timYgnWjDMNwzaGsQP3cXcTCXWU8n7TIrkJc21YQSTDHkaWaJo40twLrPjDcQOteVIW6+jy7VrAk5ilHyMyjdh13iCPZAMzwraizDmiumx5mMCfOdFRvIGWjiHTXpkSd8mvUWIxIlKZ7PjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991648; c=relaxed/simple;
	bh=fGVINHHgl4sPcGBemjH4XHr0VHl2Q9QmK3pENdeKnOQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SmkmTpvKasCkuyEAdbEeWrGsKK7g3LB4scLwXCAbvKhA+cTq3I3RFuvakDcYQvAKAbSCVLOSqAXH6nsFOEoty0vsjYYy3jHjBy/ECbV37PadT/0HXJNmq8JNFcKH33LDWuu8tpZVbXzRW1eOFgdIcpOPPyOhRc4UqWU1fYIgF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4afa222912eso1043917b6e.2
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 21:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785991645; x=1786596445;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WlRcwDRvn7qQIjNUu3Q6RGqwDzBI81vHs+MEncx6g3E=;
        b=OOfpXvR89RIhVWKWtHXZ0zZkzZlk/4kaCbZWZYnpmHytascT814WIDq9fz12p3Wee8
         wRc+mnCrJmGDF5PUEsjWZl/IM4Bc2THzckBfrHvSBO4XCQMzTQHPQeF6NGPrSCA/BGry
         QCXAZpJ8mzGYZzu68Vdp8bzj6kt//sufRp7EVeMFWuMXkWrUlmKYMjEBLd8PERUxVG7R
         Z7s3uCeUjrmVUtN3dJ69KOEvEtWP7TtRw3X9gSkdR1UXOqgSr+CBHy2ps3d7x6EEGo2R
         9qtQ+OAiElawwjC4a1x6ou0wux25DEmkQYIL4tHo3M1EMVpnCRMyId4PRNaOu8G0wPBp
         dk9Q==
X-Forwarded-Encrypted: i=1; AHgh+RopJEfwIWwoGo2ntEVXVe98b3smzB7X0+tiKlXjVSn0MEiTtYx0JvQV5MTLtBBnUNSTW1MPN/bipF7wB3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ5ep0I5rxssAn1P4dNyM+Gop64HQwVokxG0VbOxOyyCPbfwX6
	/Z8UPK+RXfxIM8QyI5hmmrpElmk6uQmUjxXX3+a25yr9nuz65QEwA539CUsIQcX4QDqpUrP4GWz
	Dl14BZ2Nf8+dpdNQWUqi7fS4azyk+ImhW6vEo/AG+RA+qvg/n52RwE8MSToU=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:83c1:20b0:6ae:a950:9fb8 with SMTP id
 006d021491bc7-6aea950a187mr2121319eaf.23.1785991645487; Wed, 05 Aug 2026
 21:47:25 -0700 (PDT)
Date: Wed, 05 Aug 2026 21:47:25 -0700
In-Reply-To: <6a7159d5.9511d2ce.1fc5b9.0333.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7411dd.9c11d2ce.289b96.0094.GAE@google.com>
Subject: Re: [syzbot] [serial?] WARNING in register_console
From: syzbot <syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    0d8395707651 Merge tag 'soc-fixes-7.2-2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10883c99580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=1ebbc20f223b99446034
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b1bbb9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14b35ca281d5/disk-0d839570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68c2ac2fdce0/vmlinux-0d839570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/29bdd737b48f/bzImage-0d839570.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cce97dbb2265/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=11da8e49580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ebbc20f223b99446034@syzkaller.appspotmail.com

printk: legacy console [ttyS0] enabled
------------[ cut here ]------------
IS_ERR(kt)
WARNING: kernel/printk/printk.c:3728 at legacy_kthread_create kernel/printk/printk.c:3728 [inline], CPU#0: syz.4.49/6392
WARNING: kernel/printk/printk.c:3728 at printk_kthreads_check_locked+0x2a7/0x3f0 kernel/printk/printk.c:3802, CPU#0: syz.4.49/6392
Modules linked in:
CPU: 0 UID: 0 PID: 6392 Comm: syz.4.49 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:legacy_kthread_create kernel/printk/printk.c:3728 [inline]
RIP: 0010:printk_kthreads_check_locked+0x2a7/0x3f0 kernel/printk/printk.c:3802
Code: fe c1 38 c1 7c 9a 4c 89 f7 e8 c5 85 8a 00 eb 90 e8 7e 12 21 00 eb 05 e8 77 12 21 00 b0 01 88 05 2f a4 08 18 e9 e2 00 00 00 90 <0f> 0b 90 48 c7 c7 80 bd 6d 8b e8 1a 9f 82 ff 48 8b 1d 93 9e 04 18
RSP: 0018:ffffc9000509fa70 EFLAGS: 00010206
RAX: fffffffffffffffc RBX: 0000000000000001 RCX: 10959546c0351c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000509fb70 R08: ffff888032eb2daf R09: 1ffff110065d65b5
R10: dffffc0000000000 R11: ffffed10065d65b6 R12: 0000000000000000
R13: dffffc0000000000 R14: 1ffff92000a13f5c R15: dffffc0000000000
FS:  00007f7f4a99d6c0(0000) GS:ffff888125c3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd99747f000 CR3: 000000003dd70000 CR4: 00000000003526f0
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
RIP: 0033:0x7f7f4b35e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7f4a99d028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7f4b5e6090 RCX: 00007f7f4b35e0d9
RDX: 0000000000000002 RSI: 0000200000000600 RDI: 0000000000000004
RBP: 00007f7f4b3f5024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7f4b5e6128 R14: 00007f7f4b5e6090 R15: 00007ffcc0cedea8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
