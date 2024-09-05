Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E7D1537A8;
	Thu,  5 Sep 2024 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564190; cv=none; b=YkRQwKupzmVczlcejhOyAcVt4QYtLLlRvbNph2IiEXOJuRJIrWJ9Hku8dGfT9mKFtZrrYoQyQ1KK/HzZVrJIBzNANLeuzZbLZw/KR3ElF5DCMRUIyieTKoyDJt2eIsUp0k/r5QVxxzOLuXXpVffWpaiWWMe6vNMwwvO0KL4Ca7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564190; c=relaxed/simple;
	bh=mQN2pVwEQkF3flm9Z9OClScT2Lx6/mX7PDpQAhIlKXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sQFKLAFPM3Q2tj6EXeW8M9nRpSUdQwue0KNN5beyu+c0UBl16qVxxPWrKClXpvfUxlVa0k0t5+rxiTlwjxyAbuxkfus0kOwrnRXAne+do15ov4a2sFeB7Zz7XFCEJgb2HjaklyRTk+uxiDjsLmU6Bhclyz9vwEdCeW01cm2LlQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ScFdCQoA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wjX9/tAK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ScFdCQoA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjX9/tAK"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725564187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/k7v9dq75ZYxD6NMIKCBm1rrUuhMqAHo1YQGEDw0Fo=;
	b=ScFdCQoAJFY/dmPllSBmEKraXRBBRf4xYIK3yyunky3+PnSRtx5XZL+cb+SWPHKgnzaERf
	yeRka7fxAT5iMAP7vgy4vpbgP3t2Z2v/tZKyYIkM/PzKOiODyO2WiBhmGlIxLdwq0wTGMp
	7GOqf+hgznZSQ01hEugy/5hfe3ftmLRFO5vwATEIJlpDxPXH/HAH8NGy3DwvvUpEyRBtkd
	JhyzIdYKK1wayl5e12FFXmtMqJKXFZHCC8RYxVhy7Vk1GyU98CIwuh4ANP8fPnHFmZtXzI
	vfRVHojNVHf606XuNXomgnvstOMUpQKZ3/0V09svpSfszuLHvc09zwk4TSSXAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725564187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x/k7v9dq75ZYxD6NMIKCBm1rrUuhMqAHo1YQGEDw0Fo=;
	b=wjX9/tAKMyXG9yPWZou0k2Z9ybR82aZUvwX6irFPBSTuZeKq2289HtbiftyhJTzhrmGLGU
	z0ZdGIPBPY+3zJAw==
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Serge Semin <fancer.lancer@gmail.com>,
 Rengarajan S <rengarajan.s@microchip.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH next v1 1/2] serial: 8250: Switch to nbcon console
In-Reply-To: <Ztm85Y_mo5-OJveq@smile.fi.intel.com>
References: <20240905134719.142554-1-john.ogness@linutronix.de>
 <20240905134719.142554-2-john.ogness@linutronix.de>
 <Ztm85Y_mo5-OJveq@smile.fi.intel.com>
Date: Thu, 05 Sep 2024 21:29:06 +0206
Message-ID: <877cbp3nxh.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-09-05, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Thu, Sep 05, 2024 at 03:53:18PM +0206, John Ogness wrote:
>> Implement the necessary callbacks to switch the 8250 console driver
>> to perform as an nbcon console.
>> 
>> Add implementations for the nbcon console callbacks (write_atomic,
>> write_thread, device_lock, device_unlock) and add CON_NBCON to the
>> initial flags.
>> 
>> The legacy code is kept in order to easily switch back to legacy mode
>> by defining USE_SERIAL_8250_LEGACY_CONSOLE.
>
> ...
>
>>  static struct console univ8250_console = {
>>  	.name		= "ttyS",
>> +#ifdef USE_SERIAL_8250_LEGACY_CONSOLE
>
> Can it be done at run-time (theoretically or even practically)?
> (Note that we have already knob to disable / enable consoles.)

We don't want to maintain the legacy variant and really people should
not be using it either. NBCON is the way forward for all console
drivers.

I will just remove it for v2. If someone wants to use the old code, they
will need to revert the patch.


>> +	if (nbcon_exit_unsafe(wctxt)) {
>> +		int len = READ_ONCE(wctxt->len);
>
>> +		int i;
>
> unsigned ?

ACK.

>> +	/* Atomic console not supported for rs485 mode. */
>
> RS485

ACK.

> Feels like parts (1) and (2) duplicates existing pieces of code. May it be
> refactored to minimize the duplication?

When I remove the unused legacy code, the duplication
disappears. write_thread() and write_atomic() have very little in
common.

John Ogness
