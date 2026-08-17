Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDAC3B893C
	for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 10:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786961802; cv=none; b=bA2T+EuVj/IsRiHgq79bVmhnlC6FshAzeb5R+PZJHSMMm5+9eTrDLDNxG2H7gR0U6Y4C7Z1MXd4Nwp+SFavzl2+66brDdMQmqMXtTmRbw27fm/CDF76pa8NQl/Lnt0PBkQiphL6Gj1hzbP6BHN8qrF6+3A/9aJ4dpegUqsNNS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786961802; c=relaxed/simple;
	bh=Hcvf3FWpNjbkwNgRS+em1xRzQ/rqe1AxjWPXQtdAGuA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mlqCR2AYEqwfEeCDEZ9OUa1zMBiYVniM8WoP8vVIziuXKIoFJYopsNYBT2ELqPOj2FWi9ug8BB/6/WMDqJ+GtwxowLZuyAiQFUUULGFo/aLCeEK8clGDrOKszh1Pg1VM+cUhBRbxL0Zc1XlbqLYD7KKo7i97PxscgqgFpFttSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-451acf33124so3836574fac.0
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 03:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786961799; x=1787566599;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GM9xfGwyIPgt1wWIFKGpJmU7MPcuS8QGqqRHGCaSVIY=;
        b=jsryQfQ/IzZKkRwJOtqz7VcaLkUWinE7q5UW4gEtDY+ulje38z9D37JyuG2sdjqHmF
         nXRdtsqG7yhsTwHhwq88oagk6Mp3wRb8lmWbZj0nIYq1WfMsmOJou9WsaoY076tSGtI1
         4zsGRKvCRYo1rHycfp/wPBghJEseKdteMTRro3zi7CJVqDKnr1PWQQRkfbdHllwF4Hj0
         bHizKt7/pGm3ASNBTtGURaDadS1D98vRNE0J+5aSUCxcf/nPHQqENKJuGZkADmUndh52
         jRA09iJ5n77q3+B1dX0FBk0wXPbwdQXm+HsEnfsKhTuSsNF8AzO9d9rKR+I6MuBwLoKb
         +q0g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6iS7pqwnXKiZN2PIJwDsGaeT3Nw4kXLeXHSFc9uWENCT5oyV754WunNwffoptH0FZKiQyH4Q+Lp3R+qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7NZwi7UdPTXJUG/CtJFmRxI2vrgQ5PdXU6Eq9IwBCHk+U9m0
	qPHtzr4rXZIjaENwm4F1dq/bI/O64EzEKMXvUp/RbmXG0iqE87AGBwCNJWxUbcEjrQMTatKk1Vh
	TSSaj5ObO9WSOnXr9vJiiIQhcATRQPtJOUWoJkNvF+ssDTf0rGdh3qmNanK8=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b8e:b0:6ae:85c5:cccd with SMTP id
 006d021491bc7-6b0d5fd8c29mr22683971eaf.4.1786961799472; Mon, 17 Aug 2026
 03:16:39 -0700 (PDT)
Date: Mon, 17 Aug 2026 03:16:39 -0700
In-Reply-To: <6a695959.d9e86bb5.297b12.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a82df87.dbb3a75c.20434b.0051.GAE@google.com>
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Read in serial_core_unregister_port
From: syzbot <syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17401a25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f9d6c6580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 2 UID: 0 PID: 6063 Comm: syz-executor410 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:serial_core_get_ctrl_dev drivers/tty/serial/serial_core.c:3236 [inline]
RIP: 0010:serial_core_unregister_port+0xec/0x960 drivers/tty/serial/serial_core.c:3345
Code: 3c 02 00 0f 85 23 08 00 00 48 8b 83 98 01 00 00 48 8d 78 40 48 89 44 24 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ee 07 00 00 48 8b 44 24 08 48 8d bb d8 00 00 00
RSP: 0018:ffffc90003657a20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff9bc06240 RCX: fffff520006caf42
RDX: 0000000000000008 RSI: ffffffff85a28113 RDI: 0000000000000040
RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff2283e1a
R10: ffffc90003657b40 R11: 0000000000000000 R12: ffffffff8fbac9a0
R13: ffff88802857e010 R14: ffffffff9bc063d8 R15: ffffffff8fbadf68
FS:  00005555919d4400(0000) GS:ffff8880d5dde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1adba17bc0 CR3: 000000002d4a7000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 serial8250_unregister_port+0x1e4/0x8a0 drivers/tty/serial/8250/8250_core.c:883
 serial8250_remove+0x8c/0xc0 drivers/tty/serial/8250/8250_platform.c:241
 platform_remove+0x5f/0x80 drivers/base/platform.c:1456
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 unbind_store+0xf8/0x110 drivers/base/bus.c:244
 drv_attr_store+0x74/0xb0 drivers/base/bus.c:125
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1adb9f0907
Code: 48 89 fa 4c 89 df e8 88 1e 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffdfe653cc0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005555919d4400 RCX: 00007f1adb9f0907
RDX: 000000000000000a RSI: 00007f1adba3102e RDI: 0000000000000003
RBP: 000000000000001d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007f1adba33330
R13: 00007f1adba3102e R14: 00007f1adba5d580 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:serial_core_get_ctrl_dev drivers/tty/serial/serial_core.c:3236 [inline]
RIP: 0010:serial_core_unregister_port+0xec/0x960 drivers/tty/serial/serial_core.c:3345
Code: 3c 02 00 0f 85 23 08 00 00 48 8b 83 98 01 00 00 48 8d 78 40 48 89 44 24 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ee 07 00 00 48 8b 44 24 08 48 8d bb d8 00 00 00
RSP: 0018:ffffc90003657a20 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff9bc06240 RCX: fffff520006caf42
RDX: 0000000000000008 RSI: ffffffff85a28113 RDI: 0000000000000040
RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff2283e1a
R10: ffffc90003657b40 R11: 0000000000000000 R12: ffffffff8fbac9a0
R13: ffff88802857e010 R14: ffffffff9bc063d8 R15: ffffffff8fbadf68
FS:  00005555919d4400(0000) GS:ffff8880d5dde000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1adba17bc0 CR3: 000000002d4a7000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	3c 02                	cmp    $0x2,%al
   2:	00 0f                	add    %cl,(%rdi)
   4:	85 23                	test   %esp,(%rbx)
   6:	08 00                	or     %al,(%rax)
   8:	00 48 8b             	add    %cl,-0x75(%rax)
   b:	83 98 01 00 00 48 8d 	sbbl   $0xffffff8d,0x48000001(%rax)
  12:	78 40                	js     0x54
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 ee 07 00 00    	jne    0x822
  34:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  39:	48 8d bb d8 00 00 00 	lea    0xd8(%rbx),%rdi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
