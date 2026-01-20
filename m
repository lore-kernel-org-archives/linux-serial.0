Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B2844BCAC;
	Tue, 20 Jan 2026 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925318; cv=none; b=didRx8qYppVFfwAOqoil7fVvhF26J3pZbixmuEeI48R7R8SpxasYdAdB6m/3sXrC5KDxHey8GYkHV7hJTgiuq5JqjCCsWs1xOLMb1FgXMKa2w3eS4E8b2eqd9wdcqqjAkqH6zbQaozY47yXfdUBMvei1KIYHXtSbymMOIoy0TXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925318; c=relaxed/simple;
	bh=xxSHYRcsD6KSZPrhr8mI2zyDRVOU8GgOZrlwewaiM8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inXsQb6hqS3vqi+whrLSdr/kF+BZ0h3HVRvWSTgo/OjtRNA1BywOniSMUgImNa0+ADOdu6sBipuYS6ZOUV6Ga5Zf77J2wB52D/ujx4UTptSU+C1uNVpyKlyXAArj+ufcwnVl1BfVEXz1LrCBlT3tssrRkI90b5QDmS02EYBrQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 149FCC2371;
	Tue, 20 Jan 2026 16:08:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 98F652001E;
	Tue, 20 Jan 2026 16:08:25 +0000 (UTC)
Date: Tue, 20 Jan 2026 11:08:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-fbdev@vger.kernel.org, Petr Mladek <pmladek@suse.com>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>, Helge Deller
 <deller@gmx.de>
Subject: Re: printk's threaded legacy console + fbcon => schedule where it
 should not
Message-ID: <20260120110845.2922a91a@gandalf.local.home>
In-Reply-To: <20260114145955.d924Z-zu@linutronix.de>
References: <20260114145955.d924Z-zu@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sc1t1r9yjrbrwriah6z9pj8pwx36gdnt
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 98F652001E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+NCAIc05kvRYS+kWiNkh9HaI1GuceIB1g=
X-HE-Tag: 1768925305-657059
X-HE-Meta: U2FsdGVkX1/uU2YSjMw0vIE0Yatvg1jcqqbPKHGWS59S8kwiHZ15FGdbhu4NNd2RwVPlZ3QKDZ3ruvQ0DJCdE0w2t+Yo0bNYRW1/60jzus6Ia72jP58jgpXLvCPzjfvi0Uouif0auLB03V4OKy4X6YTrxINp1X++KSPPdxWSy63angtP7Qk9MVjZFKGIWo/LCTTa8SX5HzSzPVzClLeR0N1D60CMVc+3tb23FQ1HJ2vON2fNIfF3hdQMyVZwnrzQWuD0Qf32avV5XmPl23O0i56cfaPaPfyAb92avUHzwD9PedTLl/iP7b2vOyGarYQg7CqoM03FiHRhXsc3zXVHMCRCgkKyutQ1

On Wed, 14 Jan 2026 15:59:55 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> @@ -3362,22 +3362,6 @@ void console_unlock(void)
>  }
>  EXPORT_SYMBOL(console_unlock);
>  
> -/**
> - * console_conditional_schedule - yield the CPU if required

Egad! That goes all the way back to 2002:

  https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=a880f45a48be2956d2c78a839c472287d54435c1

> - *
> - * If the console code is currently allowed to sleep, and
> - * if this CPU should yield the CPU to another task, do
> - * so here.
> - *
> - * Must be called within console_lock();.
> - */
> -void __sched console_conditional_schedule(void)
> -{
> -	if (console_may_schedule)
> -		cond_resched();
> -}
> -EXPORT_SYMBOL(console_conditional_schedule);

I'm assuming this likely isn't needed anymore. I don't know of any reason
it needs to stay.

Should we just remove it and see what breaks?

-- Steve



> -
>  void console_unblank(void)
>  {
>  	bool found_unblank = false;
