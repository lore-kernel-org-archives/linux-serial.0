Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACB281537
	for <linux-serial@vger.kernel.org>; Tue, 22 Apr 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330610; cv=none; b=TjpAgN1kESxsuof6pvXMI3RpDHoOlG5TAmc3WVgeqXPLbUzou08PLPIvrfEfrIUFG01XwHz2qnT5e1JObUmvn+hC/SD+dH6DC1yiqZR9INXct1e5BTyXubLyS6QB3Y/IxkCvsjy9hq1lOInNDM5Yq4SgttGvQ6Pe+C61aXVyAUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330610; c=relaxed/simple;
	bh=Zb1j+QAR44NbXBV+MrhMByNZwAdkjHVk4eWSjPZJTjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URUcpzYG5wSIEGTyJ6E+OB+uy8exwEyZf0B5killwr2vJGvy1mmNiTJeAIPGz80sv5p+L2DsIVIicrYx45ll1gfWFC0rVm0fVgr6l1Qiz7zK06UPCJDqNCtqFbLeyir++aYutwtIEzKJoelcy0Eb7mYJIErtP/q+vZFAA7jzQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pipyKDF5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rPv24j/J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pipyKDF5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPv24j/J"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745330606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+za14p9E//aM02QNt7z5WEZaK7Qo3g9kaLlQPlYFFM=;
	b=pipyKDF559XKO3cgsr8wMhIamR1s6WaRaDYDJDv48/uJba3nNcRG0M+Jgd7Ks+pXthDrdG
	Zl6fqGPkzqCekEip2b6DJ10NKoYCGIbGp1dzyseMGfp38N0D7ux6bLQp5DcpfxWWiYgh2X
	RioqMjoX/eTpx6+neOcZgEnfS5y/73yD8FJ+FenzI7Q4q9LdrKYFGCs/TrFh3aXREutEDd
	iYc2wgEeDJ09k6ZJfh/dw9H3io+HLN4D5znT4PxL0+a1eVGjr7FPswbh3L6jtpujtqRW8U
	AkNZbwJv2tyVwucaXLfG/nGlRmNFNjG7ImSdWnRP2lZMyjFgenF/LHMl9NF5dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745330606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8+za14p9E//aM02QNt7z5WEZaK7Qo3g9kaLlQPlYFFM=;
	b=rPv24j/JTVeRVUcVV9P28xYbwCOXMD3GxJDSWxvvMlbHQL/lnJE/AEAurWp3t1/PqNBzOz
	nm8orUmPtT6ObqDw==
To: Petr Mladek <pmladek@suse.com>, Ryo Takakura <ryotkkr98@gmail.com>
Cc: Jason@zx2c4.com, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
In-Reply-To: <aAeIRZH_VD0mai0V@pathway.suse.cz>
References: <20250317144221.8231-1-ryotkkr98@gmail.com>
 <20250421034150.107997-1-ryotkkr98@gmail.com>
 <aAeIRZH_VD0mai0V@pathway.suse.cz>
Date: Tue, 22 Apr 2025 16:09:25 +0206
Message-ID: <84ikmwqonm.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-22, Petr Mladek <pmladek@suse.com> wrote:
> IMHO, the main difference is that the patch "serial: 8250: Switch to
> nbcon console" removes touch_nmi_watchdog() from
> serial8250_console_write().
>
> The touch_nmi_watchdog() resets the softlockup watchdog. It might
> hide that the CPU did not schedule for a long time.
>
> The touch_nmi_watchdog() was there because the console_lock() owner,
> used by the legacy loop, was responsible for flushing all pending
> messages. And there might be many pending messages when new ones
> were added by other CPUs in parallel. And the legacy loop
> could not call cond_resched() when called from printk() because
> printk() might be called in atomic context.
>
> The series removed the touch_nmi_watchdog() because the kthread
> called cond_resched. And the amount of messages flushed in
> the emergency or panic context was limited.
>
> My view:
>
> The touch_nmi_watchdog() did hide the softlockup scenario in the rslib
> test. The printk series allowed to see the problem reliably.
>
> By other words, the rslib test should get fixed by adding
> cond_resched(). And the conversion of the 8250 serial console
> driver to nbcon is correct.
>
> That said, see below.
>
>> I am still looking into the issue but I noticed that if the printing
>> during the test were done in a caller context, not by printk thread,
>> the softlock goes away.
>> 
>> I tested with a change something like below so that the printing during
>> the test were not delegated to printk thread ("pr/ttyS0"). With the below
>> change, the softlock no longer shows up.
>> 
>> --- BEGIN ---
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index fd12efcc4..07c879a64 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -1639,6 +1639,7 @@ void nbcon_cpu_emergency_enter(void)
>>         cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
>>         (*cpu_emergency_nesting)++;
>>  }
>> +EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_enter);
>> 
>>  /**
>>   * nbcon_cpu_emergency_exit - Exit an emergency section
>> @@ -1656,6 +1657,7 @@ void nbcon_cpu_emergency_exit(void)
>> 
>>         preempt_enable();
>>  }
>> +EXPORT_SYMBOL_GPL(nbcon_cpu_emergency_exit);
>> 
>>  /**
>>   * nbcon_alloc - Allocate and init the nbcon console specific data
>> diff --git a/lib/reed_solomon/test_rslib.c b/lib/reed_solomon/test_rslib.c
>> index 75cb1adac..8208f8317 100644
>> --- a/lib/reed_solomon/test_rslib.c
>> +++ b/lib/reed_solomon/test_rslib.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/moduleparam.h>
>>  #include <linux/random.h>
>>  #include <linux/slab.h>
>> +#include <linux/console.h>
>> 
>>  enum verbosity {
>>         V_SILENT,
>> @@ -323,8 +324,11 @@ static int ex_rs_helper(struct rs_control *rs, struct wspace *ws,
>>         int nroots = rs->codec->nroots;
>>         int errs, eras, retval;
>> 
>> -       if (v >= V_PROGRESS)
>> +       if (v >= V_PROGRESS) {
>> +               nbcon_cpu_emergency_enter();
>>                 pr_info("  %s\n", desc[method]);
>> +               nbcon_cpu_emergency_exit();
>> +       }
>
> I do not understand how this prevented the softlockup.
>
> The emergency context causes that the messages is flushed directly
> from printk(), see nbcon_atomic_flush_pending() in vprintk_emit().
> But see neither cond_resched() nor touch_nmi_watchdog() in this
> code path.

Note there is still a touch_nmi_watchdog() in wait_for_lsr(). If the
console printing thread is on a different CPU, then its use of
touch_nmi_watchdog() will not help the CPU running the rslib test. By
forcing emergency context, now the CPU running the rslib test will be
calling touch_nmi_watchdog().

John Ogness
