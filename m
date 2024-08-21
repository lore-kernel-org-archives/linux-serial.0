Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D41EC0A6;
	Wed, 21 Aug 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232527; cv=none; b=ADz9pX0gfFnXW4P6lt1aIJbuEg1PunAWsvrrK28ru7mdGaM722oBqPJ3PqvjMsTt2FzPZ12AMCMsO8vTWUtZ0MhC1fyAopC8qvbjbvYBO8Gn9jKHeZCbLjjwp/MRlGQjpYFLA51TgyqPBUfea1SL0GxRo89Z4tK5iv4ltqnZ2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232527; c=relaxed/simple;
	bh=d0hK44yV4ie9jJaLjDRBFkgUGqVGjErZ2qoZe4/PzkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmRcDydPmd6F7WXxZyV9rtSHp9S4Pdc4c80wOXAvaMH77PZzeLEsc71CNbzRQeOu8vurXqdqyP09wD0gOVEhj6c25I6j8cO1dZKvNttPxsdoxbtPh5FeduL4KMmfwl17DBSYMgdLYi1LusRPiOFOWcV0fy41qbXXgbt/xlhxFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=znP1ZQyU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmbcV15x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="znP1ZQyU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmbcV15x"
Date: Wed, 21 Aug 2024 11:28:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724232523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwIfjl/SkOS8cmSTOuzxNrMyi9nOGJebaxARQHgbQgA=;
	b=znP1ZQyU4MeA8mKlN4v4gTE5G+17CK2Yaz2cQx27kbU8TU/mZoOBEk8fByF01HTA8ZvIwT
	Nfc5sWK+9EWOjJBh8LjDkeMxHbEY43qFU8xb0Fej6W+RszbARBceusOm5KZApnWTv/LbUt
	6qy3mn7hygUTzts4bpEWhFwh9x2MD/pCG/ntoeTPd3jWTc1uWgtJkkMG6OjL0m2VwAz8IC
	2PG+8jwn47aWoAGemYxoC67bJdn9uVJ4k//kigr8xdUUyDLN0H2l1bLkENNGU5KdqdjAwa
	cWU8UyJVo5oH7ZJFHst2ebNtbchSu6BnGirzoh871PGQT0mAv2L05Nbkxal69A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724232523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwIfjl/SkOS8cmSTOuzxNrMyi9nOGJebaxARQHgbQgA=;
	b=MmbcV15xW1vtwOPgQ8GPMEN776QDAVZE1PNHcNXovTJNIxWbKZ6BRGjAcOQYlnMvgUHT//
	eKNLeFuqqmCaXkDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Ryo Takakura <takakura@valinux.co.jp>,
	Uros Bizjak <ubizjak@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	Lukas Wunner <lukas@wunner.de>, Feng Tang <feng.tang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH printk v8 00/35] wire up write_atomic() printing
Message-ID: <20240821092841.j42XmBAk@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
 <ZsWxpVG8uZ9Nq26h@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsWxpVG8uZ9Nq26h@pathway.suse.cz>

On 2024-08-21 11:21:41 [+0200], Petr Mladek wrote:
> The series seems to be ready for linux-next from my POV.
> 
> I am going to push it there once I get approval from John about
> the proposed update of the commit message for the 30th patch,
> see https://lore.kernel.org/r/ZsWvRETyuh1Yq80j@pathway.suse.cz

If it is just the commit message, couldn't you push it now to next now
and then simply rebase it with an updated commit message?

> Best Regards,
> Petr

Sebastian
