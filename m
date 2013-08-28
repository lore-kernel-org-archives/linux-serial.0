From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Wed, 28 Aug 2013 09:01:25 +0530
Message-ID: <CAKohpo=aoHeS3etLeLCmp6w=dN1t9RQF0Nw3oA+VCKLY6w-_MA@mail.gmail.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org>
	<52123A44.9090608@hurleysoftware.com>
	<CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
	<5212D602.2000005@hurleysoftware.com>
	<CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
	<5213C5CA.7060206@hurleysoftware.com>
	<CAKohpo=rZn-0FwcK5gzyYXufpVvfFHXSz_bK0=EqJbTDNcxqMQ@mail.gmail.com>
	<CAKohpokL4_RZ7s=yyn8S5jKh5zpW_DaUK4ni5_x_qN2+0Bv-Uw@mail.gmail.com>
	<20130827231946.GA18233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:63993 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139Ab3H1Db0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Aug 2013 23:31:26 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so7117128oag.29
        for <linux-serial@vger.kernel.org>; Tue, 27 Aug 2013 20:31:26 -0700 (PDT)
In-Reply-To: <20130827231946.GA18233@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>, Peter Hurley <peter@hurleysoftware.com>

On 28 August 2013 04:49, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> No need, I took them as-is, thanks for doing this work.

Thanks Greg..

But I think the current commit log is poor and doesn't communicate the problem
well.. I have prepared another patchset with the same diff and updated
log (below),
I can resend them if you are willing to drop current version and take next one..

----------x--------------x---------------------

    The current driver triggers a lockdep warning for RT kernel if
    tty_flip_buffer_push() is called with uart_port->lock locked. This
never shows
    up on UP kernels and comes up only on SMP kernels on RT kernels.

    This happened due to following commit in rt kernels:

        commit 714cc6dc551136b8f88b53361b504a5f624308b9
        Author: Ingo Molnar <mingo@elte.hu>
        Date:   Fri Jul 3 08:30:01 2009 -0500

            serial: 8250: Call flush_to_ldisc when the irq is threaded

            Signed-off-by: Ingo Molnar <mingo@elte.hu>
        ---
         drivers/tty/tty_buffer.c | 6 +++++-
         1 file changed, 5 insertions(+), 1 deletion(-)

        diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
        index 9121c1f..94d3215 100644
        --- a/drivers/tty/tty_buffer.c
        +++ b/drivers/tty/tty_buffer.c
        @@ -517,10 +517,15 @@ void tty_flip_buffer_push(struct tty_port *port)
                        buf->tail->commit = buf->tail->used;
                spin_unlock_irqrestore(&buf->lock, flags);

        +#ifndef CONFIG_PREEMPT_RT_FULL
                if (port->low_latency)
                        flush_to_ldisc(&buf->work);
                else
                        schedule_work(&buf->work);
        +#else
        +       flush_to_ldisc(&buf->work);
        +#endif
        +
         }
         EXPORT_SYMBOL(tty_flip_buffer_push);

    And the crash looks like this (produced with samsung.c driver):

    -----
        kernel BUG at
