Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B34C650A;
	Fri,  9 Oct 2026 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543163; cv=none; b=MzUW3H/BEqhVDkSp6oWFkXI8PVVt5NslP1o3iQBjaYa6UuhWjklhd9KTheMSs7lex8x5fMWnZFFo6A01dPViDm4JxghXInSrAda2JDDM6PLw0W/V9ePCw1B7p28aHYTF/wiT67C0gcgCGsDj/wk5dMA5xfScAkCXG+B495Zun3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543163; c=relaxed/simple;
	bh=ynNF/LZcaHv9CDeI0N5OZuIragdEycvHinNUG39v4YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+zf3YbnF1wcsYgirViZhz04femRfXlFbzmP+qgGj+T6w4UAuvW3s6+FbGK/OIBCVfv1xhhGL8r/T4mlSlMuTYmxLN4NEQHhwNR5r1lz3PfaJrF86fLNEm3YVjXvVbeY5oCth7ah5kNc8UKHQ5Kwiw7njF0zac4Ii9tlcTJPL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0WlK2IrW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dw962lIH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0WlK2IrW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dw962lIH"
Date: Fri, 9 Oct 2026 12:52:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791543146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMY002kjZ83w9g2JNRtaQJiRQwwWXJ+d94MDCB5LXGg=;
	b=0WlK2IrWkGG1Hu1WHHU+WvIYiy5UjsNrEROoWiIrVdTHkKKheRNSNUK2gFPteeu7a8RsDb
	GQemivZi15TeOL038nimUvLr4Zpgnrsuy8/Dv4+aPfIUh0H/sakh+zHNa3uDDWYLlyhz4Z
	SznHtNHUDBO/WGzpj+i3RRKlTM7RJ6LqidXhYRyWNOJEu+eTahQ/bv5Nihs53ZmOLNbuor
	NJ0gE+hBA/eNiMfSq20Kxz6QtqAgUOpp/m93Tv+GCWbJZsfuAlTr0o4LcVv9SMOe5e3Gwm
	U5QjQwYRLlxz4PZf1MZqX3eJFD2KeWXOQh58U4sK1BWXJRe/JmF8KAl9LMUuww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791543146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dMY002kjZ83w9g2JNRtaQJiRQwwWXJ+d94MDCB5LXGg=;
	b=Dw962lIHsNQIOZtNSfcl3p5qT5aRrndydbChJmn0h07l9uTvgB0uUhOkQNQvJkiQ7+GPQM
	UwUO5rzbCPRZYUCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Bradley Morgan <brads@mainlining.org>, brauner@kernel.org,
	john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
	oleg@redhat.com, oliver.sang@intel.com, ptikhomirov@virtuozzo.com,
	rostedt@goodmis.org, senozhatsky@chromium.org
Subject: Re: [PATCH] nbcon/reboot: Flush nbcon consoles synchronously on
 reboot
Message-ID: <20261009105224.FgfdSrKA@linutronix.de>
References: <20261008150852.8286-1-pmladek@suse.com>
 <CD188453-7954-45B3-8501-FE9574D5FF1A@mainlining.org>
 <asixA20sG8QHH7hf@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asixA20sG8QHH7hf@pathway.suse.cz>

On 2026-10-09 11:16:51 [+0200], Petr Mladek wrote:
> > Hi, this looks good to me reboot.c ended! :)
> > 
> > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> 
> Honestly, I am more or less ignoring Reviewed-by: Bradley Morgan.
> I can't recall any problem reported by this person. And the excited,
> AI-generated, acks do not add much value.

to be fair, there is one:
| $ git log --grep "Reported-by: Bradley Morgan" --oneline | wc -l
| 1

and there are even fixes:

| $ git log --author "Bradley Morgan" --grep "Fixes:" --oneline | wc -l
| 12

> > That's ok :) I'm too unlucky as to not go to any conferences :c
> 
> I am not sure if there will be any conferences when robots will
> be ready to attend them.

Would you or would not exclude Lieutenant Commander Data from a
conference? We don't have positronic brains yet but maybe in a few years
:)

> Best Regards,
> Petr

Sebastian
