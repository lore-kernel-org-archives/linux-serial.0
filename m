Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F91DB940;
	Mon,  2 Dec 2024 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733180028; cv=none; b=tjw28cjk0yS7xMLjCYepYWY6LU5Ing2EIO1R9f1kfZ8hqXHHX7HGIpU24fvh8vU7dkpbtTz1qTXhJAzK9MenHuzsV1Z7hCUe1JzzVcfsvNjVPDzKji8YpJMUJiXdvubu5K2sFTqIHsqymZHenmTVeCz2IPNAAqtdkxvDiZ+lzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733180028; c=relaxed/simple;
	bh=umAtyiEdVDSEwuVpr46VQyUei4fpNCUW6qDeIBUuwB8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=R5QNIwUiStQEJAsS5Hree+nrNL5PAwE1n2bYiXVmohO3pqOJEr8Aan8Y/zX70wI/Mij9Z7ee+IfrRx83cZjEmp3t81E4R4GgG2zXnfAXPnwekfy91A9IQnUhOwzL4X6E5AJmtopTNkbgyAwnDGnENysc/mKGo77Bz4CpINhL0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cMqdO3vd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6lXaYpf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cMqdO3vd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6lXaYpf"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733180024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Z/7ozj1F9DWdKtUweFnvIkBOQ9IWOLmUOfgEfHrhgB0=;
	b=cMqdO3vdgSDQRkyM7PWYleXsyFt9/dosXGlh1HhKOWs08QdyNqSt4v+x0/X93u/AEqMCWK
	8COFJMnMuAVntfoBYAlFoad+6zvUx357b7LwU+HwxRuYC1uK0pxmrlKKRnl09DyFCKyOhz
	uyeIFypI3UIENid4RhqVQzNHvJuQXUIlpLbHLDwwwJZtZBFNXIfMSl1YmZhXIM/tJx8B5L
	j48Oe/sswjf4yPm8YE8hQTE+09yJHOApJFw8BdgYxeGYUVWTmeq3+w9cORQy/s+ebEhml+
	dyr+IfQ+2nRH6e0RgpkEFdM8VpNkt9LyR+BwxOVhlAN/LXh2ta9fxVgDv2HpmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733180024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=Z/7ozj1F9DWdKtUweFnvIkBOQ9IWOLmUOfgEfHrhgB0=;
	b=J6lXaYpf8lPziFD4PIC5ZIT1rO4RsdQ0VUpN6X+mg49S/o0Fp9+pVH7JUyEv52NLzToQlU
	sdJGEHgwdEuQcuDg==
To: Leonardo Bras <leobras@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, John Ogness <john.ogness@linutronix.de>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
In-Reply-To: <ZzvmvBdqJpAyUicm@LeoBras>
Date: Mon, 02 Dec 2024 23:53:43 +0100
Message-ID: <87ed2pvgqw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 18 2024 at 22:15, Leonardo Bras wrote:
> On Thu, Nov 14, 2024 at 09:50:36AM +0200, Andy Shevchenko wrote:
>> - the IRQ core disables IRQ while handling an IRQ number in question;
>
> Not necessarily:
> When on irqs are force-threaded, only a quick handler is called, returning 
> IRQ_WAKE_THREAD, which is supposed to wake up the handler thread.
>
>   * @IRQ_WAKE_THREAD:   handler requests to wake the handler thread
>
> In this case (which is what I am dealing with), the actual handler will run 
> in thread context (which I suppose don't disable IRQ for sched-out 
> purposes).

Let's talk about the disable irq concepts here. There are 3 distinct variants:

  1) Disable interrupts on the local CPU: local_irq_disable/save().

     This only prevents the CPU from handling a pending interrupt,
     but does not prevent new interrupts from being marked pending
     in the interrupt controller.

  2) Disable interrupts in the interrupt controller

     disable_irq*() variants handle that. They come with two
     flavors: LAZY and UNLAZY

     LAZY does not mask the interrupt line right away. It only is masked
     when an interrupt arrives while the line is marked "disabled". This
     then sets the PENDING bit, which in turn causes a replay of the
     interrupt once enable_irq() is bringing the disabled count down to
     zero. LAZY has two purposes:

       A) Prevent losing edge type interrupts

       B) Optimization to avoid the maybe costly hardware access

     UNLAZY masks the interrupt right away.

  3) Disable interrupts at the device level

     This prevents the device from raising interrupts.

Now there is another twist with force threaded interrupts.

If the interrupt is level triggered the interrupt line is masked in the
hard interrupt handler and unmasked when the thread returns.
         
For edge type interrupts that's handled differently in order to not lose
an edge. The line is not masked, so that if the device raises an
interrupt before the threaded handler returns, the threaded handler is
marked runnable again. That again comes in two flavors:

  1) Non-RT kernel

     That cannot result in a scenario where the force threaded handler
     loops and interrupts keep arriving at the CPU because the CPU has
     interrupts disabled across the force threaded handler and at least
     on x86 and arm64 that's the CPU which is target of the hardware
     interrupt.

     So at max there can come a few interrupts between the first
     interrupt and the threaded handler being scheduled in, but I doubt
     it can be more than three.

  2) RT kernel

     The forced threaded handler runs with CPU interrupts enabled, so
     when the threaded handler deals with the device, new interrupts can
     come in at the hardware level and are accounted for, which is what
     you are trying to address, right?

     So the total amount of TX bytes, i.e. PASS_LIMIT * tx_loadsz,
     becomes large enough to trigger the irq storm detector, right?

