Return-Path: <SRS0=3oyo=EK=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC60C2D0A3
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FD52067C
	for <linux-serial@archiver.kernel.org>; Wed,  4 Nov 2020 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=horus.com header.i=@horus.com header.b="meij+Wru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgKDPGp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:06:45 -0500
Received: from mail.horus.com ([78.46.148.228]:51725 "EHLO mail.horus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgKDPGo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 4 Nov 2020 10:06:44 -0500
X-Greylist: delayed 542 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 10:06:42 EST
Received: from [192.168.1.20] (178-190-199-171.adsl.highway.telekom.at [178.190.199.171])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "E-Mail Matthias Reichl", Issuer "HiassofT CA 2014" (not verified))
        by mail.horus.com (Postfix) with ESMTPSA id 215E86409C;
        Wed,  4 Nov 2020 15:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1604501859;
        bh=vULZlRXuj4eeNnS12RQ8YimPRwknpj8E1IiW4WwuTPU=;
        h=Date:From:To:Cc:Subject:From;
        b=meij+WrusfeKvQObJ4iAMErt6vNuP1bzYQ/xRJRDKQPQztoLgo2SNuty7nJUusMJG
         BkK7ctbnY2COEx52paI8HfcJDRVy0Qvxxgnt8x8h0UK64FdlKCBE3WUw3MZLxzHlUH
         7lqrcMNQwC2zfyu9EHlh845iuh1XmOCIUX1trLgM=
Received: by camel2.lan (Postfix, from userid 1000)
        id E26381C75C3; Wed,  4 Nov 2020 15:57:37 +0100 (CET)
Date:   Wed, 4 Nov 2020 15:57:37 +0100
From:   Matthias Reichl <hias@horus.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     speakup@linux-speakup.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Crash when specifying non-existent serial port in speakup / tty_kopen
Message-ID: <20201104145737.GA11024@camel2.lan>
Mail-Followup-To: Matthias Reichl <hias@horus.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, speakup@linux-speakup.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I initially noticed this oops on x86_64 running kernel 5.4.59 when
I accidentally mistyped "ttyS0" as "ttyS9":

modprobe speakup_dummy dev=ttyS9

x86_64/5.10-rc2 showed the same behaviour (see below), also
5.9.3 on RPi with the ttyAMA driver. I couldn't make the kernel
warn/crash yet by specifying non-existent ttyUSB ports yet though.

It looks like spk_ttyio or tty_dev_name_to_number() / tty_kopen()
should perform some additional validation, as the missing tty->port
is quite fatal.

Here's the I got on 5.10-rc2:

