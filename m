Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC1189B84;
	Fri, 26 Sep 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758897798; cv=none; b=a8BNq/Vlzu7+oPTcF+pngV9LgEYMvM1693ghdZK4/BG7ap6UrpPpNU/VR/s/eVIG9pQnRxmGwtqV2IoeBIpE1/FPSbif3EiNWsRWkKW/LSycVhXhMqI5k2/Oy8OfrVxusoOck9KAKIKbTrT7xJ2i+7t3GvVz9FOW4lCrThhK6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758897798; c=relaxed/simple;
	bh=/1wSTGnAQRVt41V2hI0ZzT9+Zwhxg/Rq2OuY8HFG470=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=brrSMPF1jcsQ+ACKYDhecXQpbLfQDQVijzX2sIdVNxcAnkNyNZX5yuJTea0lp1FdRB17fFG8gDUZGS9VO6hQ0Mo1pSiD2afGL8s5QKAkY3qKUb/dYxQNnWcCB6DU1ug28j6y2a/nQIsNkYYBqB9lJKi3wETU49hPhg0h5quFNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoBTlk8n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8ph6xF2C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoBTlk8n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8ph6xF2C"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758897792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1IBczeEJpVQcM5jLgYJ9cWY9abCJj+XfKLD28bakKl0=;
	b=UoBTlk8nUa/+SGgQEz/qXMj17X+JLNb1IGtNr4L4r6wzn4uIgbL4eDA0jvDBe7L8+HP930
	PKu2UsJ134FzmIfYYX6S8g0Db5YdDGxVFaxgPo5VLRv4wMi5FaYyvhfSMV391cXSDhELYp
	lgR/LS2Na+qFAN30rcvz+HlBGtVKLmEv/3AStcCWei8DJdojfpQRU1uqm+OgrxSX7NxF93
	0QIdg/b5crgw+HicmNRyK+UCNARu5ZW4H5SSzeLVug0VWqYz0qXjntflRj7ripNqtr6JOp
	LB91wEHF3XuNk5rMU5rQVnSR08H4imoktMLaDYT3/Vus0YGkRWREPh81J8+8bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758897792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1IBczeEJpVQcM5jLgYJ9cWY9abCJj+XfKLD28bakKl0=;
	b=8ph6xF2C80BCtGlQfW3tmE8Hq0BUjuTTd0e18wYdBrenUqMzIqwBecYbYgYAuaWRStV5Y3
	w2FmgYIzRX99NvBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, Andrew
 Murray <amurray@thegoodpenguin.co.uk>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/3] printk/nbcon: Release nbcon consoles ownership in
 atomic flush after each emitted record
In-Reply-To: <20250926124912.243464-4-pmladek@suse.com>
References: <20250926124912.243464-1-pmladek@suse.com>
 <20250926124912.243464-4-pmladek@suse.com>
Date: Fri, 26 Sep 2025 16:49:12 +0206
Message-ID: <84v7l5gtq7.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-26, Petr Mladek <pmladek@suse.com> wrote:
> printk() tries to flush messages with NBCON_PRIO_EMERGENCY on
> nbcon consoles immediately. It might take seconds to flush all
> pending lines on slow serial consoles. Note that there might be
> hundreds of messages, for example:
>
> [    3.771531][    T1] pci 0000:3e:08.1: [8086:324
> ** replaying previous printk message **
> [    3.771531][    T1] pci 0000:3e:08.1: [8086:3246] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
> [ ... more than 2000 lines, about 200kB messages ... ]
> [    3.837752][    T1] pci 0000:20:01.0: Adding to iommu group 18
> [    3.837851][    T
> ** replaying previous printk message **
> [    3.837851][    T1] pci 0000:20:03.0: Adding to iommu group 19
> [    3.837946][    T1] pci 0000:20:05.0: Adding to iommu group 20
> [ ... more than 500 messages for iommu groups 21-590 ...]
> [    3.912932][    T1] pci 0000:f6:00.1: Adding to iommu group 591
> [    3.913070][    T1] pci 0000:f6:00.2: Adding to iommu group 592
> [    3.913243][    T1] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    3.913245][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    3.913245][    T1] software IO TLB: mapped [mem 0x000000004f000000-0x0000000053000000] (64MB)
> [    3.913324][    T1] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
> [    3.913325][    T1] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    3.913326][    T1] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    3.913327][    T1] RAPL PMU: hw unit of domain psys 2^-0 Joules
> [    3.933486][    T1] ------------[ cut here ]------------
> [    3.933488][    T1] WARNING: CPU: 2 PID: 1 at arch/x86/events/intel/uncore.c:1156 uncore_pci_pmu_register+0x15e/0x180
> [    3.930291][    C0] watchdog: Watchdog detected hard LOCKUP on cpu 0
> [    3.930291][    C0] Kernel panic - not syncing: Hard LOCKUP
> [...]
> [    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted...
> [...]
> [    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
> [    3.930291][    C0] Call Trace:
> [...]
> [    3.930291][    C0]  <TASK>
> [    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
> [    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
> [    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
> [    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
>
> The are visible two takeovers of the console ownership:
>
>   - The 1st one is triggered by the "WARNING: CPU: 2 PID: 1 at
>     arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.
>
>   - The 2nd one is triggered by the "Kernel panic - not syncing:
>     Hard LOCKUP" line printed with NBCON_PRIO_PANIC.
>
> There are more than 2500 lines, at about 240kB, emitted between
> the takeover and the 1st "WARNING" line in the emergency context.
> This amount of pending messages had to be flushed by
> nbcon_atomic_flush_pending() when WARN() printed its first line.
>
> The atomic flush was holding the nbcon console context for too long so
> that it triggered hard lockup on the CPU running the printk kthread
> "pr/ttyS0". The kthread needed to reacquire the console ownership
> for restoring the original serial port state in serial8250_console_write().
>
> Prevent the hardlockup by releasing the nbcon console ownership after
> each emitted record.
>
> Note that __nbcon_atomic_flush_pending_con() used to hold the console
> ownership all the time because it blocked the printk kthread. Otherwise
> the kthread tried to flush the messages in parallel which caused repeated
> takeovers and more replayed messages.
>
> It is not longer a problem because the repeated takeovers are blocked
> by the counter of emergency contexts, see nbcon_cpu_emergency_cnt.
>
> Link: https://lore.kernel.org/all/aNQO-zl3k1l4ENfy@pathway.suse.cz
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

Looks good and performs as advertised.
