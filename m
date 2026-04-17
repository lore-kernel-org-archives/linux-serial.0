Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C73A382D;
	Fri, 17 Apr 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431706; cv=none; b=npCAYpaOX25ZbfpT7aiYxZL18JW7NBsnHX5LZN7NLDmTZbV8hovIV+7LhQKgZ6QMr0ND2qB9mg78zy41jU0WfoF1OyOTk0sEpoyfsY1xvpziAC95SkgAh11CxdVOilpKdDwcpV9YtOu1FQYfMn9xC33oj/AUruu3+Fith4wPXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431706; c=relaxed/simple;
	bh=xFk2gK/4+ooy/jMgie45XH0cgmHkjI/ItcYyB9LtTzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LuJGhcTMelOmzKFA8zxPHzs46NMAnBIHljzAyrPYjzxdlKR58KnQRvEgKJnyx8NY3DFbkNDq0jAh+MOtSzK8GqMnh8k7W92yyZJPgoRaBFFpQz2yIhGxqy9UQtUMiZwT+iMz7jWgL1k4+8EB1uF7zuwJXyLC1/bkDsAy+ychaGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4HUpSdca; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I4ASQ8+s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4HUpSdca";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I4ASQ8+s"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776431700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMygO/0mxKoq9cMrh69vghJOl9cyomb64heMFc9y618=;
	b=4HUpSdcaX2lf22ePx64GCqiN6gpbTLWlKj/T06uLsbSBD5wCCD3EXQs9tr2Qkve9/UE9+w
	QaAB4SDaEapnJzzO58QV7ljYRE+uS4sGIVczOVBVol+sQQHLk7vVNWoRoo8U7s3/KYfYqD
	ezznUV7hoPl5h6ulKY0PIgcy1zh0E77lbquVLTAHZQK5+sTmZ0SSV4LkfQTIbtKbtdxoKu
	rt26YCYC4epMUNyOP73jF3OWgko/989KScy8pN38Iffbp1i1tW1WnBeDYdQzo/81EuYgUL
	8jJT4NwC1n+GFpx+jp3ReezvwS6WwTiwyCP1pq8usr6YvlurfXxPvDpcc1njmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776431700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMygO/0mxKoq9cMrh69vghJOl9cyomb64heMFc9y618=;
	b=I4ASQ8+sjoWCBPLqAFJH7eY4noou4TBHgRGjTERZsP7u84isO5ApwWsm/3kH5ERL8ZEbol
	mSfgiTPPJUXWlwDg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v3 1/6] serial: core: Add dedicated uart_port field
 for console flow
In-Reply-To: <20260417102423.40984-2-john.ogness@linutronix.de>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
 <20260417102423.40984-2-john.ogness@linutronix.de>
Date: Fri, 17 Apr 2026 15:21:00 +0206
Message-ID: <87v7dpafu3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-04-17, Sashiko wrote:
>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index 666430b478997..2327a364ded16 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -567,6 +568,7 @@ struct uart_port {
>>  #define UPSTAT_SYNC_FIFO	((__force upstat_t) (1 << 5))
>>  
>>  	bool			hw_stopped;		/* sw-assisted CTS flow state */
>> +	bool			cons_flow;		/* user specified console flow control */
>>  	unsigned int		mctrl;			/* current modem ctrl settings */
>>  	unsigned int		frame_time;		/* frame timing in ns */
>>  	unsigned int		type;			/* port type */
>
> Since cons_flow is now separate from the flags field, do manual
> assignments of struct uart_port need to be updated to copy this new
> field?

My goal was to catch everywhere where uart_port.flags is set explicitly
or from some "external" source. I did not want to filter anytime one
uart_port.flags is to another uart_port.flags. If UPF_CONS_FLOW is set
in the source uart_port.flags, then _that_ is the problem.

> While subsequent patches in this series update
> serial8250_register_8250_port() to explicitly copy this new field,
> early_serial_setup() does not appear to receive a similar update.
>
> For example, looking at early_serial_setup() in
> drivers/tty/serial/8250/8250_core.c:
>
> int __init early_serial_setup(struct uart_port *port)
> {
> 	...
> 	p = &serial8250_ports[port->line].port;
> 	p->iobase       = port->iobase;
> 	...
> 	p->iotype       = port->iotype;
> 	p->flags        = port->flags;
> 	p->mapbase      = port->mapbase;
> 	...
> }
>
> Because UPF_CONS_FLOW was previously copied as part of port->flags,
> will omitting cons_flow here cause a regression where the
> configuration is silently lost if any platform sets console flow
> control prior to early registration?

In this particular case, I checked all callers of
early_serial_setup(). They are passing explicit flags and UPF_CONS_FLOW
is not one of them.

Likewise, I could not find any examples, where UPF_CONS_FLOW could slip
into uart_port.flags, aside from the 2 examples I found and deal with in
my series.

I have no control over out-of-tree drivers that call
early_serial_setup() with UPF_CONS_FLOW. I could sprinkle bitmasks and
WARN_ON's to try to catch such out-of-tree misfits. But honestly, I
think that would introduce unnecesary code churn and complexity.

Considering the current questionable kernel state of console flow
control today, I doubt any out-of-tree drivers are really using the
appropriate policies anyway... meaning that the out-of-tree driver is
probably just unsafely using (uart_port.flags & UPF_CONS_FLOW) now,
which would likely continue to work as good/bad as it does now.

John

P.S. It looks like Sashiko ran out of gas [0] trying to review the 2nd
patch. So hopefully another reviewer (human or !human) will find some
time to take a look at the series.

At this point my only real concern is the community opinions on
deprecating UPF_CONS_FLOW.

[0] https://sashiko.dev/#/patchset/20260417102423.40984-1-john.ogness%40linutronix.de
