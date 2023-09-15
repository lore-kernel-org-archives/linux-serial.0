Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19EBEE3F2F
	for <linux-serial@archiver.kernel.org>; Fri, 15 Sep 2023 06:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjIOGaF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Sep 2023 02:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjIOGaE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Sep 2023 02:30:04 -0400
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25E1273D
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 23:29:53 -0700 (PDT)
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-1d5d3735b87so2646167fac.3
        for <linux-serial@vger.kernel.org>; Thu, 14 Sep 2023 23:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694759393; x=1695364193;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J/dhNCOa2uUHoRVvRlugiXn30K4c1kP4ooQHJs85hMs=;
        b=SBLmexOl6faRXR4UZBdkWxjGbH6hcE2fdS6q7nL5pxNvLmR6apgbZUWgiM1L/JuLi0
         EiBROeSe1GOkd63iGPZmz02EfHuJq3KJ0qY4hOsRaVLsZRlI3Lg+cXceAnCqjvz2Dr3w
         GRFiRP5JWP2dDC6daT89RNi84s+3zKx4qSRm5jvBE4RlpBK1RPro+8nbFkHJsmIza3mQ
         cNozG4ZkdKF1j51YCVhGkh6lxI5jRRcgu3tZSyATLg12bPuchaKY8jtuNITUxnAoDICt
         rW7/oaFw16YoU7s3E4zJBJUkQNHURZO/zSgpfVqtdsizfbm4VB/a9HsQ+OSo3Ynjtvdv
         rCDA==
X-Gm-Message-State: AOJu0YzEq982HPauQdGpXAtR5RPy0xOEkxlacxZd9/XF6YgpSyV9qQNo
        kzkcezxGW2lU6SdFtJabWsDEtkvDDatJa5e/8bGLm9X4fmS7
X-Google-Smtp-Source: AGHT+IGUAR1x0L5isvY9gORqZtpTYZVC0Fi/Ern5ryAg5URX/rh2wJk4hefFicSD2npvpdP+QiWAVR0rbIC/C3N+zLVCOAlsDwld
MIME-Version: 1.0
X-Received: by 2002:a05:6870:5a97:b0:1c5:e4a5:6990 with SMTP id
 dt23-20020a0568705a9700b001c5e4a56990mr271000oab.5.1694759393144; Thu, 14 Sep
 2023 23:29:53 -0700 (PDT)
Date:   Thu, 14 Sep 2023 23:29:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bb78206055feb7c@google.com>
Subject: [syzbot] [serial?] memory leak in gsm_activate_mux
From:   syzbot <syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0bb80ecc33a8 Linux 6.6-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a8aad8680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99ce3535087fc27
dashboard link: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163a9e30680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fcd4a0680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce21ae500663/disk-0bb80ecc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d2f34908198/vmlinux-0bb80ecc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c6f5eecda20/bzImage-0bb80ecc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888101230c00 (size 1024):
  comm "syz-executor201", pid 5036, jiffies 4294942174 (age 8.190s)
  hex dump (first 32 bytes):
    00 78 0f 11 81 88 ff ff 00 00 00 00 00 00 00 00  .x..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81573b75>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1114
    [<ffffffff827ec407>] kmalloc include/linux/slab.h:599 [inline]
    [<ffffffff827ec407>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff827ec407>] gsm_dlci_alloc+0x27/0x1f0 drivers/tty/n_gsm.c:2640
    [<ffffffff827ec5ec>] gsm_activate_mux+0x1c/0x1c0 drivers/tty/n_gsm.c:3129
    [<ffffffff827f310f>] gsm_config_ext drivers/tty/n_gsm.c:3434 [inline]
    [<ffffffff827f310f>] gsmld_ioctl+0x6cf/0x9f0 drivers/tty/n_gsm.c:3798
    [<ffffffff827d7bbb>] tty_ioctl+0x3eb/0xc70 drivers/tty/tty_io.c:2785
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888104f38000 (size 4096):
  comm "syz-executor201", pid 5036, jiffies 4294942174 (age 8.190s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815742ab>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815742ab>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff824f9f89>] kmalloc_array include/linux/slab.h:636 [inline]
    [<ffffffff824f9f89>] __kfifo_alloc+0x89/0xe0 lib/kfifo.c:43
    [<ffffffff827ec451>] gsm_dlci_alloc+0x71/0x1f0 drivers/tty/n_gsm.c:2645
    [<ffffffff827ec5ec>] gsm_activate_mux+0x1c/0x1c0 drivers/tty/n_gsm.c:3129
    [<ffffffff827f310f>] gsm_config_ext drivers/tty/n_gsm.c:3434 [inline]
    [<ffffffff827f310f>] gsmld_ioctl+0x6cf/0x9f0 drivers/tty/n_gsm.c:3798
    [<ffffffff827d7bbb>] tty_ioctl+0x3eb/0xc70 drivers/tty/tty_io.c:2785
    [<ffffffff816b25f2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816b25f2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816b25f2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816b25f2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b30008>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b30008>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
