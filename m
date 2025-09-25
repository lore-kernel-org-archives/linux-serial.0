Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562861D6AA;
	Thu, 25 Sep 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798378; cv=none; b=GaEOM3nqn4J8+poS8SgrsBmqxJbZ3P6TKWVzhW0xxIPpuBiDU4vQYM6aV68CGcRWjAoGCStYtqLfWYinRDp6nmdLKJv8kOdEmfbKvAUz+hYwYuOw4F9/DL6Jc5tHBUYOeFC4B2X7+03JPHz5os4IvT/RwJNCN/HrKtfWX0rr7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798378; c=relaxed/simple;
	bh=vvMuOKYdDIrlGB0PZRBL1rJV4LGfKU8Uc8DvtYbfWLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QzueWk6dPyFr0zhrfm01YqmHYDFKkNZ5iWQ61CgKwBjc619kQM4u0uapxjtZQG4bSQhImtCkyz0YmWxM5l4g3/8QVqwsHGI+a/jSo7/FXgJmVi+2V5JDg2vOhk6JIcEO6ENsyvEX0YiVEkIC6rwrvE8UiyOlxy12bc+CgMocbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQU5uZC8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSJLN2EG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQU5uZC8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSJLN2EG"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758798372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3u4wLoRa0I88aaTtwJPzrN6aLU8r3QVESI6zmcB4G8=;
	b=YQU5uZC8R1qPJZ0O5ro8UPXWKG4wM74Y87HcDFd3Y8SAbwRh7pOap2noqv4UFKvJ/KHotL
	zXquMdC1bsQq7zuNOJv28uBoq6T0kMNAEJZg6njG4pzZKXE/iquTkaVInzyOcSMruFAdIL
	+sk0i74EtT3G9GPcMP56ESsHlhbs9WirCLkXeAEhkc/MIY1zGJ4SCU3ndZivoAqU+OuiOF
	SrYoWSNOITd/jQvbuqjELx/nLP8YxSSrqkuykXgUNkJMAfQsaSGBhs+Mw/+7H1borbfSrz
	Wm8Xne1+u9xa4r0DFcHUXMCBq6du2IxzC/IF4f8d7pYMEuhPLAqorFZ8A309GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758798372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3u4wLoRa0I88aaTtwJPzrN6aLU8r3QVESI6zmcB4G8=;
	b=MSJLN2EG3dgzwJDK2FoMdmbGtZ9IXVwmAxxhNI1Yp1Ur86nCp/qrv5VcSLqmh1/E4yx0xa
	j0ugVmK/YN9t9HCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Serge Semin <fancer.lancer@gmail.com>, Andrew
 Murray <amurray@thegoodpenguin.co.uk>
Subject: Re: [RFC 0/1] serial: 8250: nbcon_atomic_flush_pending() might
 trigger watchdog warnigns
In-Reply-To: <aNQO-zl3k1l4ENfy@pathway.suse.cz>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de> <aNFR45fL2L4PavNc@pathway.suse.cz>
 <84348eju8a.fsf@jogness.linutronix.de> <aNO7Qjv_iSUSifTv@pathway.suse.cz>
 <84348crpi3.fsf@jogness.linutronix.de> <aNQO-zl3k1l4ENfy@pathway.suse.cz>
Date: Thu, 25 Sep 2025 13:12:11 +0206
Message-ID: <84tt0qeqqk.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Petr,

Thanks for putting together this summary...

On 2025-09-24, Petr Mladek <pmladek@suse.com> wrote:
> We currently have the following solutions for the original
> problem (hardlockup in nbcon_reacquire_nobuf()):
>
>
> 1. Touch the watchdog in nbcon_reacquire_nobuf()
>
>    Pros:
> 	+ trivial
>
>    Cons:
> 	+ Two CPUs might be blocked by slow serial consoles.

Note that nbcon_reacquire_nobuf() is not the only function that behaves
this way. We also have the same thing in the port lock wrapper:
__uart_port_nbcon_acquire().

> 2. Yield nbcon console context ownership between each record
>    and block all kthreads from emergency_enter/exit API
>
>    Pros:
> 	+ Only one CPU is blocked by slow serial console
> 	+ Prevents repeated takeovers for "every" new message
>
>    Cons:
> 	+ More complex than 1
> 	+ Completely give up on parallel console handling in emergency

This seems like the most practical solution for now. It is simple and
will guarantee that no "kthread interference" occur. Note that only
consoles that implement write_atomic() need to have their kthread
blocked. (Also consoles with unsafe write_atomic() would not need to
have their kthread blocked.)

> 3. Yield nbcon console context ownership between each record
>    and block only one kthread from __nbcon_atomic_flush_pending_con()
>
>    Pros:
> 	+ Only one CPU is blocked by slow serial console
> 	+ Parallel console handling still possible in emergency
>
>    Cons:
> 	+ More complex than 1   (similar to 2)
> 	+ Possible repeated takeovers for "every" new emergency message

IMHO this is the most complex solution and will still not guarantee
avoiding kthread interference.

> Well, releasing the console context ownership after each record
> might solve also some other problems

Sure, like with the port lock wrapper.

> I am going to try implementing the 3rd solution and see how
> complicated  it would be.
>
> It would be possible to change it two 2nd easily just by
> using a global counter and updating it in emergency_enter/exit API.

Basically you are talking about changing the per-CPU emergency counter
to be global.

John