[   49.967409] input: Speakup as /devices/virtual/input/input10
[   49.967731] initialized device: /dev/synth, node (MAJOR 10, MINOR 61)
[   49.968848] speakup 3.1.6: initialized
[   49.968852] synth name on entry is: (null)
[   49.978421] synth probe
[   49.978477] ------------[ cut here ]------------
[   49.978481] tty_init_dev: ttyS driver does not set tty->port. This would crash the kernel. Fix the driver!
[   49.978522] WARNING: CPU: 1 PID: 283 at drivers/tty/tty_io.c:1351 tty_init_dev+0x17a/0x1d0
[   49.978525] Modules linked in: speakup_dummy(+) speakup
[   49.978538] CPU: 1 PID: 283 Comm: modprobe Not tainted 5.10.0-rc2 #5
[   49.978541] Hardware name:  /8IPE775/-G, BIOS F5 08/31/2006
[   49.978580] RIP: 0010:tty_init_dev+0x17a/0x1d0
[   49.978586] Code: ff ff e8 f9 a6 f5 ff 85 c0 0f 84 43 ff ff ff 49 8b 46 10 48 c7 c6 98 30 07 82 48 c7 c7 b0 c0 26 82 48 8b 50 20 e8 95 37 69 00 <0f> 0b e9 21 ff ff ff e8 da da ff ff e9 ed fe ff ff 4c 89 f7 89 45
[   49.978591] RSP: 0018:ffffc9000029bb88 EFLAGS: 00010282
[   49.978596] RAX: 0000000000000000 RBX: ffffffffffffffea RCX: 0000000000000027
[   49.978599] RDX: 0000000000000027 RSI: ffff88807dc97820 RDI: ffff88807dc97828
[   49.978603] RBP: ffffc9000029bbb0 R08: 0000000000000000 R09: c0000000ffffdfff
[   49.978605] R10: 0000000000000001 R11: ffffc9000029b958 R12: ffff88800386df00
[   49.978608] R13: 0000000000000009 R14: ffff88800514c000 R15: ffffffffa001e500
[   49.978613] FS:  00007faebf8ae540(0000) GS:ffff88807dc80000(0000) knlGS:0000000000000000
[   49.978617] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.978621] CR2: 00007fff4ff25ff8 CR3: 000000000529a000 CR4: 00000000000006e0
[   49.978624] Call Trace:
[   49.978635]  tty_kopen+0x101/0x150
[   49.978651]  spk_ttyio_synth_probe+0xd5/0x230 [speakup]
[   49.978661]  ? _cond_resched+0x14/0x30
[   49.978669]  ? do_init_module+0x22/0x200
[   49.978678]  do_synth_init.cold.11+0x2d/0x15f [speakup]
[   49.978686]  synth_add+0x95/0xa0 [speakup]
[   49.978689]  ? 0xffffffffa0021000
[   49.978696]  synth_dummy_init+0x10/0x1000 [speakup_dummy]
[   49.978702]  do_one_initcall+0x45/0x1d0
[   49.978707]  ? _cond_resched+0x14/0x30
[   49.978714]  ? kmem_cache_alloc_trace+0x39/0x1b0
[   49.978720]  do_init_module+0x5b/0x200
[   49.978726]  load_module+0x25e6/0x2830
[   49.978733]  __do_sys_finit_module+0xc1/0x120
[   49.978737]  ? __do_sys_finit_module+0xc1/0x120
[   49.978744]  __x64_sys_finit_module+0x15/0x20
[   49.978750]  do_syscall_64+0x37/0x50
[   49.978757]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   49.978762] RIP: 0033:0x7faebf9cf919
[   49.978767] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 55 0c 00 f7 d8 64 89 01 48
[   49.978771] RSP: 002b:00007fffb3a03018 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   49.978777] RAX: ffffffffffffffda RBX: 00005620ea9c58f0 RCX: 00007faebf9cf919
[   49.978780] RDX: 0000000000000000 RSI: 00005620ea9c5e10 RDI: 0000000000000004
[   49.978783] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[   49.978785] R10: 0000000000000004 R11: 0000000000000246 R12: 00005620ea9c5e10
[   49.978788] R13: 0000000000000000 R14: 00005620ea9c5ab0 R15: 00005620ea9c58f0
[   49.978795] CPU: 1 PID: 283 Comm: modprobe Not tainted 5.10.0-rc2 #5
[   49.978798] Hardware name:  /8IPE775/-G, BIOS F5 08/31/2006
[   49.978800] Call Trace:
[   49.978806]  dump_stack+0x5e/0x74
[   49.978813]  __warn.cold.13+0xe/0x3f
[   49.978819]  ? tty_init_dev+0x17a/0x1d0
[   49.978826]  report_bug+0xc5/0x100
[   49.978831]  handle_bug+0x48/0x90
[   49.978835]  exc_invalid_op+0x18/0x70
[   49.978839]  asm_exc_invalid_op+0x12/0x20
[   49.978844] RIP: 0010:tty_init_dev+0x17a/0x1d0
[   49.978849] Code: ff ff e8 f9 a6 f5 ff 85 c0 0f 84 43 ff ff ff 49 8b 46 10 48 c7 c6 98 30 07 82 48 c7 c7 b0 c0 26 82 48 8b 50 20 e8 95 37 69 00 <0f> 0b e9 21 ff ff ff e8 da da ff ff e9 ed fe ff ff 4c 89 f7 89 45
[   49.978852] RSP: 0018:ffffc9000029bb88 EFLAGS: 00010282
[   49.978857] RAX: 0000000000000000 RBX: ffffffffffffffea RCX: 0000000000000027
[   49.978860] RDX: 0000000000000027 RSI: ffff88807dc97820 RDI: ffff88807dc97828
[   49.978863] RBP: ffffc9000029bbb0 R08: 0000000000000000 R09: c0000000ffffdfff
[   49.978865] R10: 0000000000000001 R11: ffffc9000029b958 R12: ffff88800386df00
[   49.978868] R13: 0000000000000009 R14: ffff88800514c000 R15: ffffffffa001e500
[   49.978876]  ? tty_init_dev+0x17a/0x1d0
[   49.978882]  tty_kopen+0x101/0x150
[   49.978893]  spk_ttyio_synth_probe+0xd5/0x230 [speakup]
[   49.978900]  ? _cond_resched+0x14/0x30
[   49.978905]  ? do_init_module+0x22/0x200
[   49.978915]  do_synth_init.cold.11+0x2d/0x15f [speakup]
[   49.978923]  synth_add+0x95/0xa0 [speakup]
[   49.978926]  ? 0xffffffffa0021000
[   49.978932]  synth_dummy_init+0x10/0x1000 [speakup_dummy]
[   49.978936]  do_one_initcall+0x45/0x1d0
[   49.978941]  ? _cond_resched+0x14/0x30
[   49.978947]  ? kmem_cache_alloc_trace+0x39/0x1b0
[   49.978953]  do_init_module+0x5b/0x200
[   49.978959]  load_module+0x25e6/0x2830
[   49.978967]  __do_sys_finit_module+0xc1/0x120
[   49.978973]  ? __do_sys_finit_module+0xc1/0x120
[   49.978980]  __x64_sys_finit_module+0x15/0x20
[   49.978985]  do_syscall_64+0x37/0x50
[   49.978990]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   49.978994] RIP: 0033:0x7faebf9cf919
[   49.978998] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 55 0c 00 f7 d8 64 89 01 48
[   49.979001] RSP: 002b:00007fffb3a03018 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   49.979008] RAX: ffffffffffffffda RBX: 00005620ea9c58f0 RCX: 00007faebf9cf919
[   49.979012] RDX: 0000000000000000 RSI: 00005620ea9c5e10 RDI: 0000000000000004
[   49.979015] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[   49.979020] R10: 0000000000000004 R11: 0000000000000246 R12: 00005620ea9c5e10
[   49.979023] R13: 0000000000000000 R14: 00005620ea9c5ab0 R15: 00005620ea9c58f0
[   49.979028] ---[ end trace 6f832dacaff58cbe ]---
[   49.979043] BUG: kernel NULL pointer dereference, address: 0000000000000090
[   49.986001] #PF: supervisor write access in kernel mode
[   49.991226] #PF: error_code(0x0002) - not-present page
[   49.996361] PGD 0 P4D 0 
[   49.998902] Oops: 0002 [#1] SMP PTI
[   50.002393] CPU: 1 PID: 283 Comm: modprobe Tainted: G        W         5.10.0-rc2 #5
[   50.010130] Hardware name:  /8IPE775/-G, BIOS F5 08/31/2006
[   50.015697] RIP: 0010:release_tty+0x69/0x150
[   50.019966] Code: ea ff ff 48 8b 7b 10 48 8b 87 a0 00 00 00 48 8b 40 10 48 85 c0 0f 84 9e 00 00 00 48 89 de e8 1e 19 92 00 48 8b 83 b8 02 00 00 <48> c7 80 90 00 00 00 00 00 00 00 48 8b 83 f8 01 00 00 48 85 c0 74
[   50.038707] RSP: 0018:ffffc9000029bb70 EFLAGS: 00010246
[   50.043933] RAX: 0000000000000000 RBX: ffff88800514c000 RCX: 00000000000015cb
[   50.051055] RDX: 0000000000000009 RSI: ffffffff814e0923 RDI: ffff88800386df00
[   50.058177] RBP: ffffc9000029bb78 R08: 0000000000000040 R09: c0000000ffffdfff
[   50.065300] R10: ffff888005f1cac0 R11: ffffc9000029b958 R12: ffff88800386df00
[   50.072424] R13: 0000000000000009 R14: ffff88800514c000 R15: ffffffffa001e500
[   50.079548] FS:  00007faebf8ae540(0000) GS:ffff88807dc80000(0000) knlGS:0000000000000000
[   50.087632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.093367] CR2: 0000000000000090 CR3: 000000000529a000 CR4: 00000000000006e0
[   50.100489] Call Trace:
[   50.102938]  tty_init_dev+0xb5/0x1d0
[   50.106515]  tty_kopen+0x101/0x150
[   50.109925]  spk_ttyio_synth_probe+0xd5/0x230 [speakup]
[   50.115147]  ? _cond_resched+0x14/0x30
[   50.118898]  ? do_init_module+0x22/0x200
[   50.122824]  do_synth_init.cold.11+0x2d/0x15f [speakup]
[   50.128050]  synth_add+0x95/0xa0 [speakup]
[   50.132144]  ? 0xffffffffa0021000
[   50.135457]  synth_dummy_init+0x10/0x1000 [speakup_dummy]
[   50.140855]  do_one_initcall+0x45/0x1d0
[   50.144694]  ? _cond_resched+0x14/0x30
[   50.148445]  ? kmem_cache_alloc_trace+0x39/0x1b0
[   50.153065]  do_init_module+0x5b/0x200
[   50.156815]  load_module+0x25e6/0x2830
[   50.160560]  __do_sys_finit_module+0xc1/0x120
[   50.164918]  ? __do_sys_finit_module+0xc1/0x120
[   50.169450]  __x64_sys_finit_module+0x15/0x20
[   50.173808]  do_syscall_64+0x37/0x50
[   50.177388]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   50.182438] RIP: 0033:0x7faebf9cf919
[   50.186007] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 55 0c 00 f7 d8 64 89 01 48
[   50.204741] RSP: 002b:00007fffb3a03018 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   50.212306] RAX: ffffffffffffffda RBX: 00005620ea9c58f0 RCX: 00007faebf9cf919
[   50.219428] RDX: 0000000000000000 RSI: 00005620ea9c5e10 RDI: 0000000000000004
[   50.226551] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000
[   50.233674] R10: 0000000000000004 R11: 0000000000000246 R12: 00005620ea9c5e10
[   50.240797] R13: 0000000000000000 R14: 00005620ea9c5ab0 R15: 00005620ea9c58f0
[   50.247920] Modules linked in: speakup_dummy(+) speakup
[   50.253146] CR2: 0000000000000090
[   50.256538] ---[ end trace 6f832dacaff58cbf ]---
[   50.261173] RIP: 0010:release_tty+0x69/0x150
[   50.265464] Code: ea ff ff 48 8b 7b 10 48 8b 87 a0 00 00 00 48 8b 40 10 48 85 c0 0f 84 9e 00 00 00 48 89 de e8 1e 19 92 00 48 8b 83 b8 02 00 00 <48> c7 80 90 00 00 00 00 00 00 00 48 8b 83 f8 01 00 00 48 85 c0 74
[   50.284221] RSP: 0018:ffffc9000029bb70 EFLAGS: 00010246
[   50.289462] RAX: 0000000000000000 RBX: ffff88800514c000 RCX: 00000000000015cb
[   50.296609] RDX: 0000000000000009 RSI: ffffffff814e0923 RDI: ffff88800386df00
[   50.303750] RBP: ffffc9000029bb78 R08: 0000000000000040 R09: c0000000ffffdfff
[   50.310900] R10: ffff888005f1cac0 R11: ffffc9000029b958 R12: ffff88800386df00
[   50.318048] R13: 0000000000000009 R14: ffff88800514c000 R15: ffffffffa001e500
[   50.325197] FS:  00007faebf8ae540(0000) GS:ffff88807dc80000(0000) knlGS:0000000000000000
[   50.333297] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   50.339052] CR2: 0000000000000090 CR3: 000000000529a000 CR4: 00000000000006e0

so long,

Hias
