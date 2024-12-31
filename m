Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE2170A11
	for <linux-serial@vger.kernel.org>; Tue, 31 Dec 2024 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735684471; cv=none; b=U+VjLdOGHZwN6gUWJ3O/ApfmfX9SbdUOKXxPyMLfTtjsPN+P3jtRbBrrGxzKKNdNuZnkd/YtZQ8iwzItRGtmDHLNy8a7QJMWga+QmUB5ORtjqTYyyJCfRHOraAMDat0HtmEItPikdhrvTNNKG02gmeAzPy7VlADCubijmhTneJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735684471; c=relaxed/simple;
	bh=ei9xXaRr5RkhTyFdXtKqKJ9SKj6iI6+1yunmKEHBLKs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PE4DagD9CFvih4aFt8sfNfn7IklY3pISFm+yw3hid7buVHFFNAQJymR6hp06FdK5cxIdTc1e1mu4eKIHPNxEhwSZj4Tup/XCtGhhrXb62ivC0akHgSVJdP34RpepQnPJpRXSGqO7wSVwwqLF9G9FkLj5jGfq08tvLcCPzMWlWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844ec271431so827334039f.1
        for <linux-serial@vger.kernel.org>; Tue, 31 Dec 2024 14:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735684469; x=1736289269;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5NiYMTOlyzQSxiU/meqHd8T4ZA/yi4RKOdqy0lI988=;
        b=E8eLKjppNriPKQwr+qiyrQ9/f2Ou6EdczaaA7XCZXQy4QUN5ddAFlLxCRyR17mPQ5n
         0OtyeYbxsIeDFngOeX6fHZY1IreDEfxQjZqfcZnTKIhEK3tAPJmAlzzHqlyZXlrsM+hr
         07jd8vO4SHJU03oKdOa3btwWsZ7E3/6NAYnQyNzm54ZY9BQmy/hJ0t2QedJJl4QTKjo8
         3DMwgceTRl+8+zn7EP8+Zq1HS0VuR8NBDCgJB8n4RkrpnZOZI4UYZiDy20ExEiA30Wxg
         GDGRk/A23+N9hfblpaU44jmMlHOZGoe4oM/Hn0mFstbmVCp/Ou+FyOuw3juWePJ1hKFv
         kCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUnHrW8fqtjAeMTTXSLdA7YZkS+BspT1ak3YHF2z5qiWgI7X5FaB0Afe+jI1n5aMDV1Y1q7+/bZZvRWGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBJgwpR1Gqy8sKcHRi6ZuftHWjHYw65H4A6OUHM9mh0u5DpP8P
	n3elIrjsfKwLDzJBQS5WkGJTGKeC2K877vCN43+8hMn8AJYbYKlei0MBc/MbaU0wGjf5OizsHBw
	XSJh2nVa4xJBnk0uM5So5NsryOJVu+8XTcS87tHeROeRfZSMu4Xl2ySY=
X-Google-Smtp-Source: AGHT+IER7/a2+B/Db8o8N1Mc5ETy4VvXXHurC5Xd8J7gx96xKKDmRoalACm3p8LaUbCMIfYx+/r+V9j5HVGsSn1Vptx7H8+ZBvOz
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3891:b0:3a8:1195:f216 with SMTP id
 e9e14a558f8ab-3c2d25770a4mr337301155ab.10.1735684468801; Tue, 31 Dec 2024
 14:34:28 -0800 (PST)
Date: Tue, 31 Dec 2024 14:34:28 -0800
In-Reply-To: <0000000000004228140621a87013@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67747174.050a0220.25abdd.0954.GAE@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in tty_buffer_flush (3)
From: syzbot <syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11615818580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc863cc90857c683
dashboard link: https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b9c8b0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/409ce1fd1fbc/disk-ccb98cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3919529a8a5e/vmlinux-ccb98cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6a9eb51806d/bzImage-ccb98cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com

input: HID 0926:3333 as /devices/platform/dummy_hcd.0/usb1/1-1/1-1:0.0/0003:0926:3333.0001/input/input5
keytouch 0003:0926:3333.0001: input,hidraw0: USB HID v0.00 Keyboard [HID 0926:3333] on usb-dummy_hcd.0-1/input0
======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0 Not tainted
------------------------------------------------------
kworker/1:3/6008 is trying to acquire lock:
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
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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

4 locks held by kworker/1:3/6008:
 #0: ffff88801b078948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90003cafd80 ((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8e1a9040 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x13/0x310 drivers/tty/vt/vt_ioctl.c:983
 #3: ffff8880798a40a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:263 [inline]
 #3: ffff8880798a40a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_flush+0x1c/0xe0 drivers/tty/tty_ldisc.c:386

stack backtrace:
CPU: 1 UID: 0 PID: 6008 Comm: kworker/1:3 Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
tty tty1: SAK: killed process 6013 (syz.0.16): by fd#3


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
