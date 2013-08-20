From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Tue, 20 Aug 2013 15:38:50 -0400
Message-ID: <5213C5CA.7060206@hurleysoftware.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org> <52123A44.9090608@hurleysoftware.com> <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com> <5212D602.2000005@hurleysoftware.com> <CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:39905 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751522Ab3HTTi7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Aug 2013 15:38:59 -0400
In-Reply-To: <CAKohpomE+6fxwF4JsDUDCzf+LsWZ_deBsRzF_XYjQHZTPvp_jw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>, Linaro Networking <linaro-networking@linaro.org>

On 08/20/2013 06:52 AM, Viresh Kumar wrote:
> Hi Peter,
>
> On 20 August 2013 08:05, Peter Hurley <peter@hurleysoftware.com> wrote:
>> The key to why the flush_to_disc() worker thread cannot acquire the
>> uart_port spinlock is in the first stack trace:
>>
>> s3c24xx_serial_rx_chars
>>    raw_spin_unlock_irqrestore
>>      do_raw_spin_unlock
>>        dump_stack
>>
>> So the real question here is why do_raw_spin_unlock() is doing
>> a dump_stack()?  Is one of the SPIN_BUG_ON() asserts in debug_spin_unlock()
>> triggering?
>
> Ahh, you are right and SPIN_BUG_ON() is indeed getting asserted.
>
> I am embarrassed to say this but it happened due to my stupid mistake :(
>
> And yes, non-rt kernels doesn't see this crash as we simply schedule
> work from our interrupt handlers instead of calling flush_to_ldisc()
>
> This is how I got the wrong crash dump:
> - Applied my patch over latest linux-next
> - Some more debug messages
>
> Tested: No crashes found..
>
> Thought maybe I should try without my patch first, if it really crashes
> or not.
>
> - Reverted my patch and got some conflicts due the "debug patch"..
> and ended up resolving them in the wrong way:
>
> -       spin_unlock_irqrestore(&port->lock, flags);
>          pr_info("%s\n", __func__);
>          tty_flip_buffer_push(&port->state->port);
> +       spin_unlock_irqrestore(&port->lock, flags);
>
>    out:
> +       spin_unlock_irqrestore(&port->lock, flags);
>
> Got two unlocks and so the dump..
> Sorry for the incorrect information :(

No need to apologize. At least this part of the mystery is solved.

> But yes there are some issues with the RT kernel, which are going to
> stay without this patchset.. Here are the logs with 3.10.6 + rt kernel
> (attached as well, in case lines are wrapped by gmail :( ):
>
> root@localhost:~# [  128.771800] ------------[ cut here ]------------
> [  128.771815] kernel BUG at /home/arm/work/kernel/linaro/lng/lng.git/kernel/rtmutex.c:738!
> [  128.771829] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP THUMB2
> [  128.771844] Modules linked in:
> [  128.771868] CPU: 0 PID: 1895 Comm: irq/85-12c20000 Not tainted 3.10.6-rt3+ #7
> [  128.771885] task: ef2d9cc0 ti: ee2b0000 task.ti: ee2b0000
> [  128.771915] PC is at rt_spin_lock_slowlock+0x18c/0x1a0
> [  128.771933] LR is at rt_spin_lock_slowlock+0x3f/0x1a0
> [  128.771956] pc : [<80406b9c>]    lr : [<80406a4f>]    psr: 60070033
> [  128.771956] sp : ee2b1d68  ip : 00000000  fp : 00000000
> [  128.771968] r10: ee6e641e  r9 : ef2d9cc0  r8 : 00000000
> [  128.771982] r7 : ee6e7800  r6 : 00000000  r5 : ee2b0000  r4 : 806a9ccc
> [  128.771995] r3 : ef2d9cc0  r2 : 00000000  r1 : ef2d9cc0  r0 : 00000000
> [  128.772011] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb Segment kernel
> [  128.772026] Control: 50c5387d  Table: aeac406a  DAC: 00000015
> [  128.772041] Process irq/85-12c20000 (pid: 1895, stack limit = 0xee2b0238)
> [  128.772054] Stack: (0xee2b1d68 to 0xee2b2000)
> [  128.772080] 1d60:                   00000000 00000000 00000000 00000000 00000400 80654380
> [  128.772105] 1d80: ef07d800 00000002 ef07d800 81767800 00000002 00000000 00000001 80043101
> [  128.772128] 1da0: 00000002 806a9ccc eea47400 0000002e ee6e7800 00000000 ee6e7800 ee6e641e
> [  128.772150] 1dc0: 00000000 80288639 8028864d eea47400 ee6e651d 80278af5 81767380 800451c9
> [  128.772173] 1de0: 00000064 ef2d9e18 81767380 80654380 ef2d9cc0 80406a4f ef2d9e18 80037a0d
> [  128.772195] 1e00: eea11250 ee2b0000 eea11240 eea11250 eea11240 80406a4f 00000000 ffffffff
> [  128.772216] 1e20: ef33a000 80037be5 00000000 80406a4f 00000100 00000001 eea11250 ee2b0000
> [  128.772238] 1e40: eea11250 806582c0 ee75a500 80406a4f eea11250 ee2b0000 00000000 806582c0
> [  128.772260] 1e60: 0000003f 80406a4f eea11240 eea11250 00000000 8027bcdd 00000001 00000000
> [  128.772282] 1e80: ee2b1ebc 271ae71a eea11240 eea11240 eea47400 eea11250 80278a59 ee75a500
> [  128.772304] 1ea0: eea11308 00000001 ee6e651c 8027bbe5 00000000 806a9cac 806a9ccc 00000000
> [  128.772325] 1ec0: 806582c0 0000003f 00000000 ee75a300 00000000 8028d4db 00000000 8003ca2b
> [  128.772347] 1ee0: 00000001 ee2b0000 806a9cac 00000001 00000055 00000000 ee75a320 80067da1
> [  128.772368] 1f00: ee75a300 8028dbdd ee75a300 8065c800 ee2b0000 80067db9 00000001 8067b750
> [  128.772390] 1f20: ee2b0000 80067e91 ee75a300 8065c800 ee75a300 00000000 00000000 80067cfd
> [  128.772411] 1f40: ee2b1f58 ee6bdcd0 ee2b1f88 ee75a300 80067dd9 00000000 00000000 00000000
> [  128.772432] 1f60: 00000000 80033561 00000000 00000000 000000f8 ee75a300 00000000 00000000
> [  128.772453] 1f80: ee2b1f80 ee2b1f80 00000000 00000000 ee2b1f90 ee2b1f90 00000000 ee6bdcd0
> [  128.772473] 1fa0: 800334f5 00000000 00000000 8000cf3d 00000000 00000000 00000000 00000000
> [  128.772492] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  128.772512] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [  128.772564] [<80406b9c>] (rt_spin_lock_slowlock+0x18c/0x1a0) from [<80288639>] (uart_start+0x1d/0x30)
> [  128.772608] [<80288639>] (uart_start+0x1d/0x30) from [<80278af5>] (n_tty_receive_buf+0x9d/0xbf0)
> [  128.772650] [<80278af5>] (n_tty_receive_buf+0x9d/0xbf0) from [<8027bbe5>] (flush_to_ldisc+0xb5/0xe8)
> [  128.772697] [<8027bbe5>] (flush_to_ldisc+0xb5/0xe8) from [<8028d4db>] (s3c24xx_serial_rx_chars+0xbf/0x19c)
> [  128.772742] [<8028d4db>] (s3c24xx_serial_rx_chars+0xbf/0x19c) from [<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38)
> [  128.772793] [<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38) from  [<80067db9>] (irq_forced_thread_fn+0x19/0x38)
> [  128.772837] [<80067db9>] (irq_forced_thread_fn+0x19/0x38) from [<80067e91>] (irq_thread+0xb9/0x118)
> [  128.772884] [<80067e91>] (irq_thread+0xb9/0x118) from [<80033561>] (kthread+0x6d/0x74)
> [  128.772932] [<80033561>] (kthread+0x6d/0x74) from [<8000cf3d>] (ret_from_fork+0x11/0x20)
> [  128.772962] Code: f7ff fae4 e7ac de02 (de02) 1d23
> [  129.122974] ---[ end trace 0000000000000002 ]---
> [  129.122994] note: irq/85-12c20000[1895] exited with preempt_count 1
> [  129.123041] Unable to handle kernel paging request at virtual address ffffffec
> [  129.123049] pgd = 80004000
> [  129.123077] [ffffffec] *pgd=af7fd821, *pte=00000000, *ppte=00000000
> [  129.123095] Internal error: Oops: 17 [#2] PREEMPT SMP THUMB2
> [  129.123108] Modules linked in:
> [  129.123131] CPU: 0 PID: 1895 Comm: irq/85-12c20000 Tainted: G D      3.10.6-rt3+ #7
> [  129.123144] task: ef2d9cc0 ti: ee2b0000 task.ti: ee2b0000
> [  129.123173] PC is at kthread_data+0xa/0x10
> [  129.123196] LR is at irq_thread_dtor+0x21/0x80
> [  129.123218] pc : [<80033886>]    lr : [<80067d1d>]    psr: 800700b3
> [  129.123218] sp : ee2b1bd8  ip : 00000031  fp : 20070093
> [  129.123231] r10: ef2d9cc0  r9 : 80680008  r8 : ee2b0000
> [  129.123243] r7 : ef2d9cc0  r6 : 806d8c88  r5 : 00000000  r4 : ef2d9cc0
> [  129.123254] r3 : 00000000  r2 : 80000000  r1 : ee2b1f38  r0 : ef2d9cc0
> [  129.123269] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb Segment user
> [  129.123283] Control: 50c5387d  Table: aeac406a  DAC: 00000015
> [  129.123297] Process irq/85-12c20000 (pid: 1895, stack limit = 0xee2b0238)
> [  129.123307] Stack: (0xee2b1bd8 to 0xee2b2000)
> [  129.123324] 1bc0:     80067cfd ef2da124
> [  129.123348] 1be0: 00000000 8003136f ee2b0000 002f002f 00000000 0000000b 00000000 00000000
> [  129.123370] 1c00: ee2b1d20 8001f619 20070093 00000001 8053407c 8001dccf 002f002f 806855ec
> [  129.123392] 1c20: ee2b0000 806c5f84 0000000b ee2b0000 ee2b1d20 8052fd08 80680008 00000000
> [  129.123413] 1c40: 20070093 8000fcf1 ee2b0238 0000000b 8176f34c 00000000 00030001 00000004
> [  129.123434] 1c60: 0000de02 ee2b1d20 80406b9c ee6e641e 00000000 80008235 00000006 00000002
> [  129.123456] 1c80: 00000004 00000000 00030001 80406b9c 00000193 80651d84 0111c000 80021859
> [  129.123477] 1ca0: 00000001 80021c2b 8176dd84 8006dd4f 00000000 81770380 00000001 00000001
> [  129.123498] 1cc0: 00000001 00000000 00000400 80042a73 0000041d 000003e3 00000400 00000000
> [  129.123519] 1ce0: 80654380 ef07e950 80654380 ef07e8c0 00000000 80654380 ffffffff 00000000
> [  129.123540] 1d00: ee2b1d0c 80406b9e 60070033 ffffffff ee2b1d54 00000000 ef2d9cc0 8000cac1
> [  129.123561] 1d20: 00000000 ef2d9cc0 00000000 ef2d9cc0 806a9ccc ee2b0000 00000000 ee6e7800
> [  129.123581] 1d40: 00000000 ef2d9cc0 ee6e641e 00000000 00000000 ee2b1d68 80406a4f 80406b9c
> [  129.123601] 1d60: 60070033 ffffffff 00000000 00000000 00000000 00000000 00000400 80654380
> [  129.123622] 1d80: ef07d800 00000002 ef07d800 81767800 00000002 00000000 00000001 80043101
> [  129.123643] 1da0: 00000002 806a9ccc eea47400 0000002e ee6e7800 00000000 ee6e7800 ee6e641e
> [  129.123664] 1dc0: 00000000 80288639 8028864d eea47400 ee6e651d 80278af5 81767380 800451c9
> [  129.123686] 1de0: 00000064 ef2d9e18 81767380 80654380 ef2d9cc0 80406a4f ef2d9e18 80037a0d
> [  129.123708] 1e00: eea11250 ee2b0000 eea11240 eea11250 eea11240 80406a4f 00000000 ffffffff
> [  129.123729] 1e20: ef33a000 80037be5 00000000 80406a4f 00000100 00000001 eea11250 ee2b0000
> [  129.123750] 1e40: eea11250 806582c0 ee75a500 80406a4f eea11250 ee2b0000 00000000 806582c0
> [  129.123770] 1e60: 0000003f 80406a4f eea11240 eea11250 00000000 8027bcdd 00000001 00000000
> [  129.123792] 1e80: ee2b1ebc 271ae71a eea11240 eea11240 eea47400 eea11250 80278a59 ee75a500
> [  129.123813] 1ea0: eea11308 00000001 ee6e651c 8027bbe5 00000000 806a9cac 806a9ccc 00000000
> [  129.123834] 1ec0: 806582c0 0000003f 00000000 ee75a300 00000000 8028d4db 00000000 8003ca2b
> [  129.123855] 1ee0: 00000001 ee2b0000 806a9cac 00000001 00000055 00000000 ee75a320 80067da1
> [  129.123876] 1f00: ee75a300 8028dbdd ee75a300 8065c800 ee2b0000 80067db9 00000001 8067b750
> [  129.123897] 1f20: ee2b0000 80067e91 ee75a300 8065c800 ee75a300 00000000 00000000 80067cfd
> [  129.123918] 1f40: ee2b1f58 ee6bdcd0 ee2b1f88 ee75a300 80067dd9 00000000 00000000 00000000
> [  129.123938] 1f60: 00000000 80033561 00000000 00000000 000000f8 ee75a300 00000000 00000000
> [  129.123959] 1f80: ee2b1f80 ee2b1f80 00000001 00010001 ee2b1f90 ee2b1f90 00000000 ee6bdcd0
> [  129.123979] 1fa0: 800334f5 00000000 00000000 8000cf3d 00000000 00000000 00000000 00000000
> [  129.123998] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [  129.124017] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [  129.124070] [<80033886>] (kthread_data+0xa/0x10) from [<80067d1d>] (irq_thread_dtor+0x21/0x80)
> [  129.124116] [<80067d1d>] (irq_thread_dtor+0x21/0x80) from [<8003136f>] (task_work_run+0x73/0xac)
> [  129.124156] [<8003136f>] (task_work_run+0x73/0xac) from [<8001f619>] (do_exit+0x215/0x6fc)
> [  129.124189] [<8001f619>] (do_exit+0x215/0x6fc) from [<8000fcf1>] (die+0x155/0x1e8)
> [  129.124221] [<8000fcf1>] (die+0x155/0x1e8) from [<80008235>] (do_undefinstr+0x69/0x14c)
> [  129.124261] [<80008235>] (do_undefinstr+0x69/0x14c) from [<8000cac1>] (__und_svc_finish+0x1/0x40)
> [  129.124272] Exception stack(0xee2b1d20 to 0xee2b1d68)
> [  129.124296] 1d20: 00000000 ef2d9cc0 00000000 ef2d9cc0 806a9ccc ee2b0000 00000000 ee6e7800
> [  129.124318] 1d40: 00000000 ef2d9cc0 ee6e641e 00000000 00000000 ee2b1d68 80406a4f 80406b9c
> [  129.124329] 1d60: 60070033 ffffffff
> [  129.124372] [<8000cac1>] (__und_svc_finish+0x1/0x40) from [<80406b9c>] (rt_spin_lock_slowlock+0x18c/0x1a0)
> [  129.124408] [<80406b9c>] (rt_spin_lock_slowlock+0x18c/0x1a0) from [<80288639>] (uart_start+0x1d/0x30)
> [  129.124445] [<80288639>] (uart_start+0x1d/0x30) from [<80278af5>] (n_tty_receive_buf+0x9d/0xbf0)
> [  129.124484] [<80278af5>] (n_tty_receive_buf+0x9d/0xbf0) from [<8027bbe5>] (flush_to_ldisc+0xb5/0xe8)
> [  129.124527] [<8027bbe5>] (flush_to_ldisc+0xb5/0xe8) from [<8028d4db>] (s3c24xx_serial_rx_chars+0xbf/0x19c)
> [  129.124569] [<8028d4db>] (s3c24xx_serial_rx_chars+0xbf/0x19c) from [<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38)
> [  129.124615] [<8028dbdd>] (s3c64xx_serial_handle_irq+0x31/0x38) from [<80067db9>] (irq_forced_thread_fn+0x19/0x38)
> [  129.124657] [<80067db9>] (irq_forced_thread_fn+0x19/0x38) from [<80067e91>] (irq_thread+0xb9/0x118)
> [  129.124700] [<80067e91>] (irq_thread+0xb9/0x118) from [<80033561>] (kthread+0x6d/0x74)
> [  129.124745] [<80033561>] (kthread+0x6d/0x74) from [<8000cf3d>] (ret_from_fork+0x11/0x20)
> [  129.124775] Code: f85d eb04 f8d0 3264 (f853) 0c14

In light of the RT patch below, completely understandable why it crashes.

PS - Not automagic formatting, unless you consider my hand-editing automagic.

> ---------x-----------------x------------
>
> Here we haven't scheduled work from tty_flip_buffer_push() because of
> following change in RT kernel:
>
> commit 714cc6dc551136b8f88b53361b504a5f624308b9
> Author: Ingo Molnar <mingo@elte.hu>
> Date:   Fri Jul 3 08:30:01 2009 -0500
>
>      serial: 8250: Call flush_to_ldisc when the irq is threaded
>
>      Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>   drivers/tty/tty_buffer.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 9121c1f..94d3215 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -517,10 +517,15 @@ void tty_flip_buffer_push(struct tty_port *port)
>                  buf->tail->commit = buf->tail->used;
>          spin_unlock_irqrestore(&buf->lock, flags);
>
> +#ifndef CONFIG_PREEMPT_RT_FULL
>          if (port->low_latency)
>                  flush_to_ldisc(&buf->work);
>          else
>                  schedule_work(&buf->work);
> +#else
> +       flush_to_ldisc(&buf->work);
> +#endif

As you've discovered, not correct for 25+ drivers, including the samsung driver.


> +
>   }
>   EXPORT_SYMBOL(tty_flip_buffer_push);
>
> @@ -545,4 +550,3 @@ void tty_buffer_init(struct tty_port *port)
>          buf->memory_used = 0;
>          INIT_WORK(&buf->work, flush_to_ldisc);
>   }
>
> ---------x------------------x-------------------
>
> How do you guys suggest me to fix this problem now? The fix I suggested?
> Or something specific to the RT kernel only? Or maybe send these patches
> for RT kernel only.

That's really Greg's call whether he wants to take up RT-specific patches
into the regular tree.


> One more thing: We are calling tty_flip_buffer_push() with (from interrupt
> context) and without (from process context) port->lock held.  Shouldn't we
> make this flat, like don't acquire port->lock while calling
> tty_flip_buffer_push() as that may cause recursive locking?

The tty buffer interface is designed for a single producer so
provides no locking of its own. Provided a uart port mini-driver only uses
the tty buffer interface serially, then no locking is required (to protect
the internals of the tty buffer).

When you note that tty_flip_buffer_push() is called from 'process context',
I assume you mean kworker threads handling rx DMA. Besides the pty driver
and the fwserial staging driver that has loopback mode, I'm not aware of
any other drivers that do rx from process context.

Regards,
Peter Hurley



