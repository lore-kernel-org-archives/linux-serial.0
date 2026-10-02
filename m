Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F650476680;
	Fri,  2 Oct 2026 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932437; cv=none; b=UlxxToUbzuyh9+tF7fpFbGe0LmmjM5mJ0tO971OkgqHBeqz+QAhT28tYvQw2BQ7Dj8fTpon5YMwGEMs8UckFe0KznLFEpXGQ7iL8JNQ2BgzSsXtu84TFErOQxSyGZm1n8bQAe2vJxnZ7lQtaRVhN50mTyNOpLmd+kdN0/HXzvDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932437; c=relaxed/simple;
	bh=XjECC/76Kx4GLg4WNuJ4XZyAdX68d0SjCkq85tltP1c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qdztiMZrFoDkDfsvb0tnwnEpnK6KD2Jey7W28/BJ2ZmoktNs2Ousxl8KeAuT6tr+wnzzXzg3v6RoddGo46RivvleHIQBrZ1LPYI1wo0NogHymytnOX2ghG1fqthwjPgm+uujQkVzsNChVPhq70Y123flulz9ogkHkxGn0mmR/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jaluJOCE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMHbJyBx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jaluJOCE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMHbJyBx"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790932434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttetKvleXMEquiPnuWfDClRaQG7XGFkYd7ppUiWWo9E=;
	b=jaluJOCEffagfAKw28ReqP9Nyn11YnwVvg7Bs3mJoiQnj3hWwRkurg/WfGNjQBTwl8e2zM
	xXjykMndYfTy0ZgRXHYRTRNwzDlSR75dIkw/5z5qXjviHxRoxt2GJwHx3PSn0SuV2XtP9V
	/4+Q/PRXras/MUy6nr1WZbEyACtpPUjxFtZClzO9HWV/67BXQFzbQI7+KSVSG0UgVs6FzX
	KfuBfGnB4nYyDbVO6FdSQ+j/klP3cYAw6scG5HJbpajN6KwWD5AhWgROExCgVRDT26zq+G
	Wn+meN+3JLN6tlmJHNBwg+gg3v+sWy+nJrkukDsRQUtQrS8oEv3HukBa74JhAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790932434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttetKvleXMEquiPnuWfDClRaQG7XGFkYd7ppUiWWo9E=;
	b=JMHbJyBxzxesxJQMV9q6U5w55HlR4gKD0nRMcsAhMS7L/XnvjZuSqwlCa8aqqbV36D/LWQ
	/LdE2/8z8CZDqaDg==
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
Subject: Re: [PATCH v4 1/1] braille: nbcon: Allow to use a serial console
 with NBCON API as Braille console
In-Reply-To: <ar9wacP7FGkiKFXp@pathway.suse.cz>
References: <20261001140727.124398-1-pmladek@suse.com>
 <20261001140727.124398-2-pmladek@suse.com>
 <87h5j58mj2.fsf@jogness.linutronix.de> <ar9wacP7FGkiKFXp@pathway.suse.cz>
Date: Fri, 02 Oct 2026 11:19:53 +0206
Message-ID: <87mrswwjla.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-10-02, Petr Mladek <pmladek@suse.com> wrote:
> It should be good enough for 7.3. And I wanted to get it into
> linux-next ASAP.
>
> There is still an open problem with the dependency on CONFIG_PRINTK
> to fix the Sashiko complains. We might add it as a separate patch.
> But we might also try to fix it properly by enabling nbcon.c code
> even when CONFIG_PRINTK is disabled, ...

It would probably be enough just to set the !CONFIG_PRINTK case to:

	static inline bool nbcon_braille_try_acquire(struct console *con,
		     struct nbcon_write_context *wctxt) { return true; }

Since there is no PRINTK, there will be no consoles to synchronize
against.

Or in drivers/accessibility/braille/braille_console.c you could change
all the

	panic_on_this_cpu()

checks to

       IS_ENABLED(CONFIG_PRINTK) && panic_on_this_cpu()

John
