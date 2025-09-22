Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996C30EF83
	for <linux-serial@vger.kernel.org>; Mon, 22 Sep 2025 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548458; cv=none; b=X00QymTKTNUOuPkWJnPcTQ764hK09hzSqIOQEhjRMxA27DmOZ+sdzf5IbQ41mIAUe6A3kOA6gERqV/fUN//xVOUPHURFI5f68Z65XdRgEe3JV5Vzp9atBC6pA2jiBrbHsWI13Zn+4CfUS+0vs/wekRGxRUOtAW5VKEU8mNRF0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548458; c=relaxed/simple;
	bh=djjs1Cgl+z9Z5ZYEvL9lLmg9iB7u3MaGPr2yWWIfhXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2x87UrjpaPS4IzyR9dR4K4I1CQa5XXulpVpS3D6aaAfILPa/Ipf6vgJOj1FxRa5OciB1uY1CVESQkJ/pVLVLX9tDrnrMVO6fcFGY71PAQMAe4cLADC4tXV23JNrLzbgfZxFfLocPa/Y9XIQ0csgh3cd2ibc5ZnKdaLqwJm+ea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z7vs6eKj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z7vs6eKj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so608578566b.2
        for <linux-serial@vger.kernel.org>; Mon, 22 Sep 2025 06:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758548454; x=1759153254; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sThF/jMu1V4SzL3oQOryent1v+YX6aWTBQ34qC6Glfg=;
        b=Z7vs6eKjjf6pr43tOOcjbUT8144KdZrOCqMqXZi/bTL+/JZGfw05du20rVErOibtnG
         Ymt1G4+yKlc9TqjXARX7mTG08Vq6cZAfRQlYLASydOur6MCG48F6yS+S/84V4Bswbl7V
         zkZGzVKyCZlQuOtpBM6SYgFzftR2uZv5ZNCji0Yzf97ciDCHVmcn/wDUKNqiH3uCzQXU
         4wwIG3WrbEJu6pdx11Y8DOQgnzwrEP+xn+bNw33at7dFs/+ONuea3kEjM5s4kisuAdWF
         N+ahQebrS3Pnio+l+JK0hJ+GR6dcFL3AXFJLUzCF3IsIOPqlfjx37mNxiYCv1CA9DeFd
         5mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548454; x=1759153254;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sThF/jMu1V4SzL3oQOryent1v+YX6aWTBQ34qC6Glfg=;
        b=khtpdmVy3Q1pRkpaIpsf9g2JGFdhw4R5SwjKeslKSjxGMzM9Ppo5VoAH8fDhH+bF3Q
         yPfB1n+Fkzlklbw66fKAfRgLWZPwDGq/adIiakLRmLu/KzFAPIP59DChwBLariJ7YGKv
         Ls2fou64R+FbaBI6UQwpehf/A+tE0CCzS511FDFbKvdAUpll1ihAMdmyZLuv4EosMRt6
         F9cUxo4eI+mPIhZNS//hJBRkC9ZnExjag/ydMeGagThQeuX7fOzJMxW2yNRGmW0BADBm
         Afg+QMUsifLQc9KQihc9wOLyLk1BZ0cOyBgf9mAWnUezNmo173m7HkIllQ8flmL/hoQu
         60Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVfM/0ThZnDtu9IRr8DLoyLXd19SzoFb6iYYEYXcE38PwUWXpJFmAtO4883lLOioK2KS4cmomHmBFO1A8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQHBw/WxAlzicZ4Gewxx3vc9qTLtQHgLXTeIwjmBbXhuCYxF0
	C6SAMmEhSwND89BPTlaSdPJKxyhxx9OVx4BnwTwlr6z487iAkMPOIBdDxy0RmqxLjQY=
