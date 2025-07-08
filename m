Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEE02D613;
	Tue,  8 Jul 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983252; cv=none; b=N7n3Afe48+aKPeD2y/APBX08byNl6b5kXRJVl7MvUZdPGP1drWqoxqN+C39/t20Em/gHiL/I1ZM3CKRTPMXDcGUPxuTsSoYEgKx9eQ5Yd1zwvmlOhmnh2pSwaRf6o3yK+F63gSW1MczE9V6sPZsWLgJ7TWON2uu29OofBp7PUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983252; c=relaxed/simple;
	bh=XReFg8lzS1pkGZT0P1YIXIvT032iwGoONRTTI9SRBRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQXi3aGcQaUVcqGR9WDNRo1/qU++oa4+g2AgL33HGgkeYDQDUH/HvEE9w7wvhEUYY1h0Db7vOugodsdbr64iikHqkCdQps29Nh1+ay+LWcWgExVUKDxy9/xACVnBwoQk30I9BUh5QgkeyeME0j4B0kAg3scBYd6Z3gPIwW/vERA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so737356566b.0;
        Tue, 08 Jul 2025 07:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751983249; x=1752588049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YURTXCptCSZEmhbUYCBqxZVrD3kYao1LSH9kzVWrsc=;
        b=nO/arqi3XkVWVHQXtMVnReZ7wL2c5aZx/sNPU1VwhoWpkfBAEVItJZFoJAuMMaLbS2
         0BNXAr9ndPxLEQgiF8wE0DPdS8sYQyx4ms3C0UkGxL5eclHI5MHy1JFEjSF27SZEHsgT
         nplinuN/blhUSueM3CBCW+1sCxwig7FaVY+YB3SGhXjaqKXnPJjWecdiFj6dsvZnTBQA
         aCtT0OjSNE8CouoTwQLxDzR3puqayhH47VEbjrpBbFiRnSMRFNFrAJ3w46WfbmV/LBpH
         h1k0v2fkToUD737FYy7HOpHBXFGmtSwjoNq/OIYEUtcuUY01/faW/EDA71o2qSiAQ0xn
         qiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGPOGrcFINZD3Fqb6Kymo6wKGzOW7VlU88P++vpsPr6wg66UkdsZhyZXdVT+EGDQ/MEVUVZnLiqmhDx/o=@vger.kernel.org, AJvYcCXHb5j3gEC/hsKI6EmMJXsTceA+H21yhG+eO56bbNlWOzg3/tTzG7rUfmKf4yN+y/8B/nQaDKSgWbSHI6Es@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wXJHoDQVvdFsGBLsH6sAO3xn/8eP/CgcB80rg6H47en+501P
	zm1m9Ssu19YeOOrYTrubvY3VIBmKE4QO5+B61vFvKrLfhs7YiBBoTenH
X-Gm-Gg: ASbGncufcBSPy4nWeN/6WgeKnH4+X4lWVh4JC+a70YedTS6mImOg/kFEPibnDGjFaX8
	dZ+E/G/rTwrKGek/iqwv0Kx3eU8sbaYxCaVxHf/YlBLieWA722aTAZ3k7TF1Sd2hGJADFX4rCvn
	idBxMrTXlgA5sBJkKl9au2aH8NMTOIfqSGDUcu8HHzq4N5oDh2kVpc6+pEDjMDzx2MQo38P8Z0d
	nXrpsRepsvcYXp5mBZq6QMyP0fBKUEhVxgXZkmfvRGKR5OhRCAwes0+7djDvY8+5rfaqCnu0PaU
	tRrtFLNggEAMMUBAaubJDt0KzlxizFVny56ij92iPvRj0whE7S2t+954FXZY2Y0=
X-Google-Smtp-Source: AGHT+IGXOKNS8CCiY5x6OJiBuZ2ATOTUIIt4Qq9+KAF8vaEWWbhlFc9sESTRoxEkjQhwxHSfc/uYLg==
X-Received: by 2002:a17:907:d86:b0:ade:484d:1518 with SMTP id a640c23a62f3a-ae3fe6be48bmr1664163466b.26.1751983248358;
        Tue, 08 Jul 2025 07:00:48 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6ac5f80sm911998166b.97.2025.07.08.07.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:00:47 -0700 (PDT)
Date: Tue, 8 Jul 2025 07:00:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Rutland <mark.rutland@arm.com>, ankita@nvidia.com,
	bwicaksono@nvidia.com
Cc: rmk+kernel@armlinux.org.uk, catalin.marinas@arm.com,
	linux-serial@vger.kernel.org, rmikey@meta.com,
	linux-arm-kernel@lists.infradead.org, usamaarif642@gmail.com,
	leo.yan@arm.com, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	Ankit Agrawal <ankita@nvidia.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>
