Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDC19D8BC;
	Mon, 22 Sep 2025 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560571; cv=none; b=TdGvB4BiyR3r/qiMdYEaCEb4hjoNZdJkxHtuV3+xWh/oHyisscRPLP2fn/16dtZIS9gRZrQoHklQMq6p+AhW/0tG4sgl/cCXDbuelAGW10DAKFwmUghwF37SrVSkc2CEYXN4ikYAyu68nJCCC6Ey+F62I89alB3t/xCF5ii3VGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560571; c=relaxed/simple;
	bh=Qvg83Qu6YbCe2R5WpEPoIiWAVMIinrNZ+JlUpuhEgPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lq8kQ/2y0pO6wVuepVR56acq2+6qpibEiSz7Yyf7PeF0bI2Dq73J45xIyMiRmNNQRnc7KGXUOXd+p02dcEMSB4aJWrVW79Mp6MmxqSthn/cLUaoHJ6EtCmU4g2W8Y6xM6M3cyrRyTMercyj0wYnU40QPbWDtSHRl9npg2MgCifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bw/QfCX1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A51e/Kyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bw/QfCX1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A51e/Kyu"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758560566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUqMA26b1vUicgfT4K+dRgpiKkcWxum2fd2DSOHZFk4=;
	b=Bw/QfCX1Z7L3VAd3THhhYOirVF1fGlj9rRFBrhgK9T0XuT51c9DIc4IJEvysRFrT1RSL2w
	4NinpDYD8uGFnEkNWAHgGtx0LSGCfwjTIeLitq7hEPXx72i3Tc2tfyU3+TwyP8tfc6FJDo
	I3sVozyw1oAUJ0tYYxj6TMdyXyCB3AW0XXG+z6xK1QeYg+bu8/KezDurItOYzqp2gJB222
	tW2UxuSeokCIlZSanjTf/SEW1ldW56kWu/G9H/gzt9VfsPu+UkEnD43JtB7kGWIrqgB23v
	ISgJ4s5XVJlmG3hV9rUnlJ1PBAw9TEwTu1nvHoLPGJhIV2Y98DvuwvGZ1BncGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758560566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RUqMA26b1vUicgfT4K+dRgpiKkcWxum2fd2DSOHZFk4=;
	b=A51e/Kyu/6HBntiw3EP8g2JIqqA5eg/P6ouajs8hy3Nc44cB+qg1aaqtcHaGvrtTkg5voD
	WWxqol48W7tKoYCQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
