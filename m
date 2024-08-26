Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BB12C473
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707520; cv=none; b=deX66QBQbNtVDEDt75fgVpgnERjkCmht+PxKW/C0iWZ5U4WblzLXolhy9NaDWAeBXAXoK4218R2GzT86u5QBMvLX2aQNhN7jSmlLHVqN943YU2STToZn0aH1KvRG4r4PMSHk+bOxL95WFkoohOHLkFmvoOHXNkIDkBxul6lqmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707520; c=relaxed/simple;
	bh=8mtJ79gJHk22ttB7Y0KlgRQsEovfZZSzqSjeR2XZQGM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VkcC4C2TeANcgSLyxtqf9SKUW/cy62jyxTk2kkL1zaiGkam2xaLXNUzrkcXKC2QSw0klIjo9DA37/ryc+UgLxcLGDpF9+WTko0H3yn2EMqZcUUOSjaaJVDPH/1ZfbnoLr/V8V3/2mVBNr2rIQkjRx+dUDwUF866FuwJVAU3ZbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=T5jtiiWM; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=A25ZxVHk; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="T5jtiiWM";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="A25ZxVHk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724707517; x=1756243517;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=8mtJ79gJHk22ttB7Y0KlgRQsEovfZZSzqSjeR2XZQGM=;
  b=T5jtiiWMnKBhIu9i7WAHo1ICLPNtxz9qwOlMJLQV6m9U2Fzt2tYDTIK9
   EneWDXqSwASIWnNlm9XDDEs3+85Su2jN4l86d+0wimZtjXdTS17/uwwve
   zpkhB/tONu+/GAPmp3WPlKuU2AB1us3Hjlj87DK3sCftvsD6NAqYUhosv
   URvMeJfAY4CFFgO/rvnn28J7MXGJFqV0RiTGjq3zOu0jQOBPJaU/OX2T4
   WgzBBiEauAS+DkcfAUBct4jCYW6XR2qe5ZZ6kIECx6aLGYQB2ACG6Le9i
   h6orRgo2X5gLnaQNzi/CcrJpnYDqkQ6yP25S/BBK2jBz0Tbj8K3Focc6j
   Q==;
X-CSE-ConnectionGUID: QzPn9teAQuSGgvXnpphVvA==
X-CSE-MsgGUID: G5BEdOisRu6v/yAJ1vQ+dg==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 26 Aug 2024 14:25:16 -0700
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8293cdb1so505102039f.2
        for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724707516; x=1725312316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAn1vNogb0P/PqvEi4Qg+yV3uiEQRVPok3oLJyDzc7g=;
        b=A25ZxVHkKJfGokYxp/ZuXBPQHwXQA0zP/YeLgB4j5vKSZUc3bYaG5WcWFqBLyUe80u
         mDupqNNVOm94aFHu92dlTyYK0q8gCvErXnu49QqxF+3LnO/GYWagR7dOjag3bcI+LxVN
         jhMmYBeCLGXenGDorDOK/9VxfPuPSfZkoqZ4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707516; x=1725312316;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAn1vNogb0P/PqvEi4Qg+yV3uiEQRVPok3oLJyDzc7g=;
        b=AC4uxQu5g6/hVvnsYsHir5S7WmIAxt7hSTMB1mfAksU16wn1g4101KGr+uBAxVHNMB
         /xfdZcpgoSKcAPUilgPg58OIILbXc44VsiIhxjo5kBR1nDtUrqF9MeITU3++vCZGEuGO
         Us9WalWW5iTi7AEnVps4qo5iOyFq0+CvXEgoBfyozSUIR4wPHDXP8SfUHPbmtEq8z1ZJ
         bDAqBihDX+A5bWHUh4Yva0LDi8Y8VIuC0GQYVKPjyCWAVCQ4hDDa5Rgg0vYo1zx4Px/D
         +YvI8V3RyyJeDMWzjqTc4xlT9WZK4Coi0ovRwfWgkkDFeS70UEiWxLiTG6vkizl1xEMN
         dORw==
X-Forwarded-Encrypted: i=1; AJvYcCXgZr14X7Zft8LxolNaHyUmFwUZo2ZM9c1csFux1o4ITslGdRUQv1qg86zXk88a1ZqSryVaNjucBuUiaOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Eqpr/gzQninPRBSPmwa46ggGCg5ajoHY5TQs1Fn4XrPrfprC
	jkkf7h5t9ORDWfM3qC7mM+7e+U32pHtOOXCoXpcQKeKwnb8fo4EJgsY1QYITAviBZCyOQKcPZHd
	pnBuzvfDvcJpkg24NxXFeESCrwuxImDwHrTxzkf1Xtqgl2l8KAG/JFDf93G70nLMzkQ3aU1I0Lk
	iAD5SzoLJON03ooVmcss2Prjrct+QNcC0f4RzmHBNUFe5YR806tz0=
