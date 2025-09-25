Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD781F5F6;
	Thu, 25 Sep 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799155; cv=none; b=mgIzhb4yKp5xDzY3pxVYeiqSB3slTmgFbQ6UG9cwkkKoD6/Ak0VXzkY1Z4cNxN/IyVGpEddNOg1Ix0raFn2beBxngvVRMlgJTCPCPUCR1/aRCxMyCIffJWwBKuDrk8og8uz3+PpDqhdLPBy7tmVu1fNwrwsGdx7vD0dt3pB10lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799155; c=relaxed/simple;
	bh=LDlpCKyv/1Df/QVVkmokmueXyerA+afGAZ7R7Ns+L4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjCyrhATeRpWNyc7JkfOXrQ/auupJ955h1NOxghGc7I5OTKWeT9Tfl1pINMNQVbomfI++l9VVe8RoBJNdv0n0TLbKyTB22WroOaEs0knGjOcuXQVHhATnvdIu0IYu+nSSXGR4dRrmJdrIZWstSHMBqt+Xrf5WenV4Woq4jobYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jnXYyngu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wR1Jdthn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jnXYyngu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wR1Jdthn"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758799152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NIl4vLQM/mBW4n0b+jJCY7p8CuhHQZ22scqk5S8M4=;
	b=jnXYynguA3ALdgN3dgGdl6gMf7EoQ42o1rfbRw6ZdlTyDMg6qOpqiDxCLeL56BVC7zpPj/
	qu63Zm7ZnZNWFb7HGnY7sugkoLxHkRW5pKCNdKKa8m77uYFX4VLs5fbv7YM1i9jVWSzbMP
	s583+dOqlq84AQ9XN3HZuXRceeC3hrkjM8cFhrPnu01EQdmE6QmaPCOx7AEMIlmuxn8AN/
	MF6qQAsZ1HyZ0aj8n7DsInceQd//MzJlYGLV7sUoqGq75Uon95WAus9ZKlwp3j2N3DOZLF
	pFFDf0uNSi6WABjMx4xOl6LrHZLu60FaIRY8M6V4Gq+FiWumMQTVs2fXDPbqEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758799152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4NIl4vLQM/mBW4n0b+jJCY7p8CuhHQZ22scqk5S8M4=;
	b=wR1JdthnEjJVBSTgvUNkip8sa+Gf+I8mXVdpc60TUaoPpNCBeDJExk6h5xI6ASP4n0eF9/
	OEEIEDgXnlpDDbCw==
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
In-Reply-To: <84tt0qeqqk.fsf@jogness.linutronix.de>
References: <20250822142502.69917-1-pmladek@suse.com>
 <84qzwzbr90.fsf@jogness.linutronix.de> <aNFR45fL2L4PavNc@pathway.suse.cz>
 <84348eju8a.fsf@jogness.linutronix.de> <aNO7Qjv_iSUSifTv@pathway.suse.cz>
 <84348crpi3.fsf@jogness.linutronix.de> <aNQO-zl3k1l4ENfy@pathway.suse.cz>
 <84tt0qeqqk.fsf@jogness.linutronix.de>
Date: Thu, 25 Sep 2025 13:25:11 +0206
Message-ID: <84qzvueq4w.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-25, John Ogness <john.ogness@linutronix.de> wrote:
>> I am going to try implementing the 3rd solution and see how
>> complicated  it would be.
>>
>> It would be possible to change it two 2nd easily just by
>> using a global counter and updating it in emergency_enter/exit API.
>
> Basically you are talking about changing the per-CPU emergency counter
> to be global.

Sorry, I spoke too quickly there. The per-CPU emergency counter is still
necessary to make sure the CPU with the emergency is the one that is
pushing out the messages, i.e. printk() is only expensive for the CPU
dealing with an emergency.

John
