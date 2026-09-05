Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305213EC827;
	Sat,  5 Sep 2026 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607301; cv=none; b=H6ajLVx/m5Fhpg7eg1lX1U3A4euhaqhl+ntTTRjJp2ELQMZKF9l/yeYqxhMMdcph50c5hheFggHEUjm94u/G9encKwcrZhw3dS49YyP3O9ChZn5/QU93kmyR7Y2t0quJoA5Fx9zoRdmy6AI0oXga3pDGQE2Bd8PXHy4kbdkLqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607301; c=relaxed/simple;
	bh=vkUqtF+Wq4KeeRT2+Tjiqi8gTtATMHEll5h56+oTPac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCXc+zvgmLnawWk7Hfsj+amNeBptO8jK8cLHoscedKUpIxnOVLZU/gdunGNfh8WWDuoeg/7tv6oJmrLq0HHj0fbiQ+wm3oFJoHYbz1pgSP3HGymbryp+KJdVHZxGCUSHpaoxN3rWxAv/YBztzAtIMscMyruhbubnjva0W5RpNC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skmsMC7E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skmsMC7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066581F00A3D;
	Sat,  5 Sep 2026 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788607299;
	bh=zZkrrSFBTfJu1Do79jQiuuMXikUloJSJxOt9LFuNHVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=skmsMC7E5M9fItkfXa/nJ5Z0ef//BHMHril4qe/N4zIIlei9YjcOoTUGCsTJoJgzY
	 YkhYifkf7FOxbTRpcGlN/sOAY9LQEo7Dn13I7xZYJ8wzBxJRg27O0Mzc6XCd9+g75E
	 Fan9wAY2z6LzZ3NLw7IdrRpolNImX4E5PKlVwf9g=
Date: Sat, 5 Sep 2026 13:19:54 +0200
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
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] kthread: convert remaining users to
 kthread_create_worker
Message-ID: <2026090514-smuggler-elixir-8888@gregkh>
References: <cover.1788513591.git.brads@mainlining.org>
 <20260904085418.50d66b34@kernel.org>
 <84548BCE-377E-4900-A2EF-177B0CC1B0D0@mainlining.org>
 <20260904141032.34f7ed1b@kernel.org>
 <2AE8656F-326C-40B5-BA11-EB9CD72D2AF7@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2AE8656F-326C-40B5-BA11-EB9CD72D2AF7@mainlining.org>

On Fri, Sep 04, 2026 at 10:13:32PM +0100, Bradley Morgan wrote:
> On 4 September 2026 22:10:32 BST, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Fri, 04 Sep 2026 16:56:30 +0100 Bradley Morgan wrote:
> >> On 4 September 2026 16:54:18 BST, Jakub Kicinski <kuba@kernel.org>
> >wrote:
> >> >On Fri,  4 Sep 2026 09:37:21 +0000 Bradley Morgan wrote:  
> >> >>   media: ivtv: convert to kthread_run_worker
> >> >>   net: encx24j600: convert to kthread_run_worker
> >> >>   tty: sc16is7xx: convert to kthread_run_worker
> >> >>   cpufreq: schedutil: convert to kthread_create_worker  
> >> >
> >> >Please send these 4 to appropriate subsystems
> >> >  
> >> >>   kthread: remove worker->task self assignment  
> >> >
> >> >Then after the next merge window when trees converge send this one out 
> >> 
> >> hi, I was hoping one person could merge it with acks from all subsystems
> >
> >Not how this works.
> Ugh, I've seen it before happen.
> 
> Look, fine, I'll do a V3 soon, WITH ONLY the subsystem changes, all
> separate, all sent over to their respective maintainers, then when all
> thathas been merged and there's the next merge window, then whatever, I'll
> send then the kthread removal
> 
> IMHO this is a massive annoyance though.. because what if one of the
> driverfolks doesn't wanna respond to me!?!

Then, after trying for the normal way, you can make the driver change at
the same time.  But to circumvent the "normal way" thinking it might not
work, is not the best thing to do.

thanks,

greg k-h