That obviously begs two questions:

  1) Why do you want to deal with this interrupt flood at the storm
     detector and not at the root cause of the whole thing?

     It does not make any sense to take a gazillion of interrupts for
     nothing and then work around the resulting detector fallout.

     The obvious adhoc cure is to add this to serial8250_interrupt():

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
        	disable_irq_nosync(irq);
                
        magic_loop();

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
        	enable_irq(irq);

     Ideally we'd disable interrupt generation in the IER register
     around the loop, but that's another can of worms as this can't be
     done easily without holding port lock across the IER disabled
     section. Also see below.


  2) Is the 512 iterations loop (PASS_LIMIT) still appropriate?

     That loop in serial8250_interrupt() looks pretty horrible even on a
     non-RT kernel with an emulated UART.

     The issue is mostly irrelevant on real hardware as the FIFO writes
     are faster than the UART can empty the FIFO. So unless there are
     two FIFO UARTs sharing the same interrupt line _and_ writing
     large amount of data at the same time the loop will terminate after
     one write cycle. There won't be an interrupt per TX byte either.

     On emulated hardware this is very different because the write
     causes a VMEXIT with a full round trip to user space, which
     consumes the character and immediately raises the TX empty
     interrupt again because there is no "slow" hardware involved.

     With the default qemu FIFO depth of 16 bytes, this results in up to
     512 * 16 = 8192 bytes written out with interrupts disabled for one
     invocation of the interrupt handler (threaded or not)...

     I just traced interrupt entry/exit in a VM and for a file with 256k
     bytes written to /dev/ttyS0 this results in:

     Interrupts:          35
     Bytes/Interrupt:  ~7490
     Tmax:            104725 us
     Tavg:             96778 us

     So one interrupt handler invocation which writes up to 8k takes
     roughly 100ms with interrupts disabled...

     Now looking at the host side. For every write to the TX FIFO there
     are _four_ invocations of kvm_set_irq() originating from kvm_vm_ioctl_irq_line():

      CPU 36/KVM-2063    [097] ..... 1466862.728737: kvm_pio: pio_write at 0x3f8 size 1 count 1 val 0xd 
      CPU 36/KVM-2063    [097] ..... 1466862.728742: kvm_set_irq: gsi 4 level 0 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728749: kvm_set_irq: gsi 4 level 0 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728754: kvm_set_irq: gsi 4 level 1 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728762: kvm_set_irq: gsi 4 level 1 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728783: kvm_pio: pio_write at 0x3f8 size 1 count 1 val 0xa 
      CPU 36/KVM-2063    [097] ..... 1466862.728787: kvm_set_irq: gsi 4 level 0 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728792: kvm_set_irq: gsi 4 level 0 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728797: kvm_set_irq: gsi 4 level 1 source 0
      CPU 36/KVM-2063    [097] ..... 1466862.728809: kvm_set_irq: gsi 4 level 1 source 0

     No idea why this needs four ioctls and not only two, but this
     clearly demonstrates that each byte written creates an edge
     interrupt. No surprise that the storm detector triggers on RT. But
     this also makes it clear why it's a patently bad idea to work
     around this in the detector...

     Now being "smart" and disabling THRI in the IER before the write
     loop in serial8250_tx_chars() changes the picture to:
     
      CPU 18/KVM-2045    [092] ..... 1466230.357478: kvm_pio: pio_write at 0x3f9 size 1 count 1 val 0x5

      IER.THRI is cleared now so it's expected that nothing fiddles with
      the interrupt line anymore, right? But ....

      CPU 18/KVM-2045    [092] ..... 1466230.357479: kvm_set_irq: gsi 4 level 0 source 0
      CPU 18/KVM-2045    [092] ..... 1466230.357481: kvm_set_irq: gsi 4 level 0 source 0
      CPU 18/KVM-2045    [092] ..... 1466230.357484: kvm_pio: pio_write at 0x3f8 size 1 count 1 val 0x73 
      CPU 18/KVM-2045    [092] ..... 1466230.357485: kvm_set_irq: gsi 4 level 0 source 0
      CPU 18/KVM-2045    [092] ..... 1466230.357487: kvm_set_irq: gsi 4 level 0 source 0
      CPU 18/KVM-2045    [092] ..... 1466230.357489: kvm_set_irq: gsi 4 level 0 source 0
      CPU 18/KVM-2045    [092] ..... 1466230.357491: kvm_set_irq: gsi 4 level 0 source 0
      ....

     So every write to the TX FIFO sets the level to 0 four times in a
     row to not create an edge. That's truly impressive!

Thanks,

        tglx
