Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047A158858
	for <linux-serial@vger.kernel.org>; Sat, 18 Jan 2025 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737227547; cv=none; b=tYGAtKBbtJS3qVciCl+hdf2zzrv6gs2l4YAGclERVwneXk5MOjGSMTg5t1p2NH+Zd405obVLuOCWWl3mu+RZwVlN2MmjBOTidf1saDaiPFBazCsSOm5gOP5KcvjKyree2Rw3hRae4Ez3m4PNLnBqP+VrlVTdXsB/kaXBlcZh204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737227547; c=relaxed/simple;
	bh=gG99gZaQXG/kLA3RvkedizakgTIv1ZLVSDlaRFK4dSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=abjmv6s2cuG+p5EUrQ3XFKNC0rXErHuzKq5tfdFiMW6muAtP55n8F0FxSk3AK0XsE3rDC1LSg9omIOJE+Vu2KR3I6Vtwn0DewiXXeeO8APVCFLRrvoTcKQBwYNzgibyEqpynqJbU9E5/RQ1WfuQEjJvLsdc1bz3Qb/Y2k6RmtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so22825725ab.0
        for <linux-serial@vger.kernel.org>; Sat, 18 Jan 2025 11:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737227545; x=1737832345;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+F1THzvi/8kv3aSor1pEUmloSqlF3QO7d/CbZRP7bo=;
        b=iVyM0JdI3A+u1lLBlOjC/ejx8FUbNmYyGzixQAT/UQLRYls2yJguih3IM7Er9tCZi6
         cpBDyC4L2GM+MMapW+T541C6Wo1QQC32sIHWwP42n7wGpHi2i0zitsBu1iijEgq2x5Fh
         VsNYGx3zdE1xt9RBuC2YayIY2SaZCfbkS7KyKxE5bBaDqyiN7OapqNaaAugWlho/NubD
         KaCnnM3tnulqYDrQ61gdS43t7bg+L/GPnmdWlD1zr+R1NwXomYstFYNofXEiP2kaGHIf
         rM8nJaecvgZxVTcei+dzd809O61mHScBmYkLV0k9Yx9QFNsF5BhLVegVHdUiG84WDhtY
         QmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+D6YGGlc4VGCsyUeblQpeewOXkgE7VHwd2a6bK10G1OzDAQqqmZbOuQInE21dyRaeT6ea6zXjyEAfbBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvzVBfJ22IBtlTdLvvJXYnYG1k+dNyDb01gqT5Azf7syg6SywJ
	npQ2yYnRqqM6Xgs/qCPvTGICFsZwwSMhzZxeK2ZaHq+YeM1ug5q8mV6v5jd70+Qn06Gehv5Ih/8
	6bXabTOmCD/IoVs4rWlQz8zXA1sGSvaxCVwCOGmiIxH7aO75d03gaGZw=
X-Google-Smtp-Source: AGHT+IGfNASJF4M5RYdDWnmueist9YzKccjqqqx7kgLayRikYOsq6YDctUMPJofRk6CkFL0JN2Y/fXxZwSdUZ62oDwiuert/fKil
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219e:b0:3cf:6463:41fc with SMTP id
 e9e14a558f8ab-3cf74487c3bmr57345115ab.17.1737227545076; Sat, 18 Jan 2025
 11:12:25 -0800 (PST)
Date: Sat, 18 Jan 2025 11:12:25 -0800
In-Reply-To: <0000000000004228140621a87013@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678bfd19.050a0220.303755.0030.GAE@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in tty_buffer_flush (3)
From: syzbot <syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    595523945be0 Merge tag 'devicetree-fixes-for-6.13-2' of gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=124d7a18580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164091f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17903fc4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f7863c08b5c/disk-59552394.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/06971b2686d0/vmlinux-59552394.xz
kernel image: https://storage.googleapis.com/syzbot-assets/66c751022d90/bzImage-59552394.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc7-syzkaller-00189-g595523945be0 #0 Not tainted
------------------------------------------------------
kworker/1:4/5864 is trying to acquire lock:
ffff88801b0990b8 (&buf->lock){+.+.}-{4:4}, at: tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229

but task is already holding lock:
ffffffff8e1a9040 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x13/0x310 drivers/tty/vt/vt_ioctl.c:983

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (console_lock){+.+.}-{0:0}:
       console_lock+0x7a/0xa0 kernel/printk/printk.c:2833
       con_flush_chars+0x5e/0x80 drivers/tty/vt/vt.c:3503
       __receive_buf drivers/tty/n_tty.c:1644 [inline]
       n_tty_receive_buf_common+0xa99/0x1980 drivers/tty/n_tty.c:1739
       tty_ldisc_receive_buf+0xa2/0x190 drivers/tty/tty_buffer.c:387
       tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
       receive_buf drivers/tty/tty_buffer.c:445 [inline]
       flush_to_ldisc+0x264/0x780 drivers/tty/tty_buffer.c:495
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3317 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #1 (&tty->termios_rwsem){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       n_tty_receive_buf_common+0x85/0x1980 drivers/tty/n_tty.c:1702
       tty_ldisc_receive_buf+0xa2/0x190 drivers/tty/tty_buffer.c:387
       tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
       receive_buf drivers/tty/tty_buffer.c:445 [inline]
       flush_to_ldisc+0x264/0x780 drivers/tty/tty_buffer.c:495
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3317 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&buf->lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229
       tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
       __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
       vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3317 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &buf->lock --> &tty->termios_rwsem --> console_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               lock(&tty->termios_rwsem);
                               lock(console_lock);
  lock(&buf->lock);

 *** DEADLOCK ***

4 locks held by kworker/1:4/5864:
 #0: ffff88801b078948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3211
 #1: ffffc90004a9fd80 ((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3212
 #2: ffffffff8e1a9040 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x13/0x310 drivers/tty/vt/vt_ioctl.c:983
 #3: ffff8880698950a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:263 [inline]
 #3: ffff8880698950a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_flush+0x1c/0xe0 drivers/tty/tty_ldisc.c:386

stack backtrace:
CPU: 1 UID: 0 PID: 5864 Comm: kworker/1:4 Not tainted 6.13.0-rc7-syzkaller-00189-g595523945be0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: events vc_SAK
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
 tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229
 tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
 __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
 vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
tty tty1: SAK: killed process 5889 (syz-executor496): by fd#4
usb 2-1: USB disconnect, device number 3
usb 2-1: new high-speed USB device number 4 using dummy_hcd
usb 2-1: config 0 interface 0 altsetting 0 endpoint 0x81 has an invalid bInterval 0, changing to 7
usb 2-1: New USB device found, idVendor=0926, idProduct=3333, bcdDevice= 0.40
usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 2-1: config 0 descriptor??
keytouch 0003:0926:3333.000F: fixing up Keytouch IEC report descriptor
input: HID 0926:3333 as /devices/platform/dummy_hcd.1/usb2/2-1/2-1:0.0/0003:0926:3333.000F/input/input19
keytouch 0003:0926:3333.000F: input,hidraw2: USB HID v0.00 Keyboard [HID 0926:3333] on usb-dummy_hcd.1-1/input0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
