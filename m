Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A919923A;
	Thu,  5 Sep 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545556; cv=none; b=KmPxAqVYCel5ZZsTNgdLHoYa0QY6pwkZB0PLkK0M2sa4vbYPWdg+cI9lvvlkhCqrb6Q1lg+SOWf+NgSBPVoba+ZZ01AtLYAjiOiIeezG2UfAxe7Df1iNXWzuwVzs9QuNPUxX6rSol/GnBZLzOp+6tFlh1nKapsMSZRWZGpf9mUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545556; c=relaxed/simple;
	bh=jgJLqQ5aUW1GtlCByoTB0kURD9IZ5ZOc/YkwJwwd8p0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDzGAgm//U+MF1OrA5fBJSn07tD3pdamFAJ4O3KilzzsDgroWZUCJHHXg9KWnuREY2QFP7r2ZPmQh/i0Z7tqVCVpMyb2simC2SKLt65rUgeagSivf+akMF5r2NojFQ9ijAp8N4xcsfCOrTIUJ/fX75oguWgjY8+GyzgVXWysFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwZ9jRjO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2hRokJ0V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwZ9jRjO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2hRokJ0V"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725545553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mX9sRy7qflqbJGwYCotHLR/2Vyut02DomVqWS3hqAW8=;
	b=gwZ9jRjO1UIrP0E6OYbmbiX0Pv5Dp+rFKarjwUAKNcVCIqepRQ1ViFlWidIJOP+pAwpUdd
	BesdEFLjDBV2xrUhuIQFiN1TvLvAX32dJ7xjJHFfvFXPeJx+ZvyrPn7kZM59jH/FOgOGvt
	n5PGX8SlGnpmTooiF654yAHu90lcQ3Lo5PLEqNhlUl+SCbmM6MnIyAsq5pxmu6MTtK8Lx8
	FVaj3oQVkQGLg+li4YFJeOoFpvZVr5SoXAxy9uORZ4LGfO+5BLjaEWh2ooFUZFohzA+wxF
	k8AgJgoUTwGwPZhvd+RpZpTkPdOz5jqDT8KMymqpP0+7ixdY4piGWVuu4wk5Yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725545553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mX9sRy7qflqbJGwYCotHLR/2Vyut02DomVqWS3hqAW8=;
	b=2hRokJ0VqPq3yflQpnMXpsUt2DnkAM34ll/veuwvPF0vMDZJJlHDk8w7BkTR4laHeQVc8D
	xif1gj99saIKM3Dg==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Tony Lindgren
 <tony@atomide.com>, "Paul E. McKenney" <paulmck@kernel.org>, Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, Lino
 Sanfilippo <l.sanfilippo@kunbus.com>, Derek Barbosa <debarbos@redhat.com>
Subject: Re: [PATCH tty-next v1 0/2] convert 8250 to nbcon
In-Reply-To: <2024090554-mating-humiliate-292b@gregkh>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <2024090554-mating-humiliate-292b@gregkh>
Date: Thu, 05 Sep 2024 16:18:31 +0206
Message-ID: <87cyli2nqo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-05, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Thu, Sep 05, 2024 at 03:53:17PM +0206, John Ogness wrote:
>> The recent printk rework introduced a new type of console NBCON
>> that will perform printing via a dedicated kthread during
>> normal operation. For times when the kthread is not available
>> (early boot, panic, reboot/shutdown) the NBCON console will
>> print directly from the printk() calling context (even if from
>> NMI).
>> 
>> Futher details about NBCON consoles are available here [0].
>
> Really?  That link calls them "NOBKL", is that the same thing?

Sorry. Yes, they are the same thing. It was renamed because NOBKL did
not look nice.

NBCON stands for "No BKL Console".

John
