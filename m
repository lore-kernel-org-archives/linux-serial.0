Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C381397
	for <linux-serial@vger.kernel.org>; Fri, 26 Sep 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890989; cv=none; b=NLfECF90joL/VzGeAlFWRphGDWYPUpaWBve4+XUgHevZgT7AzfHLYXIF4Ip/ycWH3Idesjw1LGojMG82bvEalX5DNZH0Ow6KdVypXv2T5t4ztop1FRT0Nmdp+KnUyaQNr/89CiOUjn44UR3Us2iXUf6gylXOLKRKazbLGRrU0Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890989; c=relaxed/simple;
	bh=BJeaK9hUariIirAmBLD2fZWT1DYILlNZjQUDKPs6Gco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG27szS2nizT2V79yK+bdrPFQVI9pEUQ0T/JbLyZJT+duY7fTDDgGElSnqRXz8NMRKKjnoJpJtzXnSIrzN6/ewi9OAFa7k1BC7DFRc78ZNijmateeEAJmsmt2bF72+f2tuiP2IUcyJTK08Gjpr45/9lZHaqGa2aAh2eZSH4pXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=o8GkX9hc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WaOoF8+N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="o8GkX9hc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WaOoF8+N"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id C89B04106;
	Fri, 26 Sep 2025 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758890986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KNJxCh0s4I781vRuxLTEA2h2/xeNRvLyNBgY3kLeN+Q=;
	b=o8GkX9hcmBtMIN3ryYw5ZcJdytKZ/U59OTvQIJCxqVOZXvlqfBsFVibScDR1QieNqYPVtl
	zlkS4VjH4Ep00uzD/HjJagzEOJcL0sQFLoJ87EFAUQ+lFsGGUztMkIPjiX1hlKL0PxO98D
	uDs3MCNMCmAog5qsTW9Wh9nikYP0K/Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758890985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KNJxCh0s4I781vRuxLTEA2h2/xeNRvLyNBgY3kLeN+Q=;
	b=WaOoF8+NFTVWd5TEfWaZGd9Bb5b9x2sNu4IhYQYSEm9zZCF4Pp+bkBmXMiRRgnayduCSLR
	NIs6pVaMFM96SqixOLRRwGgXgf3FQlnjJDa+S1naHwb3mdbX4NB4OfCdtpEEtd1RD7Se12
	QEKnPlf6WVultnKVY05aulUQEvBCzmc=
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
Subject: [PATCH 0/3] printk/nbcon: Prevent hardlockup reports caused by atomic nbcon flush
Date: Fri, 26 Sep 2025 14:49:09 +0200
Message-ID: <20250926124912.243464-1-pmladek@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,chromium.org,goodmis.org,linutronix.de,geanix.com,vger.kernel.org,linux.intel.com,arndb.de,atomide.com,linux.ibm.com,gmail.com,thegoodpenguin.co.uk,suse.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.30

This patchset should solve problem which was being discussed
at https://lore.kernel.org/all/aNFR45fL2L4PavNc@pathway.suse.cz

__nbcon_atomic_flush_pending_con() preserves the nbcon console
ownership all the time when flushing pending messages. It might
take a long time with slow serial consoles.

It might trigger a hardlockup report on another CPU which is
busy waiting for the nbcon console ownership, for example,
in nbcon_reacquire_nobuf() or __uart_port_nbcon_acquire().

The problem is solved by the 3rd patch. It releases the console
context ownership after each record.

The 3rd patch alone would increase the risk of takeovers and repeated
lines. It is prevented by the 1st patch which blocks the printk kthread
when any CPU is in an emergency context.

The 2nd patch allows to block the printk kthread also in panic.
It is not important. It is just an obvious update of the check
for emergency contexts.

Note: The patchset applies against current Linus' tree (v6.17-rc7).

      The 2nd patch would need an update after the consolisation of
      the panic state API gets merged via -mm tree,
      see https://lore.kernel.org/r/20250825022947.1596226-2-wangjinchao600@gmail.com

Petr Mladek (3):
  printk/nbcon: Block printk kthreads when any CPU is in an emergency
    context
  printk/nbcon/panic: Allow printk kthread to sleep when the system is
    in panic
  printk/nbcon: Release nbcon consoles ownership in atomic flush after
    each emitted record

 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 43 +++++++++++++++++++++++++++++++++++-----
 kernel/printk/printk.c   |  2 +-
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.51.0