In-Reply-To: <aNFR45fL2L4PavNc@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de> <aNFR45fL2L4PavNc@pathway.suse.cz>
Date: Mon, 22 Sep 2025 19:08:45 +0206
Message-ID: <84348eju8a.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-22, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2025-08-25 13:06:27, John Ogness wrote:
>> On 2025-08-22, Petr Mladek <pmladek@suse.com> wrote:
>> > There are clearly visible two points where nbcon_atomic_flush_pending()
>> > took over the ownership from a lover priority context. I believe that:
>> >
>> >   + 1st occurrence is triggered by the "WARNING: CPU: 2 PID: 1 at
>> >     arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.
>> >
>> >   + 2nd occurrence is triggered by the "Kernel panic - not syncing:
>> >     Hard LOCKUP" line printed with NBCON_PRIO_PANIC.
>> >
>> > There were flushed more than 2500lines, about 240kB of characters,
>> > in the NBCON_PRIO_EMERGENCY before the hardlockup detector
>> > triggered panic.
>> >
>> > If I count it correctly, a serial console with the speed 115200 baud/sec
>> > would be able to emit about 11.5kB/sec. And it would take about 20sec
>> > to emit the 240kB of messages.
>> >
>> > => softlockup is quite realistic
>> >
>> > Solution:
>> >
>> > IMHO, we really should flush all pending messages atomically.
>> > It means that the watchdog reports need to be prevented
>> > by touching the watchdog. It is not needed in
>> > univ8250_console_write_thread()
>> >
>> > => put back touch_nmi_watchdog() into univ8250_console_write_atomic().
>> 
>> I would expect the touch_nmi_watchdog() within wait_for_lsr() to be
>> sufficient. After all, that is the loop that leads to the large emit
>> times.
>
> Good point. I was not aware of this touch_nmi_watchdog().
>
>> For QEMU, the touch_nmi_watchdog() within wait_for_lsr() will never be
>> called because QEMU does not implement baud rates. So that may be reason
>> enough to accept this change.
>
> Another good point.
>
> Well, the original problem happened on bare metal. And the problem
> was reporoducible even with the extra touch_nmi_watchog() in
> univ8250_console_write_atomic().
>
> I was confused _until_ I realized that touch_nmi_watchog()
> modified per-CPU variable:
>
> notrace void arch_touch_nmi_watchdog(void)
> {
> 	raw_cpu_write(watchdog_hardlockup_touched, true);
> }
>
> And the hardlockup detector checked only the one per-CPU variable
> as well:
>
> void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
> {
> 	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
> 		per_cpu(watchdog_hardlockup_touched, cpu) = false;
> 		return;
> 	}
> [...]
> }
>
> By other words, touch_nmi_watchog() delays hardlockup report
> only on the given CPU.
>
> But we have two CPUs stuck by printk:
>
> 1. CPU2 is calling WARN():
>
>    [    3.933488][    T1] WARNING: CPU: 2 PID: 1 at arch/x86/events/intel/uncore.c:1156 uncore_pci_pmu_register+0x15e/0x180
>
>    It gets busy with flushing the backlog of pending messages
>    in the emergency context.
>
>    This context regularly touches the watchodog.
>    So far, so good.
>
>
> 2. CPU0 tries to reacquire the console ownership so that it could
>    restore IRQ settting from the printk kthread.
>
>    The nbcon_reacquire_nobuf() is called with disabled IRQs
>    so that it might trigger hardlockup. And it clearly
>    happens:
>
>    [    3.930291][    C0] watchdog: Watchdog detected hard LOCKUP on cpu 0
>    [    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted 6.12.0-160000.18-default #1 PREEMPT(voluntary) SLFO-1.2 (unreleased) dd174c2cca19586eee16eaccfeba02f4d5b57c67
>    [    3.930291][    C0] Hardware name: HPE ProLiant DL560 Gen11/ProLiant DL560 Gen11, BIOS 2.48 03/11/2025
>    [    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
>    [...]
>    [    3.930291][    C0]  <TASK>
>    [    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
>    [    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
>    [    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
>    [    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
>
>
> Note that CPU2 keeps the nbcon console ownership until all pending
> messages are flushed and the ownership is blocked for a long
> time:
>
> static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
> 					    bool allow_unsafe_takeover)
> {
> 	if (!nbcon_context_try_acquire(ctxt, false))
> 		return -EPERM;
>
> 	while (nbcon_seq_read(con) < stop_seq) {
> 		if (!nbcon_emit_next_record(&wctxt, true))
> 			return -EAGAIN;
> 	}
>
> 	nbcon_context_release(ctxt);
> }
>
> An solution is to touch the watchdog also in nbcon_reacquire_nobuf()
> because it might get blocked from known reasons. Something like:
>
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 646801813415..dd5966261b09 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -12,6 +12,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/kthread.h>
>  #include <linux/minmax.h>
> +#include <linux/nmi.h>
>  #include <linux/percpu.h>
>  #include <linux/preempt.h>
>  #include <linux/slab.h>
> @@ -932,8 +933,10 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>  {
>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>  
> -	while (!nbcon_context_try_acquire(ctxt, true))
> +	while (!nbcon_context_try_acquire(ctxt, true)) {
> +		touch_nmi_watchdog();
>  		cpu_relax();
> +	}
>  
>  	nbcon_write_context_set_buf(wctxt, NULL, 0);
>  }
>
>
> Alternative solution would be to release the console ownership in
> __nbcon_atomic_flush_pending_con() between each record. It might
> give the kthread a chance to restore the IRQ setting an continue.
>
> It might be better. But we would need to make sure that the kthread
> would stay blocked until the emergency context flushes all messages.
> Otherwise, the kthread would repeatedly lose the console ownership
> in the middle of the message when __nbcon_atomic_flush_pending_con()
> would acquire the context with NBCON_EMERGENCY_PRIO for the next
> pending message.
>
> We might need similar handshake also between panic and emergency
> context.
>
> I am not sure if this is worth the complexity.
>
> What do you think?

Originally I had implemented the atomic flushing to release between
records. The problem is, as you mentioned, that the threaded printers
keep jumping back in. So you end up with lots of "replaying previous
printk message" from the atomic printer taking over all the time. This
is visible from a simple WARN() and it is ugly as hell.

Trying to make the output clean is quite tricky. Mainly because the
lower-prio context (which may or may not be the kthread printer) and the
higher-prio context need to understand each other's intentions and
somehow coordinate. My code started to look like I was implementing a
second layer of ownership (indended ownership) and/or some type of
bizarre scheduling with "printing-prio boosting" and/or "proxy console
ownership". It was a lot of code to make emergency blocks look sane.

In the end I decided to keep things simple and let the kthread printer
busy-wait, possibly with interrupts disabled. Your suggestion of adding
touch_nmi_watchdog() to nbcon_reacquire_nobuf() would also follow that
line of simplicity. The simplicity comes at the cost of possibly having
two CPUs dedicated to atomically flushing a single console (one that is
actually printing and one that is the busy-waiting normal-prio printer).

Note that for PREEMPT_RT the hardware interrupts are not actually
disabled. That is not an excuse to keep things this way, just a
reminder. Non-RT may also want to use that 2nd CPU for something useful,
in which case we would need the higher-prio printer to somehow
temporarily yield ownership to the lower-prio printer. And quite
frankly, that is not something the nbcon console ownership model was
designed to support.

If we can come up with an elegant way to handle the temporary transfer
while preserving clean output, I am all for it. I will take another look
and see if I can come up with a _proper_ (no duct tape) solution.

John
