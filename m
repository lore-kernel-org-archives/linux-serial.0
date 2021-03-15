Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E21C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 10:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8AB64E12
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 10:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCOKjb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 06:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhCOKjL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 06:39:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25D5C061574
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 03:39:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id r14so8679461qtt.7
        for <linux-serial@vger.kernel.org>; Mon, 15 Mar 2021 03:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXEfNhWWutdNciXPyO7G9q0sSCX+L4NWahYQsjDBQso=;
        b=XUD2pfEDnUXjzZ3GCLrPyLUXz14dLjBhyyqxVU1qBtuvHtqUKUx9Hmu618R8j+jiMz
         VWGdW8+eEb9q2+7VX6Nak9JPWypGCXbImiGwqE5z1c+0B5nFWeelN7Kq8Z+NsIQfpTYb
         6TEBxsE8fKbFEUPYA84zVtRwQc28G59FGigyKfOamoM350F7lhWjfVoGtwmc1D/DTcUj
         MBepctmQiW/+mRPbl5d06ll3LVOke1cyJDrvf1ASKGUOAPWGEWcfzbgaj3rgTyWj98r2
         HeiikqUKm9r4lMtJOSqEXzWwDynSdsXltS5pXQhZuBaDqqDuzCmfbiqOnVEua8yIh1F+
         UMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXEfNhWWutdNciXPyO7G9q0sSCX+L4NWahYQsjDBQso=;
        b=eXGKQSDof5XdCNJDNU1fUCQ6v/l7Hy8/XKyhLHrmow5QBrsdqoFQNUSSOV41w9EON+
         3fVuLAdd1RLdXZ8kjjkCbQULzRqPuKOLlSUTxtsvPOIEtqwP0IY5DoTQM16zAvG7FI4P
         kvFfoS2lb0jqgasTZb5d9bfF/9VUjuAzLG7DHqkzudNJzPeHp4fHqb+UNg7leArr1+jM
         pUiXycy0GFvx8Xd+ABYeGatueCC0+m41E9fQqXrz0gfdNNLxSHzJG9613vNFAFye7xQ4
         iJnZe4UDsh6187TJwol/mIsgQvoxhYWoZSlfptPV/5kBusLbeIGPdESXFmmfDyKdBt62
         W+hg==
X-Gm-Message-State: AOAM532sL7LNDm0hQZ0ctu9N67WBQ83gyS0WCr2QjUJV7obiZn12zyzD
        jaAI4QyrFj1gGYN0sd40NDB/Xt8TtEIORB2JQ1Okcw==
X-Google-Smtp-Source: ABdhPJzj5iLWxOye7v2ZByOkHS0FBseCW1iD2qYT3brU7nxQ1O4KKt2B9SEd6ic62mytAlrSP9Ih1glzUr7tL//IkNw=
X-Received: by 2002:aed:2c61:: with SMTP id f88mr21890371qtd.337.1615804749682;
 Mon, 15 Mar 2021 03:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005ec92c05ba05de1b@google.com> <CACT4Y+aBLoCsc9EFnSm7grXJyzEpek=i3+XdSC_7FrL4JF=MuQ@mail.gmail.com>
 <20210201121607.GB64300@C02TD0UTHF1T.local>
In-Reply-To: <20210201121607.GB64300@C02TD0UTHF1T.local>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 15 Mar 2021 11:38:58 +0100
Message-ID: <CACT4Y+YihAkggG2=oefrt_iBi9DS1yGw33byvDzMHS4K8YA2oQ@mail.gmail.com>
Subject: Re: Internal error in io_serial_out
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     syzbot <syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com>,
        Sergey.Semin@baikalelectronics.ru,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Feb 1, 2021 at 1:16 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Jan 29, 2021 at 09:35:46AM +0100, Dmitry Vyukov wrote:
> > On Fri, Jan 29, 2021 at 9:34 AM syzbot
> > <syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    76c057c8 Merge branch 'parisc-5.11-2' of git://git.kernel...
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13728c5f500000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f75d66d6d359ef2f
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=51bed6fc20ecc6362058
> > > userspace arch: arm64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+51bed6fc20ecc6362058@syzkaller.appspotmail.com
> >
> > +Mark
> >
> > This happens on arm64 only and pretty frequently. Mark, have you seen
> > it in your testing? This is qemu emulation, though.
>
> I have not seen this, but:
>
> * I'm using KVM acceleration (atop a v5.6 host).
>
> * I haven't tested v5.11-rc5 specifically.
>
> * My config might be different. I use a kconfig fragment to enable
>   a few options atop the latest defconfig:
>   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=fuzzing/5.10-rc7&id=83abdaa512626051c6eecd7c1dfb41fb061ebcb9
>
> * My Syzkaller instance is older (b6cd37e38acccec1421055549f46948d667f0e60),
>   so it might not be tickling the kernel in the same way.
>
> ... and any of those could potentially have some impact.
>
> I had just set off a run on v5.11-rc6; I'll update to the latest
> Syzkaller version and restart that with my config. If that doesn't blow
> up after a while I can give your config a go on v5.11-rc5.
>
> My KVM-accelerated VM is using a PL011 UART as its main UART, but does
> seem to detect an 8250 UART, so it doesn't look like this is down to VM
> configuration.

