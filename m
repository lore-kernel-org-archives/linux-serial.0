Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BE3AB26E;
	Sat,  5 Sep 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612943; cv=none; b=dOxvPCPRAmdrRX3oeWeWIIMtinfxwcKIKusoBVZG4ELsQtvZmrmoypM351VY3dMB94GxtOUMF8BYw5ntSyRc64OxgiFBvjbFNd/UIOXtinioNWoyLurNgLBDi5KX20YPtt1cOA+zZ/Xzf0jWoirmZ1a3t+nL9ElzACwyn5aO3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612943; c=relaxed/simple;
	bh=wKJEQ5Q0SWwLuYpWZ54K0RfOg1erOJfjFc0dYFnnF+Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=R4Akn4JZVCqyElDDUygqDrLco0xreTPOqUca6/9qh/b/fXUZM8m2Tbtf458oMWJWciVjLzCxdz1c1UnybbFGAHHNBpL53xge8v1c0OP75IYROmN0lAc7qBEu+VflkW6o0b0FgJsXfk/H9/9YD+dJ0iqtEk4WDLaBNK/IHotUPv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=YG6+A1Wr; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=HLAFaG1y; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="YG6+A1Wr";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="HLAFaG1y"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788612937; bh=XYPB5r2hrdZcjH5+GIkVcIc
	AfwYPQt/OOpik7OvusH0=; b=YG6+A1WrySqf41XBTEmcx/+srulR0A84+jfOvl4HnQD0wDZPLP
	bYULG3vqf8NxCQ9I2wCRPwZsGertvhnQvAL/Z/7xQGMOWzqkFWlkNhODJzn5Y3KheTCF8sF9p+X
	AfovAK4YheM4n85y05qb7h0xFRwIt9RooXCTXJebh0dggSz4BW4m4uLs/m43QI5B1VoErg66IIh
	4QJ8EgUo3QnbAS/CzXi1uKgKh3rk44HrHcSOKuYW0R1QJ8loOyLA0oaMj1mhwqSgMCcfsa0xDOJ
	nw2qdNK0BSiu8eilcDP/4rkTwdqArrD3ZUDpD70+L+Nb/55airRE4HslEZrC2lHxCBQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788612937; bh=XYPB5r2hrdZcjH5+GIkVcIc
	AfwYPQt/OOpik7OvusH0=; b=HLAFaG1yxWXd1Xe4eIO0U8Setq3cc6wnubq8q6eAQNfY7ftNqF
	wATrGVTQOH6TgK4ppR6nSSapyhkGgJkSMTBQ==;
Date: Sat, 05 Sep 2026 13:55:35 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Andy Walls <awalls@md.metrocast.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Slaby <jirislaby@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
 netdev@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-pm@vger.kernel.org, akpm@linux-foundation.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/5=5D_kthread=3A_convert_re?=
 =?US-ASCII?Q?maining_users_to_kthread=5Fcreate=5Fworker?=
In-Reply-To: <2026090514-smuggler-elixir-8888@gregkh>
References: <cover.1788513591.git.brads@mainlining.org> <20260904085418.50d66b34@kernel.org> <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org> <20260904141032.34f7ed1b@kernel.org> <2AE8656F-326C-40B5-BA11-EB9CD72D2AF7@mainlining.org> <2026090514-smuggler-elixir-8888@gregkh>
Message-ID: <6F579B00-7B91-49F4-99FF-5F31E844355C@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 12:19:54 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>On Fri, Sep 04, 2026 at 10:13:32PM +0100, Bradley Morgan wrote:
>> On 4 September 2026 22:10:32 BST, Jakub Kicinski <kuba@kernel.org>
>wrote:
>> >On Fri, 04 Sep 2026 16:56:30 +0100 Bradley Morgan wrote:
>> >> On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org>
>> >wrote:
>> >> >On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:  
>> >> >>   media: ivtv: convert to kthread_run_worker
>> >> >>   net: encx24j600: convert to kthread_run_worker
>> >> >>   tty: sc16is7xx: convert to kthread_run_worker
>> >> >>   cpufreq: schedutil: convert to kthread_create_worker  
>> >> >
>> >> >Please send these 4 to appropriate subsystems
>> >> >  
>> >> >>   kthread: remove worker->task self assignment  
>> >> >
>> >> >Then after the next merge window when trees converge send this one
>out 
>> >> 
>> >> hi, I was hoping one person could merge it with acks from all
>subsystems
>> >
>> >Not how this works.
>> Ugh, I've seen it before happen.
>> 
>> Look, fine, I'll do a V3 soon, WITH ONLY the subsystem changes, all
>> separate, all sent over to their respective maintainers, then when all
>> thathas been merged and there's the next merge window, then whatever,
>I'll
>> send then the kthread removal
>> 
>> IMHO this is a massive annoyance though.. because what if one of the
>> driverfolks doesn't wanna respond to me!?!
>
>Then, after trying for the normal way, you can make the driver change at
>the same time.  But to circumvent the "normal way" thinking it might not
>work, is not the best thing to do.
>

Greg!

Right, okay, Ill tell you more.

For features being added, where many drivers from different subsystems get
covered at once, what they tend to do is:

A: send all patches, rely on all maintainers to merge their own crap, which is a mess

B: Have a designated merger, who merges all the changes at once, no chance of regression because it's all bundled up.


C: send drivers first, then send the feature. So then driver maintainers can merge their crap, then the main feature gets merged in merge window 

I prefer B, because it's easier that way, akpm is usually des merger hence
I CCed him.

Or tip tree?

Honestly, if I had to be honest, C is a very annoying way, because of what
I said above, if driver maintainer thinks I'm some newbie idiot or
something, then what will I do? He won't merge it!


>thanks,
>
>greg k-h

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
