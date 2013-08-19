From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Mon, 19 Aug 2013 09:15:59 -0400
Message-ID: <52121A8F.8050600@hurleysoftware.com>
References: <cover.1376651114.git.viresh.kumar@linaro.org> <20130816122753.GA24550@kroah.com> <CAKohpomFJprUfTOXrPpkp0LYgy_9WJBSHuRC49dJ7_X1=untUg@mail.gmail.com> <CAKohponE-FY132W8zcLn-yAP+wLQjJ4xH9_HPeyV5K1VRdjksw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:38453 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751412Ab3HSNQH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 09:16:07 -0400
In-Reply-To: <CAKohponE-FY132W8zcLn-yAP+wLQjJ4xH9_HPeyV5K1VRdjksw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 08/19/2013 06:43 AM, Viresh Kumar wrote:
> On 16 August 2013 23:14, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 16 August 2013 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
>
>>> Lots of tty and serial changes have happened since -rc5 in linux-next,
>>> can you please rebase, and test, these against that tree and resend them
>>> if they are still needed?
>>
>> I have rebased them over latest linux-next and they applied cleanly..
>> Haven't tested it though.. Will try that next week.
>
> I initially thought that the problem only occurs with a merge to RT
> kernel otherwise this would have happened to lots of people..
>
> But when I tried latest linux-next/master (as of today), without
> RT patch I was able to reproduce the issue on Samsung's Arndale
> board.
>
> [  129.179314] [<c0014d58>] (unwind_backtrace+0x0/0xf8) from [<c0011908>] (show_stack+0x10/0x14)
> [  129.187676] [<c0011908>] (show_stack+0x10/0x14) from [<c035da34>] (dump_stack+0x6c/0xac)
> [  129.195619] [<c035da34>] (dump_stack+0x6c/0xac) from [<c01b59ac>] (do_raw_spin_unlock+0xc4/0xd8)
> [  129.204247] [<c01b59ac>] (do_raw_spin_unlock+0xc4/0xd8) from [<c03627e4>] (_raw_spin_unlock_irqrestore+0xc/0)
> [  129.214241] [<c03627e4>] (_raw_spin_unlock_irqrestore+0xc/0x38) from [<c020a1a8>] (s3c24xx_serial_rx_chars+0)
> [  129.224832] [<c020a1a8>] (s3c24xx_serial_rx_chars+0x12c/0x260) from [<c020aae8>] (s3c64xx_serial_handle_irq+)
> [  129.235336] [<c020aae8>] (s3c64xx_serial_handle_irq+0x48/0x60) from [<c006aaa0>] (handle_irq_event_percpu+0x)
> [  129.245753] [<c006aaa0>] (handle_irq_event_percpu+0x50/0x194) from [<c006ac20>] (handle_irq_event+0x3c/0x5c)
> [  129.255407] [<c006ac20>] (handle_irq_event+0x3c/0x5c) from [<c006d864>] (handle_fasteoi_irq+0x80/0x13c)
> [  129.264636] [<c006d864>] (handle_fasteoi_irq+0x80/0x13c) from [<c006a4a4>] (generic_handle_irq+0x20/0x30)
> [  129.274030] [<c006a4a4>] (generic_handle_irq+0x20/0x30) from [<c000f454>] (handle_IRQ+0x38/0x94)
> [  129.282655] [<c000f454>] (handle_IRQ+0x38/0x94) from [<c0008538>] (gic_handle_irq+0x34/0x68)
> [  129.290938] [<c0008538>] (gic_handle_irq+0x34/0x68) from [<c00123c0>] (__irq_svc+0x40/0x70)
> [  129.299134] Exception stack(0xc04cdf70 to 0xc04cdfb8)
> [  129.304084] df60:                                     00000000 00000000 0000166e 00000000
> [  129.312117] df80: c04cc000 c050278f c050278f 00000001 c04d444c 410fc0f4 c03649b0 00000000
> [  129.320146] dfa0: 00000001 c04cdfb8 c000f758 c000f75c 60070013 ffffffff
> [  129.326639] [<c00123c0>] (__irq_svc+0x40/0x70) from [<c000f75c>] (arch_cpu_idle+0x28/0x30)
> [  129.334756] [<c000f75c>] (arch_cpu_idle+0x28/0x30) from [<c0054888>] (cpu_startup_entry+0x5c/0x148)
> [  129.343644] [<c0054888>] (cpu_startup_entry+0x5c/0x148) from [<c0497aa4>] (start_kernel+0x334/0x38c)
> [  133.343767] BUG: spinlock lockup suspected on CPU#0, kworker/0:1/360
> [  133.348574]  lock: s3c24xx_serial_ports+0x1d8/0x370, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
> [  133.357885] CPU: 0 PID: 360 Comm: kworker/0:1 Not tainted 3.11.0-rc6-next-20130819-00003-g75485f1 #2
> [  133.366858] Workqueue: events flush_to_ldisc
> [  133.371034] [<c0014d58>] (unwind_backtrace+0x0/0xf8) from [<c0011908>] (show_stack+0x10/0x14)
> [  133.379413] [<c0011908>] (show_stack+0x10/0x14) from [<c035da34>] (dump_stack+0x6c/0xac)
> [  133.387355] [<c035da34>] (dump_stack+0x6c/0xac) from [<c01b581c>] (do_raw_spin_lock+0x100/0x17c)
> [  133.395982] [<c01b581c>] (do_raw_spin_lock+0x100/0x17c) from [<c03628a0>] (_raw_spin_lock_irqsave+0x20/0x28)
> [  133.405635] [<c03628a0>] (_raw_spin_lock_irqsave+0x20/0x28) from [<c0203224>] (uart_start+0x18/0x34)
> [  133.414602] [<c0203224>] (uart_start+0x18/0x34) from [<c01ef890>] (__receive_buf+0x4b4/0x738)
> [  133.422973] [<c01ef890>] (__receive_buf+0x4b4/0x738) from [<c01efb44>] (n_tty_receive_buf2+0x30/0x98)
> [  133.432026] [<c01efb44>] (n_tty_receive_buf2+0x30/0x98) from [<c01f2ba8>] (flush_to_ldisc+0xec/0x138)
> [  133.441081] [<c01f2ba8>] (flush_to_ldisc+0xec/0x138) from [<c0031af0>] (process_one_work+0xfc/0x348)
> [  133.450048] [<c0031af0>] (process_one_work+0xfc/0x348) from [<c0032138>] (worker_thread+0x138/0x37c)
> [  133.459014] [<c0032138>] (worker_thread+0x138/0x37c) from [<c0037a7c>] (kthread+0xa4/0xb0)
> [  133.467128] [<c0037a7c>] (kthread+0xa4/0xb0) from [<c000e5f8>] (ret_from_fork+0x14/0x3c)
>
>
> And so yes they are required over latest linux-next as well..
> I will resend V2 soon. Thanks..

Umm. How did a worker thread schedule while an IRQ handler was holding a irq-disabling spin lock?

Regards,
Peter Hurley

PS - please paste your stack backtraces with line-wrap disabled

