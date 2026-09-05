Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9604BB5DE;
	Sat,  5 Sep 2026 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788631028; cv=none; b=U1kILLGWJSg0xSQoWmNPxx7eOliUEnJkp65EzdslBD02dh55zxOcrW2wJ0hPUiKdTAB7clfHblBLKjJP9Efv+zV38nDRJc2mbcbWwlGWep7xo8jJcZoFwQIM0xR8oOulv97kUFL+nLE17sYWCSlcTAHj7YjEZB6MyVDUhPlPT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788631028; c=relaxed/simple;
	bh=Qvgg+kiKgT4Hjsk0rghWRHJZqgdAgxfCkMSm8PKHHLM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BpZXaUNCVELEmWCBfYwB4Ix/bDA1PeO2iJqjEkls0M83X3Ok+Iv9unGaT3gMbqxd2pc66eDL02Qxr0K+d+GaFdfQAfNxLmrk5kF7VCgA4Fh8Q+KWDeZGq1s6KkJwRbraWBQ43OmSfPkb3AsgyG8rXfXvDi/Px49gwwZTSsCmeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Cbd+UDbG; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=RudGKzYE; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Cbd+UDbG";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="RudGKzYE"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788630997; bh=/uGxumBJ5UAO4xHhOSodMqP
	edc/Uqnf/1W4c3XeAi44=; b=Cbd+UDbGkRpaIF+b1UDx2rkJFGlZSVgAY9/tnv0gLb8enQxpkW
	UmxdjHimseIubQAaye3qlB9I/z9f/lkxN3gkB3cbadQ1r/E9k5DNpXBxxkwx/nSL80qTqDHM7Hs
	K174Wu9KkEDJJilq/UYUt4EN60NvzZ0Z/gVGmsWIJLD9ZVIpOU68Vowsted+EHCBGFNUb0j/KeX
	WoU/wVNB7o6r063HP8kk5Y4imMZnMCWHCj5V0w7UxWuGiqQGBvfu9PXGVpkpZHRdbRbsIRkVSAK
	Y0WMSkhgBRPf38w7kjaCmS53srsIX/ng/WptBNki3nVdvZ2WPEg+Dsj0YlRxFOiaeJg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1788630997; bh=/uGxumBJ5UAO4xHhOSodMqP
	edc/Uqnf/1W4c3XeAi44=; b=RudGKzYEERoH4MQrIdexsch8HhyO4q2A35/dtDC9GgH3ir2rM6
	uY2RbGarRNz+cBorgG+Pde6cLP/bQfRFG2Bg==;
Date: Sat, 05 Sep 2026 18:56:37 +0100
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
In-Reply-To: <2026090500-seventh-come-270c@gregkh>
References: <cover.1788513591.git.brads@mainlining.org> <20260904085418.50d66b34@kernel.org> <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org> <20260904141032.34f7ed1b@kernel.org> <2AE8656F-326C-40B5-BA11-EB9CD72D2AF7@mainlining.org> <2026090514-smuggler-elixir-8888@gregkh> <6F579B00-7B91-49F4-99FF-5F31E844355C@mainlining.org> <2026090500-seventh-come-270c@gregkh>
Message-ID: <E652F21B-E26D-4137-A50B-45CF25D3F527@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 5 September 2026 18:10:56 BST, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>On Sat, Sep 05, 2026 at 01:55:35PM +0100, Bradley Morgan wrote:
>> On 5 September 2026 12:19:54 BST, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> >On Fri, Sep 04, 2026 at 10:13:32PM +0100, Bradley Morgan wrote:
>> >> On 4 September 2026 22:10:32 BST, Jakub Kicinski <kuba@kernel.org>
>> >wrote:
>> >> >On Fri, 04 Sep 2026 16:56:30 +0100 Bradley Morgan wrote:
>> >> >> On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org>
>> >> >wrote:
>> >> >> >On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:  
>> >> >> >>   media: ivtv: convert to kthread_run_worker
>> >> >> >>   net: encx24j600: convert to kthread_run_worker
>> >> >> >>   tty: sc16is7xx: convert to kthread_run_worker
>> >> >> >>   cpufreq: schedutil: convert to kthread_create_worker  
>> >> >> >
>> >> >> >Please send these 4 to appropriate subsystems
>> >> >> >  
>> >> >> >>   kthread: remove worker->task self assignment  
>> >> >> >
>> >> >> >Then after the next merge window when trees converge send this
>one
>> >out 
>> >> >> 
>> >> >> hi, I was hoping one person could merge it with acks from all
>> >subsystems
>> >> >
>> >> >Not how this works.
>> >> Ugh, I've seen it before happen.
>> >> 
>> >> Look, fine, I'll do a V3 soon, WITH ONLY the subsystem changes, all
>> >> separate, all sent over to their respective maintainers, then when
>all
>> >> thathas been merged and there's the next merge window, then whatever,
>> >I'll
>> >> send then the kthread removal
>> >> 
>> >> IMHO this is a massive annoyance though.. because what if one of the
>> >> driverfolks doesn't wanna respond to me!?!
>> >
>> >Then, after trying for the normal way, you can make the driver change
>at
>> >the same time.  But to circumvent the "normal way" thinking it might
>not
>> >work, is not the best thing to do.
>> >
>> 
>> Greg!
>> 
>> Right, okay, Ill tell you more.
>> 
>> For features being added, where many drivers from different subsystems
>get
>> covered at once, what they tend to do is:
>> 
>> A: send all patches, rely on all maintainers to merge their own crap,
>which is a mess
>> 
>> B: Have a designated merger, who merges all the changes at once, no
>chance of regression because it's all bundled up.
>> 
>> 
>> C: send drivers first, then send the feature. So then driver maintainers
>can merge their crap, then the main feature gets merged in merge window 
>> 
>> I prefer B, because it's easier that way, akpm is usually des merger
>hence
>> I CCed him.
>> 
>> Or tip tree?
>> 
>> Honestly, if I had to be honest, C is a very annoying way, because of
>what
>> I said above, if driver maintainer thinks I'm some newbie idiot or
>> something, then what will I do? He won't merge it!
>
>To quote a longtime kernel developer years ago, "Kernel development is
>hard, let's go shopping."
>
>Sorry, but yes, it can be difficult to touch cross-subsystem stuff like
>this, always has been.  Just be patient.
>
>good luck!


Yes. Ack.


I feel this is convoluted. 

(I do mean sashiko did start crying! , sigh)


But tbh, B is the best option. For me atleast. Is C a requirement?

>
>greg k-h

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
