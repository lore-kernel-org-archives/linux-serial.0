Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613B2C21F3;
	Thu,  9 Oct 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760010575; cv=none; b=WJhbwCyscODD5fA+9jZVMBkAgUE0Nk3nDfZ8qJqZiXtJeSoDjpuDldzm7SV4lF0LemiIHIWWELhvyXTxOj8WVu3jj/njfnYk2ExuRxoqYEvSzEX14/9XIMA+SRGCq0ijQjlgANvYNUkS/KS1vvqKI4E4ot7PrY2gqzZRG1J0xNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760010575; c=relaxed/simple;
	bh=qUs/uHMz1ZFaC1vVPhGntEv/oQ5mWSJtmvzToYMMDb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pzvBXXXeMpAPalOQPEyj0WNsZwt50ZtrEHwu0fxcJSoL3K6G+mZhjbnVhAWFrbNQQ4CKoYcg3mbSCorbEPjSyHq6zEDg0Pq/+Qydy616mTBKzxYboCWlmB5kmMMxlTGOy2JOMDmDMOi2A2bAXMKkW6Zc3tmMFvG2l5ExeVWh5eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M2j0Yq17; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHnSRfah; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2j0Yq17";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHnSRfah"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760010570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qUs/uHMz1ZFaC1vVPhGntEv/oQ5mWSJtmvzToYMMDb0=;
	b=M2j0Yq17Aa9BO0ldHx7ChlTzkafsSLYC3+ZEIdgJ5R/vhTWdhGhUE1Fn7HMeUpoiK2xI33
	zQn+ZBCd/sVH40AR3v0KshhXx3bA8TtxO54P/6o1oQMxddr2t/sRif8D9gkgr1tDmPR+9K
	jQzI6nfhVRccjkBRQiTy3a4+qjDmvOZGJqgQHfawXPAqD47MOoDRoMcK7ZCwm23MuJuVBj
	kjDZHbVqHMQ/cdOdViE9fudGfhzGaY40iDKj2C4ruCuSvAlqfRy/PpQu3uO8fNCsCPE1UL
	RAmZvb1zBzLZVCbKGimN9o7EwmjYnWMXsx8keJHHCSZulaUT3iNUCTO0w3c9GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760010570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qUs/uHMz1ZFaC1vVPhGntEv/oQ5mWSJtmvzToYMMDb0=;
	b=AHnSRfahOip7Dg6a2LaDWYUTPeW3O5fdJcjXdScXdf7qK7okNw30a+ltLoN8/WhVnMiULd
	2WM6WvlYQ5AIsuCQ==
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thierry Reding <treding@nvidia.com>, Jiri
 Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Esben
 Haabendal <esben@geanix.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Tony
 Lindgren <tony@atomide.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Serge Semin <fancer.lancer@gmail.com>, "linux-tegra@vger.kernel.org"
 <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH tty-next v5 5/6] serial: 8250: Switch to nbcon console
In-Reply-To: <csyu222cbxrze5yv3qnwj3gl67x2pwkd6ichpotrwxoj7jru5h@cywpyiqycfre>
References: <20250107212702.169493-1-john.ogness@linutronix.de>
 <20250107212702.169493-6-john.ogness@linutronix.de>
 <80b020fc-c18a-4da4-b222-16da1cab2f4c@nvidia.com>
 <84a521pets.fsf@jogness.linutronix.de>
 <92b787f4-1f51-4974-9e58-231dddd4b8f2@nvidia.com>
 <csyu222cbxrze5yv3qnwj3gl67x2pwkd6ichpotrwxoj7jru5h@cywpyiqycfre>
Date: Thu, 09 Oct 2025 13:55:29 +0206
Message-ID: <844is8qoqe.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Thierry,

On 2025-10-09, Thierry Reding <thierry.reding@gmail.com> wrote:
>> Thierry, do you have a Tegra124 Jetson TK1 handy to test this change on?
>
> Yes, I do. I reapplied patches 5 and 6 from the series (resolved a tiny
> conflict for patch 5) and reran the tests. Same results as back in
> January, though. Basically the first suspend doesn't work (it exits back
> to userspace after a few seconds) and the second attempt then hangs. No
> idea why that would be happpening.

[...]

> John, I'm happy to test any other patches if you've got any ideas on
> what could be wrong.

Thanks for your support. I created a branch on a public git repository
[0] so that we have a common source to work with. I will push additional
debug-commits on top.

I am taking this email-debugging-session offlist. I will post again to
this thread once we come to some conclusion.

John

[0] https://github.com/Linutronix/linux (branch nvidia/debug-8250-nbcon)