X-Gm-Gg: ASbGncvCcVl5YrtJY0hB5zEwtsmh50irMhXs6MOHI/o0T3S797f7lFfM78i6uGHug7a
	5WrW/xXkIkmj41TTh0yn5FifalBqiMgt1kEw/68BEN5lKUCX+SR7Rs7Hcw3HAgWoh7bnceDY2yy
	8fJ98xExXw5Fki135PRi0+MZ1PatZgTCFF+X1I5VnBoR8Ij9/5co1cjYaUQdcX353lYQ1I6wJOD
	z8lvenyYSEAKDP7Du8YcRmqLICE8FrfixImr5R7daRR2e5GfgNUppIIgyrPGtl6pj8enKFolrnb
	s1mxQQl0deEwHx51xZ+M75fn29PUNbPD/vww4sddRPwuCGenOsjbuZsjh6qJ+GAwd/W9Q1dqqD3
	fuL6De9CYt9ApHjFB1kovRUseKQ==
X-Google-Smtp-Source: AGHT+IFPoHox6UJcsHYsLgHimGOjfFsVDm+Ai+pgMFcfzSX3knc0JhQx6I1T25o4tAWAp91FOunANA==
X-Received: by 2002:a17:907:7247:b0:b04:54dc:3048 with SMTP id a640c23a62f3a-b24ef97bd4fmr1352882666b.21.1758548454301;
        Mon, 22 Sep 2025 06:40:54 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29912fb4d2sm491461966b.14.2025.09.22.06.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:40:53 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:40:51 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
Message-ID: <aNFR45fL2L4PavNc@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84qzwzbr90.fsf@jogness.linutronix.de>