X-Received: by 2002:a05:6602:6c0b:b0:803:6699:787 with SMTP id ca18e2360f4ac-82788046b86mr1560658139f.0.1724707515735;
        Mon, 26 Aug 2024 14:25:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcImS5ruhtphxTKxVtN4OAnV8oSlV9JQ+eCEnT20yuegXLo3SxM1zApz77D9CE8m/ckWzpbla5olye2jGK3i0=
X-Received: by 2002:a05:6602:6c0b:b0:803:6699:787 with SMTP id
 ca18e2360f4ac-82788046b86mr1560655539f.0.1724707515193; Mon, 26 Aug 2024
 14:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Mon, 26 Aug 2024 14:25:03 -0700
Message-ID: <CANikGpfSu2EezqpTyJgPN4DAvBFwuQbZAA6X5MvD2U7vbmh-cQ@mail.gmail.com>
Subject: BUG: possible deadlock in console_flush_all
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
A possible deadlock issue was discovered in function
`serial8250_console_write` when it attempted to acquire the lock
`up->port->lock` ( executing `uart_port_lock_irqsave(port, &flags);` )

The full report including the Syzkaller reproducer:
https://gist.github.com/TomAPU/5c1865d66f0183d1596d400df59c2919

The brief report is below:

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.10.0 #13 Not tainted
------------------------------------------------------
swapper/0/0 is trying to acquire lock:
ffffffff8db27200 (console_owner){..-.}-{0:0}, at: rcu_try_lock_acquire
include/linux/rcupdate.h:334 [inline]
ffffffff8db27200 (console_owner){..-.}-{0:0}, at:
srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
ffffffff8db27200 (console_owner){..-.}-{0:0}, at:
console_srcu_read_lock kernel/printk/printk.c:286 [inline]
ffffffff8db27200 (console_owner){..-.}-{0:0}, at:
console_flush_all+0x14d/0xfb0 kernel/printk/printk.c:2971

but task is already holding lock:
ffff888013098018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x6d3/0xce0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pool->lock){-.-.}-{2:2}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x6d3/0xce0
       queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
       queue_work include/linux/workqueue.h:621 [inline]
       rpm_suspend+0x108a/0x1950 drivers/base/power/runtime.c:662
       __pm_runtime_idle+0x12c/0x1a0 drivers/base/power/runtime.c:1104
       pm_runtime_put include/linux/pm_runtime.h:448 [inline]
       __device_attach+0x3d4/0x500 drivers/base/dd.c:1046
       bus_probe_device+0x1b1/0x290 drivers/base/bus.c:532
       device_add+0x91d/0xd00 drivers/base/core.c:3679
       serial_base_port_add+0x2ec/0x3c0 drivers/tty/serial/serial_base_bus.c:178
       serial_core_port_device_add
drivers/tty/serial/serial_core.c:3380 [inline]
       serial_core_register_port+0x386/0x21f0
drivers/tty/serial/serial_core.c:3421
       serial8250_register_8250_port+0x142c/0x1c80
drivers/tty/serial/8250/8250_core.c:1135
       serial_pnp_probe+0x4ed/0x9c0 drivers/tty/serial/8250/8250_pnp.c:490
       pnp_device_probe+0x2b2/0x450 drivers/pnp/driver.c:111
       call_driver_probe+0x9a/0x1b0
       really_probe+0x274/0x8e0 drivers/base/dd.c:656
       __driver_probe_device+0x199/0x380 drivers/base/dd.c:798
       driver_probe_device+0x50/0x240 drivers/base/dd.c:828
       __driver_attach+0x366/0x5a0 drivers/base/dd.c:1214
       bus_for_each_dev+0x269/0x2e0 drivers/base/bus.c:368
       bus_add_driver+0x369/0x680 drivers/base/bus.c:673
       driver_register+0x236/0x310 drivers/base/driver.c:246
       serial8250_init+0x96/0x170 drivers/tty/serial/8250/8250_core.c:1236
       do_one_initcall+0xc4/0x310 init/main.c:1267
       do_initcall_level+0x14e/0x270 init/main.c:1329
       do_initcalls+0x3f/0x80 init/main.c:1345
       kernel_init_freeable+0x42e/0x5c0 init/main.c:1578
       kernel_init+0x19/0x2a0 init/main.c:1467
       ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244