/home/arm/work/kernel/linaro/lng/lng.git/kernel/rtmutex.c:738!
        Internal error: Oops - BUG: 0 [#1] PREEMPT SMP THUMB2
        Modules linked in:
        CPU: 0 PID: 1895 Comm: irq/85-12c20000 Not tainted 3.10.6-rt3+ #7
        task: ef2d9cc0 ti: ee2b0000 task.ti: ee2b0000
        PC is at rt_spin_lock_slowlock+0x18c/0x1a0
        LR is at rt_spin_lock_slowlock+0x3f/0x1a0
        pc : [<80406b9c>]    lr : [<80406a4f>]    psr: 60070033
        sp : ee2b1d68  ip : 00000000  fp : 00000000
        r10: ee6e641e  r9 : ef2d9cc0  r8 : 00000000
        r7 : ee6e7800  r6 : 00000000  r5 : ee2b0000  r4 : 806a9ccc
        r3 : ef2d9cc0  r2 : 00000000  r1 : ef2d9cc0  r0 : 00000000
        Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb Segment kernel
        Control: 50c5387d  Table: aeac406a  DAC: 00000015
        Process irq/85-12c20000 (pid: 1895, stack limit = 0xee2b0238)
        Stack: (0xee2b1d68 to 0xee2b2000)

        [snip]

        [<80406b9c>] (rt_spin_lock_slowlock+0x18c/0x1a0) from
[<80288639>] (uart_start+0x1d/0x30)
        [<80288639>] (uart_start+0x1d/0x30) from [<80278af5>]
(n_tty_receive_buf+0x9d/0xbf0)
        [<80278af5>] (n_tty_receive_buf+0x9d/0xbf0) from [<8027bbe5>]
(flush_to_ldisc+0xb5/0xe8)
        [<8027bbe5>] (flush_to_ldisc+0xb5/0xe8) from [<8028d4db>]
(s3c24xx_serial_rx_chars+0xbf/0x19c)
        [<8028d4db>] (s3c24xx_serial_rx_chars+0xbf/0x19c) from
[<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38)
        [<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38) from
[<80067db9>] (irq_forced_thread_fn+0x19/0x38)
        [<80067db9>] (irq_forced_thread_fn+0x19/0x38) from
[<80067e91>] (irq_thread+0xb9/0x118)
        [<80067e91>] (irq_thread+0xb9/0x118) from [<80033561>]
(kthread+0x6d/0x74)
        [<80033561>] (kthread+0x6d/0x74) from [<8000cf3d>]
(ret_from_fork+0x11/0x20)
        Code: f7ff fae4 e7ac de02 (de02) 1d23
        ---[ end trace 0000000000000002 ]---
        note: irq/85-12c20000[1895] exited with preempt_count 1
        Unable to handle kernel paging request at virtual address ffffffec
        pgd = 80004000
        [ffffffec] *pgd=af7fd821, *pte=00000000, *ppte=00000000
        Internal error: Oops: 17 [#2] PREEMPT SMP THUMB2
        Modules linked in:
        CPU: 0 PID: 1895 Comm: irq/85-12c20000 Tainted: G D      3.10.6-rt3+ #7
        task: ef2d9cc0 ti: ee2b0000 task.ti: ee2b0000
        PC is at kthread_data+0xa/0x10
        LR is at irq_thread_dtor+0x21/0x80

        [snip]

        [<80033886>] (kthread_data+0xa/0x10) from [<80067d1d>]
(irq_thread_dtor+0x21/0x80)
        [<80067d1d>] (irq_thread_dtor+0x21/0x80) from [<8003136f>]
(task_work_run+0x73/0xac)
        [<8003136f>] (task_work_run+0x73/0xac) from [<8001f619>]
(do_exit+0x215/0x6fc)
        [<8001f619>] (do_exit+0x215/0x6fc) from [<8000fcf1>] (die+0x155/0x1e8)
        [<8000fcf1>] (die+0x155/0x1e8) from [<80008235>]
(do_undefinstr+0x69/0x14c)
        [<80008235>] (do_undefinstr+0x69/0x14c) from [<8000cac1>]
(__und_svc_finish+0x1/0x40)
        Exception stack(0xee2b1d20 to 0xee2b1d68)
        1d20: 00000000 ef2d9cc0 00000000 ef2d9cc0 806a9ccc ee2b0000
00000000 ee6e7800
        1d40: 00000000 ef2d9cc0 ee6e641e 00000000 00000000 ee2b1d68
80406a4f 80406b9c
        1d60: 60070033 ffffffff
        [<8000cac1>] (__und_svc_finish+0x1/0x40) from [<80406b9c>]
(rt_spin_lock_slowlock+0x18c/0x1a0)
        [<80406b9c>] (rt_spin_lock_slowlock+0x18c/0x1a0) from
[<80288639>] (uart_start+0x1d/0x30)
        [<80288639>] (uart_start+0x1d/0x30) from [<80278af5>]
(n_tty_receive_buf+0x9d/0xbf0)
        [<80278af5>] (n_tty_receive_buf+0x9d/0xbf0) from [<8027bbe5>]
(flush_to_ldisc+0xb5/0xe8)
        [<8027bbe5>] (flush_to_ldisc+0xb5/0xe8) from [<8028d4db>]
(s3c24xx_serial_rx_chars+0xbf/0x19c)
        [<8028d4db>] (s3c24xx_serial_rx_chars+0xbf/0x19c) from
[<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38)
        [<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38) from
[<80067db9>] (irq_forced_thread_fn+0x19/0x38)
        [<80067db9>] (irq_forced_thread_fn+0x19/0x38) from
[<80067e91>] (irq_thread+0xb9/0x118)
        [<80067e91>] (irq_thread+0xb9/0x118) from [<80033561>]
(kthread+0x6d/0x74)
        [<80033561>] (kthread+0x6d/0x74) from [<8000cf3d>]
(ret_from_fork+0x11/0x20)

    Moreoever port->lock isn't really required before calling
tty_flip_buffer_push()
    and hence its better to make changes in mainline kernel instead of
RT kernel.

    Release the port lock before calling tty_flip_buffer_push() and reacquire it
    after the call.

    Similar stuff was already done for few other drivers in the past, like:

        commit 2389b272168ceec056ca1d8a870a97fa9c26e11a
        Author: Thomas Gleixner <tglx@linutronix.de>
        Date:   Tue May 29 21:53:50 2007 +0100

            [ARM] 4417/1: Serial: Fix AMBA drivers locking

        Cc: Tobias Klauser <tklauser@distanz.ch>
