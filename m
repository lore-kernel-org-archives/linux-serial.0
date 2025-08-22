Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393AD327797
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872709; cv=none; b=R7vcZSDUmeSBzVNZwTQMvnJCQoEX2W6fO1fy09LpH0sj9YizSX626H987d7M0KGHiowiwkym2/LRheMOKCDvV/NlCjVLSuH8L2IavtKZxQ4qEhL0UQmR4Ni5+MN/Tao9Yf516b/eYdyfNBsTbQQj7belND0X9CIqpGlY3/23Jrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872709; c=relaxed/simple;
	bh=8YTQgAFVKnhHYQ1Q6q79wp+U6I02XgGNAva0c1MOPa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PGlWM3iKDfVGWyiONsvRJs63sZ2bH1lU7wPh8ICjA2PKFOh+mG8jhdu4sS1dmPeT5UFoC0e2mAp1BmTefAsPexYl7S/wH15sNpTN8zzGNQJ7loJNYyj+Rg46q2GnkyeP2YSsEKJXzpPXoyfheFvliSPPs4yydaLHW4ZvHXfbOc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LPGXRVaC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N4O6WpkF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LPGXRVaC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N4O6WpkF"
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1a::1129])
	by smtp-out2.suse.de (Postfix) with ESMTP id 247D31F38E;
	Fri, 22 Aug 2025 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755872705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HuPQzNtbk6yN0wy8AslSqdT08Xq1kpv1h1dnrnbEasg=;
	b=LPGXRVaCM8WPj8i5XdZ2Awz/VOTnu60DQayY0OnyVobD+cxQUrF715JZiofT//nC9v2A6h
	IUyzaozIbFPr0HoKqmONzBzr229LDkgnv2+munr7VML3b6D03XVyGeidIRJyqdcnUhK5do
	LN0WAMaX8ialC3BX2t6QApIxnGwuUeU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=N4O6WpkF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755872704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=HuPQzNtbk6yN0wy8AslSqdT08Xq1kpv1h1dnrnbEasg=;
	b=N4O6WpkFZKF1u5a8v1rMoEgYw3kaU1B4R0J9LOq2Z5TiTL+M97iVBwOqnEVf/4r5V08+HX
	f0fuNhPdFT4Xe6eqRigHDbN1sfbW0GNGlilUYq0f7vtrDjJxGW/0bwJFozDtINmlxanWJ8
	XCz1elf7ylxEZxKiGOLrH4fBuViJhuI=
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Esben Haabendal <esben@geanix.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Serge Semin <fancer.lancer@gmail.com>
Subject: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might trigger watchdog warnigns
Date: Fri, 22 Aug 2025 16:25:01 +0200
Message-ID: <20250822142502.69917-1-pmladek@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: **************************
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [26.56 / 50.00];
	BAYES_SPAM(5.10)[100.00%];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	NEURAL_SPAM_SHORT(2.97)[0.990];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	MID_CONTAINS_FROM(1.00)[];
	HFILTER_HELO_IP_A(1.00)[pathway.suse.cz];
	R_MISSING_CHARSET(0.50)[];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[pathway.suse.cz];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1a::1129:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[git-send-email 2.50.1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	GREYLIST(0.00)[pass,body];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,suse.com,chromium.org,goodmis.org,linutronix.de,geanix.com,vger.kernel.org,linux.intel.com,arndb.de,atomide.com,linux.ibm.com,gmail.com];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b2bf:1a::1129:from];
	R_DKIM_ALLOW(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spamd-Bar: ++++++++++++++++++++++++++
X-Rspamd-Queue-Id: 247D31F38E
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Score: 26.56
X-Spam: Yes

Hi,

this is a followup for the patchset which converted serial 8250
console driver to nbcon [1]. It was added into upstream but
the last two patches were later reverted because they caused
regressions.

We have seen the following hardlockup report when using the converted
serial 8250 console driver:

[    0.000000][    T0] Command line: elfcorehdr=0x145f000000  mitigations=auto security=selinux selinux=1 console=ttyS0,115200 earlyprintk=ttyS0,115200 ignore_loglevel panic=13 intel_iommu=on sysrq=yes reset_devices acpi_no_memhotplug cgroup_disable=memory nokaslr numa=off irqpoll nr_cpus=4 root=kdump rootflags=bind rd.udev.children-max=8 disable_cpu_apicid=0  
[...]
[    3.771531][    T1] pci 0000:3e:08.1: [8086:324
** replaying previous printk message **
[    3.771531][    T1] pci 0000:3e:08.1: [8086:3246] type 00 class 0x088000 PCIe Root Complex Integrated Endpoint
[ ... more than 2000 lines, about 200kB messages ... ]
[    3.837752][    T1] pci 0000:20:01.0: Adding to iommu group 18
[    3.837851][    T
** replaying previous printk message **
[    3.837851][    T1] pci 0000:20:03.0: Adding to iommu group 19
[    3.837946][    T1] pci 0000:20:05.0: Adding to iommu group 20
[ ... more than 500 messages for iommu groups 21-590 ...]
[    3.912932][    T1] pci 0000:f6:00.1: Adding to iommu group 591
[    3.913070][    T1] pci 0000:f6:00.2: Adding to iommu group 592
[    3.913243][    T1] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    3.913245][    T1] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    3.913245][    T1] software IO TLB: mapped [mem 0x000000004f000000-0x0000000053000000] (64MB)
[    3.913324][    T1] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 655360 ms ovfl timer
[    3.913325][    T1] RAPL PMU: hw unit of domain package 2^-14 Joules
[    3.913326][    T1] RAPL PMU: hw unit of domain dram 2^-14 Joules
[    3.913327][    T1] RAPL PMU: hw unit of domain psys 2^-0 Joules
[    3.933486][    T1] ------------[ cut here ]------------
[    3.933488][    T1] WARNING: CPU: 2 PID: 1 at arch/x86/events/intel/uncore.c:1156 uncore_pci_pmu_register+0x15e/0x180
[    3.930291][    C0] watchdog: Watchdog detected hard LOCKUP on cpu 0
[    3.930291][    C0] Modules linked in:
[    3.930291][    C0] Supported: No, Unreleased kernel
[    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted 6.12.0-160000.18-default #1 PREEMPT(voluntary) SLFO-1.2 (unreleased) dd174c2cca19586eee16eaccfeba02f4d5b57c67
[    3.930291][    C0] Hardware name: HPE ProLiant DL560 Gen11/ProLiant DL560 Gen11, BIOS 2.48 03/11/2025
[    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb eb 02 f3 90 <48> 89 df e8 b7 fc ff ff 84 c0 74 f2 48 8b 03 48 c7 43 28 00 00 00
[    3.930291][    C0] RSP: 0000:ffa0000000147d38 EFLAGS: 00000046
[    3.930291][    C0] RAX: 0000000000000000 RBX: ffa0000000147e78 RCX: 0000000000000001
[    3.930291][    C0] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffa0000000147e78
[    3.930291][    C0] RBP: ffa0000000147e78 R08: 0000000000000010 R09: 0000000000000000
[    3.930291][    C0] R10: 312e38303a65333a R11: 3030303020696370 R12: ff1100145f53f032
[    3.930291][    C0] R13: 0000000000000000 R14: ff1100145f53f032 R15: ff1100145f53f072
[    3.930291][    C0] FS:  0000000000000000(0000) GS:ff1100147ea00000(0000) knlGS:0000000000000000
[    3.930291][    C0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.930291][    C0] CR2: ff1100147e402000 CR3: 000000147d238001 CR4: 0000000000f71ef0
[    3.930291][    C0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.930291][    C0] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[    3.930291][    C0] PKRU: 55555554
[    3.930291][    C0] Call Trace:
[    3.930291][    C0]  <NMI>
[    3.930291][    C0]  ? watchdog_hardlockup_check.cold+0xe7/0xec
[    3.930291][    C0]  ? __perf_event_overflow+0x11b/0x380
[    3.930291][    C0]  ? handle_pmi_common+0x15c/0x3d0
[    3.930291][    C0]  ? intel_pmu_handle_irq+0x10f/0x5b0
[    3.930291][    C0]  ? perf_event_nmi_handler+0x2a/0x50
[    3.930291][    C0]  ? nmi_handle+0x5e/0x120
[    3.930291][    C0]  ? default_do_nmi+0x40/0x130
[    3.930291][    C0]  ? exc_nmi+0x187/0x240
[    3.930291][    C0]  ? end_repeat_nmi+0xf/0x53
[    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0]  </NMI>
[    3.930291][    C0]  <TASK>
[    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
[    3.930291][    C0]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
[    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
[    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
[    3.930291][    C0]  ? __pfx_nbcon_kthread_func+0x10/0x10
[    3.930291][    C0]  kthread+0xcd/0x110
[    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
[    3.930291][    C0]  ret_from_fork+0x31/0x50
[    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
[    3.930291][    C0]  ret_from_fork_asm+0x1a/0x30
[    3.930291][    C0]  </TASK>
[    3.930291][    C0] Kernel panic - not syncing: Hard LOCKUP
[    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted 6.12.0-160000.18-default #1 PREEMPT(voluntary) SLFO-1.2 (unreleased) dd174c2cca19586eee16eaccfeba02f4d5b57c67
[    3.930291][    C0] Hardware name: HPE ProLiant DL560 Gen11/ProLiant DL560 Gen11, BIOS 2.48 03/11/2025
[    3.930291][    C0] Call Trace:
[    3.930291][    C0]  <NMI>
[    3.930291][    C0]  dump_stack_lvl+0x4b/0x70
[    3.930291][    C0]  panic+0x106/0x2d3
[    3.930291][    C0]  nmi_panic.cold+0xc/0xc
[    3.930291][    C0]  watchdog_hardlockup_check.cold+0xca/0xec
[    3.930291][    C0]  __perf_event_overflow+0x11b/0x380
[    3.930291][    C0]  handle_pmi_common+0x15c/0x3d0
[    3.930291][    C0]  intel_pmu_handle_irq+0x10f/0x5b0
[    3.930291][    C0]  perf_event_nmi_handler+0x2a/0x50
[    3.930291][    C0]  nmi_handle+0x5e/0x120
[    3.930291][    C0]  default_do_nmi+0x40/0x130
[    3.930291][    C0]  exc_nmi+0x187/0x240
[    3.930291][    C0]  end_repeat_nmi+0xf/0x53
[    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0] Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb eb 02 f3 90 <48> 89 df e8 b7 fc ff ff 84 c0 74 f2 48 8b 03 48 c7 43 28 00 00 00
[    3.930291][    C0] RSP: 0000:ffa0000000147d38 EFLAGS: 00000046
[    3.930291][    C0] RAX: 0000000000000000 RBX: ffa0000000147e78 RCX: 0000000000000001
[    3.930291][    C0] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffa0000000147e78
[    3.930291][    C0] RBP: ffa0000000147e78 R08: 0000000000000010 R09: 0000000000000000
[    3.930291][    C0] R10: 312e38303a65333a R11: 3030303020696370 R12: ff1100145f53f032
[    3.930291][    C0] R13: 0000000000000000 R14: ff1100145f53f032 R15: ff1100145f53f072
[    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0]  ? nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0]  </NMI>
[    3.930291][    C0]  <TASK>
[    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
[    3.930291][    C0]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
[    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
[    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0
[    3.930291][    C0]  ? __pfx_nbcon_kthread_func+0x10/0x10
[    3.930291][    C0]  kthread+0xcd/0x110
[    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
[    3.930291][    C0]  ret_from_fork+0x31/0x50
[    3.930291][    C0]  ? __pfx_kthread+0x10/0x10
[    3.930291][    C0]  ret_from_fork_asm+0x1a/0x30
[    3.930291][    C0]  </TASK>
[    3.930291][    C0] Shutting down cpus with NMI
[    3.930291][    C0] Rebooting in 13 seconds..  


There are clearly visible two points where nbcon_atomic_flush_pending()
took over the ownership from a lover priority context. I believe that:

  + 1st occurrence is triggered by the "WARNING: CPU: 2 PID: 1 at
    arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.

  + 2nd occurrence is triggered by the "Kernel panic - not syncing:
    Hard LOCKUP" line printed with NBCON_PRIO_PANIC.

There were flushed more than 2500lines, about 240kB of characters,
in the NBCON_PRIO_EMERGENCY before the hardlockup detector
triggered panic.

If I count it correctly, a serial console with the speed 115200 baud/sec
would be able to emit about 11.5kB/sec. And it would take about 20sec
to emit the 240kB of messages.

=> softlockup is quite realistic

Solution:

IMHO, we really should flush all pending messages atomically.
It means that the watchdog reports need to be prevented
by touching the watchdog. It is not needed in
univ8250_console_write_thread()

=> put back touch_nmi_watchdog() into univ8250_console_write_atomic().


Warning:

The log shows report from the hardlockup report. And it triggered
only after about 0.2 sec. It looks suspicious but the softlockup
scenario seems realistic.

Note that the kernel parameter "root=kdump". The problem happened
when booting the crash kernel using __crash_kexec(). The original
kernel was crashed by "SysRq C" for testing purposes.

It means that it was a nested boot. There might be a bug in
the hardlockup detector in the nested boot so that perf event
was scheduled by the original kernel and happened too early.
Or something like this. I am going to investigate this as
well.

But still, it seems that the softlockup in
nbcon_atomic_flush_pending() is realistic and we should put
back the touch_nmi_watchdog() in the write_atomic() callbacks.


[1] https://lore.kernel.org/r/20250107212702.169493-1-john.ogness@linutronix.de

Petr Mladek (1):
  serial: 8250: Touch watchdogs in write_atomic()

 drivers/tty/serial/8250/8250_core.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.50.1

