Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1652B4E66A3;
	Sat,  5 Sep 2026 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628364; cv=none; b=mCs3e2moi0uHIOiDNEYcj22WlsqtP/rKQoRtAyaPIcNpTuCEfADyAB4WM0vuk5bb4PQWvyxhec7Ln2JAa3vCl1y9/CjjUJutkePUKQqmwtyM2rUBD5x7HAxHeQYK3GYNy7EDE2VJgItP4fp0/3Eqp4n/jlMAFbP7PE2yvSJ60C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628364; c=relaxed/simple;
	bh=0WlEQ9NTGdKsJKuEva5krlDpHGDjDnq6UoWcffek8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7MNNDufF2d+Kd/3g5h4UNOZt6kaWobCC1ZBJXJwq5pGCSQr+LAUf35yVAM7mu61vszAWau+6/9Pmvdqb6t8PKdpOww/CdQRTPUH7SXrAIxxZFNDwTor6Hr0UX9MwmKc9VC36EtLF5tAfOXBxjHF8ZYKwngjaWGLO7Bx1wB6dHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vu5jVN6t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vu5jVN6t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0D31F00A3A;
	Sat,  5 Sep 2026 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788628362;
	bh=nGLgAQNoLfaFQJxAXDIrwWwGfi/EusKEG+W7YzFtytE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vu5jVN6t+KEiza92TxzuY2GyQ5v5znR6Jd+89lg+bcwlBXTbHyicxN8ZgLsx8+BHw
	 NjYX6BC0hSTjYnz9yCUp6CTmtPj7qgsOs1SLQf60rFVEXAM3RJJO7GrXLvnSZnaek7
	 arfWIizLy9CZtYncZSyePjJ45ny4BaC6XhEfygZU=
Date: Sat, 5 Sep 2026 19:10:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Walls <awalls@md.metrocast.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-pm@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH v2 0/5] kthread: convert remaining users to
 kthread_create_worker
Message-ID: <2026090500-seventh-come-270c@gregkh>
References: <cover.1788513591.git.brads@mainlining.org>
 <20260904085418.50d66b34@kernel.org>
 <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org>
 <20260904141032.34f7ed1b@kernel.org>
 <2AE8656F-326C-40B5-BA11-EB9CD72D2AF7@mainlining.org>
 <2026090514-smuggler-elixir-8888@gregkh>
 <6F579B00-7B91-49F4-99FF-5F31E844355C@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F579B00-7B91-49F4-99FF-5F31E844355C@mainlining.org>

On Sat, Sep 05, 2026 at 01:55:35PM +0100, Bradley Morgan wrote:
> On 5 September 2026 12:19:54 BST, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >On Fri, Sep 04, 2026 at 10:13:32PM +0100, Bradley Morgan wrote:
> >> On 4 September 2026 22:10:32 BST, Jakub Kicinski <kuba@kernel.org>
> >wrote:
> >> >On Fri, 04 Sep 2026 16:56:30 +0100 Bradley Morgan wrote:
> >> >> On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org>
> >> >wrote:
> >> >> >On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:  
> >> >> >>   media: ivtv: convert to kthread_run_worker
> >> >> >>   net: encx24j600: convert to kthread_run_worker
> >> >> >>   tty: sc16is7xx: convert to kthread_run_worker
> >> >> >>   cpufreq: schedutil: convert to kthread_create_worker  
> >> >> >
> >> >> >Please send these 4 to appropriate subsystems
> >> >> >  
> >> >> >>   kthread: remove worker->task self assignment  
> >> >> >
> >> >> >Then after the next merge window when trees converge send this one
> >out 
> >> >> 
> >> >> hi, I was hoping one person could merge it with acks from all
> >subsystems
> >> >
> >> >Not how this works.
> >> Ugh, I've seen it before happen.
> >> 
> >> Look, fine, I'll do a V3 soon, WITH ONLY the subsystem changes, all
> >> separate, all sent over to their respective maintainers, then when all
> >> thathas been merged and there's the next merge window, then whatever,
> >I'll
> >> send then the kthread removal
> >> 
> >> IMHO this is a massive annoyance though.. because what if one of the
> >> driverfolks doesn't wanna respond to me!?!
> >
> >Then, after trying for the normal way, you can make the driver change at
> >the same time.  But to circumvent the "normal way" thinking it might not
> >work, is not the best thing to do.
> >
> 
> Greg!
> 
> Right, okay, Ill tell you more.
> 
> For features being added, where many drivers from different subsystems get
> covered at once, what they tend to do is:
> 
> A: send all patches, rely on all maintainers to merge their own crap, which is a mess
> 
> B: Have a designated merger, who merges all the changes at once, no chance of regression because it's all bundled up.
> 
> 
> C: send drivers first, then send the feature. So then driver maintainers can merge their crap, then the main feature gets merged in merge window 
> 
> I prefer B, because it's easier that way, akpm is usually des merger hence
> I CCed him.
> 
> Or tip tree?
> 
> Honestly, if I had to be honest, C is a very annoying way, because of what
> I said above, if driver maintainer thinks I'm some newbie idiot or
> something, then what will I do? He won't merge it!

To quote a longtime kernel developer years ago, "Kernel development is
hard, let's go shopping."

Sorry, but yes, it can be difficult to touch cross-subsystem stuff like
this, always has been.  Just be patient.

good luck!

greg k-h