Subject: Re: arm64: csdlock at early boot due to slow serial (?)
Message-ID: <aG0kYjl/sphGqd4r@gmail.com>
References: <aGVn/SnOvwWewkOW@gmail.com>
 <aGZbYmV26kUKJwu_@J2N7QTR9R3>
 <aGaQBghdAl8VGWmV@gmail.com>
 <aGawTd8N2i8MDCmL@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGawTd8N2i8MDCmL@J2N7QTR9R3>

On Thu, Jul 03, 2025 at 05:31:09PM +0100, Mark Rutland wrote:

> > How do I find the SoC exactly?
> 
> >From what you've told me above, the SoC is Nvidia Grace; what they call
> the CPU is the whole SoC.
> 
> > > Likewise that might imply more folk to add to Cc.
> 
> I've added Ankit and Besar, since they've both worked on some system
> level bits on Grace, and might have an idea.
> 
> Ankit, Besar, are you aware of any UART issues on Grace (as described in
> Breno's messages below), or do you know of anyone who might have an
> idea?

Here is more information I got about this problem. TL;DR: While the
machine is booting, it is throttled by the UART speed, while having IRQ
disabled.

Here is my line of investigation:

1) when the kernel start to flush the messages, there are ~700 messages
   in the buffer that will be flushed using
   pl011_console_write_atomic()

	[    0.653673] printk: console [ttyAMA0] enabled
	[    9.239225] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])

 a) pl011_console_write_atomic() is called  ~700 times. Each message
 have around 50 chars.

 b) For each char, it needs to wait for it to be sent before proceeding.

3) pl011_console_write_atomic() have two big while()/cpu_relax() blocks.
   One per character and one per message.

    a) the first one is in pl011_console_putchar(), where it checks if the
    FIFO is full before writing a single character. This is done one per
    character.

          while (pl011_read(uap, REG_FR) & UART01x_FR_TXFF)
                  cpu_relax();
	 
    b) After the line is written, then it hits the second one, in
    pl011_console_write_atomic(), where it waits until the controller is
    not busy anymore:

              while ((pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr) & uap->vendor->fr_busy)
                  cpu_relax();
	

4) The controller has FIFO enabled, but, it doesn't help much, because
   the CPU is waiting for the 700 * 50 chars to be transmitted.

5) At this time we just have one single CPU online (?)

