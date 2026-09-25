Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618334AFE14;
	Fri, 25 Sep 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346990; cv=none; b=mLDGbcao+07LWFh0FA43PELJjuc5L1UfIIRZ7MExPjt+MA65u4wH8zK2Jq5XWMxhZDAzwdSz0U7n00xXiOThqO9hxHaJtJ3+wQonKf/ZL5I8NYZN8QHDLloswEDz7CztOxVVFhyS1VcL9NblLe8oPwkKIJ/G7espBycQ95j7mUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346990; c=relaxed/simple;
	bh=Yy4VLzaq5j8K32peWj7SmtCdRaQCZLz9v3mDF0TRvAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RpDd3CrtW5Re1tqHDoc323sP4tVvbbNvXjUjIloezAjpqK2zzNhWvYvjOdr5MatWH2d2IjJ5TREvSW9D8pcoGZrtH/UNvphK9/2zxnCqTpkBZJRUPbHqb3AT3J85a3Va2a3ejBbOYUDJEPKRjNLrrzHgp658aEbNp9g4dsWBcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TwP0BRtd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ED9wvqx4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TwP0BRtd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ED9wvqx4"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790346980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yy4VLzaq5j8K32peWj7SmtCdRaQCZLz9v3mDF0TRvAI=;
	b=TwP0BRtd4yY7ohqn0IoS5ZYeOKkAxDnJ38EZapg3eZwTPWPkP7pwyajzETv6Zv9sDSSUFF
	wID6knU2e7mXaDQ4PhP8M8WHX+Ytyh1wZ6/4Gbo0rZN/RNsklcYhRHkq7buG53nVGMTGuZ
	9tS0jy9LC6HLWKp2r2CNqDxspuDu8fMxcgYn92SIBtyXxu3HMWjRUwLOXOZEHoz0Wstm1e
	0kmmRlOwAewM9veVjAZblZESOsPxW+BME3Gyf1k8OOCXME5juVMtsBk2LGfKbbzXd72Uxt
	GHyzKblSzNkybbGgJ9JFeTSamqDUMRnLexv5HNz1ryLXjyy4p9GQlBamR5d1Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790346980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yy4VLzaq5j8K32peWj7SmtCdRaQCZLz9v3mDF0TRvAI=;
	b=ED9wvqx4VGwEkTMlQ9vhEG347Fes6FI2RLOGkLYk14OA+D9EuAa5OM20x34lhVf8/KKwL/
	nKnnc0+aejTyRVAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, Samuel
 Thibault <samuel.thibault@ens-lyon.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Fushuai Wang <wangfushuai@baidu.com>, Kees
 Cook <kees@kernel.org>, Stepan Ionichev <sozdayvek@gmail.com>,
 linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] braille: nbcon: Allow using a serial driver
 converted to nbcon API as a Braille console
In-Reply-To: <araAvkIB5XatHPNk@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <87ik3tiim7.fsf@jogness.linutronix.de> <araAvkIB5XatHPNk@pathway.suse.cz>
Date: Fri, 25 Sep 2026 16:42:19 +0206
Message-ID: <87a4p5iejg.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
> This shows that braille_write() is called form printk() even when
> braille_co is not in console_list. It is called via vt_console_print()
> because the graphical console driver (ttyX) is registered.

But isn't that a bug? I thought Braille consoles were not supposed to be
handled by printk(). Even in this new series you added that exact
comment.

John
