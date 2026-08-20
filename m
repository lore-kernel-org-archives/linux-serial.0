Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE46443E3C;
	Thu, 20 Aug 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229697; cv=none; b=cmhR7VI+4Gw7YhidPGxSc3liR9JSp/+Rm7oKG1aLqArxyZATnvqlfs/ylxk5rVxhXag4oTQPElXu6tZJsf6X/BZihKcu5/bwmzURTUyAP06tGrEolWEga6F0qHiinqL4uqW6H5NPL/wKisxpe56XdJXwQoJPmM17lKP6o0ghJ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229697; c=relaxed/simple;
	bh=3gg6xn8jGnVE+a/AKrm++XqeT9tdpJ8JbloPuVo1YF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cqSkF7PV2l+umlI4V6j9yCIsUvWOTdonUMvNWu4NDrwcQjdfZuGnEa+y+eSDev14NYbE2c1QkB64gWDJKyFGe/agLCrnfgzHFNBUGb6YPwyXYXJzkbBYtsaBFpfF2xehW12QLFwFnVW1Jaeif7fs/jh27XWYQbpx5QsrIGAIu38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B85dw8kJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlkUPbAk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B85dw8kJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlkUPbAk"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787229690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4DuqMt5ojYFavapKyuixKGQoi+hlFR1IYklBAnUxhY=;
	b=B85dw8kJktsrFlmfwap27OjyMnpfdsMAfoO4FUFNWz+tfxP2GDBgr417yZWp/AraXsxQjr
	LmcuPpF7uCBP7hjE1jn2hNwwaLFryNk+v5PC/jNrwJ1CgWcA5eVDobStmfRZlLZ0n/1rWz
	8Zqyo7aauafE9oyl+wbuUGEHtbA26N7RlnV/tqpzZd4wnMLEDL8T17z94kbEE9PEb7amaq
	ToW0ZHyW7hBMt6wXJd6KWqh5yW3mXWtBQnB+Tj1/HuLmaSUbXkJ+M/meuvcWpVbRehiQH6
	Bnf6LnTbyic5G4Vmrq9ml9UfXoEMFpj4Yy+ZVmn0O1mqnVIigRNcVJ2iE+KXzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787229690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T4DuqMt5ojYFavapKyuixKGQoi+hlFR1IYklBAnUxhY=;
	b=TlkUPbAkaehQx+oghViuZ+J7+gy79qS4DxQyqsLnWu5Bn9MJMafnDP4596egc4HKzmzobq
	re98mJskvfnsYADA==
To: Jon Hunter <jonathanh@nvidia.com>, Petr Mladek <pmladek@suse.com>
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
In-Reply-To: <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
References: <20260729120439.281252-1-john.ogness@linutronix.de>
 <20260729120439.281252-2-john.ogness@linutronix.de>
 <f3757a75-0ba1-4558-bf57-f19ab7e59a4c@nvidia.com>
 <aoQPFC7d8mSuNZMh@pathway.suse.cz>
 <861247ca-dfd4-40c6-a094-0fbe389f3b67@nvidia.com>
 <aoR_9g7W0qyqWbOj@pathway.suse.cz>
 <fd1802c3-4b38-4127-b988-a9ff059bcebf@nvidia.com>
Date: Thu, 20 Aug 2026 14:46:10 +0206
Message-ID: <877bll9d91.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Jon,

On 2026-08-20, Jon Hunter <jonathanh@nvidia.com> wrote:
>> 1. I wonder if adding a WARN() with v5 of this patchset
>>     would make v5 fail as well.
>
> Thanks for the analysis. I don't think that WARN occurred back in V5 
> because this is something I believe is fairly recent and we need to fix. 
> Anyway, for testing, I simply removed the warning to see if this has an 
> impact and it does. So you are right, this appears to be the cause of 
> the issue.

Instead of the WARN, could you insert a pr_err() call? I would like to
remove the EMERGENCY printing from the picture if we can. If it hangs
due to NORMAL console printing from that suspend function, I expect it
is irqwork related.

John
