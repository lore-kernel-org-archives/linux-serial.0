Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FB4BD374;
	Fri, 25 Sep 2026 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348757; cv=none; b=No2LePLKAl5/oTRu/ZpFc7hy0N3z09GiH+9EnI7IieKkAOQb901in0r+mJrZ2Q93Oir1StRVyf2Y6b42AnlXnC2a9YkGgrvjqmftMehGjs5HeWu8cQbConXCWJmdWikzTN6jl2bfrE1CrUoYdcWbEGO4zJIw+4v6dPuwVBj1GvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348757; c=relaxed/simple;
	bh=B0NpXhhNFRZuqg72AkkSd/VNe9X+s2bbEm7voK3IQUI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6Wq0flb0r/Lep8l+r9Q3gr0nX5mqLNMzK82LgXutYraJdlRdB4wP/Yd/cpRdDmu4CxudRA9MV5ZuxoRbdyr+TY8ytJAS70YH74RqYzFBUW6UBVSc1AXbOBVMlzAqsrRb4VO4wgTKylg/riYCRBGKpHDKp1uFMMYNLlWZcrMQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKV5IsLA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lblv32Qn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKV5IsLA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lblv32Qn"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790348744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9UOnSrVvo7U5rovUr4MwflJsqGtl//zZCil6jWNDZo=;
	b=TKV5IsLA2FU8BztW796lKPM6+i9jc6ofqNMSI2pl7U6rnBzvN2oeRMC9FrS/ac+XiMwm3w
	yy9a3u9fNS4//xaZUmrhxUNsuOcJaNrdLCNzVHm1P7xIdxIAmemFg/53Q7lrYA8jHpHE9s
	3iE3zUl+1KKfYs2hgMcHmcQBgmqEIhxhOiDfKKTMPpluaJZvhvIGTGLa5tDOEcvTc50X/d
	vbi/Nnela0C5f61L4RbnILE6PFfdkc9DwmpmYsmxYHzQe74jGTwnuBKu1gGa3S4hcuR4AF
	IlkMYkgDzRhypAxQJfdW8JGcLJvFEpR/62Aw76Eqzz6eniAouzxQbT+/pJOrWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790348744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R9UOnSrVvo7U5rovUr4MwflJsqGtl//zZCil6jWNDZo=;
	b=Lblv32QnDT1BUKtIfwqCgX3VKsQA7Hmf9h2q6ySmBbThNojvNpotopwIlV6zndvBU4kHFx
	ER++nm21cMBTAZDw==
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
In-Reply-To: <araJ-EBntyqOGPkT@pathway.suse.cz>
References: <20260922072558.98854-1-pmladek@suse.com>
 <87ik3tiim7.fsf@jogness.linutronix.de> <araAvkIB5XatHPNk@pathway.suse.cz>
 <87a4p5iejg.fsf@jogness.linutronix.de> <araJ-EBntyqOGPkT@pathway.suse.cz>
Date: Fri, 25 Sep 2026 17:11:44 +0206
Message-ID: <877bk9id6f.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-09-25, Petr Mladek <pmladek@suse.com> wrote:
>> > This shows that braille_write() is called form printk() even when
>> > braille_co is not in console_list. It is called via vt_console_print()
>> > because the graphical console driver (ttyX) is registered.
>> 
>> But isn't that a bug? I thought Braille consoles were not supposed to be
>> handled by printk(). Even in this new series you added that exact
>> comment.
>
> I believe that it is not a bug. I understand it the way that the
> Braille device should show everything that is shown on the virtual
> terminal. It should show the printk() messages when they are
> printed there by the related console driver.
>
> It is just that printk() is only one source of messages shown
> on the terminal. The vt code maintains what is displayed.

But how do you register "the terminal" so that printk messages appear
there?

John
