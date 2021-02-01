Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F114C433E0
	for <linux-serial@archiver.kernel.org>; Mon,  1 Feb 2021 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0754D64E9E
	for <linux-serial@archiver.kernel.org>; Mon,  1 Feb 2021 12:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhBAMRF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:17:05 -0500
Received: from foss.arm.com ([217.140.110.172]:58396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231432AbhBAMRA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Feb 2021 07:17:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 079D0ED1;
        Mon,  1 Feb 2021 04:16:13 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 852D73F718;
        Mon,  1 Feb 2021 04:16:10 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:16:07 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com>,
        Sergey.Semin@baikalelectronics.ru,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: Internal error in io_serial_out
Message-ID: <20210201121607.GB64300@C02TD0UTHF1T.local>
References: <0000000000005ec92c05ba05de1b@google.com>
 <CACT4Y+aBLoCsc9EFnSm7grXJyzEpek=i3+XdSC_7FrL4JF=MuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aBLoCsc9EFnSm7grXJyzEpek=i3+XdSC_7FrL4JF=MuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jan 29, 2021 at 09:35:46AM +0100, Dmitry Vyukov wrote:
> On Fri, Jan 29, 2021 at 9:34 AM syzbot
> <syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    76c057c8 Merge branch 'parisc-5.11-2' of git://git.kernel...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13728c5f500000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f75d66d6d359ef2f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=51bed6fc20ecc6362058
> > userspace arch: arm64
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com
> 
> +Mark
> 
> This happens on arm64 only and pretty frequently. Mark, have you seen
> it in your testing? This is qemu emulation, though.

I have not seen this, but:

* I'm using KVM acceleration (atop a v5.6 host).

* I haven't tested v5.11-rc5 specifically.

* My config might be different. I use a kconfig fragment to enable
  a few options atop the latest defconfig:
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.10-rc7&id=83abdaa512626051c6eecd7c1dfb41fb061ebcb9

* My Syzkaller instance is older (b6cd37e38acccec1421055549f46948d667f0e60),
  so it might not be tickling the kernel in the same way.

... and any of those could potentially have some impact.

I had just set off a run on v5.11-rc6; I'll update to the latest
Syzkaller version and restart that with my config. If that doesn't blow
up after a while I can give your config a go on v5.11-rc5.

My KVM-accelerated VM is using a PL011 UART as its main UART, but does
seem to detect an 8250 UART, so it doesn't look like this is down to VM
configuration.

Thanks,
Mark.

> > Internal error: synchronous external abort: 97140050 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 1 PID: 21580 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00040-g76c057c84d28 #0
> > Hardware name: linux,dummy-virt (DT)
> > pstate: 80400089 (Nzcv daIf +PAN -UAO -TCO BTYPE=--)
> > pc : __raw_writeb arch/arm64/include/asm/io.h:27 [inline]
> > pc : _outb include/asm-generic/io.h:501 [inline]
> > pc : logic_outb+0x40/0xb0 lib/logic_pio.c:299
> > lr : io_serial_out+0x2c/0x40 drivers/tty/serial/8250/8250_port.c:453
> > sp : ffff80001767bbd0
> > x29: ffff80001767bbd0 x28: f1ff000004267000
> > x27: ffff800014281000 x26: 0000000000000001
> > x25: ffff8000142832a0 x24: ffff800014281000
> > x23: ffff800014281000 x22: 0000000000000fff
> > x21: 0000000000000001 x20: 0000000000000002
> > x19: fffffbfffe800001 x18: 00000000fffffffb
> > x17: 0000000000000000 x16: 0000000000000000
> > x15: 0000000000000020 x14: ffffffffffffffff
> > x13: 0000000000000000 x12: ffff80001767bd9f
> > x11: 0000000000000000 x10: 7f7f7f7f7f7f7f7f
> > x9 : fefefefefeff3252 x8 : ffff80001767b924
> > x7 : 0000000000000003 x6 : 0000000000000001
> > x5 : f1ff000005d7c4e0 x4 : 0000000000000000
> > x3 : ffff800013c02808 x2 : 0000000000000000
> > x1 : fffffbfffe800000 x0 : 0000000000ffbffe
> > Call trace:
> >  _outb include/asm-generic/io.h:501 [inline]
> >  logic_outb+0x40/0xb0 lib/logic_pio.c:299
> >  io_serial_out+0x2c/0x40 drivers/tty/serial/8250/8250_port.c:453
> >  serial_out drivers/tty/serial/8250/8250.h:118 [inline]
> >  serial8250_set_THRI drivers/tty/serial/8250/8250.h:138 [inline]
> >  __start_tx drivers/tty/serial/8250/8250_port.c:1566 [inline]
> >  serial8250_start_tx+0x98/0x1c4 drivers/tty/serial/8250/8250_port.c:1666
> >  __uart_start.isra.0+0x3c/0x4c drivers/tty/serial/serial_core.c:127
> >  uart_start+0x70/0x110 drivers/tty/serial/serial_core.c:137
> >  uart_flush_chars+0x14/0x20 drivers/tty/serial/serial_core.c:573
> >  __receive_buf drivers/tty/n_tty.c:1651 [inline]
> >  n_tty_receive_buf_common+0x2a0/0xb30 drivers/tty/n_tty.c:1744
> >  n_tty_receive_buf+0x18/0x2c drivers/tty/n_tty.c:1773
> >  tiocsti drivers/tty/tty_io.c:2203 [inline]
> >  tty_ioctl+0x5b8/0xe5c drivers/tty/tty_io.c:2577
> >  vfs_ioctl fs/ioctl.c:48 [inline]
> >  __do_sys_ioctl fs/ioctl.c:753 [inline]
> >  __se_sys_ioctl fs/ioctl.c:739 [inline]
> >  __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:739
> >  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> >  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
> >  el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
> >  do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
> >  el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
> >  el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
> >  el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
> > Code: d2bfd001 f2df7fe1 f2ffffe1 8b010273 (39000274)
> > ---[ end trace 00ba385f910422db ]---
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005ec92c05ba05de1b%40google.com.
