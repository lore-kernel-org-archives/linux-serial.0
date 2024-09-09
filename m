Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A682481;
	Mon,  9 Sep 2024 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725884026; cv=none; b=iTsGObX5Nqf0M6T2/elu+gYlxGAvG4i8HDStnPoppyf3m4xfHZg8kdy71nei+mOZx2draRh1tJF8Hns+Yut4EpRuTK/nYqwWKuu6s2aQKwgP8wxCUT1EglUAUNEOkX9V2THLcBjCzY7ho6gK0wdbMMpWrVFsLYdNNNFEIWR+6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725884026; c=relaxed/simple;
	bh=t47CccqHr/DHgoJgcqrfHM5zObVL3KmsSeDr4bAPynY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kos8Bt+PF1Gtq9VcTFLSq1XrFy78PS1kPvTjLd5aVoN5Y+HjMiPkhhbpAx/AG/n/9gcb7/LzMtvIsls1+zsvXHPTI9sJVGWXwpTV2cuR/TB2SaZeQ9Q4Ml/hLU4n545efqP4XpTLqN+cgLFtTqWW5aNt96k7oHLqm1cz2Ah7QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FECj/lhO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NrBI3X9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FECj/lhO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NrBI3X9G"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725884022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIG1cGBt+ym2uX13tn/UdRrvQEpGjYbA+c7n0ENDLNw=;
	b=FECj/lhOKYjJ6flkqb6lvQGG4FSgAGDozv7YgLU8C2Fs/Gbwev3mn6AZdzjAqHloa2ENCB
	Mj2l9w15Vy30RGNjW92SaF3jeEHKZdZqGupdMWGTubdO1SwL4kTfSnFpfoJVsJracAdFOx
	mvXMPlMg4XONErwnu544+EsOvcVRLgaGkjfFY4tVcWvOgQ0hqaf0YPzLu9EKyIydMiZl1w
	lkGhatT2/RwJ0MkNViuLjsgOQ0mBzTjJy9dhTl3ubOgelotSg78Ll5xxSf1Wapgb2Rytak
	D+khITwGpVHGO3xt6YpxQ7LNFklTAgYs81w8yHAPBISQFXUzlGvMkhWAL2NW0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725884022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XIG1cGBt+ym2uX13tn/UdRrvQEpGjYbA+c7n0ENDLNw=;
	b=NrBI3X9Gq7AlZJarU8wsCJQBFozXbVZWtkmSh2xG/z2fW9y9izo1R0eIthUyg+D5ZQIDWj
	q2uT+u4Hhx0rdUBA==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: John Ogness <john.ogness@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
In-Reply-To: <Zt7FstSsthuxtpEz@smile.fi.intel.com>
References: <87jzfod9f2.fsf@jogness.linutronix.de> <8734mbdwrf.ffs@tglx>
 <Zt7FstSsthuxtpEz@smile.fi.intel.com>
Date: Mon, 09 Sep 2024 14:13:42 +0200
Message-ID: <875xr5c9e1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 09 2024 at 12:53, Andy Shevchenko wrote:
> On Sat, Sep 07, 2024 at 10:39:00PM +0200, Thomas Gleixner wrote:
>> On Fri, Sep 06 2024 at 18:44, John Ogness wrote:
>
> ...
>
>> I'm 100% that this is just a problem of blindly sharing this with the
>> regular uart code and not because there is a requirement. See what
>> serial8250_console_setup() does at the end:
>> 
>>         if (port->dev)
>>                 pm_runtime_get_sync(port->dev);
>> 
>> The corresponding put() is in serial8250_console_exit(). So there is
>> absolutely zero reason for power management in the console write
>> functions. It's the usual voodoo programming which nobody noticed
>> because it did not immediately blow up in their face.
>
> It might be historical, but yes, the above is for a reason.
> And if somebody needs a kernel console to be shutdown, they should remove
> it from the active consoles.

Correct, because you cant do PM from arbitrary contexts.

Ergo the code which does PM in the context of the console write function
is bogus.

Thanks,

        tglx


