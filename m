Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0593D45C1;
	Thu, 20 Aug 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221099; cv=none; b=rxbovwyvRAzLqXqHnR+30GEyYQU5L+JJXaeQMllEdlgZqwh3FLNQZ+cGjhD5diJ73BVGt8d5RYP9YXeNGOupTo8rqbOm0y2roWRjrM01kQQAezG2W0BV86+vPCwb4aJtxOeeSGvlqkFS6MlVtmDPbrfr4OSf1qAWG/dAamZNRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221099; c=relaxed/simple;
	bh=jnHnNCsJ2ipTPRt3iQ2TA3WXtD9ikMwcqbvJA3buiBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0kq5Y/Ab0TCODKWtunrg1ihi136ML8knYrqVxrUCV64iW7cheRJB3m1KsRjaAb/Ux6es32uF4Fk0CIfywEqZIC2XhmM8P7MrmTYh5nh6tV1wnfRYtcyd4SF0NEHe/1S1j3fPkvBteKIiEFIC8Fl+yhP+Fxpea6dsUbrP0sCbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5z1sihF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQao7JLk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5z1sihF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQao7JLk"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787221089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgYeVfgN5J2y55yOfIGqDbi4PlQPKemPsKm5JFkfUa8=;
	b=W5z1sihF5BcqmaTrZbxwvgaCRU3P3pOPNlP1ERqsH8nfmFImr+wJXrfH7y0Io0qRc1vMlz
	4erB5kb3gxdPDt27BKT/NocHYEgbDOTHAzUj4hlQf8G5Z2jPi2eVb9Z6tPjae655fNosMU
	AO6AaHzFkpSwFpLUSf2GhOPkOAN2jmXFocNtkF2iBM95AHy6Jb45xuyynLcJn8A1zIjWU3
	mpGXJIX1PIFvm2PRRd9mjPizvMtLH/KgGaO3cbRAjWlM89XbdkSZVFUtoIvbFkjDkgcNhR
	iOe5+hpYWllBVB5r+/WZk8POl4xd671wy0MCzaEmOFUE0kqQ5YCiWudqzmUwwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787221089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AgYeVfgN5J2y55yOfIGqDbi4PlQPKemPsKm5JFkfUa8=;
	b=vQao7JLkzZmNQ47oqLGBU04FBwGWHwbCs4HyYzDRSvTkdseR98JkWufBg/cT8s4FG+k4u5
	+iHoCv+JvfjRRZAw==
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andreas Schwab
 <schwab@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, Petr Mladek <pmladek@suse.com>, "open
 list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] m68k: nfcon: don't call console_is_registered in
 nfcon_device
In-Reply-To: <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
References: <87ecfzsv6h.fsf@igel.home>
 <CAMuHMdU4C+W6Tpsn3Vr_kqmuU2Vzg7ExXhspmB5qNWMZ3Wnfeg@mail.gmail.com>
Date: Thu, 20 Aug 2026 12:22:46 +0206
Message-ID: <87fr099jw1.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-08-17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, 15 Aug 2026 at 09:33, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Since 7c2af0f634f1 ("tty: tty_io: use console_list_lock for list
>> synchronization") show_cons_active calls the device method under the
>> console_list_lock, but console_is_registered tries to acquire
>> console_list_lock as well, causing a deadlock.  It should not be necessary
>> to check console_is_registered here since the function should not be
>> called in the fist place when the console is not registered.
>
> Nice catch!
>
>> Fixes: 7c2af0f634f1 ("tty: tty_io: use console_list_lock for list synchronization")
>> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

FWIW:

Reviewed-by: John Ogness <john.ogness@linutronix.de>
