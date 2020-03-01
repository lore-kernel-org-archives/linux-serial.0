Return-Path: <SRS0=+ol5=4S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC367C3F2CD
	for <linux-serial@archiver.kernel.org>; Sun,  1 Mar 2020 01:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FC924649
	for <linux-serial@archiver.kernel.org>; Sun,  1 Mar 2020 01:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCABpM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Feb 2020 20:45:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:54062 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgCABpL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Feb 2020 20:45:11 -0500
Received: by mail-il1-f200.google.com with SMTP id t11so7346137ill.20
        for <linux-serial@vger.kernel.org>; Sat, 29 Feb 2020 17:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pHhCTce9EZRh6yMt1LKQF/1Li19vVI0eOId6Q1UjB0g=;
        b=JbB2UJUZeGchxoJHcEgluLLxSIfjx04ytOBXVcDQD+frlNEmaB/ni6K7rNrqJeXfsO
         8iC/30BzlSkQlfIWPT2qa3fF30xn/kyXvR2Tga4hmnG/ZO3MOrZGmGo3UNAfpcTwlo3E
         AfneadF5hZgqft96HMBBQ8vf9oyaS+ljdBA3IUuXfosAea61vt9+IJVk5fco0sWCUuqT
         nVAhCHIeIY8I7xZvc/V0LZMZcda3yEPQq6L2kgv60VXcyPec7/Rzv1kgAn81jZltvd4X
         5Znga6AOwFfbz3WnxFlTc3Cunp4+CxSbpx2P486T3mV2J9q+0sHLQmbYHjD41PXeGvEC
         DdBA==
X-Gm-Message-State: APjAAAWdv2AKNg/JMn+3MCZOsovuXoZ4QKDdQ3PoMjsKDtx9Z+DkmiGq
        snpcJqIoxVZg6A95imT8ZyQ5hlAzno1q3ZcpmXCRng1Oa3wd
X-Google-Smtp-Source: APXvYqztGXptYaZPKRKIiQ4IqcFK2tvyq0LRUkl4LpHbJ5KjeCQe0bVqM9NJPy/8a+772bOFQTRuAwvnmpZm8XDDvxyJEQCnrs0N
MIME-Version: 1.0
X-Received: by 2002:a5d:8952:: with SMTP id b18mr8705743iot.40.1583027111085;
 Sat, 29 Feb 2020 17:45:11 -0800 (PST)
Date:   Sat, 29 Feb 2020 17:45:11 -0800
In-Reply-To: <000000000000072c55059aa2033b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a04b93059fc13804@google.com>
Subject: Re: possible deadlock in uart_write
From:   syzbot <syzbot+b0e376d3731cd5e82bb7@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f8788d86 Linux 5.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1342fd29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
dashboard link: https://syzkaller.appspot.com/bug?extid=b0e376d3731cd5e82bb7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1587ee65e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11993d31e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b0e376d3731cd5e82bb7@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
5.6.0-rc3-syzkaller #0 Not tainted
--------------------------------------------
swapper/1/0 is trying to acquire lock:
ffffffff8c353e10 (&port_lock_key){-.-.}, at: uart_write+0x1e1/0x6f0 drivers/tty/serial/serial_core.c:592

but task is already holding lock:
ffffffff8c353e10 (&port_lock_key){-.-.}, at: serial8250_handle_irq.part.0+0x24/0x2b0 drivers/tty/serial/8250/8250_port.c:1822

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&port_lock_key);
  lock(&port_lock_key);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by swapper/1/0:
 #0: ffff88809835ec30 (&(&i->lock)->rlock){-.-.}, at: spin_lock include/linux/spinlock.h:338 [inline]
 #0: ffff88809835ec30 (&(&i->lock)->rlock){-.-.}, at: serial8250_interrupt+0x2d/0x1a0 drivers/tty/serial/8250/8250_core.c:116
 #1: ffffffff8c353e10 (&port_lock_key){-.-.}, at: serial8250_handle_irq.part.0+0x24/0x2b0 drivers/tty/serial/8250/8250_port.c:1822
 #2: ffff8880a6ea6090 (&tty->ldisc_sem){++++}, at: tty_ldisc_ref+0x22/0x90 drivers/tty/tty_ldisc.c:288

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_deadlock_bug kernel/locking/lockdep.c:2370 [inline]
 check_deadlock kernel/locking/lockdep.c:2411 [inline]
 validate_chain kernel/locking/lockdep.c:2954 [inline]
 __lock_acquire.cold+0x15d/0x385 kernel/locking/lockdep.c:3954
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x95/0xcd kernel/locking/spinlock.c:159
 uart_write+0x1e1/0x6f0 drivers/tty/serial/serial_core.c:592
 n_hdlc_send_frames+0x29a/0x480 drivers/tty/n_hdlc.c:401
 n_hdlc_tty_wakeup+0xc0/0xe0 drivers/tty/n_hdlc.c:477
 tty_wakeup+0xe9/0x120 drivers/tty/tty_io.c:536
 tty_port_default_wakeup+0x2b/0x40 drivers/tty/tty_port.c:50
 tty_port_tty_wakeup+0x57/0x70 drivers/tty/tty_port.c:388
 uart_write_wakeup+0x46/0x70 drivers/tty/serial/serial_core.c:104
 serial8250_tx_chars+0x495/0xaf0 drivers/tty/serial/8250/8250_port.c:1760
 serial8250_handle_irq.part.0+0x261/0x2b0 drivers/tty/serial/8250/8250_port.c:1833
 serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1819 [inline]
 serial8250_default_handle_irq+0xc0/0x150 drivers/tty/serial/8250/8250_port.c:1849
 serial8250_interrupt+0xf1/0x1a0 drivers/tty/serial/8250/8250_core.c:126
 __handle_irq_event_percpu+0x15d/0x970 kernel/irq/handle.c:149
 handle_irq_event_percpu+0x74/0x160 kernel/irq/handle.c:189
 handle_irq_event+0xa7/0x134 kernel/irq/handle.c:206
 handle_edge_irq+0x25e/0x8d0 kernel/irq/chip.c:830
 generic_handle_irq_desc include/linux/irqdesc.h:156 [inline]
 do_IRQ+0xde/0x280 arch/x86/kernel/irq.c:250
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:607
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: c8 c3 c3 f9 eb 8a cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 94 14 58 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 84 14 58 00 fb f4 <c3> cc 55 48 89 e5 41 57 41 56 41 55 41 54 53 e8 5e 83 72 f9 e8 29
RSP: 0018:ffffc90000d3fd68 EFLAGS: 00000286 ORIG_RAX: ffffffffffffffda
RAX: 1ffffffff1367622 RBX: ffff8880a99fc340 RCX: 0000000000000000
RDX: dffffc0000000000 RSI: 0000000000000006 RDI: ffff8880a99fcbd4
RBP: ffffc90000d3fd98 R08: ffff8880a99fc340 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffff8aa5b3c0 R14: 0000000000000000 R15: 0000000000000001
 arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:686
 default_idle_call+0x84/0xb0 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x3c8/0x6e0 kernel/sched/idle.c:269
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:361
 start_secondary+0x2f4/0x410 arch/x86/kernel/smpboot.c:264
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