The discussion of this issues has moved into that thread:
https://lore.kernel.org/lkml/CACT4Y+YYa9mXtiQ0cqNaWtT0EkhGimJb6mVT+iXwHPAyBRE0Qw@mail.gmail.com/T/#m1a2afa944083cc3e3e48caae88009abbb2434cb3

FTR I've filed a bug on qemu:
https://bugs.launchpad.net/qemu/+bug/1918917

And there is also proposed kernel fix from John:
arm64: io: Introduce IO_SPACE_BASE
https://lore.kernel.org/lkml/1610729929-188490-2-git-send-email-john.garry@huawei.com/



> > > Internal error: synchronous external abort: 97140050 [#1] PREEMPT SMP
> > > Modules linked in:
> > > CPU: 1 PID: 21580 Comm: syz-executor.0 Not tainted 5.11.0-rc5-syzkaller-00040-g76c057c84d28 #0
> > > Hardware name: linux,dummy-virt (DT)
> > > pstate: 80400089 (Nzcv daIf +PAN -UAO -TCO BTYPE=--)
> > > pc : __raw_writeb arch/arm64/include/asm/io.h:27 [inline]
> > > pc : _outb include/asm-generic/io.h:501 [inline]
> > > pc : logic_outb+0x40/0xb0 lib/logic_pio.c:299
> > > lr : io_serial_out+0x2c/0x40 drivers/tty/serial/8250/8250_port.c:453
> > > sp : ffff80001767bbd0
> > > x29: ffff80001767bbd0 x28: f1ff000004267000
> > > x27: ffff800014281000 x26: 0000000000000001
> > > x25: ffff8000142832a0 x24: ffff800014281000
> > > x23: ffff800014281000 x22: 0000000000000fff
> > > x21: 0000000000000001 x20: 0000000000000002
> > > x19: fffffbfffe800001 x18: 00000000fffffffb
> > > x17: 0000000000000000 x16: 0000000000000000
> > > x15: 0000000000000020 x14: ffffffffffffffff
> > > x13: 0000000000000000 x12: ffff80001767bd9f
> > > x11: 0000000000000000 x10: 7f7f7f7f7f7f7f7f
> > > x9 : fefefefefeff3252 x8 : ffff80001767b924
> > > x7 : 0000000000000003 x6 : 0000000000000001
> > > x5 : f1ff000005d7c4e0 x4 : 0000000000000000
> > > x3 : ffff800013c02808 x2 : 0000000000000000
> > > x1 : fffffbfffe800000 x0 : 0000000000ffbffe
> > > Call trace:
> > >  _outb include/asm-generic/io.h:501 [inline]
> > >  logic_outb+0x40/0xb0 lib/logic_pio.c:299
> > >  io_serial_out+0x2c/0x40 drivers/tty/serial/8250/8250_port.c:453
> > >  serial_out drivers/tty/serial/8250/8250.h:118 [inline]
> > >  serial8250_set_THRI drivers/tty/serial/8250/8250.h:138 [inline]
> > >  __start_tx drivers/tty/serial/8250/8250_port.c:1566 [inline]
> > >  serial8250_start_tx+0x98/0x1c4 drivers/tty/serial/8250/8250_port.c:1666
> > >  __uart_start.isra.0+0x3c/0x4c drivers/tty/serial/serial_core.c:127
> > >  uart_start+0x70/0x110 drivers/tty/serial/serial_core.c:137
> > >  uart_flush_chars+0x14/0x20 drivers/tty/serial/serial_core.c:573
> > >  __receive_buf drivers/tty/n_tty.c:1651 [inline]
> > >  n_tty_receive_buf_common+0x2a0/0xb30 drivers/tty/n_tty.c:1744
> > >  n_tty_receive_buf+0x18/0x2c drivers/tty/n_tty.c:1773
> > >  tiocsti drivers/tty/tty_io.c:2203 [inline]
> > >  tty_ioctl+0x5b8/0xe5c drivers/tty/tty_io.c:2577
> > >  vfs_ioctl fs/ioctl.c:48 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:753 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:739 [inline]
> > >  __arm64_sys_ioctl+0xac/0xf0 fs/ioctl.c:739
> > >  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> > >  invoke_syscall arch/arm64/kernel/syscall.c:49 [inline]
> > >  el0_svc_common.constprop.0+0x74/0x190 arch/arm64/kernel/syscall.c:159
> > >  do_el0_svc+0x78/0x90 arch/arm64/kernel/syscall.c:198
> > >  el0_svc+0x14/0x20 arch/arm64/kernel/entry-common.c:365
> > >  el0_sync_handler+0x1a8/0x1b0 arch/arm64/kernel/entry-common.c:381
> > >  el0_sync+0x190/0x1c0 arch/arm64/kernel/entry.S:699
> > > Code: d2bfd001 f2df7fe1 f2ffffe1 8b010273 (39000274)
> > > ---[ end trace 00ba385f910422db ]---
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000005ec92c05ba05de1b%40google.com.
