From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH V2 00/25] tty: serial: drop uart_port->lock before calling
Date: Mon, 19 Aug 2013 22:35:46 -0400
Message-ID: <5212D602.2000005@hurleysoftware.com>
References: <cover.1376923198.git.viresh.kumar@linaro.org> <52123A44.9090608@hurleysoftware.com> <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:50164 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751401Ab3HTCfw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 Aug 2013 22:35:52 -0400
In-Reply-To: <CAKohpon2k6SNUzJ0u0EqGZRPnMwyUk0QcWb-XVRc1PU8yW4PNg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.cz, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 08/19/2013 08:18 PM, Viresh Kumar wrote:
> Hi Peter,
>
> On 19 August 2013 21:01, Peter Hurley <peter@hurleysoftware.com> wrote:
>
>> Please review commit 677fe555cbfb188af58cce105f4dae9505e58c31
>> 'serial: imx: Fix recursive locking bug' to see if that is actually the
>> problem
>> you're having with the samsung serial driver.
>
> No, this doesn't seem to be the same issue... The issue here is:
>
> s3c24xx_serial_rx_chars()
> -> spin_lock_irqsave(&port->lock, flags);
> -> tty_flip_buffer_push()
>    -> flush_to_ldisc()
>      -> n_tty_receive_buf2()
>        -> __receive_buf()
>           -> uart_start()
>              -> spin_lock_irqsave(&port->lock, flags);

Nope.

First, you have two stack traces from your previous message.
The BUG report is the second stack trace:

worker_thread
   process_one_work
     flush_to_ldisc
       n_tty_receive_buf2
         __receive_buf
           uart_start
             raw_spin_lock_irqsave(&port->lock)

IOW, no lock recursion because it's running on a separate
kworker thread, and did not arrive from s3c24xx_serial_rx_chars()
(other than indirectly via schedule_work()).

It's BUGing because the uart_port spinlock cannot be acquired
_even though apparently there is no owning CPU_.

The key to why the flush_to_disc() worker thread cannot acquire the
uart_port spinlock is in the first stack trace:

s3c24xx_serial_rx_chars
   raw_spin_unlock_irqrestore
     do_raw_spin_unlock
       dump_stack

So the real question here is why do_raw_spin_unlock() is doing
a dump_stack()?  Is one of the SPIN_BUG_ON() asserts in debug_spin_unlock()
triggering?

> This seems to be a generic enough problem as many drivers are already
> doing the right thing. They release lock before calling
> tty_flip_buffer_push()..

No. Those drivers are carrying vestige code from the original 2.6
tree import.

As documented in tty_flip_buffer_push():

  *	Queue a push of the terminal flip buffers to the line discipline. This
  *	function must not be called from IRQ context if port->low_latency is
  *	set.

IOW, s3c24xx_serial_rx_chars() executing in IRQ context cannot call
flush_to_ldisc() -- the work must be scheduled instead. Since flush_to_ldisc()
will be scheduled on a separate kworker thread, the uart_port spin lock will
not be recursively claimed.

So, recursive locking of the uart_port lock is not the problem
(at least, not wrt the flush_to_ldisc() call chain).

Regards,
Peter Hurley

