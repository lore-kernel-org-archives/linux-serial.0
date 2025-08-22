Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D5322C73
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872723; cv=none; b=NNQI5iQPXWJNb2a6hIMEPSjmsgpmg55hBEoPRMvqc5JXOE46yCkgOvb1dizbiLc2JT4HI4gJOwr5T5V67Wmofss7Mpgo6rdvt9mofVm0FNT2lFIXSDqqs0rTadCCzwICoDimOCemlspLaUV+HFtcd/cXgBIsg7zIaKV8tTTt/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872723; c=relaxed/simple;
	bh=FIGq4ZevQubFRC9nWMgpiQ446H3GATj4q4A0TnFE+lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7hfHdLyMUUCrQVq8jywvN5lSCVaYSDLUFBhXdPckFkvmTAuf3XWcCNdtBhzLsrEX/fQYzdL9rooH9CtEFJ8YzXzA9641/ACIaUxkot94sM7Z/7MigVAYQ35EzRZv/lthdBnAB3QBsqI9vUfs7cK5EwiG1g+RPNiE1VhGKR/DpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FX9W9lAz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FX9W9lAz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FX9W9lAz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FX9W9lAz"
Received: from pathway.suse.cz (unknown [IPv6:2a07:de40:b2bf:1a::1129])
	by smtp-out2.suse.de (Postfix) with ESMTP id DD8181F444;
	Fri, 22 Aug 2025 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755872719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2UipXV26yEk+c5tL/57ZMj1ORZRIhCtZuJtTOJPGS4=;
	b=FX9W9lAzWgXRJx/Mzb52bJfX+9XgDiRvxA1aLq3ntFb9hPeUVy5/aKgh2YjFk+SQoit2tT
	QZDnxA9Yi32SSSRhEmUydB1xgbqgIL0tq174fRWj/bSY++QgrmGioPvkq0GRpQkk2nboI3
	DnUx0DuoZpOAL/UBw1BEQTUw2cbw/lI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FX9W9lAz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755872719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2UipXV26yEk+c5tL/57ZMj1ORZRIhCtZuJtTOJPGS4=;
	b=FX9W9lAzWgXRJx/Mzb52bJfX+9XgDiRvxA1aLq3ntFb9hPeUVy5/aKgh2YjFk+SQoit2tT
	QZDnxA9Yi32SSSRhEmUydB1xgbqgIL0tq174fRWj/bSY++QgrmGioPvkq0GRpQkk2nboI3
	DnUx0DuoZpOAL/UBw1BEQTUw2cbw/lI=
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
Subject: [RFC 1/1] serial: 8250: Touch watchdogs in write_atomic()
Date: Fri, 22 Aug 2025 16:25:02 +0200
Message-ID: <20250822142502.69917-2-pmladek@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822142502.69917-1-pmladek@suse.com>
References: <20250822142502.69917-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spam-Flag: YES
X-Spam-Level: **************************
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [26.58 / 50.00];
	BAYES_SPAM(5.10)[100.00%];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	NEURAL_SPAM_SHORT(2.99)[0.995];
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b2bf:1a::1129:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DIRECT_TO_MX(0.00)[git-send-email 2.50.1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	GREYLIST(0.00)[pass,meta];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
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
X-Rspamd-Queue-Id: DD8181F444
X-Spam-Score: 26.58
X-Spam: Yes

printk() tries to flush a message with NBCON_PRIO_EMERGENCY on
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
[...]
[    3.930291][    C0] Kernel panic - not syncing: Hard LOCKUP

The are visible two takeovers of the console ownership:

  - The 1st one is triggered by the "WARNING: CPU: 2 PID: 1 at
    arch/x86/..." line printed with NBCON_PRIO_EMERGENCY.

  - The 2nd one is triggered by the "Kernel panic - not syncing:
    Hard LOCKUP" line printed with NBCON_PRIO_PANIC.

There are more than 2500 lines, at about 240kB, emitted between
the takeover and the 1st "WARNING" line in the emergency context.

This amount of messages might trigger hardlockup or softlockup watchdogs
when they are emitted in an atomic context. Prevent it by touching
the watchdogs in univ8250_console_write_atomic().

The watchdogs used to be touched in the legacy univ8250_console_write()
callback. It is not longer necessary when the messages are emitted
by the printk kthread. But it seems to be still needed in the atomic one.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/8250/8250_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 7184100129bd..1f514bb64c2a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -394,6 +394,11 @@ static void univ8250_console_write_atomic(struct console *co,
 	struct uart_8250_port *up = &serial8250_ports[co->index];
 
 	serial8250_console_write(up, wctxt, true);
+	/*
+	 * It might take seconds to flush all pending messages
+	 * on a slow serial console.
+	 */
+	touch_nmi_watchdog();
 }
 
 static void univ8250_console_write_thread(struct console *co,
-- 
2.50.1

