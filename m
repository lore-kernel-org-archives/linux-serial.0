Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4401925D530
	for <linux-serial@vger.kernel.org>; Wed, 30 Apr 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746027666; cv=none; b=KrPdpaWos979xqEYc8/UYLSFP/M2sXq5qSSweWkcdeL/3EaL1CtNQBI3aAREy5rJWZzFaHWm346mqwpEWdkWKvOz9pzBd824puw8S0UuTQJXRkteIDzg6pXKsin6S8VnU4WTK7m3ffobAYb1t6Nr0wjKzWA9kOumV/QgHZ+v8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746027666; c=relaxed/simple;
	bh=S/vqLrE9MwEibIcPjjIkBfXFM4lNV/KpoyCob/1/Ieg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qKFKy+rAWleqOrY0+Q9h4PxZ6iGrX3ncGg1QzDZKxhEGT8C7O/HiwjTH0s05eCqd1LUcWunePj/oVDdMX06Kuz9LxPIVmOOEmQIT1KQyASTx7eANWHsDJ4QvRvFoF9se4wqE/3t3arc6xbyJ+uU5S+Er6e0BBr0Tt2ta9tMYQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ML2WE7a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/H2ODD9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ML2WE7a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/H2ODD9"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746027662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/vqLrE9MwEibIcPjjIkBfXFM4lNV/KpoyCob/1/Ieg=;
	b=0ML2WE7aV+VaoJXm43g5r2ogbJ/7eggZ9siBjl1xWnCXDnT7PkjL32mlmalEfxmGBdOwn8
	thEiwWTwXQm92awOOnAO6PA8d+wb369Cs8y7wQBUGd2NIYhk5C0GOHVBBccqLr+KRnarZx
	ePKK4ifcWcFlgS0sPvsy+3d7drAembHlJnFXoPZUvg5HxEQmsxijCSdM/ybKTC4SSx7FzE
	xNCeTZJGPLajQ2aa/ivgQWuOQqBH8ox1dO2DPNxnVFUZujJ3UZSe0xVpLfGRCFXCGMugTD
	e5XkEb77GIJerGrAbtTEpIGMLO0q2zAHJo8MvmhOoXoEVVczKwN1MpBF1ENnWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746027662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S/vqLrE9MwEibIcPjjIkBfXFM4lNV/KpoyCob/1/Ieg=;
	b=n/H2ODD9ssXhtGGnfXEttKYwqH7m9Yp3qkR4d08jSDFEumvL+87G//QtVpupc2luXfGN8J
	NN/oTMVStP04UaBA==
To: Ryo Takakura <ryotkkr98@gmail.com>, pmladek@suse.com
Cc: ryotkkr98@gmail.com, Jason@zx2c4.com, gregkh@linuxfoundation.org,
 linux-serial@vger.kernel.org, lkp@intel.com, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com
Subject: Re: [linux-next:master] [serial]  b63e6f60ea:
 BUG:soft_lockup-CPU##stuck_for#s![modprobe:#]
In-Reply-To: <20250430091520.80111-1-ryotkkr98@gmail.com>
References: <20250424081101.110914-1-ryotkkr98@gmail.com>
 <20250430091520.80111-1-ryotkkr98@gmail.com>
Date: Wed, 30 Apr 2025 17:47:01 +0206
Message-ID: <84y0vhodwy.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-30, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>>> The touch_nmi_watchdog() resets the softlockup watchdog. It might
>>> hide that the CPU did not schedule for a long time.
>
> To test the above, I run the rslib test using legacy console(without
> the John's series) with the touch_nmi_watchdog()s removed as
> following.
>
> The result is that it triggered the softlockup as expected. So I guess
> we can say that the legacy console was indeed hiding the softlockup
> scenario as suggested by Petr.

Excellent.

>> With the John's series appied, I guess the kthread were running on a
>> cpu other than the one running the rslib test as John said[0], and
>> neither of touch_nmi_watchdog() nor cond_resched() were called that
>> could prevent the softlockup.
>
> To test the above, I removed the touch_nmi_watchdog() mentioned by John[0]
> on top of the John's series with the printing forced to be done on the same
> cpu running the rslib test by marking emergency section(below change applied).
>
> The result is that it triggered the softlockup as expected. Similar to
> the first test, the touch_nmi_watchdog() was preventing the softlockup
> when its marked with emergency section.

Excellent.

> And I believe this implies that the kthread was running on some other cpu
> as stated above as it should also be calling the touch_nmi_watchdog()
> when it does printing.

Agreed.

> If sounds good, I will prepare a fix adding cond_resched() to the
> rslib test later on.

Yes, please add a cond_resched() to the rslib test.

> I tested with Linus' master on x86 qemu. I was able to see the rslib
> tests prone to softlockup and the John's series exaggerating it, same
> as raspberry pi.
>
> But I couldn't see the softlockup go away by marking the emergency
> section around the printk call within the rslib test. Looks like it
> never calls the touch_nmi_watchdog() in wait_for_lsr(). Maybe because
> trasmission gets immediatly completed on qemu board?

qemu does not emulate a baudrate, so indeed transmission completes
immediately. It would need to be tested on real hardware. But I am
certain we found the cause and explanation. Thank you for digging into
this!

John
