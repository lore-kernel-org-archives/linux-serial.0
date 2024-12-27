Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424D41F7087
	for <linux-serial@vger.kernel.org>; Fri, 27 Dec 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735325064; cv=none; b=ciVBEsT+FSabSV3Che/KoIYDh4V7mYAvr17Q8xHEtJDkAijxYmiG25t2ARm02zZpuhrE+8k9QyLE7IBbVQmOMIz413f2tCzh3Di55P3BNwWqoKoHpXc1khAI1vr7u/h7APymE9UO4DaERFmbwZkvFFAHfnQpFh6B+wFECjI8LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735325064; c=relaxed/simple;
	bh=4Apqgk9J+qUO6aCGaYWhcAnAjBxazJVUjn+gJXevae0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UNbeevWTZ038L8OWTpwLJGol5dVpX9B3PsJTv7ePXdzNFMo9TJNr/P/XBjYPUDSvlFevaft8vjhtrXOsWhdsvWnnCsIUVBGa5SbrHEu+BNzoeJwuNN/UGw+jdHgqSoyD/iszjXB7hS26OT01+ey8jAwG3fRDfDkCSgXT1oRRIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d303a5ccso152241125ab.3
        for <linux-serial@vger.kernel.org>; Fri, 27 Dec 2024 10:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735325062; x=1735929862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPLqgAYcTKqGFZTcRORvA/ervUIhqvNETbWJ36PvHYA=;
        b=YUpcNVaoV2XxMw4MEB26eZA/ScFl5VXeIrYH8/bQj9J0OAG/IBuW5YNK66+k3jClZV
         cinRVqa/mapZ28O534fmfk8q9vYnhqldIhKeBv47arEs5UyaXH/hg8jucmcqRvzmcxCX
         JgmSqPTUa6b41+sTfALPGkHWqO4P6xtcsO/VglNHpCjWgtwzxh0HJRn3uGVuTpfMQtou
         T0ctZpil/Y3YdaE/377stGwnC07IJVADYPRphfrUA+qolucIlZr96fXdPL65l/7LDLuw
         u+ZptDjX+nXzNercObLV2p+zwjG5OWJ8UD5VbzL7JDDm0kjHdHq4Gt1JzKkA0oa5fLX6
         KIRg==
X-Forwarded-Encrypted: i=1; AJvYcCUrDOI+XmLTBbQat5SiN3pFyF9z3a9dV5zNuohs7Kim2auHcfuHRtFIwzg2TBTRQtoBzrYodaMWrnVGu7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq31eYSuOSscT7OwRLtzcOoMbAZAG0r/sYcUF/AX8a6+pQx1u3
	byMuzWYZWjEVUbzR5RuXUuYVyxIEoZAnSl2a/C54U8EZhJMSLQmF6OlPc8uZ75dlNWBibSXHZem
	FmVdiNdnHpgcoWiLQFeB8Lc+ssqfo53cyQtLvBPmCOPqmQS3OtGmtdRw=
X-Google-Smtp-Source: AGHT+IHp0MaWIWdDPAGEw0AGKngFiwtXvdOmX1Dez8hWVfg9TJHL/HAk7AyilKVDhNIVsGihYW6JiQ9Zn3pgzB1R54iz3BAYd6Ov
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3a7:e7bd:9f09 with SMTP id
 e9e14a558f8ab-3c2d1e7df64mr225258345ab.5.1735325062495; Fri, 27 Dec 2024
 10:44:22 -0800 (PST)
Date: Fri, 27 Dec 2024 10:44:22 -0800
In-Reply-To: <0000000000000a1b9a0620097bad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676ef586.050a0220.2f3838.0488.GAE@google.com>
Subject: Re: [syzbot] [serial?] KMSAN: uninit-value in n_tty_receive_buf_closing
 (3)
From: syzbot <syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d6ef8b40d075 Merge tag 'sound-6.13-rc5' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106692c4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9048090d7bb0d06
dashboard link: https://syzkaller.appspot.com/bug?extid=dd514b5f0cf048aec256
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1741d018580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b87adf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/956144bfc94b/disk-d6ef8b40.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdff012f5017/vmlinux-d6ef8b40.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c97fa2a32556/bzImage-d6ef8b40.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in n_tty_receive_char_closing drivers/tty/n_tty.c:1454 [inline]
BUG: KMSAN: uninit-value in n_tty_receive_buf_closing+0x539/0xb40 drivers/tty/n_tty.c:1567
 n_tty_receive_char_closing drivers/tty/n_tty.c:1454 [inline]
 n_tty_receive_buf_closing+0x539/0xb40 drivers/tty/n_tty.c:1567
 __receive_buf drivers/tty/n_tty.c:1630 [inline]
 n_tty_receive_buf_common+0x196b/0x2490 drivers/tty/n_tty.c:1739
 n_tty_receive_buf2+0x4c/0x60 drivers/tty/n_tty.c:1785
 tty_ldisc_receive_buf+0xd0/0x290 drivers/tty/tty_buffer.c:387
 tty_port_default_receive_buf+0xdf/0x190 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:445 [inline]
 flush_to_ldisc+0x473/0xdb0 drivers/tty/tty_buffer.c:495
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
 worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
 kthread+0x3e2/0x540 kernel/kthread.c:389
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4125 [inline]
 slab_alloc_node mm/slub.c:4168 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x923/0x1230 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 tty_buffer_alloc drivers/tty/tty_buffer.c:180 [inline]
 __tty_buffer_request_room+0x36e/0x6d0 drivers/tty/tty_buffer.c:273
 __tty_insert_flip_string_flags+0x140/0x570 drivers/tty/tty_buffer.c:309
 tty_insert_flip_char include/linux/tty_flip.h:77 [inline]
 uart_insert_char+0x39e/0xa10 drivers/tty/serial/serial_core.c:3550
 serial8250_read_char+0x1a7/0x5d0 drivers/tty/serial/8250/8250_port.c:1763
 serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1780 [inline]
 serial8250_handle_irq+0x970/0x1130 drivers/tty/serial/8250/8250_port.c:1944
 serial8250_default_handle_irq+0x120/0x2b0 drivers/tty/serial/8250/8250_port.c:1969
 serial8250_interrupt+0xc5/0x360 drivers/tty/serial/8250/8250_core.c:86
 __handle_irq_event_percpu+0x118/0xca0 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0xef/0x2c0 kernel/irq/handle.c:210
 handle_edge_irq+0x340/0xfb0 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
 handle_irq arch/x86/kernel/irq.c:247 [inline]
 call_irq_handler arch/x86/kernel/irq.c:259 [inline]
 __common_interrupt+0x97/0x1f0 arch/x86/kernel/irq.c:285
 common_interrupt+0x92/0xb0 arch/x86/kernel/irq.c:278
 asm_common_interrupt+0x2b/0x40 arch/x86/include/asm/idtentry.h:693

CPU: 1 UID: 0 PID: 59 Comm: kworker/u8:3 Not tainted 6.13.0-rc4-syzkaller-00054-gd6ef8b40d075 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound flush_to_ldisc
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