-> #2 (&dev->power.lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0x10c/0x170 drivers/base/power/runtime.c:1171
       pm_runtime_get include/linux/pm_runtime.h:396 [inline]
       __uart_start+0x17a/0x430 drivers/tty/serial/serial_core.c:148
       uart_write+0x14c/0x370 drivers/tty/serial/serial_core.c:633
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xda5/0x12d0 drivers/tty/n_tty.c:2389
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x589/0xa00 drivers/tty/tty_io.c:1096
       do_iter_readv_writev+0x4f6/0x730
       vfs_writev+0x38c/0xc10 fs/read_write.c:971
       do_writev+0x1ac/0x340 fs/read_write.c:1018
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x67/0x6f

-> #1 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       serial8250_console_write+0x1a7/0x1750
drivers/tty/serial/8250/8250_port.c:3352
       console_emit_next_record kernel/printk/printk.c:2913 [inline]
       console_flush_all+0x857/0xfb0 kernel/printk/printk.c:2979
       console_unlock+0x136/0x4c0 kernel/printk/printk.c:3048
       vprintk_emit+0x59d/0x760 kernel/printk/printk.c:2348
       _printk+0xd1/0x120 kernel/printk/printk.c:2373
       register_console+0x707/0xcb0 kernel/printk/printk.c:3581
       univ8250_console_init+0x41/0x50 drivers/tty/serial/8250/8250_core.c:714
       console_init+0x63/0xb0 kernel/printk/printk.c:3727
       start_kernel+0x2df/0x500 init/main.c:1038
       x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (console_owner){..-.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x37ac/0x8050 kernel/locking/lockdep.c:5137
       lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
       console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
       console_emit_next_record kernel/printk/printk.c:2907 [inline]
       console_flush_all+0x800/0xfb0 kernel/printk/printk.c:2979
       console_unlock+0x136/0x4c0 kernel/printk/printk.c:3048
       vprintk_emit+0x59d/0x760 kernel/printk/printk.c:2348
       _printk+0xd1/0x120 kernel/printk/printk.c:2373
       __warn_printk+0x195/0x310 kernel/panic.c:737
       debug_print_object lib/debugobjects.c:514 [inline]
       debug_object_activate+0x35a/0x4a0 lib/debugobjects.c:732
       debug_work_activate kernel/workqueue.c:665 [inline]
       insert_work+0x36/0x320 kernel/workqueue.c:2205
       __queue_work+0xb61/0xce0 kernel/workqueue.c:2360
       queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
       __ieee80211_queue_skb_to_iface net/mac80211/rx.c:233 [inline]
       ieee80211_queue_skb_to_iface net/mac80211/rx.c:244 [inline]
       ieee80211_rx_h_mgmt+0x500/0x6f0 net/mac80211/rx.c:4047
       ieee80211_rx_handlers+0x8109/0xb770 net/mac80211/rx.c:4205
       ieee80211_invoke_rx_handlers net/mac80211/rx.c:4235 [inline]
       ieee80211_prepare_and_rx_handle+0x31ce/0x6270 net/mac80211/rx.c:5083
       __ieee80211_rx_handle_packet net/mac80211/rx.c:5324 [inline]
       ieee80211_rx_list+0x2ba2/0x35f0 net/mac80211/rx.c:5459
       ieee80211_rx_napi+0x186/0x3b0 net/mac80211/rx.c:5482
       ieee80211_rx include/net/mac80211.h:5093 [inline]
       ieee80211_handle_queued_frames+0xff/0x190 net/mac80211/main.c:438
       tasklet_action_common+0x3e8/0x5f0 kernel/softirq.c:785
       handle_softirqs+0x272/0x750 kernel/softirq.c:554
       __do_softirq kernel/softirq.c:588 [inline]
       invoke_softirq kernel/softirq.c:428 [inline]
       __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
       irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
       instr_sysvec_apic_timer_interrupt
arch/x86/kernel/apic/apic.c:1043 [inline]
       sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
       asm_sysvec_apic_timer_interrupt+0x16/0x20
arch/x86/include/asm/idtentry.h:702
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       default_idle+0xb/0x10 arch/x86/kernel/process.c:742
       default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
       cpuidle_idle_call kernel/sched/idle.c:191 [inline]
       do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
       cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
       rest_init+0x2db/0x300 init/main.c:747
       start_kernel+0x486/0x500 init/main.c:1103
       x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

other info that might help us debug this:

Chain exists of:
  console_owner --> &dev->power.lock --> &pool->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pool->lock);
                               lock(&dev->power.lock);
                               lock(&pool->lock);
  lock(console_owner);

 *** DEADLOCK ***

