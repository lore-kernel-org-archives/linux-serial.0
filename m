Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8930A421A18;
	Thu, 20 Aug 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224889; cv=none; b=IftlIxhCgvjUSKuHbedVk3V00m0yijVPC+KC2IOmvtqPZzW00N1WVoH8OyNYecpGLDRmBekZdLcoXJm+2VlhxmRRYKt27qnjUbhvHUi16By0xqm6k3krC41//7BvQePF8JJtQ4+Kx2/L+83ouPudc+m2EM25LzQWMcrjTrRxa+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224889; c=relaxed/simple;
	bh=krQyPC9pJNepZenEkb8f/zODFNMMMZP1Z4ebHzr6Ul8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIu8Lh6YWJODPBXyzq5/l6SOqbmiFyEIQCpjt/RNwLqW6e73M/qxAW0OcNF/PfAYCdCXlAXSjly+6Wo4Qwt0A2sVlWYL+Bb4Ntcq7q5fpD0a0uHLTkSNBPPK5ZxbqwRB1dUPEW8QQ87R+egKu/jeAkmlFTxGbFL1u5kwo9qsSWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E83Jx3Cj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fre37lOi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E83Jx3Cj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fre37lOi"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787224886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8HcnbU7W4cFA1KpGJdCFcwdAtiBZbuEA9t6lvz2NcI=;
	b=E83Jx3CjVAPY7WztO3ZM9b/sNHrSsPOON0M5li+snyRLaYd00W7e9NZDfqtMPvMz4065gH
	CaglD8DdWzsrfelFq5Sf4SGKXHa2XCGDYkZYfdMZVVaHg7kmA19769tb4Y2s8C3exPrWlC
	SPjfsgvynVCr2ZDan6rbyDZuJnVzL+1RVWPB3DeegBZwaVhVgm81Qz/h4yah+UByQyekmv
	w1VU3Hb4h7Lrq4Oq9YbDZUNzvm/UWzpCnGtWXem/GScqIwm75vMGQ6UjCiE9dHLFrWMUKf
	kipwMH6QLMilKnqxTlLOtOr8FVzpD9tDZTVZXn5t3hIwB5N/jBowiNnDI+32Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787224886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u8HcnbU7W4cFA1KpGJdCFcwdAtiBZbuEA9t6lvz2NcI=;
	b=fre37lOiOffBxAZyQnNnZc95eceOyhYwn8EzAeg9Y61sJ0A6zFwg+iwzgY1pi+I8niMUHj
	ANLNjoBU8T+QsKDQ==
To: Petr Mladek <pmladek@suse.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, Stepan Ionichev
 <sozdayvek@gmail.com>, Xin Zhao <jackzxcui1989@163.com>, Osama Abdelkader
 <osama.abdelkader@gmail.com>, Fushuai Wang <wangfushuai@baidu.com>, Marco
 Felsch <m.felsch@pengutronix.de>, linux-serial@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty v11 1/2] serial: 8250: Switch to nbcon console, take 2
In-Reply-To: <aoR_9g7W0qyqWbOj@pathway.suse.cz>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
Date: Thu, 20 Aug 2026 13:26:03 +0206
Message-ID: <87a4qh9gyk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-08-18, Petr Mladek <pmladek@suse.com> wrote:
>> [0] https://pastebin.com/FhQVSqfy

...

> Almost everything works as expected except for:
>
>   1. I am not sure why "printk: console [ttyS0] disabled" is printed.
>      It does not make any sense to me.

I have seen this in the past. It can happens unregister_console_locked()
has always printed the disabled message before actually checking if the
console is registered.

IIRC it has something to do with serial8250_register_8250_port() calling
uart_remove_one_port(). I remember starting to look into how to fix it
but then was going down a rabbit hole that exceeded my scope at the
time.

>   2. The WARNING would be handled with NBCON_PRIO_EMERGENCY.
>      I wonder if this warning happened also with "v5" of this
>      patchset.

The tegra issue we had with v5 was related to irqwork being scheduled
when suspending. When keep_bootcon is specified, there will be no
irqwork scheduled during boot because legacy_direct=true.

From the backtrace in the posted boot log we see that the warning is
within tegra_pmc_enter_suspend_mode(). I am wondering if this is the
same issue we saw with v5... an irqwork getting scheduled when the tegra
is entering some suspend state.

Back then I was able to reproduce the suspend issue on a Phytec-WEGA
board. I will see if I can reproduce this report on it as well.

John
