Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C4D1C57AA;
	Wed, 18 Sep 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672749; cv=none; b=bcYwKZg8j64KgCBvc2hgJzpZowsTlAgZvchHyvCHyb7d0aFARIhtGPPJOi0tYGkkTh+tC8FpdjWOkUoThYc6su1/JugOHo2G2ESYsVk/QI+218VlHx4/7zgDBR4jIClP6E++YDjWtahF8vh3WfxSpuF/Jw+4FdYO5me/v4/POJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672749; c=relaxed/simple;
	bh=ZMAZ7vKEqHUBAukSpcLjPwhLOZQg2LUVZxwDz6JRLKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJM8mJi5xGPC4bvFTezjTF74goa1QOVPlNoImL9+fYNXjkM7S63VOVeihXCJTqNgnQhe4In6njs2rZAz/dTf4vvyK4hCNvCg37+u5pTrIiGWtHHLPvkfWhwMs6G1kWEH6K5bJWEyXGdlmJVUlbGwUeHFTh3avOL61c/nSOxitr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22wUL/kq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bbwtiS3s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22wUL/kq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bbwtiS3s"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726672746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMAZ7vKEqHUBAukSpcLjPwhLOZQg2LUVZxwDz6JRLKc=;
	b=22wUL/kqdZo2yHNCCPpQHmAtEpfdddS2eBGOMJLarAa48yRU5gW/wdO/38cPG0R9SPSYQ8
	K9hGRT54FuIwCElY8q2q6krJk+aJ3K5bXzTcAt5pEiNQrncGWHaWCRLhhjriDcx9XENt5b
	DGzAFPUQoLpH+FZGl9BbFtYjO5l/vaka6grgIpK+sx+3Rqs3zLwA0Eq/Y6jSs1ds6dZFnY
	Mlg5E39fPyp5PSiBmRpLClVo2XUleDgwk2s6JwcrrkOjE2352tyTOgd9P7NBshor4Q07tp
	ZHZA8utQBxTPwjLn95t0oEMMav0GWlodG96yStJcT8mNVTvkMTEnl7jWwXzYxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726672746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZMAZ7vKEqHUBAukSpcLjPwhLOZQg2LUVZxwDz6JRLKc=;
	b=bbwtiS3sBwfO/7jPUTsZdSak29bPGHBhiz1cAo+r2rQeX2OP1q65g4AXFvSzrE26Wi+xEl
	9gWAPjPghxsHVdAA==
To: Petr Mladek <pmladek@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner
 <tglx@linutronix.de>, Esben Haabendal <esben@geanix.com>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren
 <tony@atomide.com>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Arnd
 Bergmann
 <arnd@arndb.de>, Florian Fainelli <florian.fainelli@broadcom.com>, Serge
 Semin <fancer.lancer@gmail.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Lino Sanfilippo
 <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH next v2 3/4] serial: 8250: Switch to nbcon console
In-Reply-To: <ZurG8YMmBmVVxttj@pathway.suse.cz>
References: <20240913140538.221708-1-john.ogness@linutronix.de>
 <20240913140538.221708-4-john.ogness@linutronix.de>
 <ZurG8YMmBmVVxttj@pathway.suse.cz>
Date: Wed, 18 Sep 2024 17:25:05 +0206
Message-ID: <84ed5hrnva.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-18, Petr Mladek <pmladek@suse.com> wrote:
> It would be fair to mention that it does not longer support fifo in
> the 8250 driver. It basically reverted the commit 8f3631f0f6eb42e5
> ("serial/8250: Use fifo in 8250 console driver").

Agreed.

> It is not usable in write_thread() because it would not allow
> a safe takeover between emitting particular characters.

If write_thread could exit_unsafe()/enter_unsafe() while busy-waiting,
then emergency/panic could still take over at any time. Even if it means
that atomic_write() would need to first wait for the FIFO to drain
(which it will). The important thing is that emergency/panic is able to
take over.

I dropped the optimization to keep things simple for now, but I agree
with Andy that it would be unfortunate. I will take a look at what such
an implementation could look like.

John