6 locks held by swapper/0/0:
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
ieee80211_rx_napi+0xd2/0x3b0 net/mac80211/rx.c:5481
 #1: ffff88803bad96d0 (&local->rx_path_lock){+.-.}-{2:2}, at:
spin_lock_bh include/linux/spinlock.h:356 [inline]
 #1: ffff88803bad96d0 (&local->rx_path_lock){+.-.}-{2:2}, at:
ieee80211_rx_handlers+0xf7/0xb770 net/mac80211/rx.c:4171
 #2: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock
include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8db32fe0 (rcu_read_lock){....}-{1:2}, at:
__queue_work+0x196/0xce0 kernel/workqueue.c:2284
 #3: ffff888013098018 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x6d3/0xce0
 #4: ffffffff8da0eb20 (console_lock){+.+.}-{0:0}, at:
_printk+0xd1/0x120 kernel/printk/printk.c:2373
 #5: ffffffff8da0e750 (console_srcu){....}-{0:0}, at:
rcu_try_lock_acquire include/linux/rcupdate.h:334 [inline]
 #5: ffffffff8da0e750 (console_srcu){....}-{0:0}, at:
srcu_read_lock_nmisafe include/linux/srcu.h:232 [inline]
 #5: ffffffff8da0e750 (console_srcu){....}-{0:0}, at:
console_srcu_read_lock kernel/printk/printk.c:286 [inline]
 #5: ffffffff8da0e750 (console_srcu){....}-{0:0}, at:
console_flush_all+0x14d/0xfb0 kernel/printk/printk.c:2971

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 check_noncircular+0x36c/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x37ac/0x8050 kernel/locking/lockdep.c:5137
 lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
 console_lock_spinning_enable kernel/printk/printk.c:1873 [inline]
 console_emit_next_record kernel/printk/printk.c:2907 [inline]
 console_flush_all+0x800/0xfb0 kernel/printk/printk.c:2979
 console_unlock+0x136/0x4c0 kernel/printk/printk.c:3048
 vprintk_emit+0x59d/0x760 kernel/printk/printk.c:2348
 _printk+0xd1/0x120 kernel/printk/printk.c:2373
 __warn_printk+0x195/0x310 kernel/panic.c:737
 debug_print_object lib/debugobjects.c:514 [inline]
 debug_object_activate+0x35a/0x4a0 lib/debugobjects.c:732
 debug_work_activate kernel/workqueue.c:665 [inline]
 insert_work+0x36/0x320 kernel/workqueue.c:2205
 __queue_work+0xb61/0xce0 kernel/workqueue.c:2360
 queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
 __ieee80211_queue_skb_to_iface net/mac80211/rx.c:233 [inline]
 ieee80211_queue_skb_to_iface net/mac80211/rx.c:244 [inline]
 ieee80211_rx_h_mgmt+0x500/0x6f0 net/mac80211/rx.c:4047
 ieee80211_rx_handlers+0x8109/0xb770 net/mac80211/rx.c:4205
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4235 [inline]
 ieee80211_prepare_and_rx_handle+0x31ce/0x6270 net/mac80211/rx.c:5083
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5324 [inline]
 ieee80211_rx_list+0x2ba2/0x35f0 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0x186/0x3b0 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_handle_queued_frames+0xff/0x190 net/mac80211/main.c:438
 tasklet_action_common+0x3e8/0x5f0 kernel/softirq.c:785
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
RAX: ddff7d1dfa769700 RBX: ffffffff816928eb RCX: 0000000000014109
RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
 default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
 cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
 rest_init+0x2db/0x300 init/main.c:747
 start_kernel+0x486/0x500 init/main.c:1103
 x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
