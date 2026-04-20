Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903F3890F6;
	Mon, 20 Apr 2026 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679073; cv=none; b=NStLHRkZHxapnQ4qqFjJpxjLeTp+cCE9LeqH+qlXtzNxENjk7hm6n0G4vLSQZVHuxKVc9g5toK2Qev3vt3kHk40qw6TwdeTmhA1OJ6yJGJvYo/BrzpJTJVZMnIR1E/GM7izILesq6zyBkEu5knjBYoONEF/q/Wd2+sFSIIjIDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679073; c=relaxed/simple;
	bh=4nfRpO7k92WxWpPy3QlPgLzYsRDOQ3DvIbC3e5iFowo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D/qgTO7uVNj9AEM0QZ5HykhCaeUQnlxc3wYC3X5W71jPtZP4EHRU3zmPIHql4lh0sw0kIwTHEsgnbMa6u4ppGUak2xxluAUveYa6hMuvXg3fEvPEdjzJpQrZ1gHZj/cglFNCczscPcb1fnLBGbKTnPBMprYvRvq29Y76DP5S5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FQcaZEm+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R9R301Kp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FQcaZEm+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R9R301Kp"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776679070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfovccUs0mXnj9CctBJQFv/KuepKrZQ6xUTht25q94U=;
	b=FQcaZEm+eIo+q0Wj15agfKDIn3sX2iN+iN9N6VvJTPmmbeh2RA139xo+NiuFWl52td5tqU
	KHa+cyAiviUqDkRQ625VRYvzxm/U9ySTPsvzrhvyljMiq6VhdfvQHHMxtzpk96giBNuXdu
	fqfuYPkdXcYUSuG2D0bCi06LCGjPLUccmEJXwYM0oNdTg0bIfsE5b6qEGro+cPlhHQv13L
	iip5bQj5na7MVOwo1w2CWRub3xKiNkmxSE03Am0T9lrQexhbcrpWS+vWVmad8yN3YbYMwA
	JlaLkudmiM2SVontIS8IQCGrnnsM9Wo4tGQ46zsogSbf2p9z+cEs/xDnhi3Y8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776679070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfovccUs0mXnj9CctBJQFv/KuepKrZQ6xUTht25q94U=;
	b=R9R301KpfyiKcJ6Ie/vljBw4CGfzmfd4UVepA8EzEBFmf0WxSasjvwpQaYXuwlnKm5mVcs
	ib/zlECUc5AdY2Dw==
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, Ilpo =?utf-8?Q?J?=
 =?utf-8?Q?=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Osama
 Abdelkader <osama.abdelkader@gmail.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Gerhard Engleder <eg@keba.com>,
 Lukas Wunner <lukas@wunner.de>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Joseph Tilahun <jtilahun@astranis.com>,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH tty v3 6/6] serial: 8250: Add support for console flow
 control
In-Reply-To: <CAHp75Vf4YZVqXa7eH-RFeVsycdzoHijcWFnUbGv2PSmtPya1-w@mail.gmail.com>
References: <20260417102423.40984-1-john.ogness@linutronix.de>
 <20260417102423.40984-7-john.ogness@linutronix.de>
 <CAHp75Vf4YZVqXa7eH-RFeVsycdzoHijcWFnUbGv2PSmtPya1-w@mail.gmail.com>
Date: Mon, 20 Apr 2026 12:03:49 +0206
Message-ID: <87jyu20x9e.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-04-20, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>         struct uart_8250_port *uart;
>> +       bool cons_flow;
>
>> +       /* Preserve specified console flow control. */
>> +       cons_flow = uart_get_cons_flow(&uart->port);
>
> Sorry for nit-picking, but when I see 'bool' and see a getter, I got
> confused.

Understandable. Right now the wrappers are a bit overkill since it is
just a single boolean and there are no locking constraints.

> I would rather see getter/setter to be something like
>
>     cons_flow = uart_is_cons_flow_enabled(&uart->port);
>     uart_enable_cons_flow(&uart->port);
>     uart_disable_cons_flow(&uart->port);

I will use your suggested API for v4 unless someone makes a case for a
different API (or just direct accessing with no wrappers).

Note that this comment actually applies to patch 1 of the series.

John