On Mon 2025-08-25 13:06:27, John Ogness wrote:
> On 2025-08-22, Petr Mladek <pmladek@suse.com> wrote:
> > Hi,
> >
> > this is a followup for the patchset which converted serial 8250
> > console driver to nbcon [1]. It was added into upstream but
> > the last two patches were later reverted because they caused
> > regressions.
> >
> > We have seen the following hardlockup report when using the converted
> > serial 8250 console driver:
> >
> > [    0.000000][    T0] Command line: elfcorehdr=0x145f000000  mitigations=auto security=selinux selinux=1 console=ttyS0,115200 earlyprintk=ttyS0,115200 ignore_loglevel panic=13 intel_iommu=on sysrq=yes reset_devices acpi_no_memhotplug cgroup_disable=memory nokaslr numa=off irqpoll nr_cpus=4 root=kdump rootflags=bind rd.udev.children-max=8 disable_cpu_apicid=0  
> > [...]
> > [    3.771531][    T1] pci 0000:3e:08.1: [8086:324
> > ** replaying previous printk message **
> > [    3.771531][    T1] pci 0000:3e:08.1: [8086:3246] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> > [ ... more than 2000 lines, about 200kB messages ... ]
> > [    3.837752][    T1] pci 0000:20:01.0: Adding to iommu group 18
> > [    3.837851][    T
> > ** replaying previous printk message **
> > [    3.837851][    T1] pci 0000:20:03.0: Adding to iommu group 19
> > [    3.837946][    T1] pci 0000:20:05.0: Adding to iommu group 20
> > [ ... more than 500 messages for iommu groups 21-590 ...]
> > [    3.912932][    T1] pci 0000:f6:00.1: Adding to iommu group 591
> > [    3.913070][    T1] pci 0000:f6:00.2: Adding to iommu group 592
> > [    3.913243][    T1] DMAR: Intel(R) Virtualization Technology for Directed I/O
> > [    3.913245][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> > [    3.913245][    T1] software IO TLB: mapped [mem 0x000000004f000000-0x0000000053000000] (64MB)
> > [    3.913324][    T1] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> > [    3.913325][    T1] RAPL PMU: hw unit of domain package 2^-14 Joules
> > [    3.913326][    T1] RAPL PMU: hw unit of domain dram 2^-14 Joules
> > [    3.913327][    T1] RAPL PMU: hw unit of domain psys 2^-0 Joules
> > [    3.933486][    T1] ------------[ cut here ]------------
> > [    3.933488][    T1] WARNING: CPU: 2 PID: 1 at arch/x86/events/intel/uncore.c:1156 uncore_pci_pmu_register+0x15e/0x180
> > [    3.930291][    C0] watchdog: Watchdog detected hard LOCKUP on cpu 0
> > [    3.930291][    C0] Modules linked in:
> > [    3.930291][    C0] Supported: No, Unreleased kernel
> > [    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted 6.12.0-160000.18-default #1 PREEMPT(voluntary) SLFO-1.2 (unreleased) dd174c2cca19586eee16eaccfeba02f4d5b57c67
> > [    3.930291][    C0] Hardware name: HPE ProLiant DL560 Gen11/ProLiant DL560 Gen11, BIOS 2.48 03/11/2025
> > [    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb eb 02 f3 90 <48> 89 df e8 b7 fc ff ff 84 c0 74 f2 48 8b 03 48 c7 43 28 00 00 00
> > [    3.930291][    C0] RSP: 0000:ffa0000000147d38 EFLAGS: 00000046
> > [    3.930291][    C0] RAX: 0000000000000000 RBX: ffa0000000147e78 RCX: 0000000000000001
> > [    3.930291][    C0] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffa0000000147e78
> > [    3.930291][    C0] RBP: ffa0000000147e78 R08: 0000000000000010 R09: 0000000000000000
> > [    3.930291][    C0] R10: 312e38303a65333a R11: 3030303020696370 R12: ff1100145f53f032
> > [    3.930291][    C0] R13: 0000000000000000 R14: ff1100145f53f032 R15: ff1100145f53f072
> > [    3.930291][    C0] FS:  0000000000000000(0000) GS:ff1100147ea00000(0000) knlGS:0000000000000000
> > [    3.930291][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    3.930291][    C0] CR2: ff1100147e402000 CR3: 000000147d238001 CR4: 0000000000f71ef0
> > [    3.930291][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    3.930291][    C0] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> > [    3.930291][    C0] PKRU: 55555554
> > [    3.930291][    C0] Call Trace:
> > [    3.930291][    C0]  <NMI>
> > [    3.930291][    C0]  ? watchdog_hardlockup_check.cold+0xe7/0xec
> > [    3.930291][    C0]  ? __perf_event_overflow+0x11b/0x380
> > [    3.930291][    C0]  ? handle_pmi_common+0x15c/0x3d0
> > [    3.930291][    C0]  ? intel_pmu_handle_irq+0x10f/0x5b0
> > [    3.930291][    C0]  ? perf_event_nmi_handler+0x2a/0x50
> > [    3.930291][    C0]  ? nmi_handle+0x5e/0x120
> > [    3.930291][    C0]  ? default_do_nmi+0x40/0x130
> > [    3.930291][    C0]  ? exc_nmi+0x187/0x240
> > [    3.930291][    C0]  ? end_repeat_nmi+0xf/0x53
> > [    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0]  </NMI>
> > [    3.930291][    C0]  <TASK>
> > [    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
> > [    3.930291][    C0]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > [    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
> > [    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
> > [    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
> > [    3.930291][    C0]  ? __pfx_nbcon_kthread_func+0x10/0x10
> > [    3.930291][    C0]  kthread+0xcd/0x110
> > [    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
> > [    3.930291][    C0]  ret_from_fork+0x31/0x50
> > [    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
> > [    3.930291][    C0]  ret_from_fork_asm+0x1a/0x30
> > [    3.930291][    C0]  </TASK>
> > [    3.930291][    C0] Kernel panic - not syncing: Hard LOCKUP
> > [    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted 6.12.0-160000.18-default #1 PREEMPT(voluntary) SLFO-1.2 (unreleased) dd174c2cca19586eee16eaccfeba02f4d5b57c67
> > [    3.930291][    C0] Hardware name: HPE ProLiant DL560 Gen11/ProLiant DL560 Gen11, BIOS 2.48 03/11/2025
> > [    3.930291][    C0] Call Trace:
> > [    3.930291][    C0]  <NMI>
> > [    3.930291][    C0]  dump_stack_lvl+0x4b/0x70
> > [    3.930291][    C0]  panic+0x106/0x2d3
> > [    3.930291][    C0]  nmi_panic.cold+0xc/0xc
> > [    3.930291][    C0]  watchdog_hardlockup_check.cold+0xca/0xec
> > [    3.930291][    C0]  __perf_event_overflow+0x11b/0x380
> > [    3.930291][    C0]  handle_pmi_common+0x15c/0x3d0
> > [    3.930291][    C0]  intel_pmu_handle_irq+0x10f/0x5b0
> > [    3.930291][    C0]  perf_event_nmi_handler+0x2a/0x50
> > [    3.930291][    C0]  nmi_handle+0x5e/0x120
> > [    3.930291][    C0]  default_do_nmi+0x40/0x130
> > [    3.930291][    C0]  exc_nmi+0x187/0x240
> > [    3.930291][    C0]  end_repeat_nmi+0xf/0x53
> > [    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb eb 02 f3 90 <48> 89 df e8 b7 fc ff ff 84 c0 74 f2 48 8b 03 48 c7 43 28 00 00 00
> > [    3.930291][    C0] RSP: 0000:ffa0000000147d38 EFLAGS: 00000046
> > [    3.930291][    C0] RAX: 0000000000000000 RBX: ffa0000000147e78 RCX: 0000000000000001
> > [    3.930291][    C0] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffa0000000147e78
> > [    3.930291][    C0] RBP: ffa0000000147e78 R08: 0000000000000010 R09: 0000000000000000
> > [    3.930291][    C0] R10: 312e38303a65333a R11: 3030303020696370 R12: ff1100145f53f032
> > [    3.930291][    C0] R13: 0000000000000000 R14: ff1100145f53f032 R15: ff1100145f53f072
> > [    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
> > [    3.930291][    C0]  </NMI>
> > [    3.930291][    C0]  <TASK>
> > [    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
> > [    3.930291][    C0]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > [    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
> > [    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
> > [    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
> > [    3.930291][    C0]  ? __pfx_nbcon_kthread_func+0x10/0x10
> > [    3.930291][    C0]  kthread+0xcd/0x110
> > [    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
> > [    3.930291][    C0]  ret_from_fork+0x31/0x50
> > [    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
> > [    3.930291][    C0]  ret_from_fork_asm+0x1a/0x30
> > [    3.930291][    C0]  </TASK>
> > [    3.930291][    C0] Shutting down cpus with NMI
> > [    3.930291][    C0] Rebooting in 13 seconds..  
> >
> >
> > There are clearly visible two points where nbcon_atomic_flush_pending()
> > took over the ownership from a lover priority context. I believe that:
> >
> >   + 1st occurrence is triggered by the "WARNING: CPU: 2 PID: 1 at
> >     arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.
> >
> >   + 2nd occurrence is triggered by the "Kernel panic - not syncing:
> >     Hard LOCKUP" line printed with NBCON_PRIO_PANIC.
> >
> > There were flushed more than 2500lines, about 240kB of characters,
> > in the NBCON_PRIO_EMERGENCY before the hardlockup detector
> > triggered panic.
> >
> > If I count it correctly, a serial console with the speed 115200 baud/sec
> > would be able to emit about 11.5kB/sec. And it would take about 20sec
> > to emit the 240kB of messages.
> >
> > => softlockup is quite realistic
> >
> > Solution:
> >
> > IMHO, we really should flush all pending messages atomically.
> > It means that the watchdog reports need to be prevented
> > by touching the watchdog. It is not needed in
> > univ8250_console_write_thread()
> >
> > => put back touch_nmi_watchdog() into univ8250_console_write_atomic().
> 
> I would expect the touch_nmi_watchdog() within wait_for_lsr() to be
> sufficient. After all, that is the loop that leads to the large emit
> times.

Good point. I was not aware of this touch_nmi_watchdog().

> For QEMU, the touch_nmi_watchdog() within wait_for_lsr() will never be
> called because QEMU does not implement baud rates. So that may be reason
> enough to accept this change.

Another good point.

Well, the original problem happened on bare metal. And the problem
was reporoducible even with the extra touch_nmi_watchog() in
univ8250_console_write_atomic().

I was confused _until_ I realized that touch_nmi_watchog()
modified per-CPU variable:

notrace void arch_touch_nmi_watchdog(void)
{
	raw_cpu_write(watchdog_hardlockup_touched, true);
}

And the hardlockup detector checked only the one per-CPU variable
as well:

void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs)
{
	if (per_cpu(watchdog_hardlockup_touched, cpu)) {
		per_cpu(watchdog_hardlockup_touched, cpu) = false;
		return;
	}
[...]
}

By other words, touch_nmi_watchog() delays hardlockup report
only on the given CPU.

But we have two CPUs stuck by printk:

1. CPU2 is calling WARN():

   [    3.933488][    T1] WARNING: CPU: 2 PID: 1 at arch/x86/events/intel/uncore.c:1156 uncore_pci_pmu_register+0x15e/0x180

   It gets busy with flushing the backlog of pending messages
   in the emergency context.

   This context regularly touches the watchodog.
   So far, so good.


2. CPU0 tries to reacquire the console ownership so that it could
   restore IRQ settting from the printk kthread.

   The nbcon_reacquire_nobuf() is called with disabled IRQs
   so that it might trigger hardlockup. And it clearly
   happens:

   [    3.930291][    C0] watchdog: Watchdog detected hard LOCKUP on cpu 0
   [    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted 6.12.0-160000.18-default #1 PREEMPT(voluntary) SLFO-1.2 (unreleased) dd174c2cca19586eee16eaccfeba02f4d5b57c67
   [    3.930291][    C0] Hardware name: HPE ProLiant DL560 Gen11/ProLiant DL560 Gen11, BIOS 2.48 03/11/2025
   [    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
   [...]
   [    3.930291][    C0]  <TASK>
   [    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
   [    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
   [    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
   [    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0


Note that CPU2 keeps the nbcon console ownership until all pending
messages are flushed and the ownership is blocked for a long
time:

static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
					    bool allow_unsafe_takeover)
{
	if (!nbcon_context_try_acquire(ctxt, false))
		return -EPERM;

	while (nbcon_seq_read(con) < stop_seq) {
		if (!nbcon_emit_next_record(&wctxt, true))
			return -EAGAIN;
	}

	nbcon_context_release(ctxt);
}

An solution is to touch the watchdog also in nbcon_reacquire_nobuf()
because it might get blocked from known reasons. Something like:

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 646801813415..dd5966261b09 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -12,6 +12,7 @@
 #include <linux/irqflags.h>
 #include <linux/kthread.h>
 #include <linux/minmax.h>
+#include <linux/nmi.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/slab.h>
@@ -932,8 +933,10 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 
-	while (!nbcon_context_try_acquire(ctxt, true))
+	while (!nbcon_context_try_acquire(ctxt, true)) {
+		touch_nmi_watchdog();
 		cpu_relax();
+	}
 
 	nbcon_write_context_set_buf(wctxt, NULL, 0);
 }


Alternative solution would be to release the console ownership in
__nbcon_atomic_flush_pending_con() between each record. It might
give the kthread a chance to restore the IRQ setting an continue.

It might be better. But we would need to make sure that the kthread
would stay blocked until the emergency context flushes all messages.
Otherwise, the kthread would repeatedly lose the console ownership
in the middle of the message when __nbcon_atomic_flush_pending_con()
would acquire the context with NBCON_EMERGENCY_PRIO for the next
pending message.

We might need similar handshake also between panic and emergency
context.

I am not sure if this is worth the complexity.

What do you think?

Best Regards,
Petr