ODEBUG: activate not available (active state 0) object:
ffff88803bad8660 object type: work_struct hint:
cfg80211_wiphy_work+0x0/0x260
WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517 debug_print_object
lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 0 at lib/debugobjects.c:517
debug_object_activate+0x35e/0x4a0 lib/debugobjects.c:732
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:debug_print_object lib/debugobjects.c:514 [inline]
RIP: 0010:debug_object_activate+0x35e/0x4a0 lib/debugobjects.c:732
Code: 8b 4d 00 48 c7 c7 a0 61 a9 8b 48 c7 c6 c0 5d a9 8b 4c 89 e2 8b
4c 24 0c 4c 8b 44 24 18 ff 74 24 10 e8 a6 3c f7 fc 48 83 c4 08 <0f> 0b
48 8b 1c 24 ff 05 06 2e c6 0a bd ea ff ff ff 83 fb 05 74 05
RSP: 0018:ffffc90000007190 EFLAGS: 00010096
RAX: ddff7d1dfa769700 RBX: ffffffff8ba96248 RCX: ffffffff8d893bc0
RDX: 0000000000000303 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8b4b7d20 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffffffff8ba96360
R13: ffffffff8b4b7d20 R14: dffffc0000000000 R15: ffff88803bad8660
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558a63a431d0 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 debug_work_activate kernel/workqueue.c:665 [inline]
 insert_work+0x36/0x320 kernel/workqueue.c:2205
 __queue_work+0xb61/0xce0 kernel/workqueue.c:2360
 queue_work_on+0x18a/0x2d0 kernel/workqueue.c:2411
 __ieee80211_queue_skb_to_iface net/mac80211/rx.c:233 [inline]
 ieee80211_queue_skb_to_iface net/mac80211/rx.c:244 [inline]
 ieee80211_rx_h_mgmt+0x500/0x6f0 net/mac80211/rx.c:4047
 ieee80211_rx_handlers+0x8109/0xb770 net/mac80211/rx.c:4205
 ieee80211_invoke_rx_handlers net/mac80211/rx.c:4235 [inline]
 ieee80211_prepare_and_rx_handle+0x31ce/0x6270 net/mac80211/rx.c:5083
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5324 [inline]
 ieee80211_rx_list+0x2ba2/0x35f0 net/mac80211/rx.c:5459
 ieee80211_rx_napi+0x186/0x3b0 net/mac80211/rx.c:5482
 ieee80211_rx include/net/mac80211.h:5093 [inline]
 ieee80211_handle_queued_frames+0xff/0x190 net/mac80211/main.c:438
 tasklet_action_common+0x3e8/0x5f0 kernel/softirq.c:785
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:default_idle+0xb/0x10 arch/x86/kernel/process.c:743
Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29
c2 e9 72 ff ff ff cc cc cc cc 66 90 0f 00 2d c7 a4 4e 00 fb f4 <fa> c3
0f 1f 00 e9 eb ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 65
RSP: 0018:ffffffff8d807d68 EFLAGS: 000002c2
RAX: ddff7d1dfa769700 RBX: ffffffff816928eb RCX: 0000000000014109
RDX: 0000000000000001 RSI: ffffffff8b4c89c0 RDI: ffffffff8ba956e0
RBP: ffffffff8d807eb8 R08: ffff888063a37d0b R09: 1ffff1100c746fa1
R10: dffffc0000000000 R11: ffffed100c746fa2 R12: 1ffffffff1b00fc6
R13: 1ffffffff1b12778 R14: 0000000000000000 R15: dffffc0000000000
 default_idle_call+0x6e/0xa0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x22b/0x5c0 kernel/sched/idle.c:332
 cpu_startup_entry+0x3d/0x60 kernel/sched/idle.c:430
 rest_init+0x2db/0x300 init/main.c:747
 start_kernel+0x486/0x500 init/main.c:1103
 x86_64_start_reservations+0x26/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x5c/0x60 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 76 e7                 jbe    0xffffffe9
   2: 48 89 07             mov    %rax,(%rdi)
   5: 49 c7 c0 08 00 00 00 mov    $0x8,%r8
   c: 4d 29 c8             sub    %r9,%r8
   f: 4c 01 c7             add    %r8,%rdi
  12: 4c 29 c2             sub    %r8,%rdx
  15: e9 72 ff ff ff       jmp    0xffffff8c
  1a: cc                   int3
  1b: cc                   int3
  1c: cc                   int3
  1d: cc                   int3
  1e: 66 90                 xchg   %ax,%ax
  20: 0f 00 2d c7 a4 4e 00 verw   0x4ea4c7(%rip)        # 0x4ea4ee
  27: fb                   sti
  28: f4                   hlt
* 29: fa                   cli <-- trapping instruction
  2a: c3                   ret
  2b: 0f 1f 00             nopl   (%rax)
  2e: e9 eb ff ff ff       jmp    0x1e
  33: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
  3a: 00 00 00
  3d: 90                   nop
  3e: 65                   gs
