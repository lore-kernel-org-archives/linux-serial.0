Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12219F480;
	Tue, 24 Jun 2025 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750763069; cv=none; b=COyQ0324Q5ugzfiE7ZzD6TtDfThOA7Qf+3JhVJRJgbccWIT9LS+Fubt9JN3JgqlNafIeTex6C862jYx06gbHEaECyXdyi17o2DWqE8oEEgy3/WByEjLSI2XplptQmdFB5ZigPwYuw5rf3r0SN6AZV2ffFFxv1MT7Tq66ixZUAIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750763069; c=relaxed/simple;
	bh=caNPTD3VH7dgoobCeidFv0d4v5Nuqkjz4WPaa5obIRM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULT+/siptXBNkAB5ZzPv/T2Sa4QNdkob9edfNQHFjNgMU9BEFkuMkrFT1c2rV3yL6TqbRJB6X20BdwrH7KnMBwYlT1N9KqdLpKl7RK0IivhMcxLBMUFeC6AxzY354XXpY4sLE445gU1TEua6vGtkK2Pp3HrfATRMArlG6j3P/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYALeI+w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0nCeoNQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYALeI+w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0nCeoNQ"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750763066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eEk+aF+pt0MvEUwqDpSXabyNiN3Qdyl9X0CVlT8PCA=;
	b=QYALeI+wDWqdBcwoiCZT1gW13kZ0aWUTJAiRv5eh24JUe0U9MCzVDV71qbKcJEx8oDqHiL
	OXwAdfdvdF/diXvlbh8URTt5TzWvTQhqVtnQheBVZ9jGaOscKmRkIr5JQ5/aBxmfeXjrgj
	JExpQURBdHLkh1O0cglLYOty2dkpagdb8/D5sSy5v4SvOVCr1n9LAkduV6Lfau4uCW3UcY
	03pvnvXuyhL8EjsMe69F/RQCrvQFaldkgAEfcchAE6GBiu0j284+9FXRSD89SBHuUEusm6
	aSzZLEvID0iLevu9ODhbRcNDdAvhyEDmMYalCMdUVZk3uk1DNXtTFgDkYOCIsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750763066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eEk+aF+pt0MvEUwqDpSXabyNiN3Qdyl9X0CVlT8PCA=;
	b=b0nCeoNQlxtkF/VATw84CXoUW5gF8S9AJRZCXj3wuKZzjUykZsiuJ6FQYpbQlla9ns5vhy
	D23fvPgwu8aY34AQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
In-Reply-To: <aFpkQHwNCslbKSP6@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz> <84y0tmiidg.fsf@jogness.linutronix.de>
 <aFpkQHwNCslbKSP6@pathway.suse.cz>
Date: Tue, 24 Jun 2025 13:10:25 +0206
Message-ID: <84wm919z9i.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-24, Petr Mladek <pmladek@suse.com> wrote:
>> > Variant C:
>> > ==========
>> >
>> > Remove even @flags parameter from console_is_usable() and read both
>> > values there directly.
>> >
>> > Many callers read @flags only because they call console_is_usable().
>> > The change would simplify the code.
>> >
>> > But there are few exceptions:
>> >
>> >    2. Another exception is __pr_flush() where console_is_usable() is
>> >       called twice with @use_atomic set "true" and "false".
>> >
>> >       We would want to read "con->flags" only once here. A solution
>> >       would be to add a parameter to check both con->write_atomic
>> >       and con->write_thread in a single call.
>> 
>> Or it could become a bitmask of printing types to check:
>> 
>> #define ATOMIC_PRINTING 0x1
>> #define NONATOMIC_PRINTING 0x2
>> 
>> and then __pr_flush() looks like:
>> 
>> if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)
>
> I like this. It will help even in all other cases when one mode is needed.
> I mean that, for example:
>
>    console_is_usable(c, flags, ATOMIC_PRINTING)
>
> is more self-explaining than
>
>    console_is_usable(c, flags, true)

After I wrote that suggestion, I decided that the naming is not
good. There is always confusion about what "atomic printing" means. For
that reason the parameter was changed to "use_atomic". Basically we are
specifying which callback to use and not the purpose. It is a bit tricky
because legacy consoles do not have an atomic callback, i.e. the
parameter only has meaning for nbcon consoles.

Perhaps these macros would be more suitable:

#define NBCON_USE_ATOMIC 0x1
#define NBCON_USE_THREAD 0x2

or

#define NBCON_USE_WRITE_ATOMIC 0x1
#define NBCON_USE_WRITE_THREAD 0x2

or

#define NBCON_ATOMIC_CB 0x1
#define NBCON_THREAD_CB 0x2

or

#define NBCON_ATOMIC_FUNC 0x1
#define NBCON_THREAD_FUNC 0x2

Hopefully that gives Petr enough ideas that he can come up with good
naming. ;-)

John
