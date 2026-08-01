Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B57B2AF1D
	for <linux-serial@vger.kernel.org>; Sat,  1 Aug 2026 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785542606; cv=none; b=WzmH4qsVT5iGtYYt+ybBV+zSCYi90QIKN3LgluSItRINRj0RKqfr/uaJNVgIEhRtWBeXAIskfFTcU4t8pwbOZuPiIIfeqhonTUNO60oMU52ksBkcVS8BTGqDKn0VYUyoQ9MBw0VWsw3TyYBYvt/Q5MEUHg5rPkC4Xtt+LBnhzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785542606; c=relaxed/simple;
	bh=pFUrZurBtciXvnqeMp216N6tYglL21j4Jdvl58CpHTg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nc+2Kia4w15GBx9n8VZ3TcNCfAmLnuud6Ih8Wt4oruG1GnqiEDh3MBhczPIIBX1It70qY8rUVooNTa3ELHFT20ENdqb48mA9B9+8yS4sUnNzFQbsNjNRbPCsYKJXZgxPQ1lZhLSygKeb7g0ZAma7rhyoLUdo/NiLjnvehGHIqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7e74781faaaso2870493a34.2
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 17:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785542603; x=1786147403;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPI602Y0g39NIKC38ICsLhKkZFI9nwbwdY786/RGUSw=;
        b=Vj02q0Y5AeyOz8NYgQD7Ye4QTGd4raJCKKh3WP6BXmgmrVJUi7yjDwn9UurE6Xegia
         h5c5dOGZXdMWH/Znr0s9GPlSKqD100H+iTzJyKy1VZlzXRJLqa0K6Jabwgvdm4z/OLfj
         mWzbFVPW452jswM+7FTKzxt4pVSFSd5UaXAQ/aF0Bf6OVLVmxtHUUFVNXYOPjrxZzqWY
         2T62FrCPY9CbgdqPLdjsOxEhZYC4W1FrEECl1r0lZwpx3K2+NwPRTT4JXMfbWGubX22l
         y4r88g1/cxskdKNc1erkE2YuEpfApGbLEdY8d6yDI5hIDQpmB9cUSVKeR6VPydDRs/Zi
         Ahhg==
X-Forwarded-Encrypted: i=1; AHgh+RpvuBKtsUnbXWZeCi+v3CGDz1cLTFPkAPfb2PMZab8VUXzTHHQvR+U2GiiM3fervCaXiOvas5OlaT8eI8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsI/yGfR2q8j31gvjVCZrhnNmE4TFZ5+4SA73l4RoZFeHjv/Ou
	Q1xC6ZY0ZydlMjfT37KtpQPwbLjJBARDC09OmlXXahPtkK48C6/4/beXyrx/WSUsFObwugOTbv2
	SgBVdYdCQicM4587shrJ1KhlJ3PiG85ezkQ0AET9rROPUc6honPTfL7EePWY=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6c85:b0:495:f8a6:81f8 with SMTP id
 5614622812f47-4af5e29cd37mr3787772b6e.13.1785542603307; Fri, 31 Jul 2026
 17:03:23 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:03:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d37cb.f794c993.27aeb.0006.GAE@google.com>
Subject: [syzbot] [serial?] possible deadlock in __refill_objects_node
From: syzbot <syzbot+5cd85bfb5621212d8c2f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174625b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=5cd85bfb5621212d8c2f
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2be78614a29/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301a11d315af/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5cd85bfb5621212d8c2f@syzkaller.appspotmail.com

=============================================================================
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.5.2538/15441 is trying to acquire lock:
ffffffff8eaf40e0 (console_owner){-.-.}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:2026 [inline]
ffffffff8eaf40e0 (console_owner){-.-.}-{0:0}, at: vprintk_emit+0x4c0/0x6b0 kernel/printk/printk.c:2478

