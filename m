Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264A28A1DC;
	Fri,  6 Jun 2025 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229107; cv=none; b=RaJ5ha+MCs66SwdNJ99bd6JxoJ6UbPkbex7yLE0jao6yQwEQvbiEXnS0VpZILTirIoeQ5Fcy54usXisUN0IIGnM/peio2Le53/VwE60eH3RV5rjWE+pr3VTYUfagKmMRw8w9CS4xpmpZqYTFfmyAT2beTZKblpkvmZEsPFHj5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229107; c=relaxed/simple;
	bh=fcglZOKYAlZZOQ2/Dkb0cJsSrYB7P0UhmfoDzTbxPtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVvgQhcDp3958A3itbKGh+v9cAFH+rgxQkoB1zEbmWMoq8LArLW3PBVy2Ai9coTqH61iwn5zDcfcF9ZPeCm17xRG1N3niOaBMZ0/BEjb5fDY/ejIQ+nLPWT+AomF2aIZyBrfvijkF89liSjxAzitpP2MD+jplK4Sl4/LRei/Htk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=35ARZ3cW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/ZzWL1W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="35ARZ3cW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/ZzWL1W"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749229102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k95L5dONGc9CGpjQXqAX4pgyDviRC1HRrOs4s2XHP00=;
	b=35ARZ3cWSCFsiwLfUkdujv+aKxhUsCTUh2IX4MmwT3dO0YvNhz8mxqLjOLSmRedTSFebTq
	psSABq/JZEzPlaUlHXBoeRc1oUYheu3iQI9vWbhT1AgIwul1wKZhwKSByI/aTYyprU81AP
	WDs52bDysUvt+72dq1xUeXUJxknI1Zij1y76fKpF69gei+VLeesoQgLgGfI3JlPIW20Cq1
	yWVwMlT2Kl1M/LZEdGyYhkTBiYx8FuORb+ERVlRo27PChn4RZE5gkqCGWNiTkgqqzzDW7K
	kgzePptvKAELg7I58UBeLnnPQ9pGPu4PhTNHLy/mdwBh7lGsczKGkYLat+gSUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749229102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k95L5dONGc9CGpjQXqAX4pgyDviRC1HRrOs4s2XHP00=;
	b=D/ZzWL1WLUKSjbYuu1m6EkVXeRSKEWqtK71hgfzILpbVD+lKbq+WraD7rm7MeCUilnhyBo
	Z/6FCBLz9/2tTICg==
To: Petr Mladek <pmladek@suse.com>
Cc: "Toshiyuki Sato (Fujitsu)" <fj6611ie@fujitsu.com>, 'Michael Kelley'
 <mhklinux@outlook.com>, 'Ryo Takakura' <ryotkkr98@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
 <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: Problem with nbcon console and amba-pl011 serial port
In-Reply-To: <aEL0tZgSEhsR9qbf@pathway.suse.cz>
References: <OS7PR01MB13775FE1A20762D1EA4A38D0ED76DA@OS7PR01MB13775.jpnprd01.prod.outlook.com>
 <84y0u95e0j.fsf@jogness.linutronix.de>
 <84plfl5bf1.fsf@jogness.linutronix.de>
 <TY4PR01MB13777674C22721FCD8ACF4FCCD76CA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEApOPTqbVOR35F_@pathway.suse.cz> <84o6v3ohdh.fsf@jogness.linutronix.de>
 <aEBNLMYVUOGzusuR@pathway.suse.cz>
 <TY4PR01MB13777CC92C858572B9C19394FD76FA@TY4PR01MB13777.jpnprd01.prod.outlook.com>
 <aEGeARVcCwqcoHb8@pathway.suse.cz> <84frgdcgug.fsf@jogness.linutronix.de>
 <aEL0tZgSEhsR9qbf@pathway.suse.cz>
Date: Fri, 06 Jun 2025 19:04:22 +0206
Message-ID: <84msakdcy9.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-06-06, Petr Mladek <pmladek@suse.com> wrote:
>> What if during non-panic-CPU shutdown, we allow reacquires to succeed
>> only for _direct_ acquires? The below diff shows how this could be
>> implemented. Since it only supports direct acquires, it does not violate
>> any state rules. And also, since it only involves the reacquire, there
>> is no ugly battling for console printing between the panic and non-panic
>> CPUs.
>
> Interesting idea. I thought a lot about it, see below.
>
>
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index 5b462029d03c1..d58ebdc8170b3 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> diff --git a/kernel/panic.c b/kernel/panic.c
>> index b0b9a8bf4560d..8f572630c9f7e 100644
>> --- a/kernel/panic.c
>> +++ b/kernel/panic.c
>> @@ -304,6 +310,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>>  		smp_send_stop();
>>  	else
>>  		crash_smp_send_stop();
>> +
>> +	nbcon_panic_allow_reacquire_set(false);
>>  }
>
> I have two concerns here:
>
> 1. I wonder whether this is reliable enough. It seems that
>    smp_send_stop() waits at least 1 sec until the CPUs
>    get stopped. But is this enough on virtualized systems?
>
> 2. It might increase a risk when CPUs are stopped using NMI.
>    The change would allow a non-panic CPU to reacquire the ownership
>    and enter _unsafe_ section right before being stopped by NMI.
>
>
> The 1st problem might be avoided by allowing the reacquire all
> the time unless an "unsafe" takeover happened.
>
> The 2nd problem is worse. But allowing the reacquire all the time
> might actually help as well.
>
> Note that the information about the "unsafe_takeover" is stored
> in struct console so that we even won't need a new global
> variable.

That is a good idea. We should add unsafe_takeover as a condition as
well. That can only happen way after the smp_send_stop() anyway. But it
means that only the atomic printing code would ever need to worry about
unsafe_takeover (assuming a driver were to implement some sort of
handling of it).

>>  /**
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index d60596777d278..d960cb8a05558 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -235,7 +235,8 @@ static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
>>   *			the handover acquire method.
>>   */
>>  static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>> -					    struct nbcon_state *cur)
>> +					    struct nbcon_state *cur,
>> +					    bool ignore_other_cpu_in_panic)
>>  {
>>  	unsigned int cpu = smp_processor_id();
>>  	struct console *con = ctxt->console;
>> @@ -249,7 +250,7 @@ static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
>>  		 * nbcon_waiter_matches(). In particular, the assumption that
>>  		 * lower priorities are ignored during panic.
>>  		 */
>> -		if (other_cpu_in_panic())
>> +		if (other_cpu_in_panic() && !ignore_other_cpu_in_panic)
>
> If you agree with allowing the reacquire all the time then I would
> rename the parameter to @is_reacquire and do something like:
>
> 	if (other_cpu_in_panic() &&
> 	   (!is_reacquire || cur->unsafe_takeover))

Looks fine to me.

>>  			return -EPERM;
>>  
>>  		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
>> @@ -913,7 +920,7 @@ void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt)
>>  {
>>  	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>>  
>> -	while (!nbcon_context_try_acquire(ctxt))
>> +	while (!nbcon_context_try_acquire(ctxt, READ_ONCE(nbcon_panic_allow_reacquire)))
>
> And here it would be:
>
> 	while (!nbcon_context_try_acquire(ctxt, true))

Right.

>>  		cpu_relax();
>>  
>>  	nbcon_write_context_set_buf(wctxt, NULL, 0);
>
>
> Summary:
>
> I open to give this alternative approach a chance when we allow the
> reacquire all the time. It might work well. And it won't require
> any special "panic" handling in all console drivers.

Agreed. Thanks for being open about this approach. I will put together
an official patch.

John
