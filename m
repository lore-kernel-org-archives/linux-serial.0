Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BEF28F51A;
	Wed,  4 Jun 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037838; cv=none; b=eew9YILeeJkG35CnRnU15ou9HQ2FehEPi5RmDkegaBHxAwRa3duhJPa19fPsst9ga2uk8ELmgYX7mu0xvyHIoM5bC7Zj6QqHplgzvUrtVtxXDxfN2iWtRBT0RemwyuI6sy+uEz5MTaHrKM+S1UgzvERRAQZijGyD42yDYGoM4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037838; c=relaxed/simple;
	bh=L8dtHkNvZx3SLd/o3iJzF6LR1Vyy7ZrilUk1Pr3G3uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A1kXhVF0Ka0B7YPW7ZpAJ33P+09j8ishlcN1ReZJQ6yXd3bcNwLiCvq5g0/rloNMTUTe7ud0O3lnKQLcE2EyQkvTVPi+aownFin3Na+U4aVYnGHRjssNIKwyYytgNs6nspYbIOgvlF2S66W9bpLJIxlmJ1O5wUX25YoVqJZbDWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oLegIJNm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SmWCssRS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oLegIJNm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SmWCssRS"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749037835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WuJsBEQO3vOHs70HHUYSLQfGS4A7b1VGRI3y13ObEFA=;
	b=oLegIJNmlkhOaetnuHLnch2mHHI+88mIOb3Y0cYl7lskKBYEEzGVCM1wsH1KXlak8ffUBR
	nZUMyHq+WVjSRiI+J5d+zSeEV6tTJpcCuHO6QGXQvXnS7EHGCqDLEy3X8CWDi4ijbAKM2F
	Px3eU6Ao/vZiGBWf6Ty5mCa1tRsEJ+KjayDZD6WJmYQVW52RS4Jbi+JJi3em83Lj9LfVQC
	p969a8IZOgd9cM9f5pzgSRNX6OLiL9uc5gVFSdgA4gntA1s/mCv+UU/ctr6r/wI0WzBmj6
	r8nyemYWNPFPNtWON1uz44w64Ej3ZByT/sIkP1z23H2cRcIHzjIA+LfcceOBvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749037835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WuJsBEQO3vOHs70HHUYSLQfGS4A7b1VGRI3y13ObEFA=;
	b=SmWCssRSGTRTgB2qp0+RPYebju8bTkPSVINOn6Di4Y+SjIWdqd2It7SNMy+NVWjVCDXVWa
	TpYNl84Bb9OtHzCw==
To: Petr Mladek <pmladek@suse.com>, "Toshiyuki Sato (Fujitsu)"
 <fj6611ie@fujitsu.com>
Cc: 'Michael Kelley' <mhklinux@outlook.com>, 'Ryo Takakura'
 <ryotkkr98@gmail.com>, Russell King <linux@armlinux.org.uk>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <aEApOPTqbVOR35F_@pathway.suse.cz>
References: <SN6PR02MB4157A4C5E8CB219A75263A17D46DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz>
Date: Wed, 04 Jun 2025 13:56:34 +0206
Message-ID: <84o6v3ohdh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-04, Petr Mladek <pmladek@suse.com> wrote:
> On Wed 2025-06-04 04:11:10, Toshiyuki Sato (Fujitsu) wrote:
>> > On 2025-06-03, John Ogness <john.ogness@linutronix.de> wrote:
>> > > On 2025-06-03, "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com> wrote:
>> > >>> 4. pr_emerg() has a high logging level, and it effectively steals the console
>> > >>> from the "pr/ttyAMA0" task, which I believe is intentional in the nbcon
>> > design.
>> > >>> Down in pl011_console_write_thread(), the "pr/ttyAMA0" task is doing
>> > >>> nbcon_enter_unsafe() and nbcon_exit_unsafe() around each character
>> > >>> that it outputs.  When pr_emerg() steals the console, nbcon_exit_unsafe()
>> > >>> returns 0, so the "for" loop exits. pl011_console_write_thread() then
>> > >>> enters a busy "while" loop waiting to reclaim the console. It's doing this
>> > >>> busy "while" loop with interrupts disabled, and because of the panic,
>> > >>> it never succeeds.
>
> I am a bit surprised that it never succeeds. The panic CPU takes over
> the ownership but it releases it when the messages are flushed. And
> the original owner should be able to reacquire it in this case.

The problem is that other_cpu_in_panic() will return true forever, which
will cause _all_ acquires to fail forever. Originally we did allow
non-panic to take over again after panic releases ownership. But IIRC we
removed that capability because it allowed us to reduce a lot of
complexity. And now nbcon_waiter_matches() relies on "Lower priorities
are ignored during panic() until reboot."

John Ogness
