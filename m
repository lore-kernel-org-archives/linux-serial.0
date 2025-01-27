Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A516EAD0;
	Mon, 27 Jan 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737991272; cv=none; b=ecMt37YX4jLU9ejuz3wmqHQsAaQqmDKBmVx+Wr7L8LXT/xlVVvr2Exi+fZVgW3si/hoy0F5p36+6dWuRtt2qhWSbQZp4dJsKORDy02+GICTEvFBHZhgmO06GZaURAC7JnnD6ONx500W24wvENgKL5gSl6MEClIzB10Q8v11qns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737991272; c=relaxed/simple;
	bh=Kwxh+tvKhoGiX5MfKzglyS08lo+go/vfdIXn/twcFTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ak1+uNnRUPFEPhTJ5SEFhjrDpxSj2KfyIUYQow6bT/PuuKLT8tvaGp3bNP14qh7flhnE+mL+bEc/jOnDDrT4FG10GT5yvrZdqauI333FFPitHd18qEXq7jUvJR0wUTGXnTV6dEkkVmo7ogX8N/zUPJq5NfMqXwTYz9KTJCFEYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+9xkLCp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJBCfIjq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+9xkLCp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJBCfIjq"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737991267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwxh+tvKhoGiX5MfKzglyS08lo+go/vfdIXn/twcFTg=;
	b=i+9xkLCpupo5mdgiroEJZillQ0kqjuRDdVDpXvliTtLtyLwy9h0KjAcHPCEfNW2heJhi++
	TRD7fUcVdWQU0cVCUi0sAyPcdHxlqHmD4VayhL61MyVLpMFU0CqfduRxzf5MQsHm23eqEu
	VNkC9t/gbogA608Ejg5iXlDC+9tHuMiqDSjOFFMifkqRSbQhA7/n4IJFMJojgzlJWVcJeL
	CRWTbnwtmNVXr7wTQqDeHJ7V8OaBmPEfG9TfCHOJvCWyVgHGV8URvH7baI2vJ2WK77WBhJ
	LMKbv/VY3REs+HHqy5wt0D8l41NJPUrHdE132HzSUZC2pfUn9baQcsz9J8cwkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737991267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kwxh+tvKhoGiX5MfKzglyS08lo+go/vfdIXn/twcFTg=;
	b=HJBCfIjqPoEQ4q++Wd3un7AZm4gBDPvvw7LXJAikDR75lOkB9bzEI7ZbdtU06SFBOGjF5T
	nMw9peknLHDMk3CQ==
To: Jon Hunter <jonathanh@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <3e93c665-7603-4b64-a64c-a29079d8d11f@nvidia.com>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84ldvcyq41.fsf@jogness.linutronix.de>
 <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
 <84y0zbyrf0.fsf@jogness.linutronix.de>
 <bee7de35-e767-4c69-94ad-d09c92a3577a@nvidia.com>
 <sx4nrwuzs3vafnbrkgag4dkapll3itvece4k3ylvobvid2vlpk@oncxz3eq33zk>
 <lrpcbufgu7jnvepqkd3sz2qap2th45ndzv4c4vxh7v4zyhep6k@t635s7vbhkgz>
 <3e93c665-7603-4b64-a64c-a29079d8d11f@nvidia.com>
Date: Mon, 27 Jan 2025 16:27:06 +0106
Message-ID: <841pwo7065.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jon,

On 2025-01-27, Jon Hunter <jonathanh@nvidia.com> wrote:
> Any feedback on this? Our boards are still broken with this change.

I have not yet been able to reproduce it (mostly battling brokenness in
am335x pm dependencies). For now the change has been reverted in
linux-next. I will send you a patch once I have something to send.

John
