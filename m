Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAB2199931;
	Thu, 16 Jan 2025 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737023928; cv=none; b=DJ5LCpvZm9c4N7oCCxRSvAqROhaVv3q93ukJcA1YwKFyvVgT+QGvLHSE9QggKGxMlzvHunHFS52AfiUNAc5Z7zbJ28NcSesrEkmKlGZLr5EeIWFa9p0B/yuBefalDI37G/RPwJJaIlvxhm31NBaR8SHmX8H6+AkcbhT+X4H6cjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737023928; c=relaxed/simple;
	bh=F6QdO0dJ0e4R0sJXu9LjMnwc/q1TYx2bWXO7q4MxaTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rSWwwAtCbR/EClik9FFAGlXk0SUiCRt5bgsXysKUKJR2V2WYQ+xjQ9tIMoEtZYEKe67/nvNPi6zS0BHZWrG9KHSwVGMg+Aqj1yq5UnVSaxMXYTwHoz9/W8nnijbTtNnt0TZUwFQhTaoGzBlMcUNt6kNv9qNBabQvzj4konQ6rp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wCR8nts0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwZksQQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wCR8nts0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwZksQQW"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737023924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebiB4Ntct5qfoP/1iCVgD73wAS3wlzkUxhhpWlNYKBQ=;
	b=wCR8nts083XjBfofO8Wz6oW0ym1/NHKnuQUJv6qpS0+3vy+/kh2ys2Fp7icQlVRVlwDwBF
	dg2iRruuchGHT0mTCkCDsxW7zSlY4UsCyeJi7E2F9e2lSYX/fhlmEODyPO/duNZUrLOzry
	cq3JaOIYUGZOmUI7LsM3nm3vvx6gI71vGDPkquDj3mKRGZN2hMIpygeMe10UYRHuFnb6TG
	NrVAt/UKrRSJQkejZQdQVQITp6d+8Vo8dTSs5mfSoxLQyWT71ayJmQ6+EA4VN7vy7wNzmX
	i8ZDvHVttxxzUBJTcA4AbxJucGPsDVKFUxquJQzJmd27h9rar0aDbSEhiX8wwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737023924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ebiB4Ntct5qfoP/1iCVgD73wAS3wlzkUxhhpWlNYKBQ=;
	b=lwZksQQW4u4qRLX00kLbXpESp77eELoFFJcHDOzgZNKImDjofSYUzwUCsKVe2reHS2b6Ih
	u4TF+XUYUzFbxtDw==
To: Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Tony
 Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Serge Semin <fancer.lancer@gmail.com>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84ldvcyq41.fsf@jogness.linutronix.de>
 <96b02b20-a51e-480f-a0ce-3a1457650ca9@nvidia.com>
Date: Thu, 16 Jan 2025 11:44:43 +0106
Message-ID: <84y0zbyrf0.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-01-16, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Do you at least know if it is failing to suspend or failing to resume
>> (based on power consumption)?
>
>
> Unfortunately, I don't. These are farm boards and so nothing local I can 
> get my hands on. For some reason all the serial console logs are not 
> available and so I am going to talk to the farm team about fixing that 
> because we should at least have serial logs.

Can you confirm that the board is actually booting? The suspend code for
8250_tegra.c is quite simple. I am wondering if the farm tests are
failing somewhere else, such as the atomic printing during early boot.

John
