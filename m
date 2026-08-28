Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D65371880;
	Fri, 28 Aug 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932696; cv=none; b=aUOeyrId5kdxiXSUWE/pcr62Ic3jpI9uZMXYVkeUHvWpS1x0SD49gtjkd4nnq+Cqt9nbWsqAu5s2GoQgMXyeVuq53EEzyEBClIDcDl6P85UVXr9rWaa4CZCTud753F+9FZj3JnCdQbnwjM/Nord2KQ1X3iGBWu4Xrfrjlw7CDxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932696; c=relaxed/simple;
	bh=LbR0znRzRfTh41Qv63K7WCKvumr+27ShRRjRn+x07XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tZcmT2pd6OGcXtFlBNnjfz5ELvh4TnAdFANQq4RmQ1a0rPpf+0LKfcublZiOy4bMZSd9NAei3olKUSpmVsKUb9bRjAID5cXVGbG4xrCyVGnIE0I26inyCKqHO6lq5Ml7lo+BHPGgVCei4Y15nZfByz67WDvrjJJXwrR8RnIu/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vgr9CwGF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9ZKqs/sY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vgr9CwGF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9ZKqs/sY"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787932692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPqDNKwChZDP342Usda3rhXvIiQJ79oFJiWvu8RCDfs=;
	b=vgr9CwGFwIpbZ3tRYFS2Q1oWvi1gg0ZmIIumv845hUKj6VOmsd0XqwMSqr+UP2dRdkDrP7
	ueLX52oBedFeESloBN6CvppQMU9CXIFVtN8+02FXHbdPHOClrhKZ4rEw60dgK5xRglqIrk
	448FSL+FwojzxRnXCRnZ3eDKNUzUL9Yi1o3BnbGWePv2zDOYCh59BM2RSSGh3iXHqkS1OD
	Hd+KldjJfWHxP6xb6rq8rsAyDqc0ZGJjxA4EvwcYTt69fVj6D17gCWjaFUsBVp8SJOtRaD
	L7x1ZWDGCFDypmDWip3tHGFcPySpH7WVRrvuHVkHRh8aicvEjAs8uLj9KMDGJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787932692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPqDNKwChZDP342Usda3rhXvIiQJ79oFJiWvu8RCDfs=;
	b=9ZKqs/sY+4yXeseYqQX9V6otfoW63uvuR3CmzbgqFuO5VzBNiWtZFo0MHXsEm8bhZCHLrs
	R/orb+uBMeRcDQDQ==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-serial@vger.kernel.org
Subject: [PATCH tty 0/1] Make 8250 deferred MSR handling LAZY
Date: Fri, 28 Aug 2026 18:04:07 +0206
Message-ID: <20260828155811.270462-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a report and follow-up discussion [0] about a problem
using regular irq_work queuing on some platforms when entering
cpuidle. To circumvent this problem, all irq_work for printk will
become IRQ_WORK_LAZY [1].

The 8250 console driver uses irq_work to defer MSR handling during
atomic printing. This means it is vulnerable to the same problem if,
for example, a WARN() is hit while entering cpuidle on one of the
affected platforms.

Avoid the problem for deferred MSR handling by changing
console_msr_work to IRQ_WORK_LAZY.

[0] https://lore.kernel.org/lkml/f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com
[1] https://lore.kernel.org/lkml/20260828140218.232439-1-john.ogness@linutronix.de

John Ogness (1):
  serial: 8250: Change console_msr_work to IRQ_WORK_LAZY

 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.47.3

