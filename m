Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527E941227D;
	Mon, 20 Jul 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549719; cv=none; b=JdomIfRFCBlF2KBfOzwVX/OIeUnvnmlXazinMPIQ+VFb5H+a2kvpzifUS/Aq/qFC3rTDMM6x6Cwib//D5/Mily1lOFLbvI5xPuG69Z173TcY/K3/d2Rx+Rz1QmAKi4buk4XwRgAp+gGJgH1HC7Uo+oubXo1NLzxxaco6TTHSNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549719; c=relaxed/simple;
	bh=oQZWqYd7uzWyyAtKdn46e6F6JP1Yc+rDpF/UYZbakR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JEzjHtPZ83X5SlrHXwDrnWqA+qdZuL8o5CjQY+MVf16dxZr9a5vxQ7F0RLzrYYFGFqrpFCQO+5KPIcp7+bLF6bhi6h0defRO96OqSvGmN8HIP42PglsVZpBxFSiy2lGWQPeXtx2oPvBblow9zlfsuv+IDk1i4dA0FnJwovE94zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HaazpAi0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyMXws+R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HaazpAi0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyMXws+R"
Date: Mon, 20 Jul 2026 14:15:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784549703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oQZWqYd7uzWyyAtKdn46e6F6JP1Yc+rDpF/UYZbakR0=;
	b=HaazpAi0BEgotZY4jiBKRwDFHf1/2zjOs+ipRohzkWca9kEWeiz2R6wHYMi8ObRaRHWQw3
	EY1eP9HbOvIg/lvQhRSoTC51lqLSSnaRoHOroog1HL4UVqDzgTA7V2RIJp8q6D4MvoZoZv
	/XEbXTU4DgA6d3IT5y7kKvvN9DK6Sz/11Q0iA5MXLn3AHlXIrCYS7S7F3wXPN/BQCcJUyi
	cxolP+W3PpeGUu5ByI86FdhaFbrlaneovUoT4NFITpOdpcei+Q6/6jo744s5UekXR7XbOt
	W8o0wyjzVPP1NZ9cnguLM8OEMBQQOWwqT6Ry84FG0pUfl0LIB0M4ExDwrZZJ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784549703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oQZWqYd7uzWyyAtKdn46e6F6JP1Yc+rDpF/UYZbakR0=;
	b=WyMXws+RNwYaWdlJwy5htve/1hToQZ07p3lge9jZKJ5+NIexJi8jBvH8G4CwmRaZaj98Ls
	xKqbe2t6Gw30pBBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Toshiyuki Sato <fj6611ie@aa.jp.fujitsu.com>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Message-ID: <20260720121502.S6lapkVk@linutronix.de>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
 <al4KdsU9YLOmwDoV@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <al4KdsU9YLOmwDoV@pathway.suse.cz>

On 2026-07-20 13:45:58 [+0200], Petr Mladek wrote:
> Just to be sure. Is this acceptable, please?

As John said, the pm hooks should be updated.

-> https://lore.kernel.org/all/8733xeaxix.fsf@jogness.linutronix.de/

> Best Regards,
> Petr

Sebastian
