Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660161DF748;
	Tue, 18 Aug 2026 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036525; cv=none; b=WhP55hFxX5f0Wr3nW5q93j96mtpha3Og3QgK763PvtADO+gHq3x+Q7uqdo1aWlP7q3VZwLxXGINrwP2xWJxatztqy1xtaFu/VWhNhC17prNca4FQSg9ic6++c7lnwTFp3iS8KgNDsKLA3y329NZ1HUV+suMnhkHfGFmkLyiERmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036525; c=relaxed/simple;
	bh=xVZeqBH5hEtFpcSWmNOU4bEUTE8enJXQtBGFmgQ8DVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUTAHr4ObM7GUFbbRaDpnIUmqaHzEyAn81gyDQ6KR2L4fIRvw77jnraQKMZkt2uKIPnF5dQpiJtvggIGt60LZb4iYH6KJRpp8k/2krqCygjFg2IdnaSuyk0tFXgh8r6fTZ6IHjtoNlnBxvqi/Y7qFpkY/OzZGUS1CGHExT8zXhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FL4nBloz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/SojvKN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FL4nBloz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/SojvKN"
Date: Tue, 18 Aug 2026 09:01:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787036522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWLdyuhtB8XaYoyZIFd8Ks4pnlbgjd2xzShMg8jNocY=;
	b=FL4nBlozBzxeqskvASCdPZdjKVzurPFKdmopZmeteBnG3U7uroNdWhlbD0mFK9P7rj0oz6
	0xAnUD04/BV+CWB+lV8T7XgoTkROD2HY0HVmJzbz9ZMAPXO/aV6f1k4YVXWdx8G5QJ+0S8
	iGb/oWqbkiu2EHwwyee8Fbcvv74HOZ1R776HVuCJ+VsDGfPRVHtuwttQMIMViSrNNkxfQ6
	yvPjNum78dV4ZNRFJijYgIZnljThxF54BzHRH6ZQVRCjE+cbeM3wRClYWdH9VFWZmq1cuV
	W/HnF26qAZ1sy2T193f/AFxtUL/pBEY1VXCLlOCwLvhv+/1fPnJcgpdCxc2YjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787036522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JWLdyuhtB8XaYoyZIFd8Ks4pnlbgjd2xzShMg8jNocY=;
	b=1/SojvKNDInoposUlHduMv/vQfxjzuCqqD8APoS69hqvV0hO53iyxl0nOhQnwzicp3iUsA
	wnjB0TYdMEFtayDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Kees Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-serial@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
Message-ID: <20260818070159.uJW5T4W5@linutronix.de>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>

On 2026-08-18 07:25:13 [+0100], Jon Hunter wrote:
> Hi John,
Hi,

> This change is causing a boot regression for our Tegra20 and Tegra30
> platforms. Reverting this on top of -next fixes the issue. Previously with
> V5 I did not see a boot issue only an issue in suspend. So far I have not
> had chance to dig any further.

If my counting is correct: v5 is from last year
	https://lore.kernel.org/all/20250107212702.169493-1-john.ogness@linutronix.de/

and part of v6.14 however the nbcon bits itself were reverted before the
final release. That is why v6 till the applied v11 has only two
patches.

> Jon

Sebastian
