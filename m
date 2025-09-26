Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647C32EBB93
	for <linux-serial@vger.kernel.org>; Fri, 26 Sep 2025 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891027; cv=none; b=dukYYbPZVkPBnOGih9szF1Y/nEOmQbwrwCqP8oW8VFtiBoZ2rjyqzDa596K/uLWSbmKawcAB+WAEAmnNV7tt//nifxq6vXbNiWnge7SOftjbRzZoVNcdLjQuIKn6xlJAghxrg+Grlb/zvv5k0Jy0jS+S0rKW4UoB8y6jv7lzBAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891027; c=relaxed/simple;
	bh=oaa4IbHTkX3qzZV9Dbu43B1Du5fNzi1Xr78qTvJfAJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATIAxArqihRQ2KDh9OQBAox1lUr+q0eFPlQsgJgDTYteNSXvpUKnkeGDDgLIErcZ7oje1FuuT7RYHSDBFP+ykRgErRBVXRnt7yxVu7MgkhDulx0oWrK/q3LPga9k+QSRI3yCJU4sP7xGpdfPdaZvB0sFeTQwvoRwnz2UNTINCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bPp2Pt9h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bPp2Pt9h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bPp2Pt9h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bPp2Pt9h"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 749674106;
	Fri, 26 Sep 2025 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758891023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sip+9wb/wTJvnAddu3/bXoZ34X5T6VBWTKCuAM8BW1o=;
	b=bPp2Pt9hKxaM2I9A8SYKyWeE1Q7ar2A5jkCpYU1nuZMR+3NOMOLHKc57m5Zb96n7gnPxnQ
	HmD7FcYmxfqFYar2+XLj1YhgktYlk1Ir/VqqncWmbYbYBa3suvL6NM9JcPTalE86kByMv0
	l3ZYG4er0le3QuyblSC/I+cxWBiTzgs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758891023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sip+9wb/wTJvnAddu3/bXoZ34X5T6VBWTKCuAM8BW1o=;
	b=bPp2Pt9hKxaM2I9A8SYKyWeE1Q7ar2A5jkCpYU1nuZMR+3NOMOLHKc57m5Zb96n7gnPxnQ
	HmD7FcYmxfqFYar2+XLj1YhgktYlk1Ir/VqqncWmbYbYBa3suvL6NM9JcPTalE86kByMv0
	l3ZYG4er0le3QuyblSC/I+cxWBiTzgs=
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
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
	Serge Semin <fancer.lancer@gmail.com>,
	Andrew Murray <amurray@thegoodpenguin.co.uk>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 3/3] printk/nbcon: Release nbcon consoles ownership in atomic flush after each emitted record
Date: Fri, 26 Sep 2025 14:49:12 +0200
Message-ID: <20250926124912.243464-4-pmladek@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926124912.243464-1-pmladek@suse.com>
References: <20250926124912.243464-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,pathway.suse.cz:helo];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLreigq8okzrb3g3qsqhoz9iaq)];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,chromium.org,goodmis.org,linutronix.de,geanix.com,vger.kernel.org,linux.intel.com,arndb.de,atomide.com,linux.ibm.com,gmail.com,thegoodpenguin.co.uk,suse.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -5.30

printk() tries to flush messages with NBCON_PRIO_EMERGENCY on
nbcon consoles immediately. It might take seconds to flush all
pending lines on slow serial consoles. Note that there might be
hundreds of messages, for example:

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
[    3.930291][    C0] Kernel panic - not syncing: Hard LOCKUP
[...]
[    3.930291][    C0] CPU: 0 UID: 0 PID: 18 Comm: pr/ttyS0 Not tainted...
[...]
[    3.930291][    C0] RIP: 0010:nbcon_reacquire_nobuf+0x11/0x50
[    3.930291][    C0] Call Trace:
[...]
[    3.930291][    C0]  <TASK>
[    3.930291][    C0]  serial8250_console_write+0x16d/0x5c0
[    3.930291][    C0]  nbcon_emit_next_record+0x22c/0x250
[    3.930291][    C0]  nbcon_emit_one+0x93/0xe0
[    3.930291][    C0]  nbcon_kthread_func+0x13c/0x1c0

The are visible two takeovers of the console ownership:

  - The 1st one is triggered by the "WARNING: CPU: 2 PID: 1 at
    arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.

  - The 2nd one is triggered by the "Kernel panic - not syncing:
    Hard LOCKUP" line printed with NBCON_PRIO_PANIC.

There are more than 2500 lines, at about 240kB, emitted between
the takeover and the 1st "WARNING" line in the emergency context.
This amount of pending messages had to be flushed by
nbcon_atomic_flush_pending() when WARN() printed its first line.

The atomic flush was holding the nbcon console context for too long so
that it triggered hard lockup on the CPU running the printk kthread
"pr/ttyS0". The kthread needed to reacquire the console ownership
for restoring the original serial port state in serial8250_console_write().

Prevent the hardlockup by releasing the nbcon console ownership after
each emitted record.

Note that __nbcon_atomic_flush_pending_con() used to hold the console
ownership all the time because it blocked the printk kthread. Otherwise
the kthread tried to flush the messages in parallel which caused repeated
takeovers and more replayed messages.

It is not longer a problem because the repeated takeovers are blocked
by the counter of emergency contexts, see nbcon_cpu_emergency_cnt.

Link: https://lore.kernel.org/all/aNQO-zl3k1l4ENfy@pathway.suse.cz
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/nbcon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 219ae0c8b5ed..e298346111b2 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1532,10 +1532,10 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 	ctxt->prio			= nbcon_get_default_prio();
 	ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
-	if (!nbcon_context_try_acquire(ctxt, false))
-		return -EPERM;
-
 	while (nbcon_seq_read(con) < stop_seq) {
+		if (!nbcon_context_try_acquire(ctxt, false))
+			return -EPERM;
+
 		/*
 		 * nbcon_emit_next_record() returns false when the console was
 		 * handed over or taken over. In both cases the context is no
@@ -1544,6 +1544,8 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 		if (!nbcon_emit_next_record(&wctxt, true))
 			return -EAGAIN;
 
+		nbcon_context_release(ctxt);
+
 		if (!ctxt->backlog) {
 			/* Are there reserved but not yet finalized records? */
 			if (nbcon_seq_read(con) < stop_seq)
@@ -1552,7 +1554,6 @@ static int __nbcon_atomic_flush_pending_con(struct console *con, u64 stop_seq,
 		}
 	}
 
-	nbcon_context_release(ctxt);
 	return err;
 }
 
-- 
2.51.0