but task is already holding lock:
ffff888028139618 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:372 [inline]
ffff888028139618 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:8009 [inline]
ffff888028139618 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x10c/0x330 mm/slub.c:8058

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&n->list_lock){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:166
       get_partial_node_bulk mm/slub.c:3744 [inline]
       __refill_objects_node+0x120/0xaa0 mm/slub.c:7169
       refill_objects+0x58/0x410 mm/slub.c:7297
       refill_sheaf mm/slub.c:2804 [inline]
       __pcs_replace_empty_main+0x376/0x680 mm/slub.c:4675
       alloc_from_pcs mm/slub.c:4773 [inline]
       slab_alloc_node mm/slub.c:4905 [inline]
       __do_kmalloc_node mm/slub.c:5333 [inline]
       __kmalloc_noprof+0x66d/0x820 mm/slub.c:5359
       _kmalloc_noprof include/linux/slab.h:992 [inline]
       tty_buffer_alloc+0x29f/0x320 drivers/tty/tty_buffer.c:187
       __tty_buffer_request_room+0x129/0x2c0 drivers/tty/tty_buffer.c:280
       __tty_insert_flip_string_flags+0xdb/0x3f0 drivers/tty/tty_buffer.c:316
       tty_insert_flip_string_fixed_flag include/linux/tty_flip.h:35 [inline]
       tty_insert_flip_string include/linux/tty_flip.h:83 [inline]
       tty_insert_flip_string_and_push_buffer+0x9c/0x230 drivers/tty/tty_buffer.c:565
       pty_write+0xd2/0x100 drivers/tty/pty.c:116
       n_tty_write+0xa9e/0x1160 drivers/tty/n_tty.c:2388
       iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
       file_tty_write.isra.0+0x4d2/0x890 drivers/tty/tty_io.c:1081
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&port->lock#2){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:166
       class_spinlock_irqsave_constructor include/linux/spinlock.h:619 [inline]
       tty_port_tty_get+0x21/0x100 drivers/tty/tty_port.c:322
       class_tty_port_tty_constructor include/linux/tty_port.h:293 [inline]
       tty_port_default_wakeup+0x15/0x60 drivers/tty/tty_port.c:66
       serial8250_tx_chars+0x68f/0x860 drivers/tty/serial/8250/8250_port.c:1723
       serial8250_handle_irq_locked+0x770/0x9a0 drivers/tty/serial/8250/8250_port.c:1837
       serial8250_handle_irq.part.0+0xb4/0x530 drivers/tty/serial/8250/8250_port.c:1853
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1849 [inline]
       serial8250_default_handle_irq+0xc2/0x280 drivers/tty/serial/8250/8250_port.c:1867
       serial8250_interrupt+0xf8/0x1b0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x232/0x880 kernel/irq/handle.c:209
       handle_irq_event_percpu kernel/irq/handle.c:246 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:263
       handle_edge_irq+0x34c/0x950 kernel/irq/chip.c:859
       generic_handle_irq_desc include/linux/irqdesc.h:188 [inline]
       handle_irq arch/x86/kernel/irq.c:209 [inline]
       call_irq_handler arch/x86/kernel/irq.c:265 [inline]
       __common_interrupt+0xd8/0x2f0 arch/x86/kernel/irq.c:280
       common_interrupt+0xb9/0xe0 arch/x86/kernel/irq.c:273
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:665
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:178 [inline]
       _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:198
       spin_unlock_irqrestore include/linux/spinlock.h:408 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:790 [inline]
       uart_port_unlock_deref drivers/tty/serial/serial_core.c:91 [inline]
       uart_port_unlock_deref drivers/tty/serial/serial_core.c:88 [inline]
       uart_write+0x29d/0xb20 drivers/tty/serial/serial_core.c:630
       process_output_block drivers/tty/n_tty.c:557 [inline]
       n_tty_write+0x431/0x1160 drivers/tty/n_tty.c:2366
       iterate_tty_write drivers/tty/tty_io.c:1006 [inline]
       file_tty_write.isra.0+0x4d2/0x890 drivers/tty/tty_io.c:1081
       tty_write drivers/tty/tty_io.c:1102 [inline]
       redirected_tty_write drivers/tty/tty_io.c:1125 [inline]
       redirected_tty_write+0xd4/0x120 drivers/tty/tty_io.c:1105
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
       _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:166
       uart_port_lock_irqsave include/linux/serial_core.h:719 [inline]
       serial8250_console_write+0x177/0x1a50 drivers/tty/serial/8250/8250_port.c:3344
       console_emit_next_record kernel/printk/printk.c:3183 [inline]
       console_flush_one_record+0x790/0xe50 kernel/printk/printk.c:3269
       console_flush_all kernel/printk/printk.c:3343 [inline]
       __console_flush_and_unlock kernel/printk/printk.c:3373 [inline]
       console_unlock+0x103/0x260 kernel/printk/printk.c:3413
       vprintk_emit+0x407/0x6b0 kernel/printk/printk.c:2479
       _printk+0xcf/0x110 kernel/printk/printk.c:2504
       register_console.cold+0xc0/0x248 kernel/printk/printk.c:4208
       univ8250_console_init+0x6f/0x80 drivers/tty/serial/8250/8250_core.c:515
       console_init+0x3d5/0x5b0 kernel/printk/printk.c:4407
       start_kernel+0x314/0x490 init/main.c:1112
       x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
       x86_64_start_kernel+0x12b/0x130 arch/x86/kernel/head64.c:291
       common_startup_64+0x13e/0x158

-> #0 (console_owner){-.-.}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       console_trylock_spinning kernel/printk/printk.c:2026 [inline]
       vprintk_emit+0x4d1/0x6b0 kernel/printk/printk.c:2478
       _printk+0xcf/0x110 kernel/printk/printk.c:2504
       __slab_bug+0x4f/0xb0 mm/slub.c:1144
       slab_bug+0x5d/0x80 mm/slub.c:1155
       list_slab_objects mm/slub.c:7978 [inline]
       free_partial mm/slub.c:8015 [inline]
       __kmem_cache_shutdown.cold+0x39/0x177 mm/slub.c:8058
       kmem_cache_destroy mm/slab_common.c:569 [inline]
       kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
       virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
       virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
       drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
       kref_put include/linux/kref.h:65 [inline]
       drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
       drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
       virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
       device_remove+0xcb/0x180 drivers/base/dd.c:616
       __device_release_driver drivers/base/dd.c:1349 [inline]
       device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
       bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
       device_del+0x376/0x9b0 drivers/base/core.c:3961
       device_unregister+0x1d/0xe0 drivers/base/core.c:4002
       unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
       virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
       pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
       device_remove+0xcb/0x180 drivers/base/dd.c:616
       __device_release_driver drivers/base/dd.c:1349 [inline]
       device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
       pci_stop_dev drivers/pci/remove.c:27 [inline]
       pci_stop_bus_device+0x120/0x160 drivers/pci/remove.c:93
       pci_stop_and_remove_bus_device+0x58/0xa0 drivers/pci/remove.c:128
       pci_stop_and_remove_bus_device_locked+0x1a/0x20 drivers/pci/remove.c:136
       remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:523
       dev_attr_store+0x58/0x80 drivers/base/core.c:2505
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &port->lock#2 --> &n->list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&n->list_lock);
                               lock(&port->lock#2);
                               lock(&n->list_lock);
  lock(console_owner);

 *** DEADLOCK ***

9 locks held by syz.5.2538/15441:
 #0: ffff88805ac12ef0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff88802f138450 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888026b2d480 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x2c2/0x5f0 fs/kernfs/file.c:336
 #3: ffffffff8f86c760 (pci_rescan_remove_lock){+.+.}-{4:4}, at: pci_stop_and_remove_bus_device_locked+0x12/0x20 drivers/pci/remove.c:135
 #4: ffff8880231301f8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #4: ffff8880231301f8 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #4: ffff8880231301f8 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
 #5: ffff88802629b1b0 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1102 [inline]
 #5: ffff88802629b1b0 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1171 [inline]
 #5: ffff88802629b1b0 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xb2/0x620 drivers/base/dd.c:1369
 #6: ffffffff8ea7a230 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy mm/slab_common.c:556 [inline]
 #6: ffffffff8ea7a230 (cpu_hotplug_lock){++++}-{0:0}, at: kmem_cache_destroy+0x4b/0x190 mm/slab_common.c:527
 #7: ffffffff8ed88200 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy mm/slab_common.c:557 [inline]
 #7: ffffffff8ed88200 (slab_mutex){+.+.}-{4:4}, at: kmem_cache_destroy+0x59/0x190 mm/slab_common.c:527
 #8: ffff888028139618 (&n->list_lock){-.-.}-{3:3}, at: spin_lock_irq include/linux/spinlock.h:372 [inline]
 #8: ffff888028139618 (&n->list_lock){-.-.}-{3:3}, at: free_partial mm/slub.c:8009 [inline]
 #8: ffff888028139618 (&n->list_lock){-.-.}-{3:3}, at: __kmem_cache_shutdown+0x10c/0x330 mm/slub.c:8058

stack backtrace:
CPU: 2 UID: 0 PID: 15441 Comm: syz.5.2538 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 console_trylock_spinning kernel/printk/printk.c:2026 [inline]
 vprintk_emit+0x4d1/0x6b0 kernel/printk/printk.c:2478
 _printk+0xcf/0x110 kernel/printk/printk.c:2504
 __slab_bug+0x4f/0xb0 mm/slub.c:1144
 slab_bug+0x5d/0x80 mm/slub.c:1155
 list_slab_objects mm/slub.c:7978 [inline]
 free_partial mm/slub.c:8015 [inline]
 __kmem_cache_shutdown.cold+0x39/0x177 mm/slub.c:8058
 kmem_cache_destroy mm/slab_common.c:569 [inline]
 kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
 virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
 virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
 drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
 kref_put include/linux/kref.h:65 [inline]
 drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
 drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
 virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 device_unregister+0x1d/0xe0 drivers/base/core.c:4002
 unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0x120/0x160 drivers/pci/remove.c:93
 pci_stop_and_remove_bus_device+0x58/0xa0 drivers/pci/remove.c:128
 pci_stop_and_remove_bus_device_locked+0x1a/0x20 drivers/pci/remove.c:136
 remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:523
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8bea79df99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8beb5fc028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8beaa25fa0 RCX: 00007f8bea79df99
RDX: 0000000000000001 RSI: 0000200000000800 RDI: 0000000000000004
RBP: 00007f8bea834ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8beaa26038 R14: 00007f8beaa25fa0 R15: 00007ffc98064e98
 </TASK>
BUG virtio-gpu-vbufs (Tainted: G             L     ): Objects remaining on __kmem_cache_shutdown()
-----------------------------------------------------------------------------

Object 0xffff88803d222000 @offset=0
Object 0xffff88803d222118 @offset=280
Object 0xffff88803d222230 @offset=560
Object 0xffff88803d222348 @offset=840
Object 0xffff88803d222460 @offset=1120
Object 0xffff88803d222578 @offset=1400
Object 0xffff88803d222690 @offset=1680
Object 0xffff88803d2227a8 @offset=1960
Slab 0xffffea0000f48880 objects=29 used=8 fp=0xffff88803d2228c0 flags=0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
------------[ cut here ]------------
1
WARNING: mm/slub.c:1244 at __slab_err+0x15/0x20 mm/slub.c:1244, CPU#2: syz.5.2538/15441
Modules linked in:
CPU: 2 UID: 0 PID: 15441 Comm: syz.5.2538 Tainted: G    B        L      syzkaller #0 PREEMPT(full) 
Tainted: [B]=BAD_PAGE, [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__slab_err+0x15/0x20 mm/slub.c:1244
Code: 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 e8 5b fd ff ff be 01 00 00 00 bf 05 00 00 00 e8 dc ba a2 00 90 <0f> 0b 90 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90004e3f738 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffffc90004e3f788 RCX: ffffffff81c709af
RDX: ffff88805bd02540 RSI: ffffffff81c709bd RDI: ffff88805bd02540
RBP: ffff888028139618 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000062616c53 R12: 0000000000001ea0
R13: ffff88803d223fb8 R14: ffff888028139600 R15: ffffea0000f48880
FS:  00007f8beb5fc6c0(0000) GS:ffff8880d5fdc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005605bceb4300 CR3: 0000000037c15000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 list_slab_objects mm/slub.c:7994 [inline]
 free_partial mm/slub.c:8015 [inline]
 __kmem_cache_shutdown.cold+0x16e/0x177 mm/slub.c:8058
 kmem_cache_destroy mm/slab_common.c:569 [inline]
 kmem_cache_destroy+0x73/0x190 mm/slab_common.c:527
 virtio_gpu_free_vbufs+0x38/0x80 drivers/gpu/drm/virtio/virtgpu_vq.c:86
 virtio_gpu_release+0x5c/0x1c0 drivers/gpu/drm/virtio/virtgpu_kms.c:312
 drm_dev_release drivers/gpu/drm/drm_drv.c:912 [inline]
 kref_put include/linux/kref.h:65 [inline]
 drm_dev_put.part.0+0xbd/0x140 drivers/gpu/drm/drm_drv.c:948
 drm_dev_put+0x1f/0x30 drivers/gpu/drm/drm_drv.c:947
 virtio_dev_remove+0xb8/0x170 drivers/virtio/virtio.c:375
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 bus_remove_device+0x2bc/0x560 drivers/base/bus.c:664
 device_del+0x376/0x9b0 drivers/base/core.c:3961
 device_unregister+0x1d/0xe0 drivers/base/core.c:4002
 unregister_virtio_device+0x39/0x60 drivers/virtio/virtio.c:594
 virtio_pci_remove+0x7c/0x110 drivers/virtio/virtio_pci_common.c:758
 pci_device_remove+0xb2/0x1d0 drivers/pci/pci-driver.c:512
 device_remove+0xcb/0x180 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x44e/0x620 drivers/base/dd.c:1372
 pci_stop_dev drivers/pci/remove.c:27 [inline]
 pci_stop_bus_device+0x120/0x160 drivers/pci/remove.c:93
 pci_stop_and_remove_bus_device+0x58/0xa0 drivers/pci/remove.c:128
 pci_stop_and_remove_bus_device_locked+0x1a/0x20 drivers/pci/remove.c:136
 remove_store+0x123/0x140 drivers/pci/pci-sysfs.c:523
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8bea79df99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8beb5fc028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f8beaa25fa0 RCX: 00007f8bea79df99
RDX: 0000000000000001 RSI: 0000200000000800 RDI: 0000000000000004
RBP: 00007f8bea834ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f8beaa26038 R14: 00007f8beaa25fa0 R15: 00007ffc98064e98
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