6) This is done with IRQ disabled, which causes a CSD lock to trigger,
   given that the CPU has IRQ disabled


   a) Following Paul's suggestion, I added
   a `lockdep_assert_irqs_enabled()` at the entrance of
   pl011_console_write_atomic(), and that is what I see.

	hardirqs last  enabled at (256267): [<ffff800080364980>] vprintk_store+0x6f8/0x820
	hardirqs last disabled at (256268): [<ffff80008036e1c4>] __nbcon_atomic_flush_pending+0x2c4/0x3e8
	softirqs last  enabled at (255640): [<ffff8000801bb020>] handle_softirqs+0x910/0xe78
	softirqs last disabled at (255635): [<ffff800080010938>] __do_softirq+0x18/0x20

  b) This is the full stack in how we are calling cpu_relax() with irq
  disabled million times:

	WARNING: CPU: 0 PID: 1 at drivers/tty/serial/amba-pl011.c:2545 pl011_console_write_atomic (drivers/tty/serial/amba-pl011.c:2545)
	Modules linked in:
	pstate: 234003c9 (nzCv DAIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
	pc : pl011_console_write_atomic (drivers/tty/serial/amba-pl011.c:2545)
	lr : pl011_console_write_atomic (drivers/tty/serial/amba-pl011.c:2545)
	sp : ffff80008980dca0
	pmr: 000000f0
	x29: ffff80008980dca0 x28: ffff0000aebcc080 x27: dfff800000000000
	x26: 1fffe00015d7985a x25: 0000000000000000 x24: 0000000000000000
	x23: ffff0000a1800000 x22: ffff800087e6d7f8 x21: 1fffe00015d7985b
	x20: ffff80008980dee0 x19: 0000000000000003 x18: 00000000ffffffff
	x17: 30313478305b2030 x16: 3030303230303030 x15: 3078302055504320
	x14: 6c61636973796870 x13: 0a2a2a2065676173 x12: ffff700011301b8b
	x11: 1ffff00011301b8a x10: ffff700011301b8a x9 : ffff800081eafdb4
	x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000000000000
	x5 : 1ffff00011301be2 x4 : 0000000000000018 x3 : 0000000000000000
	x2 : 1ffff00010fcdb57 x1 : 0000000000000000 x0 : 0000000000000001
	Call trace:
	pl011_console_write_atomic (drivers/tty/serial/amba-pl011.c:2545) (P)
	nbcon_emit_next_record (kernel/printk/nbcon.c:1026)
	__nbcon_atomic_flush_pending_con (kernel/printk/nbcon.c:1498)
	__nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1541 kernel/printk/nbcon.c:1593)
	nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1610)
	vprintk_emit (kernel/printk/printk.c:2429)
	vprintk_default (kernel/printk/printk.c:2466)
	vprintk (kernel/printk/printk_safe.c:83)
	_printk (kernel/printk/printk.c:2470)
	__warn (kernel/panic.c:768)
	report_bug (lib/bug.c:197 lib/bug.c:215)
	bug_handler (arch/arm64/kernel/traps.c:1002)
	call_break_hook (arch/arm64/kernel/debug-monitors.c:319)
	brk_handler (arch/arm64/kernel/debug-monitors.c:325)
	do_debug_exception (arch/arm64/mm/fault.c:1002)
	el1_dbg (arch/arm64/kernel/entry-common.c:514)
	el1h_64_sync_handler (arch/arm64/kernel/entry-common.c:567)
	el1h_64_sync (arch/arm64/kernel/entry.S:595)
	pl011_console_write_atomic (drivers/tty/serial/amba-pl011.c:2524) (P)
	nbcon_emit_next_record (kernel/printk/nbcon.c:1026)
	__nbcon_atomic_flush_pending_con (kernel/printk/nbcon.c:1498)
	__nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1541 kernel/printk/nbcon.c:1593)
	nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1610)
	vprintk_emit (kernel/printk/printk.c:2429)
	vprintk_default (kernel/printk/printk.c:2466)
	vprintk (kernel/printk/printk_safe.c:83)
	_printk (kernel/printk/printk.c:2470)
	register_console (kernel/printk/printk.c:4126 (discriminator 9))
	serial_core_register_port (drivers/tty/serial/serial_core.c:2637 drivers/tty/serial/serial_core.c:3157 drivers/tty/serial/serial_core.c:3388)
	serial_ctrl_register_port (drivers/tty/serial/serial_ctrl.c:42)
	uart_add_one_port (drivers/tty/serial/serial_port.c:144)
	pl011_register_port (drivers/tty/serial/amba-pl011.c:2867)
	sbsa_uart_probe (drivers/tty/serial/amba-pl011.c:3041)
	platform_probe (drivers/base/platform.c:1405)
	really_probe (drivers/base/dd.c:579 drivers/base/dd.c:657)
	__driver_probe_device (drivers/base/dd.c:799)
	driver_probe_device (drivers/base/dd.c:829)
	__device_attach_driver (drivers/base/dd.c:958)
	bus_for_each_drv (drivers/base/bus.c:462)
	__device_attach (drivers/base/dd.c:1031)
	device_initial_probe (drivers/base/dd.c:1079)
	bus_probe_device (drivers/base/bus.c:537)
	device_add (drivers/base/core.c:3699)
	platform_device_add (drivers/base/platform.c:716)
	platform_device_register_full (drivers/base/platform.c:845)
	acpi_create_platform_device (./include/linux/err.h:70 drivers/acpi/acpi_platform.c:178)
	acpi_bus_attach (./include/linux/acpi.h:738 drivers/acpi/scan.c:2206 drivers/acpi/scan.c:2198 drivers/acpi/scan.c:2316)
	acpi_dev_for_one_check (drivers/acpi/bus.c:1146)
	device_for_each_child (drivers/base/core.c:4021)
	acpi_dev_for_each_child (drivers/acpi/bus.c:1151)
	acpi_bus_attach (drivers/acpi/scan.c:2323)
	acpi_dev_for_one_check (drivers/acpi/bus.c:1146)
	device_for_each_child (drivers/base/core.c:4021)
	acpi_dev_for_each_child (drivers/acpi/bus.c:1151)
	acpi_bus_attach (drivers/acpi/scan.c:2323)
	acpi_bus_scan (drivers/acpi/scan.c:2533 drivers/acpi/scan.c:2606)
	acpi_scan_init (drivers/acpi/scan.c:2739)
	acpi_init (drivers/acpi/bus.c:1470)
	do_one_initcall (init/main.c:1274)
	kernel_init_freeable (init/main.c:1335 init/main.c:1352 init/main.c:1371 init/main.c:1584)
	kernel_init (init/main.c:1476)
	ret_from_fork (arch/arm64/kernel/entry.S:863)
	irq event stamp: 256268
	hardirqs last enabled at (256267): vprintk_store (kernel/printk/printk.c:2356 (discriminator 1))
	hardirqs last disabled at (256268): __nbcon_atomic_flush_pending (kernel/printk/nbcon.c:1539 kernel/printk/nbcon.c:1593)
	softirqs last enabled at (255640): handle_softirqs (./arch/arm64/include/asm/current.h:19 ./arch/arm64/include/asm/preempt.h:13 kernel/softirq.c:426 kernel/softirq.c:607)
	softirqs last disabled at (255635): __do_softirq (kernel/softirq.c:614)
	---[ end trace 0000000000000000 ]---

