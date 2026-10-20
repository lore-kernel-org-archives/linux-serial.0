Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481242;
	b=coXLmOzoIK+5NRcknevOXcnpHv7QcDn/cxJhJbqBilt4Ci1GecTWk47qTl4xxIPurbn1
	 WopNPdD0pTCVVirAzothMyV0TSyIZNFgEQyFpJsqX11+zeDF3uNg1YjMAMNriUkUzceKx
	 fA+ORHejhAoBMjAEqoAajm9/EAadjNskqH59DyFTB2ghSg6uE7taAGF/WbQKuh4NPaiY/
	 LUjbPXS89MdUzCYm9CoTjIFcSdGvytJzm/6bQQoUGpVEenRw7QW04MCJ347dIPamuEJuy
	 EpAXxKTWPK6gcvH29XIUxWzgMCQtgWZ8K7XUJ0vNIGQIaFE1ygckASvcmuDI35iHN1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481242;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=PrXLJDelmAFq+PcVWJ3SeAWURdxR8J8op5bluDTDVvQ=;
	b=zm6emv0HcMhHn51if3MzyysIDXYrgjgpJJvm7YnVTRcHoEFa7rzHQTzrYD56kQwZcGzW
	 zJdYMHJ0NsynPsYX2HOYaYrFTGU1FGpym1pYgG++4N2+dX23UtMR1D+/Pw5pSzttUSWig
	 tRid146oHn9lGZd0RJ1SOn//c+2QNLtsoNEsb+UctDyKfUunTIg+e8aAdBrE4BwPWYmwM
	 9GEoy13wUTgjonZLdj3wNcbGaTzvBLmayCwcedw6ni2YMbe9ETnIGDKQVftTcZPOfu7Wn
	 1A9BSVChFZwq9IMETNQOgsjJNF/hQmECld5izDgRdrTwYuAKf4qJ1RkqdpWMGDSZNcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dQc1Hi6e;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jObzmXEO;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7F606A31F
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 07:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8F7F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dQc1Hi6e;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=jObzmXEO
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792481239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrXLJDelmAFq+PcVWJ3SeAWURdxR8J8op5bluDTDVvQ=;
	b=dQc1Hi6es9MiShPw48ttjleBfYDKGVRpIczwS40hi4EKL6pMgk5c/J+pvFzYNPpTysTSlw
	2y8pFYOnLkH/PR0qZzcTMblbZf9fdtg3BX08BFqbxv9UTQrioQuRfFq535winL9Hy5r+PK
	bEAJp2iEj1w6IQC6Jhi8PcgSNHwQnYXISdlXDnK3ALYd+gjE2DdtyGnLl9UPda6KXjOZ2J
	eUaX3yKjDp4gmabpaDECueh6uDemDr5cN8H6VYSaQtp12VgGaVBh0dQ3DFS2khKEZ8lm7j
	/DGpe6D9WWGcEffwvQQ8DGEPD6vKALMuhbamyz23s3JmIPDzqMzkfnNQtrTOTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792481239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrXLJDelmAFq+PcVWJ3SeAWURdxR8J8op5bluDTDVvQ=;
	b=jObzmXEOva41jsNlTGca7FnmJXurCT47U0D9II8/YuC5vTPHN08PaC7SYYOc8JBEAfl56/
	p4uUjeMwO92C3aCQ==
To: kernel test robot <yi1.lai@intel.com>, Petr Mladek <pmladek@suse.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [linux-next:master] [serial]  d353934702:
 BUG:kernel_reboot-without-warning_in_test_stage
In-Reply-To: <atcLdg5RvEMnkzvJ@ly-workstation>
References: <202608061008.48a1e76e-lkp@intel.com>
 <87ecek1c8d.fsf@jogness.linutronix.de> <arPQwKbl7wM6IM3x@pathway.suse.cz>
 <atcLdg5RvEMnkzvJ@ly-workstation>
Date: Tue, 20 Oct 2026 09:33:18 +0206
Message-ID: <87fqy0de7d.fsf@jogness.linutronix.de>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-20, kernel test robot <yi1.lai@intel.com> wrote:
> Applied this fix on top of the commit d353934702. The
> kernel_reboot-without-warning issue cannot be reproduced.

Thank for testing.

Note that the 7.3 release includes commit d8e5fc300229 ("nbcon/reboot:
Switch NBCON consoles into the emergency mode in emergency_restart()"),
which also fixes the issue.

John
